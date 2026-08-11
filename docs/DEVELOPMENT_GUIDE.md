# Guide de Développement & Déploiement Local

> **Guide étape par étape pour installer, exécuter, tester et contribuer au projet ILLIMMI.**

---

## 1. Prérequis Système

| Composant | Outil / Version requise |
| :--- | :--- |
| **OS** | Windows 10/11 (Recommandé pour `audio-service` natif) ou Linux/macOS |
| **SDK Dart / Flutter** | Flutter 3.x / Dart 3.x |
| **Docker** | Docker Desktop & Docker Compose v2+ |
| **Clé API IA** | `GEMINI_API_KEY` (Google Generative Language API) |

---

## 2. Variables d'Environnement

Créez un fichier `.env` à la racine du projet ou définissez les variables suivantes dans votre terminal :

```bash
# Clef API IA principale (Requis)
GEMINI_API_KEY="AIzaSy..."
GEMINI_MODEL="gemini-2.5-flash"   # Optionnel, défaut: gemini-2.5-flash

# Clef facultative si utilisation d'un autre client IA
ANTHROPIC_API_KEY="sk-ant-..."

# Secret partage pour la verification JWT inter-services
AUTH_JWT_SECRET="change_moi_en_production"

# URLs des microservices (Valeurs par defaut locales)
AUDIO_SERVICE_URL="http://localhost:8082"
USER_SERVICE_URL="http://localhost:8081"
PLOT_SERVICE_URL="http://localhost:5000"
BOARD_RENDER_SERVICE_URL="http://localhost:5001"
```

---

## 3. Procédure de Démarrage pas à pas

En raison de la présence du binaire natif Windows Piper TTS (`audio-service`), la stack s'exécute en combinant des services natifs et des conteneurs Docker.

### Étape 1 : Démarrer `audio-service` (Process Natif)
```powershell
cd services/audio-service
dart pub get
dart run bin/server.dart
```
*Le service écoute sur `http://localhost:8082`.*

---

### Étape 2 : Démarrer `user-service` (Process Natif)
```powershell
cd services/user-service
dart pub get
$env:AUTH_JWT_SECRET="change_moi_en_production"
dart run bin/server.dart
```
*Le service écoute sur `http://localhost:8081`.*

---

### Étape 3 : Démarrer la stack Docker (`generation-orchestrator`, `plot-service`, `board-render-service`)
Depuis la racine du projet :
```powershell
$env:GEMINI_API_KEY="votre_cle_gemini"
$env:AUTH_JWT_SECRET="change_moi_en_production"
docker compose up --build
```

**Services conteneurisés démarrés :**
- `generation-orchestrator` : `http://localhost:8080`
- `plot-service` : `http://localhost:5000`
- `board-render-service` : `http://localhost:5001`

---

### Étape 4 : Lancer le client Flutter (`illimmi_app`)
```powershell
cd illimmi_app
flutter pub get
flutter run -d windows
```

---

## 4. Tests & Vérification de la Stack

### Vérification de la santé des microservices (Healthchecks)
```powershell
curl http://localhost:8082/health
curl http://localhost:8081/health
curl http://localhost:8080/health
curl http://localhost:5000/health
curl http://localhost:5001/health
```

### Lancer les tests unitaires Dart
```powershell
cd services/generation-orchestrator
dart test
```

### Lancer les tests du client Flutter
```powershell
cd illimmi_app
flutter test
```
