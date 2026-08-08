# ILLIMMI — architecture microservices

ILLIMMI est composé d'un client Flutter (rendu pur, joue un script Hypercourse
`.hc` + un fichier audio) et de quatre microservices qui génèrent ce script à
partir d'un prompt utilisateur :

- **`services/generation-orchestrator`** (Dart) — planification (Layer 1),
  narration + appuis visuels (Layer 3), assemblage, validation et
  vérification visuelle du script. Port `8080`.
- **`services/audio-service`** (Dart) — synthèse vocale (Piper) + alignement
  mot-à-mot. Sert aussi les fichiers `.wav` générés. Port `8082`.
- **`services/plot-service`** (Python/FastAPI) — rendu des commandes `plot`
  (snippets Python → HTML interactif). Port `5000`.
- **`services/board-render-service`** (Dart/Flutter) — rendu headless du
  tableau (le vrai `BoardPainter`/`LatexWidget` d'`illimmi_app`, via
  `flutter test` invoqué en subprocess) pour la vérification visuelle du
  Layer 3 — voir `services/generation-orchestrator/world-model-visual-feedback.md`.
  Port `5001`. `generation-orchestrator` en a besoin pour terminer une
  génération sans erreur.
- **`services/user-service`** (Dart) — comptes utilisateurs (inscription/
  connexion) et historique des cours générés (SQLite). Port `8081`. La
  connexion est optionnelle : l'app fonctionne sans jamais s'y connecter.

## Lancer la stack en local

`docker-compose up` ne suffit **pas** à lui seul : `audio-service` enveloppe
`speaker/piper/piper.exe`, un binaire Windows natif — un conteneur Linux ne
peut pas l'exécuter, et un conteneur Windows serait disproportionné pour un
simple subprocess. `audio-service` tourne donc en process natif sur l'hôte,
à côté des trois autres services containerisés.

1. **Démarrer `audio-service`** (process natif Windows) :
   ```
   cd services/audio-service
   dart pub get
   dart run bin/server.dart
   ```
   Écoute sur `http://localhost:8082`. Variables d'environnement optionnelles :
   `PIPER_EXE_PATH`, `PIPER_MODEL_PATH`, `AUDIO_OUTPUT_DIR`, `PUBLIC_BASE_URL`
   (défaut `http://localhost:8082`), `ALIGNER_BACKEND` (`local` | `remote`,
   défaut `remote`), `OPENAI_API_KEY` (si `remote`).

2. **Démarrer `user-service`** (process natif, comme `audio-service`) :
   ```
   cd services/user-service
   dart pub get
   AUTH_JWT_SECRET=change_moi dart run bin/server.dart
   ```
   Écoute sur `http://localhost:8081`. `AUTH_JWT_SECRET` doit être **la même
   valeur** que celle passée à `generation-orchestrator` (variable
   `AUTH_JWT_SECRET` également) — c'est ce secret partagé qui permet à
   l'orchestrator de vérifier un token sans appeler `user-service`.

3. **Démarrer `generation-orchestrator`, `plot-service` et
   `board-render-service`** (containerisés) :
   ```
   ANTHROPIC_API_KEY=sk-ant-... AUTH_JWT_SECRET=change_moi docker compose up --build
   ```
   `generation-orchestrator` écoute sur `http://localhost:8080`, `plot-service`
   sur `http://localhost:5000`, `board-render-service` sur `http://localhost:5001`.
   Le build de `board-render-service` embarque `illimmi_app` (image Flutter,
   plus lourde/lente à builder que les deux autres) — voir le Dockerfile pour
   le détail.

4. **Lancer le client Flutter** :
   ```
   cd illimmi_app
   flutter run -d windows
   ```

## Vérification rapide

```
curl http://localhost:8082/health
curl http://localhost:8081/health
curl http://localhost:8080/health
curl http://localhost:5000/health
curl http://localhost:5001/health
```

Voir le détail des routes et des contrats dans chaque service.
