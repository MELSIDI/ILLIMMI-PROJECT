# World model visuel pour la génération Hypercourse (Layer 3)


## Statut

**Implémentée** (2026-07-24). Ce document capture d'abord la solution
retenue suite à la discussion sur les incohérences spatiales des cours générés
(texte qui déborde, figures qui se chevauchent, texte par-dessus une figure,
flèches qui pointent mal), puis, dans la section « Implémentation » plus bas,
ce qui a été réellement construit — qui dévie sur un point important de la
proposition d'origine.

**Écart principal par rapport à la proposition initiale** : la section
« Faisabilité technique » ci-dessous envisageait de générer un SVG maison
(templating de string) puis de le rasteriser en PNG via un micro-service
Python (`resvg`/CairoSVG). Cette approche a été prototypée puis **abandonnée
en cours d'implémentation** suite à un retour direct : une approximation SVG
(texte brut à la place du LaTeX, triangle fait main pour les têtes de flèche)
« ne fonctionne pas » pour les flèches et ne reproduit pas fidèlement le
tableau. La solution retenue au final réutilise **le vrai code de rendu de
production** d'`illimmi_app` (`BoardPainter`, `ArrowHeadPainter`,
`TextPatternFinder`, `LatexWidget`) via un harnais Flutter headless — voir
« Implémentation » pour le détail. Les sections « Problème », « Pourquoi une
image par élément » et « Faisabilité technique » sont conservées telles
quelles ci-dessous comme trace du raisonnement initial ; elles ne décrivent
plus l'architecture réellement en place.

## Problème

`Layer3VisualGenerator` (`lib/pipeline/layer3_visuals.dart`) génère **tout le
script Hypercourse d'un cours en un seul appel Claude**, à partir d'un
transcript timestampé. Le prompt système ne donne que des bornes numériques
brutes (`x ∈ [0, 177.78], y ∈ [0, 100]`) — aucune information sur :

- la taille réellement rendue d'un élément (largeur d'un texte, encombrement
  d'une formule LaTeX inline, longueur d'une flèche) ;
- l'état visuel courant du tableau à un instant donné (quels éléments sont
  encore visibles, où, avec quel encombrement).

Le seul garde-fou existant est la boucle de retry entre `Layer3VisualGenerator`
et l'assembleur (`previousAttempt` / `previousError`), qui ne se déclenche que
sur des **erreurs de parsing syntaxique** — jamais sur une incohérence visuelle.
Résultat : Claude doit simuler mentalement, sur toute la durée du cours et en
un seul jet, la géométrie et l'occupation du tableau — une tâche où un LLM est
structurellement peu fiable sans retour du monde réel. D'où la panoplie de
bugs observés : texte débordant du canevas, figures qui se chevauchent, texte
par-dessus une figure, flèche (`mouse move`) qui ne pointe pas correctement
vers l'élément visé.

## Solution retenue : world model par captures d'écran (Stratégie pré-erase)

Donner à l'IA un **retour visuel réel** du tableau plutôt que de lui demander
de raisonner uniquement sur des coordonnées abstraites — « une image vaut
mille mots ». Concrètement :

1. Une fois le script généré et parsé avec succès (`Course` construit), le cours est découpé en **scènes** délimitées par les commandes `erase` (ou la fin du cours).
2. **Politique de déclenchement optimale : une capture par scène juste avant chaque `erase`** (plus une capture finale à la fin du cours). 
   - L'instant de capture pour chaque scène est situé à `t = max(startTime + duration)` parmi les éléments présentés dans la scène juste avant l'effacement.
   - À cet instant précis, **tous les éléments de la scène sont entièrement dessinés** et aucun n'a encore été effacé : la composition complète (textes, graphiques, flèches) est ainsi visible d'un seul coup dans son état stable.
   - Le nombre total d'images est drastiquement réduit à **`nombre(erase) + 1`** (ex. 3 à 5 images par cours au lieu de 30 à 50 images).
3. **Règle d'immutabilité / persistance** : 
   - Si un élément survit à un `erase` (non spécifié dans `idsToErase`) et a déjà été validé/corrigé lors d'une capture précédente, il conserve sa position géographique et ne doit **plus être re-déplacé** par le modèle afin de préserver la cohérence spatiale globale tout au long du cours.
4. Ces captures sont envoyées à Claude (accompagnées du script Hypercourse et de la liste explicite des éléments mutables vs immutables) pour vérification/correction, en réutilisant la boucle de retry existante (`previousAttempt` / `previousError`).

### Pourquoi "une image par scène pré-erase" plutôt que les alternatives

