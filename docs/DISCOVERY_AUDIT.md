# Audit & Pistes d'Amélioration du Projet ILLIMMI

> **Synthèse d'audit technique et opportunités d'amélioration basées sur l'analyse complète du code source.**

---

## 1. Origine & Vision du Projet

ILLIMMI résout le problème de la création automatique de contenus pédagogiques interactifs. L'objectif est d'offrir une expérience similaire à un cours dispensé par un professeur humain sur un tableau blanc animé, tout en maintenant des coûts de calcul et de transfert négligeables par rapport à la vidéo traditionnelle.

### Pourquoi le DSL Hypercourse `.hc` est supérieur à la vidéo MP4 :
1. **Rendu 100% vectoriel et déterministe** : Aucune dégradation de qualité peu importe la résolution d'écran.
2. **Rejouabilité instantanée** : Sauvegarder un cours ne coûte que quelques Ko dans SQLite.
3. **Validation et auto-correction** : Un script texte peut être parsé, analysé et corrigé par un compilateur strict avant d'être montré à l'étudiant.

---

## 2. Synthèse de l'Audit du Codebase

### Points Forts
- **Séparation stricte des responsabilités** entre la génération IA (orchestrateur) et le rendu graphique (`illimmi_app`).
- **Moteur temporel performant** : Utilisation d'arbres de segments (`FamilyForest` / `SegmentNode`) dans `illimmi_app` pour des requêtes temporelles en $O(\log N)$ à 60 FPS.
- **Rendu fidèle en Headless** : Le microservice `board-render-service` réutilise directement le vrai code Flutter (`BoardPainter`, `LatexWidget`, `ArrowHeadPainter`) pour éviter toute divergence de rendu.
- **Stratégie de capture pré-erase optimale** : Réduction du nombre d'images de vérification à $N_{\text{images}} = \text{count}(\text{erase}) + 1$.

---

## 3. Pistes d'Amélioration Recommandées

### A. Optimisation du Rendu Headless (`board-render-service`)
- **Problème actuel** : Chaque lot de capture invoque un subprocess `flutter test` qui redémarre le moteur Flutter.
- **Amélioration** : Implémenter un daemon Flutter persistant sur un socket local pour éliminer le coût d'initialisation du moteur Flutter entre deux requêtes.

### B. Gestion des Polices & Glyph KaTeX dans les Captures Headless
- **Problème actuel** : En mode headless `flutter test`, les polices système non bundlées (ex: `Roboto`) utilisent la police de test "Ahem" (carrés), bien que KaTeX soit correctement chargé.
- **Amélioration** : Bundler `Roboto.ttf` dans les assets du harnais de test pour permettre la lecture OCR du texte simple par le modèle multimodal.

### C. Fine-tuning d'un Modèle Spécialisé (Gemma / Llama)
- **Vision à terme** : Remplacer ou alléger la dépendance aux API de LLM propriétaires pour la génération du Layer 3 (appuis visuels `.hc`) en entraînant un modèle local fine-tuné sur un dataset de paires (Audio/Transcript $\to$ Script `.hc`).

### D. Layout Dynamique & Contraintes de Texte côté Rendu
- **Amélioration** : Borner automatiquement les boîtes de texte dans `illimmi_app` (`LatexWidget`) avec un wrap automatique et un saut de ligne automatique lorsque le texte approche le bord droit du tableau (`x > 170`).
