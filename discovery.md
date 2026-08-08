# Discovery — ILLIMMI

Document de découverte du projet : l'idée, l'architecture, le rôle de chaque
morceau de code, l'arborescence, et une liste concrète (pas générique) de
pistes d'amélioration basée sur une lecture réelle du code. Écrit pour
permettre à quelqu'un qui n'a jamais touché ce dépôt de devenir productif
rapidement.

Sources : `README.md` (racine), `illimmi_app/CLAUDE.md`,
`illimmi_app/illimmi-doc.md`, et lecture directe du code de tous les services.

---

## 1. L'idée

ILLIMMI génère des **cours de mathématiques** à partir d'un simple prompt
("Explique-moi les dérivées") : une narration audio complète, synchronisée
avec un **tableau blanc animé** (texte, formules LaTeX, tracés géométriques,
courbes de fonctions, curseur qui souligne) — comme un vrai professeur qui
parle en écrivant au tableau au fur et à mesure.

L'idée centrale qui structure tout le projet : ne **jamais** générer
directement une vidéo ou un flux de pixels. À la place, un LLM produit un
script texte dans un DSL maison, **Hypercourse** (`.hc`), qui décrit
précisément *quoi* afficher, *où* (coordonnées normalisées) et *quand*
(timestamps en secondes). Un moteur de rendu déterministe (le client Flutter)
interprète ce script et joue le cours en le synchronisant avec le fichier
audio.

Pourquoi un DSL intermédiaire plutôt qu'une génération directe :

- **Déterminisme** : le rendu ne dépend jamais d'un modèle d'IA au moment de
  la lecture — un script `.hc` se rejoue toujours identiquement.
