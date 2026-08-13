# ILLIMMI — Plateforme de Génération & Rendu de Cours Interactifs

> **Transforme une simple idée ("Explique-moi les dérivées") en une leçon dynamique synchronisée sur un tableau blanc animé.**

---

## 📚 Documentation Officielle (`docs/`)

Toute la documentation technique du projet est centralisée et maintenue dans le dossier **[`docs/`](./docs/)** :

1. 🏛️ **[docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)** : Découpage microservices, diagrammes de séquence, ports et communication.
2. 📜 **[docs/HYPERCOURSE_DSL.md](./docs/HYPERCOURSE_DSL.md)** : Spécification officielle du langage Hypercourse (`.hc`), repère 16:9 et grammaire.
3. 🤖 **[docs/AI_PIPELINE.md](./docs/AI_PIPELINE.md)** : Pipeline IA à 3 Couches, intégration de **Google Gemini** (`gemini-2.5-flash`) & Feedback Visuel Pré-Erase ($N_{\text{images}} = \text{count}(\text{erase}) + 1$).
4. 🛠️ **[docs/DEVELOPMENT_GUIDE.md](./docs/DEVELOPMENT_GUIDE.md)** : Guide de démarrage pas-à-pas en local (Docker & Natif), variables d'environnement et exécution des tests.
5. 🔍 **[docs/DISCOVERY_AUDIT.md](./docs/DISCOVERY_AUDIT.md)** : Audit d'architecture, vision produit et opportunités d'amélioration.

---

## ⚡ Démarrage Rapide Automatisé (1 seule commande)

Exécutez simplement le script d'automatisation tout-en-un (PowerShell / Batch) :

```powershell
.\start.ps1
```
*ou double-cliquez sur `start.bat`.*

**Ce script s'occupe de tout :**
1. 🔑 **Auto-détection GCP** : Récupère automatiquement votre projet GCP et votre jeton de crédits (`$300 offerts`) si `gcloud` est installé.
2. 📦 **Dépendances** : Installe automatiquement les dépendances `dart pub get` si nécessaire.
3. 🎙️ **Services Natifs** : Lance `audio-service` (port 8082) et `user-service` (port 8081) en arrière-plan.
4. 🐳 **Stack Docker** : Compile et lance `generation-orchestrator` (8080), `plot-service` (5000) et `board-render-service` (5001) via Docker Compose.

---

## 🛠️ Lancement Manuel (Étape par étape)

### 1. Variables d'environnement
```powershell
$env:GCP_PROJECT_ID="mon-projet-gcp"
$env:GCP_ACCESS_TOKEN=(gcloud auth print-access-token)
$env:AUTH_JWT_SECRET="change_moi_en_production"
```

### 2. Démarrer les services natifs Windows (`audio-service` & `user-service`)
```powershell
# Premier terminal
cd services/audio-service ; dart pub get ; dart run bin/server.dart

# Second terminal
cd services/user-service ; dart pub get ; dart run bin/server.dart
```

### 3. Démarrer la stack Docker
```powershell
docker compose up --build
```

### 4. Lancer l'application Flutter (`illimmi_app`)
```powershell
cd illimmi_app
flutter run -d windows
```

---

## 🧪 Vérification de l'état de la stack

```bash
curl http://localhost:8082/health   # audio-service
curl http://localhost:8081/health   # user-service
curl http://localhost:8080/health   # generation-orchestrator
curl http://localhost:5000/health   # plot-service
curl http://localhost:5001/health   # board-render-service
```
