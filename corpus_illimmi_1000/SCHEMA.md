# Spécification du Schéma de Données — Corpus ILLIMMI 1 000

Le corpus a été conçu pour structurer la matière première pédagogique issue des meilleurs cours et exercices de niveau lycée (avec Yvan Monka, Florence Raffin, Amélie Vioux, etc.) afin de former et fine-tuner le modèle **Gemma** pour ILLIMMI.

---

## 1. Structure d'une Entrée du Corpus

Chaque cours du corpus est représenté par un objet JSON strict répondant au schéma formel [`schema.json`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/schema.json).

```json
{
  "id": "MATH_013",
  "subject": "Mathématiques",
  "level": "Première Spécialité",
  "domain": "Analyse",
  "title": "Nombre dérivé et taux de variation — Cours fondamental et définitions",
  "pedagogical_type": "cours_notion",
  "creator": "Yvan Monka (M@ths et Tiques)",
  "search_query": "Yvan Monka Première Spécialité Nombre dérivé et taux de variation cours notion",
  "pedagogical_target": "Maîtriser la définition rigoureuse et le cadre théorique de : Nombre dérivé et taux de variation.",
  "layer1_spec": {
    "duration_target": 150,
    "concepts_cles": [
      "sécante",
      "limite du taux d'accroissement",
      "pente de la tangente"
    ],
    "ton": "bienveillant, rigoureux et stimulant",
    "plan_pedagogique": [
      {
        "section": "accroche",
        "role": "Section accroche pour Nombre dérivé",
        "support_visuel_suggere": "draw 2drep"
      },
      {
        "section": "prerequis",
        "role": "Section prerequis pour Nombre dérivé",
        "support_visuel_suggere": "draw curve"
      },
      {
        "section": "exemple_concret",
        "role": "Section exemple_concret pour Nombre dérivé",
        "support_visuel_suggere": "draw line"
      },
      {
        "section": "definition_formelle",
        "role": "Section definition_formelle pour Nombre dérivé",
        "support_visuel_suggere": "mouse move"
      },
      {
        "section": "synthese",
        "role": "Section synthese pour Nombre dérivé",
        "support_visuel_suggere": "draw 2drep"
      }
    ]
  },
  "layer2_spec": {
    "style_guidance": "Narration orale fluide pour Piper TTS, tutoiement bienveillant, explicitation orale des gestes du professeur.",
    "spoken_math_rule": "Aucun code LaTeX brut à l'oral. Prononciation littérale fluide ('x au carré' et non '$x^2$').",
    "visual_anchor_verbalization": "Rapprochons le point sécant vers le point d'ancrage pour voir naître la tangente."
  },
  "layer3_spec": {
    "hypercourse_primitives": ["draw 2drep", "draw curve", "draw line", "mouse move"],
    "recommended_scene_count": 5,
    "viewport": "16:9 (x in [0, 177.78], y in [0, 100])",
    "pre_erase_validation": true
  }
}
```

---

## 2. Description des Champs

### Métadonnées Générales
| Champ | Type | Description |
| :--- | :--- | :--- |
| `id` | `string` | Identifiant canonique : `MATH_XXX`, `PHYS_XXX`, `LANG_FR_XXX`, `LANG_EN_XXX`. |
| `subject` | `string` | Discipline : `Mathématiques`, `Physique-Chimie`, `Français`, `Anglais`. |
| `level` | `string` | Niveau lycée : `Seconde`, `Première Générale / Spécialité`, `Terminale Spécialité / Tronc Commun / Expertes`. |
| `domain` | `string` | Branche thématique (Analyse, Mécanique, Grammaire Bac, Essay Writing, etc.). |
| `title` | `string` | Intitulé explicite et didactique de la leçon ou du problème. |
| `pedagogical_type` | `enum` | Rôle pédagogique du contenu : <ul><li>`cours_notion` : découverte et formalisation</li><li>`methode_resolution` : algorithme mental et démarche</li><li>`exemple_detaille` : application guidée</li><li>`correction_exercice` : exercice type corrigé pas à pas</li><li>`probleme_complexe` : problème type Bac à étapes multiples</li><li>`synthese_revision` : mémo et carte mentale</li></ul> |
| `creator` | `string` | Chaîne ou professeur de référence (ex. Yvan Monka, Florence Raffin, Amélie Vioux). |
| `search_query` | `string` | Requête textuelle optimisée pour la récupération automatique des sous-titres et vidéos. |
| `pedagogical_target` | `string` | Compétence cible acquise par l'élève et que Gemma doit apprendre à transmettre. |

---

## 3. Alignement avec l'Architecture 3-Layers d'ILLIMMI

### `layer1_spec` : Planification Pédagogique
- **`duration_target`** : Durée cible de la narration en secondes (entre 60s et 300s, ~2.2 secondes par idée).
- **`concepts_cles`** : Liste des notions fondamentales que le cours doit impérativement aborder.
- **`ton`** : Climat pédagogique imposé au modèle (ex: "bienveillant, rigoureux et stimulant").
- **`plan_pedagogique`** : Découpage obligatoire en 4 à 7 sections structurées selon la progression didactique ILLIMMI :
  1. `accroche` : Motivation concrète et contextualisation.
  2. `prerequis` : Rappel bref de ce qui doit être connu.
  3. `exemple_concret` : Cas simple abordé avant toute abstraction.
  4. `definition_formelle` / `methode` : Énoncé rigoureux ou algorithme de résolution.
  5. `decomposition` : Raisonnement pas à pas, preuve ou calcul détaillé.
  6. `erreur_frequente` : Piège classique explicitement formulé et déjoué.
  7. `synthese` : Bilan et ouverture.

### `layer2_spec` : Narration Audio & Guidage Visuel
- **`style_guidance`** : Recommandations pour la synthèse vocale Piper TTS (ton naturel, rythme, pas de puces télégraphiques récitées).
- **`spoken_math_rule`** : Interdiction du LaTeX brut dans l'audio. Remplacement par des formes phonétiques lisibles (ex: "vecteur A B", "intégrale de a à b de f de x d x").
- **`visual_anchor_verbalization`** : Phrases orales clés qui verbalisent le geste visuel (ex: *"Traçons la tangente..."*, *"Regarde ce vecteur..."*). Ces phrases constituent les ancres temporelles utilisées par Layer 3.

### `layer3_spec` : Représentation Visuelle Hypercourse (`.hc`)
- **`hypercourse_primitives`** : Commandes graphiques recommandées (`draw 2drep`, `draw 2dfunc`, `draw curve`, `draw arrow`, `draw polygone`, `draw circle`, `draw line`, `text`, `mouse move`).
- **`recommended_scene_count`** : Nombre de scènes délimitées par des commandes `erase` ($N_{\text{images}} = \text{count}(\text{erase}) + 1$).
- **`viewport`** : Repère normalisé 16:9 ($x \in [0, 177.78]$, $y \in [0, 100]$).
- **`pre_erase_validation`** : Activation du contrôle visuel multimodal pré-effacement.
