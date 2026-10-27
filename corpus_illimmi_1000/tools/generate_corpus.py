#!/usr/bin/env python3
"""
Générateur du Catalogue 1 000 cours Lycée pour ILLIMMI (Lean Schema).
Produit le catalogue exhaustif de 1 000 cours épuré de toute métadonnée artificielle :
- Pas de layer1_spec, layer2_spec, layer3_spec.
- Uniquement : id, subject, level, domain, title, author, youtube_video_id, youtube_url, transcript_available.
- Synchronisation automatique des transcriptions réelles existantes sur disque.

Répartition :
- 500 Mathématiques (priorité Yvan Monka / M@ths et Tiques)
- 300 Physique-Chimie (Florence Raffin / Romain Bourdel / Paul Olivier)
- 200 Langues (100 Français : Amélie Vioux / Médusaces, 100 Anglais : BBC / mmmEnglish / Oxford)
"""

import json
import csv
import os
import re
from pathlib import Path
from typing import List, Dict, Any

ROOT_DIR = Path(__file__).resolve().parent.parent
CATALOG_DIR = ROOT_DIR / "catalog"
TRANSCRIPTS_PROC_DIR = ROOT_DIR / "transcripts" / "processed"
TRANSCRIPTS_RAW_DIR = ROOT_DIR / "transcripts" / "raw"
CATALOG_DIR.mkdir(parents=True, exist_ok=True)

# ---------------------------------------------------------------------------
# AUTEURS & CHAÎNES OFFICIELLES DU LYCÉE
# ---------------------------------------------------------------------------

AUTHORS = {
    "math_primary": "Yvan Monka",
    "math_secondary": "Sebastien Peyrot",
    "math_tertiary": "Arnaud Bodin",
    "phys_primary": "Florence Raffin",
    "phys_secondary": "Romain Bourdel",
    "phys_tertiary": "Paul Olivier",
    "fr_primary": "Amélie Vioux",
    "fr_secondary": "Médusaces",
    "en_primary": "BBC Learning English",
    "en_secondary": "mmmEnglish",
    "en_tertiary": "Oxford Online English",
}


def create_course_entry(
    item_id: str,
    subject: str,
    level: str,
    domain: str,
    title: str,
    author: str,
    search_query: str = ""
) -> Dict[str, Any]:
    """Fabrique une entrée épurée (Lean Schema) sans layers ni métadonnées fictives."""
    return {
        "id": item_id,
        "subject": subject,
        "level": level,
        "domain": domain,
        "title": title,
        "author": author,
        "search_query": search_query,
        "youtube_video_id": "",
        "youtube_url": "",
        "youtube_video_title": "",
        "transcript_available": False,
        "transcript_words_count": 0
    }


# ---------------------------------------------------------------------------
# GÉNÉRATEUR MATHÉMATIQUES (500 COURS)
# ---------------------------------------------------------------------------