| Approche | Nombre d'images | Verdict |
|---|---|---|
| Rendu par frame (ex. 30-60 fps) | Des milliers | Rejeté — coût explosif, la plupart des frames sont en pleine animation et n'apportent aucune information de vérification |
| Vidéo complète encodée | 1 vidéo | Rejeté — plus coûteux à produire, et l'analyse vidéo par un modèle nécessite de toute façon un échantillonnage de frames en interne, donc un détour inutile |
| Une image par élément terminé | = nombre d'éléments du cours (~30-50 images) | Ancien choix — fonctionnel mais trop lourd en nombre d'images et en tokens |
| **Une image par scène pré-erase** | **= nombre d'effacements + 1 (ex. 3-5 images)** | **Retenu (Optimal)** — capture l'intégralité de chaque scène au moment où tous ses éléments sont présents sur le tableau avant effacement. Réduit le coût et le temps de rendu tout en offrant au modèle une vision globale et complète de la composition. |

## Implémentation

Architecture réellement construite, insérée dans `JobStore._run()`
(`lib/job/job_store.dart`) juste après un `HypercourseParser(script).parse()`
réussi, avant `job.status = 'done'` :

```
JobStore._run()
  └─ HypercourseParser(script).parse() → Course
  └─ job.status = 'checking_visuals'
  └─ Layer3VisualVerifier.verify(course, script)
       ├─ planCaptures(course)                     → List<CaptureBatch>
       │    (board_capture_planner.dart : un point de capture par instant
       │    distinct startTime+duration, dédoublonné, découpé aux
       │    frontières d'erase, plafonné à maxCapturePointsPerBatch = 15)
       ├─ pour chaque CaptureBatch :
       │    serializeCaptureBatch(course, batch)    → JSON neutre
       │    (board_capture_serializer.dart, un cas par type de HyperElement)
       │    BoardRenderServiceClient.renderBatch()  → POST /render
       │    (board_render_service_client.dart)      → N PNG + trigger IDs
       │    ClaudeClient.completeMultimodalJson()   → { ok, issues[] }
       │    (script complet + une image par point, chacune précédée d'un
       │    repère texte "élément(s) déclencheur(s) ID: ...")
       └─ arrêt au premier lot en échec → previousError = issues formatées
  └─ si échec → previousAttempt = script, previousError = ..., retry
     (même boucle _maxAttempts = 3 que le retry sur erreur de parsing —
     aucun budget séparé)
```

### Fidélité du rendu : réutilisation directe du code de production, pas de réimplémentation

Le point qui a fait dévier l'implémentation de la proposition SVG d'origine.
`services/board-render-service` (nouveau micro-service Dart/Flutter) ne
réimplémente rien : il invoque `flutter test` en subprocess dans le dossier
d'`illimmi_app`, sur un harnais dédié
(`illimmi_app/integration_test/board_render_harness_test.dart`) qui :

1. désérialise le contrat JSON neutre vers les vraies classes `HyperElement`
   d'`illimmi_app` (`illimmi_app/lib/render_harness/board_capture_deserializer.dart`) ;
2. rejoue, figée à l'instant de capture (`isStatic: true`, pas d'`AnimationController`,
   pas de replay d'animation), la composition statique de
   `CoursePlayer._buildWhiteboardContent` (`illimmi_app/lib/player/course_player.dart:401-559`) —
   `BoardPainter` pour les formes (donc `ArrowHeadPainter`/`TextPatternFinder`
   pour les flèches et les références textuelles, exactement comme le
   lecteur réel), `LatexWidget` positionné pour le texte, une icône pour la
   position finale du curseur souris — via
   `illimmi_app/lib/render_harness/board_capture_widget.dart` ;
3. capture chaque frame en PNG via `RepaintBoundary.toImage()` et écrit un
   manifeste JSON (ID(s) déclencheur(s) par image).

`services/board-render-service/bin/serve.dart` n'est qu'un wrapper HTTP
(`shelf`) autour de ce subprocess : `POST /render` → fichier de requête
temporaire → `flutter test integration_test/board_render_harness_test.dart`
(un process par lot, pas de process Flutter tenu "chaud" entre deux lots —
voir "Limite connue" plus bas) → lecture des PNG + manifeste produits →
réponse JSON (`{"images": [{"triggerElementIds": [...], "imageBase64": ...}]}`).
Le Dockerfile associé (`services/board-render-service/Dockerfile`) build
depuis la **racine du repo** (pas depuis son propre dossier, à la différence
des autres services) car il a besoin à la fois d'`illimmi_app/` et de
`services/board-render-service/` dans son contexte de build.

