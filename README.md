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

## ⚡ Démarrage Rapide (En local)

### 1. Variables d'environnement
Exportez votre clé API Gemini :
```powershell
$env:GEMINI_API_KEY="votre_cle_gemini"
$env:AUTH_JWT_SECRET="change_moi_en_production"
```

### 2. Démarrer les services natifs Windows (`audio-service` & `user-service`)
```powershell
# Dans un premier terminal
cd services/audio-service ; dart pub get ; dart run bin/server.dart

# Dans un second terminal
cd services/user-service ; dart pub get ; dart run bin/server.dart
```

### 3. Démarrer les services conteneurisés (`generation-orchestrator`, `plot-service`, `board-render-service`)
```powershell
docker compose up --build
```

### 4. Lancer le client Flutter (`illimmi_app`)
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