def generate_math_courses() -> List[Dict[str, Any]]:
    """Génère exactement 500 entrées mathématiques lycée."""
    items: List[Dict[str, Any]] = []

    modules = [
        # --- SECONDE (Modules 1 à 10 : 100 cours) ---
        ("Seconde", "Nombres & Calculs", "Intervalles et encadrements de réels",
         ["notion d'intervalle", "intersection et union", "inégalités strictes et larges"]),
        ("Seconde", "Nombres & Calculs", "Valeur absolue et distance sur la droite réelle",
         ["définition valeur absolue", "distance |x-a|", "résolution d'équations |x-a|=r"]),
        ("Seconde", "Fonctions", "Généralités sur les fonctions et lecture graphique",
         ["ensemble de définition", "image et antécédent", "tableau de valeurs"]),
        ("Seconde", "Fonctions", "Variations de fonctions et extrema",
         ["croissance et décroissance", "maximum et minimum local", "tableau de variations"]),
        ("Seconde", "Fonctions", "Fonctions affines et droites du plan",
         ["coefficient directeur", "ordonnée à l'origine", "pente et tracé"]),
        ("Seconde", "Algèbre & Équations", "Résolution d'inéquations et tableaux de signes",
         ["signe de ax+b", "produit de facteurs", "règle des signes en tableau"]),
        ("Seconde", "Géométrie", "Vecteurs du plan et translation",
         ["direction, sens et norme", "vecteurs égaux", "relation de Chasles"]),
        ("Seconde", "Géométrie", "Colinéarité de vecteurs et déterminant",
         ["critère xy' - yx' = 0", "parallélisme de droites", "alignement de points"]),
        ("Seconde", "Statistiques & Probabilités", "Statistiques descriptives et dispersion",
         ["moyenne", "médiane", "quartiles Q1 et Q3", "étendue"]),
        ("Seconde", "Statistiques & Probabilités", "Probabilités sur un univers fini",
         ["événement contraire", "union et intersection P(A U B)", "équiprobabilité"]),

        # --- PREMIÈRE (Modules 11 à 25 : 180 cours) ---
        ("Première Spécialité", "Algèbre", "Second degré et forme canonique",
         ["forme développée", "forme canonique", "sommet de la parabole"]),
        ("Première Spécialité", "Algèbre", "Discriminant delta et factorisation",
         ["calcul de delta", "racines réelles", "signe du trinôme du second degré"]),
        ("Première Spécialité", "Analyse", "Nombre dérivé et taux de variation",
         ["sécante", "limite du taux d'accroissement", "pente de la tangente"]),
        ("Première Spécialité", "Analyse", "Équation de la tangente à une courbe",
         ["formule y = f'(a)(x-a) + f(a)", "coefficient directeur", "point de contact"]),
        ("Première Spécialité", "Analyse", "Calcul de dérivées usuelles et règles de dérivation",
         ["dérivée de x^n", "dérivée de 1/x et racine", "règle du produit uv et quotient u/v"]),
        ("Première Spécialité", "Analyse", "Lien entre signe de la dérivée et variations",
         ["théorème fondamental", "dérivée strictement positive", "tableau de variations complet"]),
        ("Première Spécialité", "Analyse", "Suites arithmétiques",
         ["terme général un = u0 + nr", "raison r", "somme des premiers termes"]),
        ("Première Spécialité", "Analyse", "Suites géométriques",
         ["terme général un = u0 * q^n", "raison multiplicatrice q", "somme 1+q+...+q^n"]),
        ("Première Spécialité", "Analyse", "Fonction exponentielle : définition et propriétés",
         ["exp(0)=1 et exp'(x)=exp(x)", "relation fonctionnelle exp(a+b)=exp(a)exp(b)", "strictement positive"]),
        ("Première Spécialité", "Trigonométrie", "Cercle trigonométrique et radian",
         ["enroulement de la droite réelle", "abscisse curviligne", "cosinus et sinus"]),
        ("Première Spécialité", "Trigonométrie", "Valeurs remarquables et équations trigonométriques",
         ["angles pi/6, pi/4, pi/3", "symétries cos(-x)=cos(x)", "résolution cos(x)=cos(a)"]),
        ("Première Spécialité", "Géométrie", "Produit scalaire dans le plan",
         ["définition avec le cosinus", "projection orthogonale", "formule des normes"]),
        ("Première Spécialité", "Géométrie", "Applications du produit scalaire et théorème d'Al-Kashi",
         ["formule analytique xx'+yy'", "orthogonalité", "formule d'Al-Kashi dans le triangle"]),
        ("Première Spécialité", "Probabilités", "Probabilités conditionnelles et indépendance",
         ["définition P_A(B)", "arbre de probabilité pondéré", "formule des probabilités totales"]),
        ("Première Spécialité", "Probabilités", "Variables aléatoires et loi binomiale",
         ["loi de probabilité", "espérance et variance", "schéma de Bernoulli et coefficients binomiaux"]),

        # --- TERMINALE (Modules 26 à 40 : 220 cours) ---
        ("Terminale Spécialité", "Analyse", "Raisonnement par récurrence",
         ["initialisation", "hérédité", "conclusion rigoureuse"]),
        ("Terminale Spécialité", "Analyse", "Limites de suites et théorèmes de comparaison",
         ["suite convergente et divergente", "théorème des gendarmes", "théorème de convergence monotone"]),
        ("Terminale Spécialité", "Analyse", "Limites de fonctions et asymptotes",
         ["formes indéterminées", "asymptote verticale et horizontale", "croissance comparée"]),
        ("Terminale Spécialité", "Analyse", "Continuité et Théorème des Valeurs Intermédiaires (TVI)",
         ["continuité sur un intervalle", "corollaire de la stricte monotonie (bijection)", "recherche de solution unique"]),
        ("Terminale Spécialité", "Analyse", "Dérivation de fonctions composées f(g(x))",
         ["formule (u o v)' = v' * (u' o v)", "dérivée de exp(u) et ln(u)", "dérivée de racine de u"]),
        ("Terminale Spécialité", "Analyse", "Convexité et points d'inflexion",
         ["courbe au-dessus de ses tangentes", "signe de la dérivée seconde f''", "point d'inflexion où f'' s'annule"]),
        ("Terminale Spécialité", "Analyse", "Fonction logarithme népérien",
         ["définition comme réciproque de exp", "propriété ln(ab)=ln(a)+ln(b)", "limites en 0 et +infini"]),
        ("Terminale Spécialité", "Analyse", "Primitives et calcul intégral",
         ["définition de primitive F'=f", "intégrale comme aire sous la courbe", "relation de Chasles"]),
        ("Terminale Spécialité", "Analyse", "Intégration par parties et calcul d'aires",
         ["formule uv - intégrale de u'v", "choix judicieux de u et v'", "aire entre deux courbes f et g"]),
        ("Terminale Spécialité", "Analyse", "Équations différentielles y' = ay et y' = ay + b",
         ["solution générale k*exp(ax)", "solution particulière constante", "condition initiale"]),
        ("Terminale Spécialité", "Géométrie dans l'espace", "Vecteurs, bases et repères dans l'espace",
         ["coordonnées dans l'espace", "combinaison linéaire", "coplanarité de vecteurs"]),
        ("Terminale Spécialité", "Géométrie dans l'espace", "Produit scalaire et équations cartésiennes de plans",
         ["vecteur normal n(a,b,c)", "équation ax+by+cz+d=0", "orthogonalité droite-plan"]),
        ("Terminale Spécialité", "Géométrie dans l'espace", "Représentations paramétriques de droites dans l'espace",
         ["point d'ancrage et vecteur directeur", "système paramétrique en t", "intersection de droites et plans"]),
        ("Terminale Spécialité", "Probabilités", "Loi des grands nombres et schéma de Bernoulli",
         ["inégalité de Bienaymé-Tchebychev", "inégalité de concentration", "convergence en probabilité"]),
        ("Terminale Spécialité", "Probabilités", "Loi géométrique et loi uniforme",
         ["variable sans mémoire", "espérance 1/p", "modélisation de temps d'attente"])
    ]

    title_patterns = [
        "{theme} — Cours fondamental et définitions",
        "Méthode pas à pas : Comment résoudre un problème de {theme}",
        "Exemple guidé et calcul détaillé : {theme} en pratique",
        "Correction d'exercice classique : {theme} (Entraînement Lycée)",
        "Problème type Bac : {theme} — Raisonnement en plusieurs étapes",
        "Révision express & Fiche de synthèse : Tout retenir sur {theme}"
    ]

    idx = 1
    for mod_idx, (level, domain, theme, concepts) in enumerate(modules):
        if mod_idx < 10:
            count = 10
        elif mod_idx < 25:
            count = 12
        elif mod_idx < 35:
            count = 15
        else:
            count = 14

        for i in range(count):
            author = AUTHORS["math_primary"]
            title_pat = title_patterns[i % len(title_patterns)]
            title = title_pat.format(theme=theme)
            sub_concept = concepts[i % len(concepts)]
            lvl_kw = "Seconde" if "Seconde" in level else ("Premiere" if "Première" in level else "Terminale")
            query = f"Yvan Monka {lvl_kw} {theme} {sub_concept}"
            item_id = f"MATH_{idx:03d}"

            entry = create_course_entry(
                item_id=item_id,
                subject="Mathématiques",
                level=level,
                domain=domain,
                title=title,
                author=author,
                search_query=query
            )
            items.append(entry)
            idx += 1

    return items