**Preuve de fonctionnement obtenue en implémentant** (pas seulement en
théorie) : un lot de test avec un texte LaTeX, un cercle et une flèche a été
rendu de bout en bout — via le harnais `flutter test` directement, puis via
une vraie requête HTTP contre `board-render-service` — et la flèche produite
pointe correctement vers sa cible avec la vraie géométrie de
`ArrowHeadPainter` (chevron orienté selon l'angle réel de la ligne), ce qui
est exactement le défaut que l'approximation SVG précédente ne reproduisait
pas correctement.

### Limite de fidélité connue et assumée

`flutter test` substitue par défaut tout texte par la police de test "Ahem"
(un carré par caractère) sauf police explicitement chargée. Le harnais
charge via `illimmi_app/lib/render_harness/load_bundled_fonts.dart` toutes
les polices déclarées dans `FontManifest.json` — ce qui inclut les vraies
polices KaTeX de `flutter_math_fork` (le LaTeX se rend donc avec de vrais
glyphes mathématiques). En revanche, la police `Roboto` utilisée pour le
texte simple (`AdvancedTextWidget`) n'est déclarée dans aucun asset du
bundle (elle vient normalement de la police système côté lecteur réel) :
elle reste rendue en "Ahem" dans les captures. Conséquence pratique : la
**géométrie** des captures (position, taille de boîte, chevauchement,
débordement, orientation des flèches) est fidèle, mais le **texte simple
n'est pas lisible tel quel** par Claude dans l'image — seul le LaTeX l'est.
Corriger ce point demanderait de fournir un fichier `Roboto.ttf` réel comme
asset de test, non fait dans cette itération (licence/traçabilité du
fichier à trancher séparément).

### Autres décisions confirmées en implémentant

- **Cadence de capture** : une image par instant distinct de fin
  d'apparition d'élément (`startTime + duration`), pas de rendu vidéo ni de
  frame-par-frame — conforme au tableau de la section précédente. Le nombre
  d'images produites est bien égal au nombre d'éléments du cours (avec
  dédoublonnage quand plusieurs éléments finissent au même instant), obtenu
  par injection directe de l'état actif du tableau à cet instant
  (`Course.queryAll(time)`), jamais par simulation de l'animation depuis
  `t=0`.
- **Chaque image envoyée à Claude est étiquetée par le ou les ID(s) de
  l'élément déclencheur** (bloc texte placé juste avant chaque image dans le
  message multimodal), pour que Claude puisse référencer un ID précis plutôt
  que de décrire une image de façon ambiguë.
- **Chaque lot envoyé à Claude est accompagné du script Hypercourse complet**
  (pas d'un extrait), pour que Claude puisse comparer ce qui était *prévu*
  par le script à ce qui apparaît *réellement*.
- **Granularité de vérification** : par lot, aux frontières `erase`,
  plafonné à `maxCapturePointsPerBatch = 15` (voir
  `board_capture_planner.dart`) — arrêt au premier lot en échec plutôt que de
  vérifier tous les lots d'une tentative fautive (une tentative en échec est
  de toute façon régénérée intégralement puis re-vérifiée depuis le début).
- **Portée de la correction** : régénération complète du script, en
  réutilisant `previousAttempt`/`previousError`/`_maxAttempts = 3` sans
  budget séparé — exactement comme envisagé.
- **Hors scope, non traité** : vérifications déterministes (chevauchement de
  boîtes englobantes, distance flèche-cible), rendu des éléments `plot`
  (webview, jamais sérialisé vers `board-render-service`).

### Fichiers créés ou modifiés

`services/generation-orchestrator/lib/pipeline/`
`claude_client.dart` (extension multimodale), `board_capture_planner.dart`,
`board_capture_serializer.dart`, `layer3_visual_verifier.dart` — et
`lib/http/board_render_service_client.dart`, `lib/job/job_store.dart`
(intégration dans la boucle de retry).

`illimmi_app/lib/render_harness/`
`board_capture_deserializer.dart`, `board_capture_widget.dart`,
`load_bundled_fonts.dart` — et `integration_test/board_render_harness_test.dart`
(volontairement hors de `test/` pour ne pas être ramassé par un `flutter test`
sans argument).

`services/board-render-service/` (nouveau service)
`pubspec.yaml`, `bin/serve.dart`, `Dockerfile`.

`docker-compose.yml` — nouveau service `board-render-service` (build depuis
la racine), `BOARD_RENDER_SERVICE_URL` ajouté à l'environnement de
`generation-orchestrator`.

Tests ajoutés : `test/board_capture_planner_test.dart`,
`test/board_capture_serializer_test.dart` (côté `generation-orchestrator`),
plus un test dédié dans `test/job_store_test.dart` pour le retry déclenché
par un échec de vérification visuelle.

### Point ouvert restant

