# Corpus Pédagogique ILLIMMI — 1 000 Cours Lycée (Fine-Tuning Gemma)

> **Corpus de 1 000 cours, méthodes et exercices corrigés de niveau lycée (Seconde, Première, Terminale) pour le fine-tuning didactique du modèle Gemma dans l'architecture ILLIMMI (Layer 1 → Layer 2 → Layer 3).**

---

## 1. Vision & Philosophie du Corpus

Pour qu'une intelligence artificielle génère de véritables cours animés interactifs, elle ne doit pas se contenter d'aligner des faits ou de restituer passivement des cours magistraux. Elle doit **apprendre à enseigner** et **apprendre à guider un élève pas à pas dans la résolution d'un problème**.

Les vidéos de créateurs pédagogiques d'excellence (**Yvan Monka / M@ths et Tiques**, **Florence Raffin**, **Romain Bourdel**, **Amélie Vioux**, etc.) et leurs transcriptions constituent la **matière première pédagogique**. Ce corpus structure cette matière en cohérence absolue avec l'architecture tri-couche d'ILLIMMI :

```
[Matière Première Pédagogique (1 000 Vidéos & Transcriptions)]
                              │
                              ▼
        ┌──────────────────────────────────────────────┐
        │ Layer 1 : Planification Didactique           │
        │ - Découpage en 5 à 7 sections pédagogiques   │
        │ - Durée cible & concepts clés                │
        │ - Choix explicite du support visuel          │
        └──────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────────┐
        │ Layer 2 : Narration Audio & Guidage Visuel   │
        │ - Voix naturelle pour Piper TTS              │
        │ - Verbalisation orale des gestes graphiques  │
        │ - Zéro LaTeX brut à l'oral (prononciation)   │
        │ - Timestamps mot-à-mot <start>mot<end>       │
        └──────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────────┐
        │ Layer 3 : Rendu Visuel Hypercourse (.hc)     │
        │ - Coordonnées 16:9 déterministes             │
        │ - Primitives graphiques (2drep, 2dfunc, ...) │
        │ - Découpage en scènes Pré-Erase              │
        │ - Synchronisation temporelle mot-à-mot       │
        └──────────────────────────────────────────────┘
```

---

## 2. Répartition Exacte du Corpus (1 000 Entrées)

Le corpus respecte rigoureusement la répartition fixée :

| Discipline | Volume | Niveaux Couverts | Créateurs de Référence | Focus Didactique |
| :--- | :---: | :--- | :--- | :--- |
| **Mathématiques** | **500** | Seconde (130), 1ère Spé (195), Term Spé & Expertes (175) | **Yvan Monka (M@ths et Tiques)**, Sebastien Peyrot (jaicompris.com), Arnaud Bodin (Exo7) | Démonstrations, méthodes pas à pas, corrections d'exercices d'annales, problèmes à étapes multiples. |
| **Physique-Chimie** | **300** | Seconde (60), 1ère Spé (110), Term Spé (130) | **Florence Raffin**, **Romain Bourdel**, Paul Olivier, e-penser | Mécanique de Newton, dipôles RC, thermodynamique, ondes & optique, titrages et cinétique chimique. |
| **Langues — Français** | **100** | 1ère Générale (Épreuves Anticipées du Bac), 2nde | **Amélie Vioux (commentaire-compose.fr)**, Médusaces, Jean-Luc | Méthode du commentaire, dissertation, explication linéaire orale pas à pas, syntaxe & grammaire Bac. |
| **Langues — Anglais** | **100** | Cycle Terminal (B1/B2/C1), Tronc Commun | **BBC Learning English**, mmmEnglish (Emma), Oxford Online English | Conditionnels, voix passive, méthode de rédaction PEEL, argumentation, compréhension et débats. |
| **TOTAL** | **1 000** | **Lycée Complet (2nde, 1ère, Terminale)** | **100% Curaté et Typé** | **Couverture intégrale du programme** |