# ---------------------------------------------------------------------------
# GÉNÉRATEUR PHYSIQUE-CHIMIE (300 COURS)
# ---------------------------------------------------------------------------

def generate_physique_courses() -> List[Dict[str, Any]]:
    """Génère exactement 300 entrées de physique-chimie lycée."""
    items: List[Dict[str, Any]] = []

    modules = [
        # --- SECONDE (Modules 1 à 5 : 60 cours) ---
        ("Seconde", "Physique - Mécanique", "Mouvements, trajectoires et vitesse moyenne",
         ["système et référentiel", "trajectoire rectiligne ou circulaire", "vecteur vitesse"]),
        ("Seconde", "Physique - Mécanique", "Forces et principe d'inertie",
         ["modélisation d'une force", "poids et réaction du support", "première loi de Newton"]),
        ("Seconde", "Physique - Ondes & Signaux", "Émission et propagation de la lumière : lois de Snell-Descartes",
         ["rayon incident et réfracté", "normale au dioptre", "loi n1 sin(i1) = n2 sin(i2)"]),
        ("Seconde", "Physique - Électricité", "Tension, intensité et loi d'Ohm dans un circuit",
         ["schéma électrique", "loi des mailles", "loi des nœuds", "résistance U=RI"]),
        ("Seconde", "Chimie", "Solutions aqueuses, concentration et dissolution",
         ["soluté et solvant", "concentration massique et molaire", "facteur de dilution"]),

        # --- PREMIÈRE (Modules 6 à 15 : 110 cours) ---
        ("Première Spécialité", "Physique - Mécanique", "Vecteur vitesse et vecteur accélération",
         ["variation du vecteur vitesse", "accélération moyenne", "chronophotographie"]),
        ("Première Spécialité", "Physique - Mécanique", "Deuxième loi de Newton : bilan de forces et masse",
         ["somme des forces = m * a", "centre d'inertie", "mouvement rectiligne accéléré"]),
        ("Première Spécialité", "Physique - Énergie", "Énergie cinétique et travail d'une force",
         ["travail W = F . AB", "force motrice et résistante", "théorème de l'énergie cinétique"]),
        ("Première Spécialité", "Physique - Énergie", "Énergie potentielle et conservation de l'énergie mécanique",
         ["énergie potentielle de pesanteur Epp=mgz", "énergie mécanique Em=Ec+Epp", "frottements et dissipation"]),
        ("Première Spécialité", "Physique - Ondes", "Ondes mécaniques progressives et périodiques",
         ["longueur d'onde lambda", "période temporelle T", "célérité v = lambda / T"]),
        ("Première Spécialité", "Chimie", "Réactions d'oxydoréduction et demi-équations",
         ["oxydant et réducteur", "gain et perte d'électrons", "couples redox"]),
        ("Première Spécialité", "Chimie", "Titrage colorimétrique et équivalence",
         ["burette graduée et bécher", "définition de l'équivalence", "changement de couleur"]),
        ("Première Spécialité", "Chimie", "Structure des molécules et cohésion de la matière",
         ["schéma de Lewis", "polarité des liaisons", "liaisons hydrogène et de Van der Waals"]),
        ("Première Spécialité", "Chimie", "Chimie organique et groupes caractéristiques",
         ["alcool, aldéhyde, cétone, acide carboxylique", "formule semi-développée", "spectre infrarouge"]),
        ("Première Spécialité", "Physique - Optique", "Lentilles minces convergentes et grandissement",
         ["centre optique O et foyer image F'", "distance focale f'", "relation de grandissement gamma"]),

        # --- TERMINALE (Modules 16 à 25 : 130 cours) ---
        ("Terminale Spécialité", "Physique - Mécanique", "Mouvement dans un champ de pesanteur uniforme",
         ["équations horaires de position", "trajectoire parabolique", "portée et flèche"]),
        ("Terminale Spécialité", "Physique - Mécanique", "Mouvement des planètes et satellites : Lois de Kepler",
         ["repère de Frenet", "force gravitationnelle centripète", "troisième loi de Kepler T^2/a^3"]),
        ("Terminale Spécialité", "Physique - Électricité", "Dipôle RC : charge et décharge d'un condensateur",
         ["équation différentielle en tension", "solution exponentielle u(t)", "constante de temps tau = RC"]),
        ("Terminale Spécialité", "Physique - Thermodynamique", "Premier principe et transferts thermiques",
         ["énergie interne U", "travail W et transfert thermique Q", "résistance thermique et flux"]),
        ("Terminale Spécialité", "Physique - Ondes", "Diffraction et interférences lumineuses",
         ["tache centrale de diffraction theta = lambda/a", "fentes d'Young", "interfrange i = lambda*D/b"]),
        ("Terminale Spécialité", "Physique - Ondes", "Effet Doppler sonore et astrophysique",
         ["décalage de fréquence delta f", "source en mouvement", "redshift et blueshift"]),
        ("Terminale Spécialité", "Chimie", "Transformations acido-basiques et pH",
         ["définition du pH = -log[H3O+]", "constante d'acidité Ka et pKa", "diagramme de prédominance"]),
        ("Terminale Spécialité", "Chimie", "Titrage pH-métrique et méthode des tangentes",
         ["courbe de titrage en S", "dérivée dpH/dV", "point équivalent E par tangentes parallèles"]),
        ("Terminale Spécialité", "Chimie", "Cinétique chimique et temps de demi-réaction",
         ["vitesse volumique de disparition", "loi de vitesse d'ordre 1", "temps de demi-réaction t1/2"]),
        ("Terminale Spécialité", "Chimie", "Spectroscopie RMN du proton et Infrarouge",
         ["groupes de protons équivalents", "déplacement chimique ppm", "règle des n+1 multiplets"])
    ]

    title_patterns = [
        "{theme} — Cours & Lois fondamentales",
        "Méthode guidée : Comment modéliser et résoudre en {theme}",
        "Étude de cas pas à pas : {theme} (Exemple d'application)",
        "Exercice classique corrigé : {theme} (Niveau {level})",
        "Problème type Bac : {theme} — Résolution multi-notions",
        "Fiche de synthèse & Formules indispensables : {theme}"
    ]

    idx = 1
    for mod_idx, (level, domain, theme, concepts) in enumerate(modules):
        for i in range(12):
            author = AUTHORS["phys_primary"] if i % 2 == 0 else AUTHORS["phys_secondary"]
            title_pat = title_patterns[i % len(title_patterns)]
            title = title_pat.format(theme=theme, level=level)
            sub_concept = concepts[i % len(concepts)]
            lvl_kw = "Seconde" if "Seconde" in level else ("Premiere" if "Première" in level else "Terminale")
            query = f"{author} {lvl_kw} {theme} {sub_concept}"
            item_id = f"PHYS_{idx:03d}"

            entry = create_course_entry(
                item_id=item_id,
                subject="Physique-Chimie",
                level=level,
                domain=domain,
                title=title,
                author=author,
                search_query=query
            )
            items.append(entry)
            idx += 1

    return items


