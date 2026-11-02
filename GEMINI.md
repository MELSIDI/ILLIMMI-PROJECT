# Directives & Règles du Projet ILLIMMI

## Règle de Notification Systématique sur le Statut Git / Push

Chaque fois que des modifications sont apportées au projet (création, modification ou suppression de code, documentation, scripts, règles, configurations) :

1. **Si les modifications SONT poussées sur le dépôt distant (Git / GitHub)** :
   - **Notification obligatoire** : Indiquer explicitement à l'utilisateur que les modifications ont été poussées.
   - Préciser la branche (ex: `dsl_dev` / `origin/dsl_dev`), le ou les hashs de commit et le message de commit associé.

2. **Si les modifications NE SONT PAS poussées sur le dépôt distant** :
   - **Notification obligatoire** : Indiquer explicitement à l'utilisateur que les modifications restent en local (dans le working tree ou commitées localement sans push).
   - Proposer si l'utilisateur souhaite les pousser immédiatement sur le remote.

> **Règle absolue** : Ne jamais terminer une réponse après une modification sans déclarer clairement si les modifications ont été poussées ou non sur le remote.

---

## Règle de Commande "dsl_dev -> main"

Chaque fois que l'utilisateur écrit dans le chat **`dsl_dev -> main`** (ou une variation telle que `dsl_dev to main`, `/dsl_dev-to-main`, ou demande de synchroniser/fusionner `dsl_dev` dans `main`) :

1. **Vérifier et committer `dsl_dev`** : Si des modifications restent non commitées sur `dsl_dev`, les committer et exécuter `git push origin dsl_dev`.
2. **Basculer sur `main`** : Exécuter `git checkout main` (sans faire de pull distant).
3. **Fusionner `dsl_dev` dans `main`** : Exécuter `git merge dsl_dev -m "merge: sync dsl_dev into main"`.
4. **Pousser `main` sur GitHub** : Exécuter `git push origin main`.
5. **Revenir immédiatement sur `dsl_dev`** : Exécuter `git checkout dsl_dev` car `dsl_dev` est la branche active de développement des nouvelles fonctionnalités.
6. **Notifier l'utilisateur** en détaillant les commits poussés sur `origin/dsl_dev` et sur `origin/main`, et en confirmant que le dépôt est de retour sur `dsl_dev`.

*(Le script autonome dédié `python ".agents/skills/dsl_dev-to-main/scripts/sync_dsl_dev_to_main.py"` réalise cette séquence de façon sécurisée et atomique).*