### Typologie Pédagogique Équilibrée
Chaque discipline combine harmonieusement les différents modes d'apprentissage :
- **`cours_notion`** : Découverte intuitive, motivation concrète et formalisation rigoureuse.
- **`methode_resolution`** : Algorithme intellectuel et trame rédactionnelle pas à pas.
- **`exemple_detaille`** : Étude de cas numérique ou textuelle décortiquée.
- **`correction_exercice`** : Exercice classique de lycée résolu avec explicitation des choix.
- **`probleme_complexe`** : Problème transversal type Bac nécessitant plusieurs étapes de raisonnement.
- **`synthese_revision`** : Fiche mémo, pièges d'examen et carte mentale.

---

## 3. Structure de l'Arborescence

```
corpus_illimmi_1000/
├── README.md                      # Guide central (ce document)
├── SCHEMA.md                      # Spécification exhaustive du modèle de données
├── schema.json                    # Schéma JSON formel (draft-07)
│
├── catalog/                       # Catalogues structurés
│   ├── corpus_1000_full.json      # Dataset intégral des 1 000 cours
│   ├── corpus_1000_manifest.csv   # Manifeste tabulaire complet pour tableurs/audits
│   ├── math_500.json              # Les 500 cours de Mathématiques
│   ├── physique_300.json          # Les 300 cours de Physique-Chimie
│   └── langues_200.json           # Les 200 cours de Langues (100 FR + 100 EN)
│
├── exemplars/                     # Exemples Golden complets de bout en bout
│   ├── math_derivation_tangente/
│   ├── math_exercice_bac_suites/
│   ├── physique_mouvement_newton/
│   ├── physique_titrage_acide_base/
│   ├── francais_analyse_lineaire_poesie/
│   └── anglais_conditionals_argumentation/
│
├── training_data/                 # Datasets JSONL prêts pour Fine-Tuning Gemma
│   ├── gemma_layer1_planner.jsonl
│   ├── gemma_layer2_audio.jsonl
│   ├── gemma_layer3_visuals.jsonl
│   └── gemma_illimmi_complete_3000_samples.jsonl
│
├── transcripts/                   # Transcriptions & Timestamps
│   ├── raw/                       # Textes bruts
│   └── processed/                 # Timelines compactes <start>mot<end>
│
└── tools/                         # Boîte à outils logicielle Python
    ├── generate_corpus.py         # Générateur déterministe du corpus
    ├── validate_corpus.py         # Validateur d'intégrité et de quotas
    ├── fetch_transcripts.py       # Extracteur de sous-titres YouTube
    └── export_gemma_finetuning.py # Exposteur de datasets pour SFT / LoRA
```

---

## 4. Les 6 Exemples « Golden » de Référence

Chaque dossier d'exemple dans [`exemplars/`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars) fournit l'intégralité des 5 artefacts de transformation :
1. `raw_transcript.txt` : Transcription fidèle de la vidéo du professeur.
2. `metadata_layer1.json` : Sortie structurée de Layer 1 (Planification pédagogique avec les 5 à 7 sections).
3. `narration_layer2.txt` : Narration parlée fluide pour Piper TTS (verbalisation des gestes, sans LaTeX brut).
4. `timeline_words_layer2.txt` : Chronologie mot-à-mot normalisée `<start>mot<end>`.
5. `course_layer3.hc` : Script officiel Hypercourse DSL prêt pour le rendu ILLIMMI.