# ---------------------------------------------------------------------------
# GÉNÉRATEUR LANGUES (200 COURS : 100 FRANÇAIS + 100 ANGLAIS)
# ---------------------------------------------------------------------------

def generate_langues_courses() -> List[Dict[str, Any]]:
    """Génère exactement 200 entrées de langues : 100 Français et 100 Anglais."""
    items: List[Dict[str, Any]] = []

    # 1. FRANÇAIS LYCÉE (100 cours répartis en 10 modules de 10 cours)
    fr_modules = [
        ("Première Générale", "Grammaire Bac", "Les propositions subordonnées relatives et complétives",
         ["subordonnée relative", "conjonctive complétive", "fonction sujet/COD"]),
        ("Première Générale", "Grammaire Bac", "L'expression de la négation (totale, partielle, restrictive)",
         ["ne... pas", "ne... que (restriction)", "mots négatifs"]),
        ("Première Générale", "Grammaire Bac", "L'interrogation : directe, indirecte, totale et partielle",
         ["inversion sujet-verbe", "mot interrogatif", "subordonnée interrogative"]),
        ("Première Générale", "Stylistique & Rhétorique", "Les figures d'analogie et d'image : métaphore, comparaison, allégorie",
         ["comparé et comparant", "outil de comparaison", "métaphore filée"]),
        ("Première Générale", "Stylistique & Rhétorique", "Les figures d'opposition et d'amplification : oxymore, antithèse, hyperbole",
         ["oxymore dans le même syntagme", "antithèse symétrique", "hyperbole"]),
        ("Première Spécialité", "Méthode du Commentaire", "Construire une problématique et bâtir un plan en 2 ou 3 parties",
         ["enjeu littéraire", "plan dialectique ou thématique", "axes de lecture"]),
        ("Première Spécialité", "Méthode du Commentaire", "L'analyse stylistique au service du sens (Procédé + Citation + Effet)",
         ["repérage du procédé", "citation exacte entre guillemets", "interprétation littéraire"]),
        ("Première Spécialité", "Méthode de la Dissertation", "Analyser le sujet de dissertation et formuler le paradoxe",
         ["mots-clés de la citation", "thèse de l'auteur", "limites de la thèse"]),
        ("Première Spécialité", "Oral du Bac de Français", "L'explication linéaire pas à pas (Mouvements du texte et analyse mot à mot)",
         ["lecture expressive", "découpage en mouvements", "analyse continue"]),
        ("Première Spécialité", "Œuvres au Programme", "Analyse linéaire d'un extrait de Baudelaire (Les Fleurs du Mal)",
         ["Spleen et Idéal", "versification alexandrin", "symbolisme et synesthésies"])
    ]

    fr_title_patterns = [
        "{theme} — Notions clés & Règles fondamentales",
        "Méthode Bac pas à pas : {theme}",
        "Exemple rédigé et décrypté : {theme}",
        "Exercice & Sujet corrigé : {theme} (Entraînement Bac)",
        "Fiche mémo & Synthèse express : {theme}"
    ]

    idx_fr = 1
    for mod_idx, (level, domain, theme, concepts) in enumerate(fr_modules):
        for i in range(10):
            author = AUTHORS["fr_primary"] if i % 2 == 0 else AUTHORS["fr_secondary"]
            title_pat = fr_title_patterns[i % len(fr_title_patterns)]
            title = title_pat.format(theme=theme)
            sub_concept = concepts[i % len(concepts)]
            query = f"{author} bac francais {theme} {sub_concept}"
            item_id = f"LANG_FR_{idx_fr:03d}"

            entry = create_course_entry(
                item_id=item_id,
                subject="Français",
                level=level,
                domain=domain,
                title=title,
                author=author,
                search_query=query
            )
            items.append(entry)
            idx_fr += 1

    # 2. ANGLAIS LYCÉE (100 cours répartis en 10 modules de 10 cours)
    en_modules = [
        ("Terminale Tronc Commun", "Grammar & Tenses", "Mastering the Present Perfect (Simple vs Continuous)",
         ["past action with present result", "for and since", "duration with have been -ing"]),
        ("Terminale Tronc Commun", "Grammar & Tenses", "Past Perfect vs Simple Past in Narrative Chronology",
         ["had + past participle", "flashback event", "time markers"]),
        ("Terminale Tronc Commun", "Grammar & Conditionals", "Conditionals Mastery: 1st, 2nd, 3rd and Mixed Conditionals",
         ["if + present, will", "if + past, would", "unreal past"]),
        ("Terminale Tronc Commun", "Grammar & Voice", "The Passive Voice and Impersonal Structures",
         ["be + past participle", "focus on action", "it is said that"]),
        ("Terminale Tronc Commun", "Grammar & Modals", "Modal Verbs of Deduction and Probability (Must, Can't, Might)",
         ["degree of certainty", "deduction in present", "past deduction"]),
        ("Terminale Tronc Commun", "Writing Skills", "Structuring an Argumentative Essay (PEEL Method)",
         ["thesis statement", "Point Evidence Explanation Link", "counter-argument"]),
        ("Terminale Tronc Commun", "Writing Skills", "Advanced Linking Words and Discourse Markers",
         ["contrast: however whereas", "consequence: therefore", "addition: moreover"]),
        ("Terminale Tronc Commun", "Oral Skills & Debate", "Structuring a Spontaneous 5-Minute Oral Presentation",
         ["hook and introduction", "transitioning between slides", "nuanced opinion"]),
        ("Terminale Tronc Commun", "Thematic Studies", "Innovations, Artificial Intelligence and Ethical Responsibility",
         ["technological progress", "ethical dilemmas", "data privacy"]),
        ("Terminale Tronc Commun", "Thematic Studies", "Art, Culture and Power: Propaganda vs Dissent",
         ["monumental art", "subversion and satire", "symbolic power"])
    ]

    en_title_patterns = [
        "{theme} — Comprehensive Grammar & Concepts",
        "Step-by-Step Method: How to Master {theme}",
        "In-Depth Example & Full Breakdown: {theme}",
        "Practice Exercise & Guided Correction: {theme}",
        "Cheat Sheet & Quick Revision: {theme}"
    ]

    idx_en = 1
    for mod_idx, (level, domain, theme, concepts) in enumerate(en_modules):
        for i in range(10):
            author = AUTHORS["en_primary"] if i % 2 == 0 else AUTHORS["en_secondary"]
            title_pat = en_title_patterns[i % len(en_title_patterns)]
            title = title_pat.format(theme=theme)
            sub_concept = concepts[i % len(concepts)]
            query = f"{author} high school english {theme} {sub_concept}"
            item_id = f"LANG_EN_{idx_en:03d}"

            entry = create_course_entry(
                item_id=item_id,
                subject="Anglais",
                level=level,
                domain=domain,
                title=title,
                author=author,
                search_query=query
            )
            items.append(entry)
            idx_en += 1

    return items