Le mécanisme d'exécution est volontairement la version la plus simple qui
fonctionne : un process `flutter test` par lot, sans rien tenu "chaud" entre
deux lots (ni entre deux tentatives d'un même job). Chaque relance repaie le
coût de démarrage du moteur Flutter. Piste d'amélioration non implémentée :
un process Flutter persistant capable de traiter plusieurs lots sans
redémarrer (mentionné comme point à prototyper dans la version précédente de
ce document, toujours vrai après implémentation).

## Faisabilité technique

### Envoyer l'image à Claude : trivial

`ClaudeClient` (`lib/pipeline/claude_client.dart`) est un client HTTP brut vers
l'API Messages d'Anthropic (`claude-sonnet-5`), qui envoie aujourd'hui
`content` comme une simple string. L'API Messages accepte nativement des blocs
image (base64) dans `content`, et `claude-sonnet-5` est vision-capable. Il
suffit d'étendre `ClaudeClient.complete()` (ou d'ajouter une méthode dédiée)
pour accepter un ou plusieurs blocs image en plus du texte — changement
localisé, pas de nouvelle dépendance.

### Produire la capture d'écran : le vrai chantier

`generation-orchestrator` est un serveur Dart headless (`bin/server.dart`) —
pas d'app Flutter, pas de moteur graphique, pas de `dart:ui`/`Canvas`
disponible. Il ne peut donc pas réutiliser directement `BoardPainter` /
`LatexWidget` (copiés depuis `illimmi_app`) pour produire un rendu pixel comme
le fait le lecteur.

Approche envisagée, dans la continuité de ce qui existe déjà dans ce repo :

- Générer un **SVG** à partir de l'état déjà parsé (`Course` / `HyperElement`
  à l'instant de capture) : toutes les données nécessaires (positions, rayons,
  couleurs, contenu texte, points de la trajectoire d'une flèche) sont déjà
  des nombres/chaînes connus après le parsing — templating de string, pas de
  moteur de rendu nécessaire (`<circle>`, `<path marker-end="...">` pour les
  flèches, `<text>` pour le texte).
- Rasteriser ce SVG en PNG via un outil headless (ex. `resvg` ou équivalent),
  dans un micro-service auxiliaire dédié — même principe que
  **`services/plot-service`**, qui existe déjà pour rendre les éléments
  `plot` via un serveur séparé. Ce nouveau rendu suivrait le même pattern
  plutôt que d'en inventer un nouveau.

## Intégration dans le pipeline existant

- Les instants de capture proviennent de l'index temporel déjà construit par
  `Course` (`FamilyForest` / `SegmentNode`) — aucune donnée nouvelle à
  calculer, seulement à exposer.
- La boucle de vérification s'insère entre le parsing réussi du script
  (aujourd'hui géré par `course_assembler.dart`) et la validation finale :
  script + N captures → Claude → soit validation, soit
  `previousError` décrivant le(s) problème(s) visuel(s) détecté(s) → nouvel
  appel à `Layer3VisualGenerator.generate()`, exactement comme le retry actuel
  sur erreur de parsing.
- Cette vérification visuelle est complémentaire (pas un remplacement) des
  vérifications déterministes moins coûteuses déjà envisagées séparément
  (chevauchement de boîtes englobantes, distance entre l'extrémité d'une
  flèche et sa cible) : le déterministe filtre vite et gratuitement les cas
  nets, la vision sert de filet pour tout ce qui est plus composite/subjectif
  à formaliser (cohérence globale de la composition, qualité du pointage
  d'une flèche).

## Questions ouvertes / à trancher à l'implémentation

Toutes tranchées — voir « Implémentation » ci-dessus pour le détail de
chaque décision. Conservé ici pour l'historique des options envisagées :

- **Granularité de l'appel de vérification** : un seul appel Claude avec
  toutes les N images d'un coup (plus simple, mais gros contexte), ou par
  lots (ex. par scène entre deux `erase`) ? → **par lots aux frontières
  `erase`, plafonnés à 15 images**.
- **Portée de la correction** : si un problème est détecté, Claude
  régénère-t-il le script en entier (comme le retry actuel), ou seulement les
  éléments fautifs (plus économique mais demande un mécanisme d'édition
  ciblée qui n'existe pas encore) ? → **régénération complète**, mécanisme
  d'édition ciblée toujours inexistant.
- **Choix technique du rasterizer SVG→PNG** à prototyper et valider dans un
  contexte Docker (voir `docker-compose.yml`). → **abandonné** : plus de SVG
  ni de rasterizer, remplacé par la réutilisation directe du rendu Flutter
  réel (voir « Fidélité du rendu » ci-dessus).
- **Articulation précise avec les vérifications déterministes** (ordre
  d'exécution, lequel déclenche un retry en premier). → **toujours ouvert**,
  les vérifications déterministes n'ont pas été implémentées dans cette
  itération (hors scope, voir « Autres décisions confirmées »).