| Dossier | Sujet | Type Pédagogique | Points Forts de l'Alignement |
| :--- | :--- | :--- | :--- |
| [`math_derivation_tangente`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/math_derivation_tangente) | Nombre dérivé et tangente (1ère) | Cours & Géométrie | Mouvement limite de la sécante vers la tangente, tracé de la parabole, calcul sur $x^2$. |
| [`math_exercice_bac_suites`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/math_exercice_bac_suites) | Suite arithmético-géométrique (Term) | Correction d'exercice Bac | Recherche du point fixe, suite géométrique auxiliaire, justification de limite avec $\|q\| < 1$. |
| [`physique_mouvement_newton`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/physique_mouvement_newton) | 2ème Loi de Newton & Chute libre (Term) | Problème de mécanique | Bilan des forces, simplification de la masse ($m \vec{g} = m \vec{a}$), parabole de trajectoire. |
| [`physique_titrage_acide_base`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/physique_titrage_acide_base) | Titrage acido-basique (Term) | Méthode & Expérience | Courbe de pH en S, méthode géométrique des tangentes parallèles, calcul de $c_A$. |
| [`francais_analyse_lineaire_poesie`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/francais_analyse_lineaire_poesie) | Baudelaire « L'Albatros » (1ère) | Explication linéaire Oral Bac | Découpage en 3 mouvements, formule d'or (Procédé + Citation + Sens), alerte anti-paraphrase. |
| [`anglais_conditionals_argumentation`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/exemplars/anglais_conditionals_argumentation) | Conditionals & PEEL Method (Term) | Méthode d'écriture B2/C1 | Matrice des conditionnels (1st, 2nd, 3rd), paragraphe PEEL sur l'IA, piège « would in if ». |

---

## 5. Mode d'Emploi des Outils Python

Tous les scripts sont situés dans [`tools/`](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/corpus_illimmi_1000/tools) et s'exécutent avec Python standard (3.10+) :

### 1. Régénération / Mise à jour du catalogue
```bash
python corpus_illimmi_1000/tools/generate_corpus.py
```

### 2. Audit & Validation automatique de conformité
Vérifie les quotas (500 Maths, 300 Physique, 100 FR, 100 EN), l'unicité des 1 000 identifiants et le schéma :
```bash
python corpus_illimmi_1000/tools/validate_corpus.py
```

### 3. Récupération et traitement des transcriptions
```bash
# Traiter un cours spécifique
python corpus_illimmi_1000/tools/fetch_transcripts.py --id MATH_013

# Traiter un lot de cours d'une discipline
python corpus_illimmi_1000/tools/fetch_transcripts.py --subject "Mathématiques" --limit 20

# Traiter l'intégralité du corpus
python corpus_illimmi_1000/tools/fetch_transcripts.py --all
```

### 4. Export des Datasets pour le Fine-Tuning de Gemma
Génère les fichiers JSONL au format Chat pour Unsloth, Hugging Face `trl` ou Vertex AI :
```bash
python corpus_illimmi_1000/tools/export_gemma_finetuning.py --format jsonl --split all
```

---

## 6. Protocole de Fine-Tuning de Gemma

### Modèles Recommandés
- **Gemma 2 9B-IT** : Excellent compromis performance/mémoire, parfait pour l'inférence rapide sur serveur avec GPU 24 Go.
- **Gemma 2 27B-IT** : Modèle haute fidélité pour le raisonnement mathématique complexe et la génération géométrique fine.
- **Gemma 3 (Flash / Instruct)** : Dernières avancées multimodales de Google.

### Stratégie d'Entraînement Multi-Tâches
Pour une efficacité maximale, Gemma est entraîné sur **3 tâches spécialisées** correspondant aux 3 layers :

1. **Tâche `layer1_planning`** :
   - *Entrée* : Prompt utilisateur (ex: *"Explique-moi le théorème des valeurs intermédiaires avec un exercice corrigé"*).
   - *Sortie* : JSON `CourseMetadata` respectant le plan pédagogique strict (accroche, prérequis, exemple concret, méthode, décomposition, piège fréquent, synthèse).

2. **Tâche `layer2_narration`** :
   - *Entrée* : JSON `CourseMetadata`.
   - *Sortie* : Narration parlée fluide, tutoiement bienveillant, verbalisation orale obligatoire des appuis visuels, et formules mathématiques écrites en phonétique naturelle.

3. **Tâche `layer3_visuals`** :
   - *Entrée* : Chronologie mot-à-mot horodatée (`compactTimeline`) + `CourseMetadata`.
   - *Sortie* : Script Hypercourse complet `.hc` découpé par des commandes `erase` et exploitant toutes les primitives graphiques du tableau blanc.