# ---------------------------------------------------------------------------
# SYNCHRONISATION DES VIDÉOS & TRANSCRIPTIONS RÉELLES EXISTANTES
# ---------------------------------------------------------------------------

def sync_existing_transcripts(catalog: List[Dict[str, Any]]) -> int:
    """Rattache automatiquement les vidéos et transcriptions déjà présentes sur disque."""
    synced = 0
    catalog_map = {c["id"]: c for c in catalog}

    # 1. Processed transcripts JSON
    if TRANSCRIPTS_PROC_DIR.exists():
        for file in TRANSCRIPTS_PROC_DIR.glob("*_transcript.json"):
            try:
                with open(file, "r", encoding="utf-8") as f:
                    data = json.load(f)
                item_id = data.get("item_id")
                if item_id in catalog_map:
                    item = catalog_map[item_id]
                    v_id = data.get("youtube_video_id")
                    if v_id:
                        item["youtube_video_id"] = v_id
                        item["youtube_url"] = data.get("youtube_url") or f"https://www.youtube.com/watch?v={v_id}"
                        item["youtube_video_title"] = data.get("youtube_video_title", "")
                        item["transcript_available"] = True
                        item["transcript_words_count"] = data.get("total_words_count", 0)
                        synced += 1
            except Exception:
                pass

    # 2. Raw transcript files (format {course_id}_{video_id}.txt ou {course_id}_raw.txt)
    if TRANSCRIPTS_RAW_DIR.exists():
        for file in TRANSCRIPTS_RAW_DIR.glob("*.txt"):
            stem = file.stem
            for c_id in catalog_map:
                if stem.startswith(c_id):
                    item = catalog_map[c_id]
                    item["transcript_available"] = True
                    remainder = stem.replace(c_id, "").lstrip("_")
                    if remainder and len(remainder) == 11 and remainder != "raw":
                        item["youtube_video_id"] = remainder
                        item["youtube_url"] = f"https://www.youtube.com/watch?v={remainder}"
                    try:
                        with open(file, "r", encoding="utf-8") as f:
                            text = f.read()
                        item["transcript_words_count"] = max(item["transcript_words_count"], len(text.split()))
                    except Exception:
                        pass
                    break

    return synced


