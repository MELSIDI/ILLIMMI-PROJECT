---
name: dsl_dev-to-main
description: Synchronize and merge all changes from development branch dsl_dev into main - commits and pushes dsl_dev if needed, merges into main, pushes main to GitHub, and switches back to dsl_dev. Triggered by "dsl_dev -> main", "/dsl_dev-to-main", or "sync dsl_dev to main".
---

# Skill: Synchronisation `dsl_dev -> main`

Utilise ce skill chaque fois que l'utilisateur écrit dans le chat :
- `dsl_dev -> main`
- `dsl_dev to main`
- `/dsl_dev-to-main`
- « merge dsl_dev dans main » ou « synchronise dsl_dev vers main »

---

## Objectif & Garantie

1. **Commit & Push sur `dsl_dev`** : Si des modifications restent en local sur `dsl_dev`, elles sont indexées, commitées et poussées sur `origin/dsl_dev`.
2. **Bascule & Mise à jour de `main`** : Bascule sur la branche `main` (`git checkout main`) et tire les dernières modifications (`git pull origin main`).
3. **Fusion sécurisée** : Intègre l'ensemble de l'historique et des fonctionnalités de `dsl_dev` dans `main` (`git merge dsl_dev`).
4. **Push distant de `main`** : Pousse `main` sur GitHub (`git push origin main`).
5. **Retour garanti sur `dsl_dev`** : Bascule immédiatement de nouveau sur `dsl_dev` (`git checkout dsl_dev`), qui reste la branche active permanente de développement.
6. **Notification obligatoire** : Affiche les commits, branches et états de push conformément aux règles du projet.

---

## Méthode d'exécution

### Option A — Script automatisé (Recommandé)

Exécute directement le script autonome :

```powershell
python ".agents/skills/dsl_dev-to-main/scripts/sync_dsl_dev_to_main.py"
```

*(Possibilité de préciser un message de commit pour les éventuelles modifs en attente : `--message "feat: description"`).*

### Option B — Séquence de commandes Git manuelles

Si tu dois exécuter les étapes manuellement :

```powershell
# 1. Vérification et commit sur dsl_dev si nécessaire
git checkout dsl_dev
git add -A
git commit -m "chore(dsl_dev): commit pending changes before sync to main"
git push origin dsl_dev

# 2. Bascule et pull sur main
git checkout main
git pull origin main

# 3. Fusion de dsl_dev dans main
git merge dsl_dev -m "merge: sync dsl_dev into main"

# 4. Push de main sur GitHub
git push origin main

# 5. Retour obligatoire sur dsl_dev
git checkout dsl_dev
```

---

## Rapport Obligatoire post-synchronisation

Dès que la synchronisation est terminée, indiquer à l'utilisateur :
- Hash et message du commit sur `dsl_dev` (avec mention `Poussé sur origin/dsl_dev`).
- Hash et message du merge commit sur `main` (avec mention `Poussé sur origin/main`).
- Confirmation que la branche active courante est bien revenue sur `dsl_dev`.
