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