# ---------------------------------------------------------------------------
# MAIN EXPORT
# ---------------------------------------------------------------------------

def main():
    print("=" * 70)
    print("GÉNÉRATION DU CATALOGUE ILLIMMI 1 000 COURS (LEAN SCHEMA SANS LAYERS)")
    print("=" * 70)

    math_courses = generate_math_courses()
    phys_courses = generate_physique_courses()
    lang_courses = generate_langues_courses()

    all_courses = math_courses + phys_courses + lang_courses

    assert len(math_courses) == 500, f"Erreur: {len(math_courses)} maths au lieu de 500"
    assert len(phys_courses) == 300, f"Erreur: {len(phys_courses)} physique au lieu de 300"
    assert len(lang_courses) == 200, f"Erreur: {len(lang_courses)} langues au lieu de 200"
    assert len(all_courses) == 1000, f"Erreur: {len(all_courses)} total au lieu de 1000"

    # Synchronisation des vidéos YouTube déjà récupérées
    synced = sync_existing_transcripts(all_courses)
    print(f"-> Vidéos et transcriptions déjà synchronisées : {synced}")

    # Sauvegarde du catalogue principal (corpus_1000_full.json)
    full_path = CATALOG_DIR / "corpus_1000_full.json"
    with open(full_path, "w", encoding="utf-8") as f:
        json.dump(all_courses, f, ensure_ascii=False, indent=2)
    print(f"[OK] Fichier sauvegardé : {full_path} ({full_path.stat().st_size // 1024} Ko)")

    # Sauvegarde des sous-catalogues
    math_path = CATALOG_DIR / "math_500.json"
    with open(math_path, "w", encoding="utf-8") as f:
        json.dump(math_courses, f, ensure_ascii=False, indent=2)
    print(f"[OK] Fichier sauvegardé : {math_path}")

    phys_path = CATALOG_DIR / "physique_300.json"
    with open(phys_path, "w", encoding="utf-8") as f:
        json.dump(phys_courses, f, ensure_ascii=False, indent=2)
    print(f"[OK] Fichier sauvegardé : {phys_path}")

    lang_path = CATALOG_DIR / "langues_200.json"
    with open(lang_path, "w", encoding="utf-8") as f:
        json.dump(lang_courses, f, ensure_ascii=False, indent=2)
    print(f"[OK] Fichier sauvegardé : {lang_path}")

    # Sauvegarde Manifeste CSV Lean
    csv_path = CATALOG_DIR / "corpus_1000_manifest.csv"
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([
            "id", "subject", "level", "domain", "title",
            "author", "youtube_video_id", "youtube_url", "transcript_available"
        ])
        for c in all_courses:
            writer.writerow([
                c["id"],
                c["subject"],
                c["level"],
                c["domain"],
                c["title"],
                c["author"],
                c.get("youtube_video_id", ""),
                c.get("youtube_url", ""),
                c.get("transcript_available", False)
            ])
    print(f"[OK] Manifeste CSV sauvegardé : {csv_path} ({csv_path.stat().st_size // 1024} Ko)")
    print("=" * 70)
    print("SUCCÈS : CATALOGUE LEAN 1 000 COURS GÉNÉRÉ SANS LAYERS")
    print("=" * 70)


if __name__ == "__main__":
    main()