- **Validable** : un script peut être analysé syntaxiquement et rejeté avant
  d'être montré à l'utilisateur (voir la boucle d'auto-correction, §2).
  Le LLM n'est pas fiable à 100 % en sortie ; un parseur strict l'est.
- **Petit et diffable** : un cours de 6 minutes tient dans quelques Ko de
  texte, contre des dizaines de Mo pour une vidéo équivalente.
- **Rejouable sans re-générer** : l'historique utilisateur stocke le script
  brut, pas un rendu — recharger un ancien cours ne coûte rien et ne
  ré-interroge jamais un LLM (voir `illimmi_app/lib/widgets/main_content_area.dart`,
  méthode `loadFromHistory`).
- **Écrivable à la main** : rien n'empêche un humain (ou un script) d'écrire
  directement un `.hc` sans passer par le pipeline IA — c'est exactement ce
  qui a été fait cette session pour produire un cours de test sur les
  barycentres (voir §8) quand la clé Claude n'était pas disponible.

Le projet vise aussi, à terme, à ne plus dépendre de Claude pour la partie
génération des appuis visuels ("Layer 3") : un pipeline de génération de
dataset (§6) est déjà entièrement conçu pour fine-tuner un modèle local
(`Gemma 4`) sur cette tâche spécifique — mais ce pipeline n'est pas encore
implémenté (voir §6).

---

## 2. Architecture globale

Quatre microservices + un client Flutter :

| Service | Rôle | Langage | Port | Déploiement |
|---|---|---|---|---|
| `generation-orchestrator` | Orchestre le pipeline IA à 3 couches, assemble, valide et vérifie visuellement le script final | Dart | 8080 | Docker (`docker-compose.yml`) |
| `audio-service` | TTS local (Piper) + alignement mot-par-mot | Dart | 8082 | **Natif** (wrap un `.exe` Windows) |
| `user-service` | Comptes, JWT, historique des cours | Dart | 8081 | Natif (pas encore containerisé) |
| `plot-service` | Exécute des snippets Python (`plot`) et renvoie du HTML interactif | Python/FastAPI | 5000 | Docker |
| `board-render-service` | Rend le tableau headlessly (vrai `BoardPainter`/`LatexWidget` d'`illimmi_app` via `flutter test`) pour la vérification visuelle du Layer 3 | Dart/Flutter | 5001 | Docker (build depuis la racine du repo) |
| `illimmi_app` | Client Flutter — parse et joue les `.hc` | Dart/Flutter | — | Desktop (Windows/macOS/Linux), Web |

`audio-service` n'est **pas** containerisé volontairement : il pilote
`speaker/piper/piper.exe`, un binaire natif Windows — un conteneur Linux ne
peut pas l'exécuter, et un conteneur Windows serait disproportionné pour un
simple wrapper de subprocess. `user-service` n'est simplement pas encore
containerisé (pas de contrainte technique, juste pas fait). `docker-compose.yml`
définit donc `generation-orchestrator`, `plot-service` et
`board-render-service`, qui atteignent les deux services natifs via
`host.docker.internal`. `board-render-service` est particulier dans ce
tableau : son Dockerfile build depuis la **racine** du repo (pas depuis son
propre dossier comme les deux autres) car il a besoin à la fois de
`illimmi_app/` (le vrai code de rendu, réutilisé tel quel) et de son propre
code — voir §4.6.

### Flux complet : du prompt au cours joué

```
Utilisateur tape un prompt dans l'UI
        │
        ▼
POST /courses/generate  (generation-orchestrator, port 8080)
        │  répond 202 {jobId} immédiatement, traite en tâche de fond (JobStore)
        ▼
┌───────────────────────────────────────────────────────────────┐
│ Layer 1 — Planification (Claude)                              │
│   prompt → {subject, level, duration_target, concepts_cles,   │
│             structure, ton, langue}                           │
├───────────────────────────────────────────────────────────────┤
│ Layer 2 — Narration (Claude texte + audio-service réel)       │
│   métadonnées → texte complet → POST /narrate (port 8082)     │
│   → Piper TTS (.wav réel) → alignement mot-par-mot            │
│   → {transcript_timestamped, duration, audio_file}            │
├───────────────────────────────────────────────────────────────┤
│ Layer 3 — Appuis visuels (Claude, en attendant un Gemma 4     │
│   fine-tuné — voir §6)                                        │
│   transcript timestampé → commandes Hypercourse               │
│   (text/draw/mouse/erase, synchronisées 0.2–0.5s après le     │
│   mot déclencheur)                                            │
├───────────────────────────────────────────────────────────────┤
│ Assemblage : header `course "..." id ... audio "..." { }`     │
│   + commandes Layer 3                                         │
├───────────────────────────────────────────────────────────────┤
│ Validation : HypercourseParser.parse() sur le script assemblé.│
│   Échec → l'erreur + le script précédent sont renvoyés à      │
│   Layer 3 pour correction, jusqu'à 3 tentatives.              │
├───────────────────────────────────────────────────────────────┤
│ Vérification visuelle (job.status = 'checking_visuals') —     │
│   world model : capture du tableau à la fin de chaque élément │
│   (board-render-service, rendu Flutter réel) envoyée à Claude │
│   avec le script complet → chevauchement/débordement/flèche   │
│   mal orientée détectés ? Échec → même boucle de retry que la │
│   validation syntaxique ci-dessus (3 tentatives partagées,    │
│   pas de budget séparé). Voir §4.1 et §9.                     │
└───────────────────────────────────────────────────────────────┘
        │  job.status = 'done'
        ▼
GET /courses/<jobId>  → {script, audioUrl, duration}
        │  (si connecté : persistance best-effort dans user-service)
        ▼
Client Flutter : HypercourseParser(script).parse() → Course
        → CoursePlayer joue l'audio + anime le tableau blanc
```

Le point clé : **Claude n'est jamais dans la boucle de lecture**, seulement
dans la boucle de génération. Une fois le script produit et validé, plus rien
n'appelle un LLM.

---

## 3. Le DSL Hypercourse

Référence complète : `illimmi_app/illimmi-doc.md` §1. Résumé :

- **Espace de coordonnées** : plan normalisé 16:9, `(0,0)` en haut à gauche,
  `(177.78, 100)` en bas à droite, centre `(88.89, 50)`. Indépendant de la
  résolution réelle de l'écran — le client fait le letterboxing (voir §4,
  `CoordinateSystem`).
- **Temps** : toutes les valeurs `start`/`for` sont en secondes, suffixe `s`
  obligatoire. `start` est obligatoire par élément, `for` optionnel (sans
  `for`, l'élément reste affiché jusqu'à un `erase` explicite ou la fin du
  cours).
- **IDs** : partitionnés en plages par famille via `idgap` (recommandé `100`) :
  `text` 1–100, `draw` 101–200, `speech` 201–300, `mouse` 301–400,
  `erase` 401–500. Un ID détermine sa famille par simple arithmétique
  (`(id-1) ~/ idgap`) — voir `IdConfig` en §4.
- **En-tête** : `course "<titre>" id <id> idgap <idgap> for <durée>s audio "<fichier>" { ... }`.
  `audio` est la **seule** source de narration ; `speech` est un résidu
  historique qui ne fait plus que du sous-titrage (voir §6, point sur
  `CLAUDE.md` obsolète).
- **Commandes** : `text`, `draw` (line, arrow*, path, curve, circle, ellipse,
  arc, elliptic_arc, polygone, 2drep, 2dfunc), `mouse move`, `erase`, `speech`,
  `plot`. (*`draw arrow` est documenté mais cassé — voir §6.)
- **Texte enrichi** : contenu entre `''...''`, tags `[bold]`, `[italic]`,
  `[color=#RRGGBB]`, `[font=...]`, LaTeX inline `$...$` et bloc `$$...$$`.

Exemple minimal (issu de `illimmi_app/courses/introduction_geometrie.hc`) :

```hypercourse
course "Introduction à la Géométrie" id 500 idgap 100 for 45s {
    text id 1 start 1s for 4s at (88.89, 10)
         ''[bold][color=#2980B9]Géométrie : Le Cercle[/color][/bold]'' ;
    draw circle id 101 start 2s for 2s
         color (41, 128, 185, 1) width 3 radius 15 at (88.89, 50) ;
}
```

---

## 4. Service par service

### 4.1 `generation-orchestrator` (Dart, port 8080)

- `bin/server.dart` : serveur `shelf`, routes montées depuis
  `lib/routes/courses_routes.dart` (`POST /courses/generate`,
  `GET /courses/<id>/status`, `GET /courses/<id>`).
- `lib/job/job_store.dart` : `JobStore._run` exécute les 3 layers en séquence
  en tâche de fond, met à jour le statut du job à chaque étape
  (`planning`→`narrating`→`generating_visuals`/`correcting_visuals`→
  `checking_visuals`→`done`).
- `lib/pipeline/layer1_planner.dart`, `layer2_audio.dart`, `layer3_visuals.dart` :
  un appel Claude chacun (`lib/pipeline/claude_client.dart`, client HTTP brut
  vers `api.anthropic.com`, pas de SDK officiel). Layer 3 a un prompt système
  très strict (plages d'ID, délai 0.2–0.5s, jamais de commande `speech`,
  syntaxe de référence complète) — c'est ce prompt qui a servi de spécification
  pour écrire le cours barycentres à la main (§8).
- `lib/pipeline/course_assembler.dart` : fonction pure, aucun appel réseau,
  assemble le header + les commandes Layer 3.
- `lib/parsers/hypercourse_parser.dart` : **copie miroir** du parseur du
  client Flutter, mais sans dépendance Flutter — rendue possible par
  `lib/hc_types.dart`, qui réimplémente juste les deux types `dart:ui` dont le
  parseur a besoin (`Color.fromRGBO`, `Offset`) pour tourner dans un process
  `dart run` pur. C'est ce parseur qui valide chaque tentative de Layer 3.
- **Vérification visuelle (world model)** — voir §9 pour l'étude de cas
  complète. `lib/pipeline/layer3_visual_verifier.dart` orchestre : le calcul
  des instants de capture (`board_capture_planner.dart`, un point par
  élément terminé, groupé par scène `erase`, plafonné à 15/lot), leur
  sérialisation JSON (`board_capture_serializer.dart`), l'appel HTTP vers
  `board-render-service` (`lib/http/board_render_service_client.dart`, voir
  §4.6), puis l'appel Claude multimodal. `lib/pipeline/claude_client.dart` a
  été étendu pour ça (`ContentBlock`/`TextBlock`/`ImageBlock`,
  `completeMultimodalJson`) — jusque-là `content` n'était qu'une string, il
  accepte maintenant un tableau de blocs texte/image. Le résultat s'insère
  dans la même boucle de retry que la validation syntaxique
  (`job_store.dart`, `previousAttempt`/`previousError`, `_maxAttempts = 3`
  partagé, pas de budget séparé).
- `lib/auth/jwt_verifier.dart` : vérifie les tokens émis par `user-service`
  (même secret HMAC partagé, voir §4.3). Un token absent/invalide ne bloque
  jamais la génération — bascule silencieusement en mode invité.

### 4.2 `audio-service` (Dart, port 8082)

- `lib/tts/piper_service.dart` : wrappe `speaker/piper/piper.exe` en
  subprocess (stdin = texte, stdout/stderr parsés pour la durée). Résultat mis
  en cache sur disque (`speaker/audios/<dirName>/<fileName>.wav`) — un appel
  `/narrate` avec les mêmes `dirName`/`fileName` ne resynthétise pas.
- **Trois backends d'alignement**, interchangeables via `ALIGNER_BACKEND`
  (`lib/align/aligner_factory.dart`) :
  - `local` → `LocalSherpaAligner` (`lib/align/local_sherpa_aligner.dart`) :
    utilise `sherpa_onnx` avec le modèle `speaker/whisper/model/*.onnx`. **Limite
    structurelle découverte cette session** : l'export ONNX officiel
    `sherpa-onnx-whisper-tiny` (releases GitHub k2-fsa/sherpa-onnx — vérifié
    par retéléchargement, fichier identique byte pour byte à celui déjà
    présent) ne contient pas les sorties cross-attention nécessaires aux
    timestamps mot-par-mot. `sherpa-onnx` les désactive alors silencieusement.
    Le code a été corrigé pour ne plus planter dans ce cas (retourne une liste
    vide plutôt qu'un `RangeError`), mais ce backend ne donne **aucun**
    timestamp utilisable tel quel.
  - `remote` (défaut) → `RemoteWhisperAligner` : appelle l'API OpenAI Whisper,
    nécessite `OPENAI_API_KEY`.
  - `whispercpp` → `WhisperCppAligner` (`lib/align/whispercpp_aligner.dart`,
    **ajouté cette session**) : wrappe `whisper-cli.exe` (whisper.cpp,
    `speaker/whispercpp/`) en subprocess. Convertit d'abord le wav Piper
    (22050 Hz) en 16 kHz mono via `ffmpeg`, lance `whisper-cli -ml 1 -oj`
    (un token par appel, sortie JSON avec timestamps), puis fusionne les
    sous-mots en mots complets (un token qui commence par une espace démarre
    un nouveau mot). C'est le **seul backend 100 % local qui donne de vrais
    timestamps mot-par-mot** — recommandé pour tout usage hors-ligne. Piège
    Windows rencontré : lancé via `dart run` pur (pas un build Flutter), les
    DLL natives de `sherpa_onnx_windows`/`whisper.cpp` ne sont pas
    automatiquement copiées à côté de l'exécutable ; pire, `sherpa-onnx-c-api.dll`
    résolvait sa dépendance `onnxruntime.dll` vers une version **plus ancienne
    déjà présente dans `C:\Windows\System32`** (fournie par Windows lui-même)
    plutôt que la version correcte livrée avec le package, car
    `System32` est prioritaire sur le `PATH` dans l'ordre de résolution des
    DLL Windows, et devant toute copie posée dans le dossier courant. Solution :
    `dart compile exe` puis copier les DLL correctes à côté du `.exe`
    résultant — le dossier de l'exécutable (`application directory`) est,
    lui, prioritaire sur `System32`.
- `lib/routes/narrate_route.dart` : `POST /narrate {text, dirName, fileName}`
  → `{audioUrl, duration, wordTimestamps}`. `/audios/**` sert les `.wav`
  générés en fichiers statiques.

### 4.3 `user-service` (Dart, port 8081)

- SQLite (`illimmi_users.db`) : table `users` (mot de passe hashé en bcrypt,
  salt aléatoire par utilisateur) et `course_history` (script complet, pas
  juste une référence — voir §1 sur le "rejouable sans re-générer").
- JWT (`dart_jsonwebtoken`) : secret HMAC partagé via la variable d'env
  `AUTH_JWT_SECRET`, **doit être identique** entre `user-service` et
  `generation-orchestrator` (les deux vérifient localement, sans jamais
  s'appeler l'un l'autre pour valider un token). Expiration 30 jours — pas de
  refresh token, "se déconnecter" = supprimer le token côté client
  (`illimmi_app/lib/storage/token_storage.dart`, `flutter_secure_storage`).
- Philosophie assumée : **l'authentification n'est jamais obligatoire**.
  `generation-orchestrator` génère en mode invité si le token est absent ou
  invalide ; l'app fonctionne intégralement sans jamais se connecter.

### 4.4 `plot-service` (Python/FastAPI, port 5000)

- Un seul endpoint utile : `POST /plot_interactive {code}` → HTML.
  `exec()` le snippet Python soumis (censé laisser une variable `fig`) dans un
  espace de noms restreint (`plt`, `np`, `go`, et une allowlist de builtins
  sans `open`/`eval`/`__import__`). Convertit en HTML via `mpld3` (matplotlib)
  ou `fig.to_html()` (plotly). Timeout de 10s via `ThreadPoolExecutor`.
  **Voir §6 pour les limites de sécurité réelles de cette approche.**

### 4.5 `board-render-service` (Dart/Flutter, port 5001)

Nouveau service, ajouté avec le world model visuel du Layer 3 (§9). Son
seul travail : router une requête HTTP vers un rendu **réel** du tableau,
sans jamais réimplémenter la moindre logique de dessin.

- `bin/serve.dart` : serveur `shelf` minimal, un seul endpoint utile
  (`POST /render`). Pour chaque requête : écrit le lot de captures reçu
  (JSON) dans un fichier temporaire, lance `flutter test
  integration_test/board_render_harness_test.dart` **en subprocess dans le
  dossier `illimmi_app`** (`Process.run(..., runInShell: true)` — nécessaire
  sous Windows où `flutter` est un script `.bat`, pas un exécutable direct),
  attend la fin du process, relit les PNG + le manifeste produits, répond en
  JSON (`{"images": [{"triggerElementIds": [...], "imageBase64": ...}]}`).
  Un process `flutter test` par lot — pas de moteur Flutter tenu "chaud"
  entre deux lots (piste d'amélioration non implémentée, voir §9).
- Pourquoi ce service vit à côté d'`illimmi_app` plutôt que de dupliquer son
  code : la vérification visuelle n'a de valeur que si l'image capturée
  correspond exactement à ce que l'apprenant verra réellement. Dupliquer
  `BoardPainter`/`ArrowHeadPainter`/`LatexWidget` dans un rendu maison (SVG
  ou autre) réintroduirait exactement le risque de divergence que cette
  fonctionnalité cherche à éliminer — voir §9 pour le changement de
  direction qui a mené à ce choix.
- Le Dockerfile associé build depuis la **racine** du repo (pas depuis
  `services/board-render-service/` comme les autres services) : il a besoin
  à la fois d'`illimmi_app/` et de son propre dossier dans son contexte de
  build.

### 4.6 `illimmi_app` (client Flutter)

**Pipeline de rendu** : `Tokenizer` (scanner caractère par caractère) →
`HypercourseParser` → **"triple factory"** pour étendre une forme de dessin :

1. `CommandParserFactory` (`lib/parsers/command_parsers/`) dispatch le mot-clé
   de tête (`text`, `draw`, `plot`, `erase`, `speech`, `mouse`).
2. `DrawParserFactory` (`lib/parsers/draw_parsers/`) dispatch le type de forme
   après `draw` vers un parseur qui construit le modèle
   (`lib/models/draw_elements/`).
3. `ElementPainterFactory` (`lib/board_painter/element_painters/`) dispatch
   l'élément parsé vers un `CustomPainter` dédié.

Ajouter une forme = un fichier dans chacun des trois dossiers, enregistré dans
chacune des trois factories. **Ce pattern est actuellement cassé pour
`arrow`** — voir §6.

**Indexation temporelle** (`lib/models/course.dart`) : chaque famille d'IDs a
sa propre `FamilyForest`, un arbre d'intervalles fait maison — pas un segment
tree manuel classique, plutôt un arbre à **tolérance de 0.5s** : un élément
qui couvre "presque" tout un nœud (à 0.5s près) y est stocké tel quel sans
fragmenter davantage l'arbre ; un élément à cheval sur le point médian d'un
nœud est inséré dans les deux enfants. `erase` ne supprime rien : il modifie
`endTime` en place sur l'objet partagé par référence dans tous les nœuds où il
a été inséré — c'est ce qui rend l'effacement instantané partout.
`Course.queryAll(temps)` (appelé à chaque tick d'animation) met en cache le
dernier résultat.

**Rendu** : `BoardPainter` (`CustomPainter`) dessine les formes sur un
`Canvas` via `CoordinateSystem` (transformation 16:9→pixels) ; `TextElement`/
`PlotElement`/`MouseEvent` sont des widgets Flutter positionnés séparément
(`Positioned`) par `CoursePlayer`, qui recalcule **indépendamment** la même
transformation 16:9 — duplication à surveiller (§6). Texte enrichi et LaTeX
via `flutter_math_fork` (`lib/board_writter/latex_widget.dart`, révélation
caractère par caractère synchronisée sur la progression temporelle). `plot`
via `webview_flutter` qui charge le HTML renvoyé par `plot-service`.

**Rendu headless pour la vérification visuelle** (`lib/render_harness/`,
ajouté avec le world model du Layer 3, §9) : **pas** une fonctionnalité
utilisateur, une réutilisation du code de rendu ci-dessus pour un usage
serveur. `board_capture_deserializer.dart` reconstruit les vraies classes
`HyperElement` (`dart:ui Offset`/`Color`) à partir du JSON envoyé par
`generation-orchestrator` ; `board_capture_widget.dart` rejoue, figée à un
instant donné (`isStatic: true`, sans `AnimationController`), la même
composition que `CoursePlayer._buildWhiteboardContent` (donc le même
`BoardPainter`, y compris `ArrowHeadPainter`/`TextPatternFinder`) ;
`load_bundled_fonts.dart` charge les polices réellement embarquées dans le
bundle (dont les glyphes KaTeX de `flutter_math_fork`) pour éviter que
`flutter test` substitue tout par sa police de test "Ahem" par défaut.
Consommé par `integration_test/board_render_harness_test.dart` — placé
sous `integration_test/` (pas `test/`) précisément pour ne pas être ramassé
par un `flutter test` sans argument ; il n'est invoqué qu'explicitement par
`board-render-service` (§4.5).

**État / auth / génération** : `SessionController` est un simple
`ChangeNotifier` (choix assumé : 3 consommateurs seulement, pas besoin d'un
package de state management). La génération tourne dans un **isolate séparé**
(`lib/api/generation_isolate.dart`) précisément pour que la boucle de polling
HTTP (toutes les 800ms) ne puisse jamais provoquer de micro-freeze de l'UI.

---

## 5. Arborescence du projet

```
ILLIMMI-CLAUDE/
├── README.md                    # setup, ports, ordre de démarrage
├── docker-compose.yml           # generation-orchestrator + plot-service + board-render-service
├── discovery.md                 # ce document
│
├── services/
│   ├── generation-orchestrator/ # Dart — orchestration du pipeline IA (port 8080)
│   │   ├── world-model-visual-feedback.md  # design + implémentation de la vérification visuelle (§9)
│   │   ├── bin/server.dart
│   │   ├── lib/
│   │   │   ├── auth/            # vérification JWT (miroir de user-service)
│   │   │   ├── http/            # clients HTTP : audio-service, user-service, board-render-service
│   │   │   ├── job/             # JobStore : exécution async + statut
│   │   │   ├── pipeline/        # Layer1/2/3, ClaudeClient, course_assembler, models,
│   │   │   │                    # + board_capture_planner/serializer, layer3_visual_verifier
│   │   │   ├── parsers/         # copie Flutter-free du parseur Hypercourse
│   │   │   ├── models/          # copie des modèles d'éléments (sans Flutter)
│   │   │   ├── routes/          # courses_routes.dart
│   │   │   └── hc_types.dart    # shim Color/Offset sans dart:ui
│   │   └── test/                # + board_capture_planner_test.dart, board_capture_serializer_test.dart
│   │
│   ├── audio-service/           # Dart — TTS + alignement (port 8082)
│   │   ├── bin/server.dart
│   │   ├── lib/
│   │   │   ├── align/           # LocalSherpaAligner, RemoteWhisperAligner,
│   │   │   │                    # WhisperCppAligner, aligner_factory
│   │   │   ├── tts/             # PiperServices
│   │   │   └── routes/          # narrate_route.dart
│   │   └── speaker/
│   │       ├── piper/           # piper.exe + modèles de voix .onnx (français)
│   │       ├── whisper/model/   # export ONNX sherpa-onnx-whisper-tiny (sans timestamps)
│   │       ├── whispercpp/      # whisper-cli.exe + modèle ggml-small.bin
│   │       └── audios/          # .wav générés, mis en cache par dirName/fileName
│   │
│   ├── user-service/            # Dart — comptes + historique (port 8081)
│   │   ├── bin/server.dart
│   │   └── lib/{auth,db,routes}/
│   │
│   ├── plot-service/            # Python/FastAPI — rendu de plots (port 5000)
│   │   ├── Dockerfile
│   │   ├── requirements.txt
│   │   └── app/main.py
│   │
│   └── board-render-service/    # Dart/Flutter — rendu headless du tableau (port 5001)
│       ├── Dockerfile           # build depuis la RACINE du repo (besoin d'illimmi_app/ aussi)
│       ├── pubspec.yaml
│       └── bin/serve.dart       # wrapper HTTP → subprocess `flutter test` dans illimmi_app
│
└── illimmi_app/                 # Client Flutter (multi-plateforme)
    ├── illimmi-doc.md           # référence DSL + spec pipeline IA (à jour)
    ├── CLAUDE.md                # notes internes (partiellement obsolètes, voir §6)
    ├── courses/                 # scripts .hc d'exemple (chargeables sans réseau)
    ├── integration_test/
    │   └── board_render_harness_test.dart  # harnais invoqué par board-render-service
    └── lib/
        ├── main.dart                       # bootstrap (SessionController + AppShell)
        ├── api/                            # clients HTTP + isolate de génération
        ├── parsers/
        │   ├── tokenizer/                  # scanner de caractères
        │   ├── command_parsers/            # factory niveau 1
        │   └── draw_parsers/               # factory niveau 2
        ├── models/
        │   ├── basic_elements/             # text, erase, mouse, plot, speech, audio
        │   └── draw_elements/              # line, circle, polygon, 2drep, 2dfunc, ...
        ├── board_painter/
        │   ├── element_painters/           # factory niveau 3
        │   └── helpers/                    # flèches, évaluateur de fonctions, grille
        ├── board_writter/                  # rendu texte enrichi + LaTeX
        ├── board_plotter/                  # webview vers plot-service
        ├── render_harness/                 # désérialisation JSON + composition figée pour le
        │                                   # rendu headless (board-render-service) — pas une
        │                                   # fonctionnalité utilisateur, voir §4.6 et §9
        ├── player/                         # CoursePlayer (timeline + audio)
        ├── screens/                        # AppShell, auth_dialog
        ├── state/                          # SessionController
        ├── storage/                        # token_storage (flutter_secure_storage)
        ├── theme/
        └── widgets/                        # sidebar, main_content_area, progress view
```

---

## 6. Comment améliorer le projet

Liste construite à partir d'une lecture réelle du code (pas générique) :

**Documentation**
- `illimmi_app/CLAUDE.md` contient trois sections obsolètes à corriger :
  1. "Entry points" décrit encore un `HypercourseDebugPage` dans `main.dart`
     et un fichier `lib/main_set.dart` — les deux n'existent plus ; la logique
     a migré vers `widgets/main_content_area.dart` sous `AppShell`.
  2. La section "Speech/TTS et correction temporelle (legacy)" décrit un
     mécanisme (`_applyTemporalCorrections`, synthèse Piper depuis le
     parseur) qui a été **supprimé du code** — `speech` n'est plus qu'un
     sous-titre à timing fixe (confirmé par un test dédié dans
     `hypercourse_parser_test.dart`).
  3. `plot` est décrit comme dépendant d'un serveur "non fourni dans ce
     dépôt" — faux depuis que `services/plot-service/` existe.

**Bugs / fonctionnalités cassées**
- `draw arrow` est documenté dans `illimmi-doc.md` et modélisé
  (`models/draw_elements/arrow_element.dart`), mais **aucun**
  `arrow_draw_parser.dart` ni `arrow_element_painter.dart` n'existe, et rien
  n'est enregistré dans les factories correspondantes. Un script utilisant
  `draw arrow` échoue au parsing (`'Type de dessin non reconnu'`). À trancher :
  implémenter les deux fichiers manquants, ou supprimer la commande/le modèle
  si `draw line ... with +arrow` (déjà supporté) suffit.
- `LocalSherpaAligner` reste sans solution : même en corrigeant le crash,
  l'export ONNX officiel k2-fsa ne permettra jamais de timestamps. Basculer
  la documentation/les défauts vers `whispercpp` comme option locale
  recommandée (voir §4.2), ou ré-exporter le modèle avec
  `scripts/whisper/export-onnx-with-attention.py` si ce backend doit rester.

**Dette technique**
- Maths de letterboxing 16:9 dupliquées entre
  `board_painter/coordinate_system.dart` et `player/course_player.dart`
  (`_buildWhiteboardContent`) — même calcul écrit deux fois, à factoriser en
  une seule source de vérité avant qu'elles ne divergent silencieusement.
- `print()` de debug (préfixés d'emojis 🔍✅❌⚠️📊) non conditionnés dans
  `hypercourse_parser.dart` et `course.dart`/`FamilyForest` — s'exécutent à
  chaque parsing et chaque insertion dans l'arbre, y compris en release.
- Incohérence de valeur par défaut pour `idgap` : `100000` dans le
  constructeur d'`IdConfig`, `10000` dans le fallback du parseur quand
  l'en-tête n'en précise pas, `100` recommandé par la documentation — les
  trois devraient converger.
- `Course.handleErase` semble être un chemin mort : le vrai mécanisme
  d'effacement passe par la map locale du parseur, avant même la construction
  de l'objet `Course`. À vérifier avec un grep exhaustif avant suppression.
- `lib/my_app.dart` : scratch de test avec la logique principale commentée —
  candidat à la suppression ou à la réécriture.
- Parseurs individuels (`command_parsers/`, `draw_parsers/`) avancent
  `currentIndex` par des offsets fixes codés en dur plutôt que de renvoyer la
  nouvelle position — fonctionne tant que la forme des tokens ne change pas,
  mais fragile pour toute évolution de syntaxe.
- `board-render-service` relance un process `flutter test` complet à chaque
  lot de capture — pas de moteur Flutter tenu "chaud" entre deux lots ni
  entre deux tentatives d'un même job. Fonctionne, mais chaque relance
  repaie le coût de démarrage du moteur ; un process persistant capable de
  traiter plusieurs lots serait plus rapide sur un job avec plusieurs
  tentatives/scènes. Voir §9 et
  `services/generation-orchestrator/world-model-visual-feedback.md`
  ("Point ouvert restant").
- Les captures produites pour la vérification visuelle rendent le texte
  simple (police `Roboto`) avec la police de test "Ahem" de Flutter (des
  carrés) faute d'un fichier de police réel embarqué comme asset de test —
  seul le LaTeX (glyphes KaTeX réels) est lisible dans ces images. La
  géométrie reste fidèle (utile pour détecter chevauchement/débordement),
  mais Claude ne peut pas lire le texte simple tel quel. Voir §9.

**Tests**
- `illimmi_app/test/widget_test.dart` est le template par défaut de
  `flutter create` (compteur "0"/"1"), sans rapport avec l'app réelle — à
  supprimer ou réécrire en test de fumée sur `AppShell`.
- Seul `hypercourse_parser_test.dart` teste réellement quelque chose (header
  `audio`, absence de `speech`/TTS). Aucun test sur les parseurs de formes
  individuels (`circle`, `line`, `2drep`, `2dfunc`, etc.), ni sur les clients
  HTTP (`AuthClient`, `GenerationClient`, `HistoryClient`), ni sur
  `CoursePlayer`/les painters.

**Sécurité**
- `plot-service` exécute du Python arbitraire via `exec()` avec une allowlist
  de builtins — une protection "molle", connue pour être contournable en
  Python pur (introspection d'objets, `__class__.__bases__`, etc.), sans
  isolation OS réelle, sans limite mémoire/CPU au-delà d'un timeout de 10s
  qui ne tue pas vraiment un thread bloqué. Le code le reconnaît lui-même en
  commentaire. Tant que le contenu exécuté vient uniquement de scripts `.hc`
  écrits à la main, le risque est limité — mais dès qu'un `plot` généré par
  IA (Layer 3) sera accepté sans revue humaine, une vraie isolation
  (subprocess/conteneur dédié à limites de ressources) devient nécessaire.
- Secret JWT unique partagé par variable d'environnement entre deux services,
  pas de rotation, tokens valables 30 jours sans refresh — acceptable pour un
  projet de cette taille, à revoir avant une mise en production réelle.

**Roadmap non implémentée**
- La boucle de questions en cours de lecture (`illimmi-doc.md` §2.6 :
  pause → mini Layer1/2/3 → réponse → reprise) n'existe pas côté client :
  `CoursePlayer._handleQuestion` affiche juste un `SnackBar` placeholder
  (`// TODO: Implémenter l'interaction avec l'IA`). Idem pour la
  reconnaissance vocale (bouton micro, même genre de placeholder).
- Le pipeline de génération de dataset (`illimmi-doc.md` §3 : YouTube via
  `yt-dlp` → transcription+alignement via WhisperX → Claude simule Layer 3 →
  validateur → paires `{input, output}` → fine-tuning LoRA d'un
  `google/gemma-4-4b-it` sur Kaggle) est **entièrement spécifié dans la
  documentation, avec schémas JSON, prompts et hyperparamètres, mais aucun
  code n'existe** — ni `pipeline.py`, ni dépendances `yt-dlp`/`whisperx`
  déclarées nulle part. Le seul lien avec le code réel est un commentaire dans
  `layer3_visuals.dart` expliquant que Claude fait actuellement le travail en
  attendant ce fine-tuning. À traiter comme une roadmap crédible, pas comme
  un composant existant.

**Opérationnel**
- Le dépôt n'est pas un dépôt git initialisé (pas de `.git`, pas de
  `.gitignore`, pas de CI) — premier réflexe pour un futur travail collaboratif.

---

## 7. Lancer et tester le projet

Ordre documenté dans `README.md` (racine) :

1. `audio-service` (natif, requis en premier) :
   ```
   cd services/audio-service
   dart pub get
   ALIGNER_BACKEND=whispercpp FFMPEG_EXE_PATH="<chemin ffmpeg.exe>" dart run bin/server.dart
   ```
   (`ALIGNER_BACKEND=whispercpp` recommandé pour un alignement 100 % local
   avec de vrais timestamps — voir §4.2. Sur Windows, préférer compiler en
   exe et copier les DLL sherpa/whisper à côté, sinon `System32` peut
   interférer — voir §4.2 pour le détail du piège.)
2. `user-service` (natif) : `AUTH_JWT_SECRET=<secret> dart run bin/server.dart`
   — **même valeur** de `AUTH_JWT_SECRET` que celle passée à
   `generation-orchestrator` à l'étape suivante.
3. `generation-orchestrator` + `plot-service` + `board-render-service`
   (conteneurs) :
   `ANTHROPIC_API_KEY=<clé> AUTH_JWT_SECRET=<même secret> docker compose up --build`.
   `board-render-service` embarque `illimmi_app` dans son image (build plus
   long que les deux autres services, voir §4.5).
4. Client : `cd illimmi_app && flutter run -d windows` (ou `-d chrome`, etc.).

Vérifications rapides :
```
curl http://localhost:8082/health   # audio-service
curl http://localhost:8081/health   # user-service
curl http://localhost:8080/health   # generation-orchestrator
curl http://localhost:5000/health   # plot-service
curl http://localhost:5001/health   # board-render-service
```

Sans backend du tout, deux boutons "Charger l'exemple" dans l'UI (prompt
d'accueil) chargent directement un `.hc` local depuis `illimmi_app/courses/`
sans passer par le réseau — le moyen le plus rapide de tester le rendu seul.

---

## 8. Étude de cas récente — vérification end-to-end de l'alignement local

Contexte utile pour quiconque retouche `audio-service` : cette session a
servi à vérifier que le pipeline fonctionne réellement de bout en bout, en
particulier le modèle Whisper local tout juste installé dans
`speaker/whisper/model/`.

1. Un cours complet (~1250 mots, français) sur les barycentres a été rédigé
   à la main pour remplacer les Layers 1 et 3 (indisponibles sans clé
   Anthropic), tout en laissant le reste de la chaîne tourner réellement.
2. `audio-service` a été lancé pour de vrai (Piper + alignement local) — deux
   blocages découverts et corrigés en cours de route :
   - Chargement de `sherpa-onnx-c-api.dll` en échec en `dart run` pur (pas de
     mécanisme Flutter pour copier les DLL natives) → résolu en compilant
     (`dart compile exe`) et en plaçant les DLL à côté du binaire.
   - `LocalSherpaAligner` renvoyait une liste de timestamps vide (export ONNX
     sans cross-attention, confirmé en retéléchargeant l'archive officielle —
     fichier identique) → `WhisperCppAligner` a été implémenté comme
     alternative 100 % locale fonctionnelle (voir §4.2).
3. Curiosité notée en passant : le modèle `ggml-small` de whisper.cpp
   transcrit systématiquement "barycentre" en **"Barry Centre"** (confondu
   avec un nom propre anglophone) — sans conséquence pratique puisque seul le
   *timing* des mots sert à synchroniser les visuels, jamais le texte
   reconnu affiché à l'écran.
4. Le script final (`illimmi_app/courses/barycentres.hc`) a été assemblé et
   validé avec le **vrai** code de production
   (`course_assembler.dart` + `HypercourseParser`, pas une simulation), puis
   rendu accessible en un clic dans l'UI via un second bouton "Charger
   l'exemple : Barycentres" à côté de l'exemple existant.
5. Vérifié visuellement dans l'app Flutter réelle (captures d'écran) : lecture
   audio + synchronisation des visuels conformes au script.

Cette étude de cas illustre bien la philosophie du projet (§1) : même sans
LLM disponible, un script Hypercourse valide peut être écrit à la main et
lu exactement comme s'il avait été généré par le pipeline complet.

---

## 9. Étude de cas — world model visuel pour le Layer 3

Document de référence complet :
`services/generation-orchestrator/world-model-visual-feedback.md`. Ce qui
suit résume le problème, le changement de direction survenu en cours
d'implémentation, et les preuves de bon fonctionnement obtenues.

**Le problème.** `Layer3VisualGenerator` génère tout le script Hypercourse
d'un cours en un seul appel Claude, à partir d'un transcript timestampé et
de bornes numériques brutes (`x ∈ [0, 177.78], y ∈ [0, 100]`) — sans jamais
voir à quoi ressemble le tableau réellement rendu. Le seul garde-fou
existant (la boucle `previousAttempt`/`previousError` entre
`Layer3VisualGenerator` et l'assembleur) ne se déclenche que sur des erreurs
de **parsing syntaxique**, jamais sur une incohérence visuelle. D'où les
bugs observés : texte débordant du cadre, figures qui se chevauchent, texte
par-dessus une figure, flèches mal orientées.

**La solution retenue** : donner à l'IA un retour visuel réel du tableau.
Une fois le script parsé avec succès (`Course` construit), le tableau est
capturé en image à la fin de l'apparition de chaque élément
(`startTime + duration`, déjà calculé par le parseur — aucune nouvelle
logique de timing), puis ces captures sont envoyées à Claude avec le script
complet pour vérification, en réutilisant la boucle de retry existante.

**Le changement de direction en cours d'implémentation.** La proposition de
design initiale envisageait de générer un SVG maison (templating de string
à partir de l'état parsé) puis de le rasteriser en PNG via un micro-service
Python (`resvg`/CairoSVG), sur le modèle de `plot-service`. Un premier jet
de cette approche a été construit, puis **explicitement rejeté** suite à un
retour direct : une approximation SVG (texte brut à la place du LaTeX,
triangle fait main pour les têtes de flèche) ne reproduisait pas fidèlement
le tableau — en particulier, la géométrie des flèches ne correspondait pas
à ce que le lecteur affiche réellement. La décision finale : réutiliser **le
vrai code de rendu de production** d'`illimmi_app`
(`BoardPainter`/`ArrowHeadPainter`/`TextPatternFinder`/`LatexWidget`) plutôt
que d'en réimplémenter une version approximative, via un nouveau service
`board-render-service` qui invoque `flutter test` en subprocess sur un
harnais dédié (`illimmi_app/integration_test/board_render_harness_test.dart`) —
voir §4.5 et §4.6 pour le détail architectural.

**Preuves de bon fonctionnement obtenues cette session** (pas seulement en
théorie) :
- Un lot de test (texte LaTeX, cercle, flèche) rendu directement via le
  harnais `flutter test` : la flèche produite pointe correctement vers sa
  cible avec la vraie géométrie de `ArrowHeadPainter` — exactement le défaut
  que l'approximation SVG ne reproduisait pas.
- Le même lot rendu via une vraie requête HTTP `POST /render` contre
  `board-render-service` démarré localement (pas un mock) : image PNG 1600×900
  décodée et inspectée visuellement, cohérente avec le rendu direct.
- Suite de tests verte sur les trois projets touchés après l'implémentation :
  `dart test`/`dart analyze` sur `generation-orchestrator` (13 tests, dont un
  dédié au retry déclenché par un échec de vérification visuelle) et sur
  `board-render-service`, `flutter analyze`/`flutter test` sur `illimmi_app`
  (aucune régression sur les fichiers existants ; seul échec restant : le
  test template `widget_test.dart`, déjà documenté comme non adapté avant
  cette session).

**Limite assumée, pas corrigée.** `flutter test` substitue par défaut tout
texte par sa police de test "Ahem" (un carré par caractère). Le harnais
charge les polices réellement embarquées dans le bundle
(`load_bundled_fonts.dart`), ce qui suffit pour le LaTeX (les polices KaTeX
de `flutter_math_fork` sont bien déclarées comme assets de package), mais
pas pour le texte simple : `Roboto` n'est déclarée nulle part comme asset
dans ce projet (elle vient de la police système côté lecteur réel), donc
elle reste en "Ahem" dans les captures. La géométrie (position, boîte,
chevauchement, débordement, orientation des flèches) reste fidèle ; seule la
lisibilité du texte simple dans l'image est dégradée. Corriger ce point
demanderait de fournir un `Roboto.ttf` réel comme asset de test — non fait
dans cette itération.

Cette étude de cas illustre un principe transverse au projet : quand une
fonctionnalité dépend de la fidélité d'un rendu, réutiliser le code de rendu
réel (même au prix d'une architecture plus lourde — ici, un service Flutter
headless plutôt qu'un simple rasterizer SVG) bat une réimplémentation
approximative, précisément parce que la divergence entre les deux est le
genre de bug qui ne se voit qu'en le cherchant activement — ce qui a été le
cas ici.
