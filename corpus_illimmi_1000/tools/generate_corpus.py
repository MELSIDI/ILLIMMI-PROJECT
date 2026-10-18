#!/usr/bin/env python3
"""
Générateur du Corpus 1 000 cours Lycée pour ILLIMMI.
Produit le catalogue exhaustif de 1 000 cours avec métadonnées pédagogiques,
alignement 3-Layers (Layer 1, Layer 2, Layer 3) et exports JSON/CSV.

Répartition :
- 500 Mathématiques (priorité Yvan Monka / M@ths et Tiques)
- 300 Physique-Chimie
- 200 Langues (100 Français, 100 Anglais)
"""

import json
import csv
import os
from pathlib import Path
from typing import List, Dict, Any

ROOT_DIR = Path(__file__).resolve().parent.parent
CATALOG_DIR = ROOT_DIR / "catalog"
CATALOG_DIR.mkdir(parents=True, exist_ok=True)

# ---------------------------------------------------------------------------
# DÉFINITIONS & TAXONOMIES
# ---------------------------------------------------------------------------

CREATORS = {
    "math_primary": "Yvan Monka (M@ths et Tiques)",
    "math_secondary": "Sebastien Peyrot (jaicompris.com)",
    "math_tertiary": "Arnaud Bodin (Exo7 Lycée)",
    "phys_primary": "Florence Raffin (Physique-Chimie)",
    "phys_secondary": "Romain Bourdel (Physique Lycée)",
    "phys_tertiary": "Paul Olivier (Professeur Phyc)",
    "phys_expert": "e-penser (Vulgarisation & Rigueur Lycée)",
    "fr_primary": "Amélie Vioux (Commentaire-compose.fr)",
    "fr_secondary": "Médusaces (Français Lycée)",
    "fr_tertiary": "Jean-Luc (Bac Français)",
    "fr_method": "Les Bons Profs (Français)",
    "en_primary": "BBC Learning English",
    "en_secondary": "mmmEnglish (Emma)",
    "en_tertiary": "Oxford Online English",
    "en_academic": "Learn English with EnglishClass101",
}

def create_item(
    item_id: str,
    subject: str,
    level: str,
    domain: str,
    title: str,
    ped_type: str,
    creator: str,
    query: str,
    target: str,
    duration: int,
    concepts: List[str],
    l1_sections: List[str],
    l2_visual_cue: str,
    l3_primitives: List[str],
    l3_scenes: int
) -> Dict[str, Any]:
    """Fabrique une entrée normalisée pour le corpus."""
    return {
        "id": item_id,
        "subject": subject,
        "level": level,
        "domain": domain,
        "title": title,
        "pedagogical_type": ped_type,
        "creator": creator,
        "search_query": query,
        "pedagogical_target": target,
        "layer1_spec": {
            "duration_target": duration,
            "concepts_cles": concepts,
            "ton": "bienveillant, rigoureux et stimulant",
            "plan_pedagogique": [
                {
                    "section": s,
                    "role": f"Section {s} pour {title}",
                    "support_visuel_suggere": l3_primitives[i % len(l3_primitives)]
                }
                for i, s in enumerate(l1_sections)
            ]
        },
        "layer2_spec": {
            "style_guidance": "Narration orale fluide pour Piper TTS, tutoiement bienveillant, explicitation orale des gestes du professeur.",
            "spoken_math_rule": "Aucun code LaTeX brut à l'oral. Prononciation littérale fluide ('x au carré' et non '$x^2$').",
            "visual_anchor_verbalization": l2_visual_cue
        },
        "layer3_spec": {
            "hypercourse_primitives": l3_primitives,
            "recommended_scene_count": l3_scenes,
            "viewport": "16:9 (x in [0, 177.78], y in [0, 100])",
            "pre_erase_validation": True
        }
    }


# ---------------------------------------------------------------------------
# GÉNÉRATEUR MATHÉMATIQUES (500 COURS)
# ---------------------------------------------------------------------------

def generate_math_courses() -> List[Dict[str, Any]]:
    """Génère exactement 500 entrées mathématiques structurées."""
    items: List[Dict[str, Any]] = []

    # 40 Modules d'apprentissage en mathématiques lycée
    # (Seconde: 1-10, Première: 11-25, Terminale: 26-40)
    modules = [
        # --- SECONDE (Modules 1 à 10 : 100 cours) ---
        ("Seconde", "Nombres & Calculs", "Intervalles et encadrements de réels",
         ["notion d'intervalle", "intersection et union", "inégalités strictes et larges"],
         "Observons sur cette droite graduée l'intersection des deux intervalles colorés.",
         ["draw line", "draw path", "text"]),
        ("Seconde", "Nombres & Calculs", "Valeur absolue et distance sur la droite réelle",
         ["définition valeur absolue", "distance |x-a|", "résolution d'équations |x-a|=r"],
         "Traçons la distance entre le point d'abscisse x et le point central a.",
         ["draw line", "draw arrow", "text"]),
        ("Seconde", "Fonctions", "Généralités sur les fonctions et lecture graphique",
         ["ensemble de définition", "image et antécédent", "tableau de valeurs"],
         "Plaçons le point M de coordonnées x et f de x sur notre repère.",
         ["draw 2drep", "draw curve", "mouse move", "text"]),
        ("Seconde", "Fonctions", "Variations de fonctions et extrema",
         ["croissance et décroissance", "maximum et minimum local", "tableau de variations"],
         "Suivons la montée de la courbe pour en déduire le sens de variation.",
         ["draw 2drep", "draw curve", "draw arrow", "text"]),
        ("Seconde", "Fonctions", "Fonctions affines et droites du plan",
         ["coefficient directeur", "ordonnée à l'origine", "pente et tracé"],
         "Traçons la droite affine en avançant d'une unité vers la droite et montant du coefficient m.",
         ["draw 2drep", "draw line", "draw arrow", "text"]),
        ("Seconde", "Algèbre & Équations", "Résolution d'inéquations et tableaux de signes",
         ["signe de ax+b", "produit de facteurs", "règle des signes en tableau"],
         "Remplissons le tableau de signes ligne par ligne pour déterminer la zone positive.",
         ["text", "draw line", "draw polygone"]),
        ("Seconde", "Géométrie", "Vecteurs du plan et translation",
         ["direction, sens et norme", "vecteurs égaux", "relation de Chasles"],
         "Construisons le vecteur somme en appliquant la règle du parallélogramme.",
         ["draw arrow", "draw polygone", "text"]),
        ("Seconde", "Géométrie", "Colinéarité de vecteurs et déterminant",
         ["critère xy' - yx' = 0", "parallélisme de droites", "alignement de points"],
         "Calculons le déterminant croisé pour vérifier si les deux flèches sont parallèles.",
         ["draw arrow", "draw line", "text"]),
        ("Seconde", "Statistiques & Probabilités", "Statistiques descriptives et dispersion",
         ["moyenne", "médiane", "quartiles Q1 et Q3", "étendue"],
         "Représentons les données sous forme de diagramme en boîte à moustaches.",
         ["draw line", "draw polygone", "text"]),
        ("Seconde", "Statistiques & Probabilités", "Probabilités sur un univers fini",
         ["événement contraire", "union et intersection P(A U B)", "équiprobabilité"],
         "Schématisons les deux ensembles disjoints à l'aide de patates de Venn.",
         ["draw circle", "draw ellipse", "text"]),

        # --- PREMIÈRE (Modules 11 à 25 : 180 cours) ---
        ("Première Spécialité", "Algèbre", "Second degré et forme canonique",
         ["forme développée", "forme canonique", "sommet de la parabole"],
         "Faisons apparaître l'identité remarquable pour factoriser le trinôme.",
         ["draw 2drep", "draw curve", "text"]),
        ("Première Spécialité", "Algèbre", "Discriminant delta et factorisation",
         ["calcul de delta", "racines réelles", "signe du trinôme du second degré"],
         "Visualisons la parabole selon que son discriminant soit positif, nul ou négatif.",
         ["draw 2drep", "draw curve", "text", "draw line"]),
        ("Première Spécialité", "Analyse", "Nombre dérivé et taux de variation",
         ["sécante", "limite du taux d'accroissement", "pente de la tangente"],
         "Rapprochons le point sécant vers le point d'ancrage pour voir naître la tangente.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Première Spécialité", "Analyse", "Équation de la tangente à une courbe",
         ["formule y = f'(a)(x-a) + f(a)", "coefficient directeur", "point de contact"],
         "Traçons la droite tangente au point de contact avec sa pente f prime de a.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Première Spécialité", "Analyse", "Calcul de dérivées usuelles et règles de dérivation",
         ["dérivée de x^n", "dérivée de 1/x et racine", "règle du produit uv et quotient u/v"],
         "Décomposons la formule de dérivation en identifiant les blocs u et v.",
         ["text", "draw arrow", "draw polygone"]),
        ("Première Spécialité", "Analyse", "Lien entre signe de la dérivée et variations",
         ["théorème fondamental", "dérivée strictement positive", "tableau de variations complet"],
         "Dressons le tableau reliant le signe de la dérivée aux flèches de variation de f.",
         ["text", "draw line", "draw arrow"]),
        ("Première Spécialité", "Analyse", "Suites arithmétiques",
         ["terme général un = u0 + nr", "raison r", "somme des premiers termes"],
         "Représentons les points isolés de la suite alignés sur une droite de pente r.",
         ["draw 2drep", "draw circle", "draw line", "text"]),
        ("Première Spécialité", "Analyse", "Suites géométriques",
         ["terme général un = u0 * q^n", "raison multiplicatrice q", "somme 1+q+...+q^n"],
         "Construisons la suite des rectangles dont les hauteurs augmentent selon un facteur constant.",
         ["draw 2drep", "draw polygone", "draw curve", "text"]),
        ("Première Spécialité", "Analyse", "Fonction exponentielle : définition et propriétés",
         ["exp(0)=1 et exp'(x)=exp(x)", "relation fonctionnelle exp(a+b)=exp(a)exp(b)", "strictement positive"],
         "Dessinons la courbe exponentielle qui démarre en 0 1 et monte vertigineusement.",
         ["draw 2drep", "draw curve", "text"]),
        ("Première Spécialité", "Trigonométrie", "Cercle trigonométrique et radian",
         ["enroulement de la droite réelle", "abscisse curviligne", "cosinus et sinus"],
         "Faisons tourner le rayon sur le cercle trigonométrique de rayon unité.",
         ["draw circle", "draw line", "draw arrow", "draw arc"]),
        ("Première Spécialité", "Trigonométrie", "Valeurs remarquables et équations trigonométriques",
         ["angles pi/6, pi/4, pi/3", "symétries cos(-x)=cos(x)", "résolution cos(x)=cos(a)"],
         "Plaçons les projections orthogonales sur les axes des abscisses et ordonnées du cercle.",
         ["draw circle", "draw line", "text"]),
        ("Première Spécialité", "Géométrie", "Produit scalaire dans le plan",
         ["définition avec le cosinus", "projection orthogonale", "formule des normes"],
         "Projetons orthogonalement le vecteur V sur la direction du vecteur U.",
         ["draw arrow", "draw line", "draw arc", "text"]),
        ("Première Spécialité", "Géométrie", "Applications du produit scalaire et théorème d'Al-Kashi",
         ["formule analytique xx'+yy'", "orthogonalité", "formule d'Al-Kashi dans le triangle"],
         "Traçons le triangle quelconque et appliquons Al-Kashi pour trouver le côté inconnu.",
         ["draw polygone", "draw arc", "text"]),
        ("Première Spécialité", "Probabilités", "Probabilités conditionnelles et indépendance",
         ["définition P_A(B)", "arbre de probabilité pondéré", "formule des probabilités totales"],
         "Déroulons l'arbre pondéré avec ses branches de premier et second niveau.",
         ["draw line", "text", "draw arrow"]),
        ("Première Spécialité", "Probabilités", "Variables aléatoires et loi binomiale",
         ["loi de probabilité", "espérance et variance", "schéma de Bernoulli et coefficients binomiaux"],
         "Dessinons l'arbre à deux issues succès et échec répété n fois de façon indépendante.",
         ["draw line", "text", "draw polygone"]),

        # --- TERMINALE (Modules 26 à 40 : 220 cours) ---
        ("Terminale Spécialité", "Analyse", "Raisonnement par récurrence",
         ["initialisation", "hérédité", "conclusion rigoureuse"],
         "Visualisons l'effet domino : la première pièce tombe, puis la transmission assure la chute.",
         ["draw polygone", "draw arrow", "text"]),
        ("Terminale Spécialité", "Analyse", "Limites de suites et théorèmes de comparaison",
         ["suite convergente et divergente", "théorème des gendarmes", "théorème de convergence monotone"],
         "Encadrons la suite oscillante entre deux suites qui convergent vers le même palier horizontal.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Terminale Spécialité", "Analyse", "Limites de fonctions et asymptotes",
         ["formes indéterminées", "asymptote verticale et horizontale", "croissance comparée"],
         "Approchons la courbe de la droite asymptote sans jamais la traverser à l'infini.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Terminale Spécialité", "Analyse", "Continuité et Théorème des Valeurs Intermédiaires (TVI)",
         ["continuité sur un intervalle", "corollaire de la stricte monotonie (bijection)", "recherche de solution unique"],
         "Tracons la ligne horizontale de hauteur k qui coupe la courbe strictement monotone une unique fois.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Terminale Spécialité", "Analyse", "Dérivation de fonctions composées f(g(x))",
         ["formule (u o v)' = v' * (u' o v)", "dérivée de exp(u) et ln(u)", "dérivée de racine de u"],
         "Écrivons la chaîne de composition avec les flèches d'opérations intermédiaires.",
         ["text", "draw arrow", "draw polygone"]),
        ("Terminale Spécialité", "Analyse", "Convexité et points d'inflexion",
         ["courbe au-dessus de ses tangentes", "signe de la dérivée seconde f''", "point d'inflexion où f'' s'annule"],
         "Observons la courbure qui tourne sa concavité vers le haut puis bascule au point d'inflexion.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Terminale Spécialité", "Analyse", "Fonction logarithme népérien",
         ["définition comme réciproque de exp", "propriété ln(ab)=ln(a)+ln(b)", "limites en 0 et +infini"],
         "Traçons la courbe du logarithme par symétrie de l'exponentielle par rapport à la première bissectrice.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Terminale Spécialité", "Analyse", "Primitives et calcul intégral",
         ["définition de primitive F'=f", "intégrale comme aire sous la courbe", "relation de Chasles"],
         "Colorions l'aire sous la courbe positive comprise entre les bornes a et b.",
         ["draw 2drep", "draw curve", "draw polygone", "text"]),
        ("Terminale Spécialité", "Analyse", "Intégration par parties et calcul d'aires",
         ["formule uv - intégrale de u'v", "choix judicieux de u et v'", "aire entre deux courbes f et g"],
         "Hachurons l'espace confiné entre les deux courbes pour poser l'intégrale de f moins g.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Terminale Spécialité", "Analyse", "Équations différentielles linéaires y' = ay + b",
         ["solutions homogènes ke^(ax)", "solution particulière constante", "condition initiale unique"],
         "Tracons la famille de courbes intégrales correspondant aux différentes constantes k.",
         ["draw 2drep", "draw curve", "text"]),
        ("Terminale Spécialité", "Géométrie dans l'espace", "Vecteurs, droites et plans de l'espace",
         ["base de l'espace (i,j,k)", "vecteurs coplanaires", "représentation paramétrique de droite"],
         "Représentons la droite dans l'espace passant par le point A et dirigée par le vecteur directeur u.",
         ["draw line", "draw arrow", "draw polygone", "text"]),
        ("Terminale Spécialité", "Géométrie dans l'espace", "Produit scalaire dans l'espace et orthogonalité",
         ["vecteur normal à un plan", "équation cartésienne ax+by+cz+d=0", "distance d'un point à un plan"],
         "Dressons le plan orthogonal au vecteur normal n issu du point A.",
         ["draw polygone", "draw arrow", "draw line", "text"]),
        ("Terminale Spécialité", "Probabilités", "Loi binomiale et approximation",
         ["coefficients binomiaux et triangle de Pascal", "espérance E=np, variance V=np(1-p)", "inégalité de concentration"],
         "Affichons l'histogramme des probabilités binomiales en forme de cloche.",
         ["draw line", "draw polygone", "draw curve", "text"]),
        ("Terminale Maths Expertes", "Algèbre", "Nombres complexes : forme algébrique et géométrie",
         ["partie réelle et imaginaire", "affixe d'un point et d'un vecteur", "conjugué et module"],
         "Plaçons le nombre complexe z dans le plan d'Argand-Cauchy avec ses composantes x et y.",
         ["draw 2drep", "draw arrow", "draw line", "text"]),
        ("Terminale Maths Expertes", "Arithmétique", "Divisibilité, congruences et théorèmes de Gauss/Bézout",
         ["division euclidienne", "congruence modulo n", "identité de Bézout au+bv=1 et algorithme d'Euclide"],
         "Écrivons la cascade des divisions euclidiennes de l'algorithme d'Euclide étendu.",
         ["text", "draw arrow", "draw polygone"])
    ]

    # Types pédagogiques demandés
    types_cycle = [
        ("cours_notion", 4),
        ("methode_resolution", 3),
        ("exemple_detaille", 2),
        ("correction_exercice", 3),
        ("probleme_complexe", 2),
        ("synthese_revision", 1),
    ]

    idx = 1
    # Déroulons les 40 modules pour produire exactement 500 cours
    # 40 modules * ~12.5 entrées en moyenne = 500 entrées précises
    for mod_idx, (level, domain, theme, concepts, visual_cue, primitives) in enumerate(modules):
        # Déterminons le nombre d'entrées pour ce module pour arriver pile à 500
        # 40 modules : 20 modules à 13 items (260) et 20 modules à 12 items (240) = 500 items !
        entries_count = 13 if mod_idx < 20 else 12

        for i in range(entries_count):
            ped_type, weight = types_cycle[(i + mod_idx) % len(types_cycle)]
            creator = CREATORS["math_primary"] if i % 5 != 4 else CREATORS["math_secondary"]

            # Variations de titres selon le type pédagogique
            if ped_type == "cours_notion":
                title = f"{theme} — Cours fondamental et définitions"
                target = f"Maîtriser la définition rigoureuse et le cadre théorique de : {theme}."
                duration = 150
                sections = ["accroche", "prerequis", "exemple_concret", "definition_formelle", "synthese"]
            elif ped_type == "methode_resolution":
                title = f"Méthode pas à pas : Comment résoudre un problème de {theme}"
                target = f"Acquérir la méthode systématique de calcul et de rédaction pour {theme}."
                duration = 140
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "exemple_detaille":
                title = f"Exemple guidé et calcul détaillé : {theme} en pratique"
                target = f"Appliquer la méthode sur un exemple concret typique du lycée pour {theme}."
                duration = 120
                sections = ["accroche", "exemple_concret", "decomposition", "synthese"]
            elif ped_type == "correction_exercice":
                title = f"Correction d'exercice classique : {theme} (Entraînement Lycée)"
                target = f"S'entraîner sur un exercice standard de lycée avec correction détaillée et guidée sur {theme}."
                duration = 160
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "probleme_complexe":
                title = f"Problème type Bac : {theme} — Raisonnement en plusieurs étapes"
                target = f"Mener un raisonnement mathématique structuré à plusieurs questions enchaînées sur {theme}."
                duration = 180
                sections = ["accroche", "prerequis", "exemple_concret", "decomposition", "erreur_frequente", "synthese"]
            else: # synthese_revision
                title = f"Révision express & Fiche de synthèse : Tout retenir sur {theme}"
                target = f"Récapituler les formules clés, pièges d'examen et réflexes essentiels pour {theme}."
                duration = 110
                sections = ["accroche", "definition_formelle", "erreur_frequente", "synthese"]

            sub_concept = concepts[i % len(concepts)]
            lvl_keyword = "Seconde" if "Seconde" in level else ("Premiere" if "Première" in level else "Terminale")
            query = f"Yvan Monka {lvl_keyword} {theme} {sub_concept}"
            item_id = f"MATH_{idx:03d}"

            item = create_item(
                item_id=item_id,
                subject="Mathématiques",
                level=level,
                domain=domain,
                title=title,
                ped_type=ped_type,
                creator=creator,
                query=query,
                target=target,
                duration=duration,
                concepts=concepts,
                l1_sections=sections,
                l2_visual_cue=visual_cue,
                l3_primitives=primitives,
                l3_scenes=len(sections)
            )
            items.append(item)
            idx += 1

    return items


# ---------------------------------------------------------------------------
# GÉNÉRATEUR PHYSIQUE-CHIMIE (300 COURS)
# ---------------------------------------------------------------------------

def generate_physique_courses() -> List[Dict[str, Any]]:
    """Génère exactement 300 entrées de physique-chimie lycée."""
    items: List[Dict[str, Any]] = []

    # 25 Modules de physique-chimie lycée (Seconde: 1-5, Première: 6-15, Terminale: 16-25)
    modules = [
        # --- SECONDE (Modules 1 à 5 : 60 cours) ---
        ("Seconde", "Physique - Mécanique", "Mouvements, trajectoires et vitesse moyenne",
         ["système et référentiel", "trajectoire rectiligne ou circulaire", "vecteur vitesse"],
         "Traçons la trajectoire de l'objet ponctuel et ajoutons les vecteurs vitesse tangents.",
         ["draw 2drep", "draw curve", "draw arrow", "text"]),
        ("Seconde", "Physique - Mécanique", "Forces et principe d'inertie",
         ["modélisation d'une force", "poids et réaction du support", "première loi de Newton"],
         "Représentons le solide posé sur son plan incliné avec le poids vertical et la réaction normale.",
         ["draw polygone", "draw line", "draw arrow", "text"]),
        ("Seconde", "Physique - Ondes & Signaux", "Émission et propagation de la lumière : lois de Snell-Descartes",
         ["rayon incident et réfracté", "normale au dioptre", "loi n1 sin(i1) = n2 sin(i2)"],
         "Tracons le dioptre horizontal, la normale pointillée et le rayon lumineux réfracté.",
         ["draw line", "draw arrow", "draw arc", "text"]),
        ("Seconde", "Physique - Électricité", "Tension, intensité et loi d'Ohm dans un circuit",
         ["schéma électrique", "loi des mailles", "loi des nœuds", "résistance U=RI"],
         "Dessinons le schéma du circuit en boucle fermée avec la résistance et le générateur.",
         ["draw polygone", "draw line", "text", "draw arrow"]),
        ("Seconde", "Chimie", "Solutions aqueuses, concentration et dissolution",
         ["soluté et solvant", "concentration massique et molaire", "facteur de dilution"],
         "Représentons la fiole jaugée et la pipette pour illustrer le protocole de dilution.",
         ["draw polygone", "draw curve", "text"]),

        # --- PREMIÈRE (Modules 6 à 15 : 110 cours) ---
        ("Première Spécialité", "Physique - Mécanique", "Vecteur vitesse et vecteur accélération",
         ["variation du vecteur vitesse", "accélération moyenne", "chronophotographie"],
         "Plaçons les positions successives M1, M2 et traçons le vecteur delta V.",
         ["draw 2drep", "draw circle", "draw arrow", "text"]),
        ("Première Spécialité", "Physique - Mécanique", "Deuxième loi de Newton : bilan de forces et masse",
         ["somme des forces = m * a", "centre d'inertie", "mouvement rectiligne accéléré"],
         "Faisons le bilan des forces extérieures appliquées au centre de gravité du système.",
         ["draw polygone", "draw arrow", "text"]),
        ("Première Spécialité", "Physique - Énergie", "Énergie cinétique et travail d'une force",
         ["travail W = F . AB", "force motrice et résistante", "théorème de l'énergie cinétique"],
         "Calculons le produit scalaire entre la force de traction et le vecteur déplacement.",
         ["draw arrow", "draw line", "draw arc", "text"]),
        ("Première Spécialité", "Physique - Énergie", "Énergie potentielle et conservation de l'énergie mécanique",
         ["énergie potentielle de pesanteur Epp=mgz", "énergie mécanique Em=Ec+Epp", "frottements et dissipation"],
         "Affichons le graphique montrant le transfert parfait entre énergie potentielle et cinétique.",
         ["draw 2drep", "draw curve", "draw line", "text"]),
        ("Première Spécialité", "Physique - Ondes", "Ondes mécaniques progressives et périodiques",
         ["longueur d'onde lambda", "période temporelle T", "célérité v = lambda / T"],
         "Traçons l'onde sinusoïdale spatiale et repérons la double périodicité.",
         ["draw 2drep", "draw curve", "draw line", "draw arrow"]),
        ("Première Spécialité", "Chimie", "Réactions d'oxydoréduction et demi-équations",
         ["oxydant et réducteur", "gain et perte d'électrons", "couples redox"],
         "Écrivons les deux demi-équations électroniques et ajustons les coefficients stœchiométriques.",
         ["text", "draw arrow", "draw polygone"]),
        ("Première Spécialité", "Chimie", "Titrage colorimétrique et équivalence",
         ["burette graduée et bécher", "définition de l'équivalence", "changement de couleur"],
         "Représentons le montage du titrage avec la burette graduée au-dessus de l'agitateur magnétique.",
         ["draw polygone", "draw line", "text", "draw arrow"]),
        ("Première Spécialité", "Chimie", "Structure des molécules et cohésion de la matière",
         ["schéma de Lewis", "polarité des liaisons", "liaisons hydrogène et de Van der Waals"],
         "Dessinons la géométrie coudée de la molécule d'eau avec ses moments dipolaires partiels.",
         ["draw circle", "draw line", "draw arrow", "text"]),
        ("Première Spécialité", "Chimie", "Chimie organique et groupes caractéristiques",
         ["alcool, aldéhyde, cétone, acide carboxylique", "formule semi-développée", "spectre infrarouge"],
         "Mettons en évidence le groupe carbonyle C=O avec une flèche pointant la double liaison.",
         ["draw polygone", "draw line", "draw arrow", "text"]),
        ("Première Spécialité", "Physique - Optique", "Lentilles minces convergentes et grandissement",
         ["centre optique O et foyer image F'", "distance focale f'", "relation de grandissement gamma"],
         "Construisons les trois rayons caractéristiques passant par le centre et les foyers de la lentille.",
         ["draw line", "draw arrow", "draw polygone", "text"]),

        # --- TERMINALE (Modules 16 à 25 : 130 cours) ---
        ("Terminale Spécialité", "Physique - Mécanique", "Mouvement dans un champ de pesanteur uniforme",
         ["équations horaires de position", "trajectoire parabolique", "portée et flèche"],
         "Dessinons la trajectoire parabolique du projectile lancé avec l'angle initial alpha.",
         ["draw 2drep", "draw curve", "draw arrow", "draw line"]),
        ("Terminale Spécialité", "Physique - Mécanique", "Mouvement des planètes et satellites : Lois de Kepler",
         ["repère de Frenet", "force gravitationnelle centripète", "troisième loi de Kepler T^2/a^3"],
         "Traçons l'orbite elliptique avec le Soleil placé à l'un des deux foyers.",
         ["draw ellipse", "draw circle", "draw arrow", "draw line"]),
        ("Terminale Spécialité", "Physique - Électricité", "Dipôle RC : charge et décharge d'un condensateur",
         ["équation différentielle en tension", "solution exponentielle u(t)", "constante de temps tau = RC"],
         "Affichons la courbe de charge asymptotique et la tangente à l'origine en tau.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Terminale Spécialité", "Physique - Thermodynamique", "Premier principe et transferts thermiques",
         ["énergie interne U", "travail W et transfert thermique Q", "résistance thermique et flux"],
         "Construisons le bilan énergétique de la paroi avec le flux thermique traversant.",
         ["draw polygone", "draw arrow", "text"]),
        ("Terminale Spécialité", "Physique - Ondes", "Diffraction et interférences lumineuses",
         ["tache centrale de diffraction theta = lambda/a", "fentes d'Young", "interfrange i = lambda*D/b"],
         "Schématisons l'écran d'observation avec les franges brillantes et sombres alternées.",
         ["draw line", "draw polygone", "draw curve", "text"]),
        ("Terminale Spécialité", "Physique - Ondes", "Effet Doppler sonore et astrophysique",
         ["décalage de fréquence delta f", "source en mouvement", "redshift et blueshift"],
         "Tracons les fronts d'ondes circulaires comprimés vers l'avant de la source en mouvement.",
         ["draw circle", "draw arrow", "draw line", "text"]),
        ("Terminale Spécialité", "Chimie", "Transformations acido-basiques et pH",
         ["définition du pH = -log[H3O+]", "constante d'acidité Ka et pKa", "diagramme de prédominance"],
         "Dessinons l'axe gradué en pH avec la frontière pKa séparant la zone acide de la zone basique.",
         ["draw line", "draw arrow", "text", "draw polygone"]),
        ("Terminale Spécialité", "Chimie", "Titrage pH-métrique et méthode des tangentes",
         ["courbe de titrage en S", "dérivée dpH/dV", "point équivalent E par tangentes parallèles"],
         "Tracons les deux tangentes parallèles et la droite équidistante pour repérer le volume équivalent.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Terminale Spécialité", "Chimie", "Cinétique chimique et temps de demi-réaction",
         ["vitesse volumique de disparition", "loi de vitesse d'ordre 1", "temps de demi-réaction t1/2"],
         "Suivons la décroissance de la concentration et traçons l'horizontale à C0 divisé par deux.",
         ["draw 2drep", "draw curve", "draw line", "mouse move"]),
        ("Terminale Spécialité", "Chimie", "Spectroscopie RMN du proton et Infrarouge",
         ["groupes de protons équivalents", "déplacement chimique ppm", "règle des n+1 multiplets"],
         "Tracons les pics du spectre RMN avec leur multiplicité singulet, doublet ou triplet.",
         ["draw 2drep", "draw line", "text"])
    ]

    types_cycle = [
        ("cours_notion", 4),
        ("methode_resolution", 3),
        ("exemple_detaille", 2),
        ("correction_exercice", 3),
        ("probleme_complexe", 2),
        ("synthese_revision", 1),
    ]

    idx = 1
    # 25 modules * 12 items = exactement 300 entrées !
    for mod_idx, (level, domain, theme, concepts, visual_cue, primitives) in enumerate(modules):
        for i in range(12):
            ped_type, _ = types_cycle[(i + mod_idx) % len(types_cycle)]
            creator = CREATORS["phys_primary"] if i % 3 == 0 else (CREATORS["phys_secondary"] if i % 3 == 1 else CREATORS["phys_tertiary"])

            if ped_type == "cours_notion":
                title = f"{theme} — Cours & Lois fondamentales"
                target = f"Assimiler les lois physiques et concepts théoriques majeurs : {theme}."
                duration = 150
                sections = ["accroche", "prerequis", "exemple_concret", "definition_formelle", "synthese"]
            elif ped_type == "methode_resolution":
                title = f"Méthode guidée : Comment modéliser et résoudre en {theme}"
                target = f"Acquérir les étapes rigoureuses de projection et calcul pour {theme}."
                duration = 140
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "exemple_detaille":
                title = f"Étude de cas pas à pas : {theme} (Exemple d'application)"
                target = f"Mener une application numérique complète et justifiée sur {theme}."
                duration = 120
                sections = ["accroche", "exemple_concret", "decomposition", "synthese"]
            elif ped_type == "correction_exercice":
                title = f"Exercice classique corrigé : {theme} (Niveau {level})"
                target = f"Résoudre un exercice d'annale avec rédaction soignée et bilan des forces/grandeurs pour {theme}."
                duration = 160
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "probleme_complexe":
                title = f"Problème type Bac : {theme} — Résolution multi-notions"
                target = f"Résoudre un problème transversal avec analyse documentaire et calculs poussés sur {theme}."
                duration = 180
                sections = ["accroche", "prerequis", "exemple_concret", "decomposition", "erreur_frequente", "synthese"]
            else:
                title = f"Fiche de synthèse & Formules indispensables : {theme}"
                target = f"Mémoriser les relations fondamentales, unités et pièges classiques pour {theme}."
                duration = 110
                sections = ["accroche", "definition_formelle", "erreur_frequente", "synthese"]

            sub_concept = concepts[i % len(concepts)]
            lvl_keyword = "Seconde" if "Seconde" in level else ("Premiere" if "Première" in level else "Terminale")
            phys_creator = "Florence Raffin" if i % 2 == 0 else "Romain Bourdel"
            query = f"{phys_creator} {lvl_keyword} {theme} {sub_concept}"
            item_id = f"PHYS_{idx:03d}"

            item = create_item(
                item_id=item_id,
                subject="Physique-Chimie",
                level=level,
                domain=domain,
                title=title,
                ped_type=ped_type,
                creator=creator,
                query=query,
                target=target,
                duration=duration,
                concepts=concepts,
                l1_sections=sections,
                l2_visual_cue=visual_cue,
                l3_primitives=primitives,
                l3_scenes=len(sections)
            )
            items.append(item)
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
         ["subordonnée relative", "conjonctive complétive", "fonction sujet/COD", "mode indicatif/subjonctif"],
         "Soulignons en bleu la proposition principale et encadrons en vert la proposition subordonnée.",
         ["text", "draw line", "draw polygone"]),
        ("Première Générale", "Grammaire Bac", "L'expression de la négation (totale, partielle, restrictive)",
         ["ne... pas", "ne... que (restriction)", "mots négatifs", "négation lexicale vs syntaxique"],
         "Identifions la double marque de la négation et la portée sémantique sur le verbe.",
         ["text", "draw arrow", "draw polygone"]),
        ("Première Générale", "Grammaire Bac", "L'interrogation : directe, indirecte, totale et partielle",
         ["inversion sujet-verbe", "mot interrogatif", "subordonnée interrogative indirecte"],
         "Comparons la structure directe avec point d'interrogation et la structure indirecte.",
         ["text", "draw line", "draw arrow"]),
        ("Première Générale", "Stylistique & Rhétorique", "Les figures d'analogie et d'image : métaphore, comparaison, allégorie",
         ["comparé et comparant", "outil de comparaison", "métaphore filée", "personnification"],
         "Relions par une flèche le terme concret comparant à la notion abstraite comparée.",
         ["text", "draw arrow", "draw circle"]),
        ("Première Générale", "Stylistique & Rhétorique", "Les figures d'opposition et d'amplification : oxymore, antithèse, hyperbole",
         ["oxymore dans le même syntagme", "antithèse symétrique", "hyperbole et gradation"],
         "Mettons en regard les deux termes opposés pour faire ressortir la tension poétique.",
         ["text", "draw polygone", "draw line"]),
        ("Première Spécialité", "Méthode du Commentaire", "Construire une problématique et bâtir un plan en 2 ou 3 parties",
         ["enjeu littéraire", "plan dialectique ou thématique", "axes de lecture", "progressivité"],
         "Schématisons l'arbre du plan avec les deux axes principaux et leurs sous-parties A, B, C.",
         ["text", "draw polygone", "draw line", "draw arrow"]),
        ("Première Spécialité", "Méthode du Commentaire", "L'analyse stylistique au service du sens (Procédé + Citation + Effet)",
         ["repérage du procédé", "citation exacte entre guillemets", "interprétation littéraire"],
         "Structurons la formule magique du commentaire : Procédé, Citation, Interprétation.",
         ["text", "draw polygone", "draw arrow"]),
        ("Première Spécialité", "Méthode de la Dissertation", "Analyser le sujet de dissertation et formuler le paradoxe",
         ["mots-clés de la citation", "thèse de l'auteur", "limites de la thèse", "problématisation"],
         "Décomposons la citation de l'auteur en confrontant ses affirmations à l'œuvre intégrale.",
         ["text", "draw polygone", "draw line"]),
        ("Première Spécialité", "Oral du Bac de Français", "L'explication linéaire pas à pas (Mouvements du texte et analyse mot à mot)",
         ["lecture expressive", "découpage en mouvements", "analyse continue", "bilan conclusif"],
         "Faisons apparaître les accolades pour délimiter les trois mouvements du poème.",
         ["text", "draw curve", "draw line", "mouse move"]),
        ("Première Spécialité", "Œuvres au Programme", "Analyse linéaire d'un extrait de Baudelaire (Les Fleurs du Mal)",
         ["Spleen et Idéal", "versification alexandrin", "symbolisme et synesthésies"],
         "Surlignons les rimes croisées et les allitérations qui installent l'angoisse du poète.",
         ["text", "draw line", "draw polygone", "mouse move"])
    ]

    fr_types_cycle = [
        ("cours_notion", 3),
        ("methode_resolution", 3),
        ("exemple_detaille", 1),
        ("correction_exercice", 2),
        ("synthese_revision", 1),
    ]

    idx = 1
    # 10 modules * 10 cours = 100 cours de Français
    for mod_idx, (level, domain, theme, concepts, visual_cue, primitives) in enumerate(fr_modules):
        for i in range(10):
            ped_type, _ = fr_types_cycle[(i + mod_idx) % len(fr_types_cycle)]
            creator = CREATORS["fr_primary"] if i % 2 == 0 else CREATORS["fr_secondary"]

            if ped_type == "cours_notion":
                title = f"{theme} — Notions clés & Règles fondamentales"
                target = f"Identifier et comprendre les mécanismes littéraires et syntaxiques pour : {theme}."
                duration = 140
                sections = ["accroche", "prerequis", "exemple_concret", "definition_formelle", "synthese"]
            elif ped_type == "methode_resolution":
                title = f"Méthode Bac pas à pas : {theme}"
                target = f"Acquérir la méthodologie rigoureuse exigée aux épreuves du Bac de français sur {theme}."
                duration = 150
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "exemple_detaille":
                title = f"Exemple rédigé et décrypté : {theme}"
                target = f"Observer un modèle de rédaction d'excellence annoté et expliqué pour {theme}."
                duration = 130
                sections = ["accroche", "exemple_concret", "decomposition", "synthese"]
            elif ped_type == "correction_exercice":
                title = f"Exercice & Sujet corrigé : {theme} (Entraînement Bac)"
                target = f"S'entraîner sur un sujet type Bac avec correction guidée pas à pas sur {theme}."
                duration = 160
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            else:
                title = f"Fiche mémo & Synthèse express : {theme}"
                target = f"Réviser les points cruciaux et automatismes indispensables le jour de l'épreuve pour {theme}."
                duration = 110
                sections = ["accroche", "definition_formelle", "erreur_frequente", "synthese"]

            sub_concept = concepts[i % len(concepts)]
            fr_creator = "Amelie Vioux" if i % 2 == 0 else "Medusaces"
            query = f"{fr_creator} bac francais {theme} {sub_concept}"
            item_id = f"LANG_FR_{idx:03d}"

            item = create_item(
                item_id=item_id,
                subject="Français",
                level=level,
                domain=domain,
                title=title,
                ped_type=ped_type,
                creator=creator,
                query=query,
                target=target,
                duration=duration,
                concepts=concepts,
                l1_sections=sections,
                l2_visual_cue=visual_cue,
                l3_primitives=primitives,
                l3_scenes=len(sections)
            )
            items.append(item)
            idx += 1

    # 2. ANGLAIS LYCÉE (100 cours répartis en 10 modules de 10 cours)
    en_modules = [
        ("Terminale Tronc Commun", "Grammar & Tenses", "Mastering the Present Perfect (Simple vs Continuous)",
         ["past action with present result", "for and since", "duration with have been -ing", "state verbs"],
         "Let's draw a timeline from the past reaching right into the present moment.",
         ["draw line", "draw arrow", "text", "draw circle"]),
        ("Terminale Tronc Commun", "Grammar & Tenses", "Past Perfect vs Simple Past in Narrative Chronology",
         ["had + past participle", "flashback event", "time markers: before, after, by the time"],
         "We place Event A in the double past before Event B on our horizontal time arrow.",
         ["draw line", "draw arrow", "text"]),
        ("Terminale Tronc Commun", "Grammar & Conditionals", "Conditionals Mastery: 1st, 2nd, 3rd and Mixed Conditionals",
         ["if + present, will", "if + past, would", "if + past perfect, would have", "unreal past"],
         "Let's build the conditional matrix showing probability on one axis and time on the other.",
         ["draw polygone", "draw line", "text", "draw arrow"]),
        ("Terminale Tronc Commun", "Grammar & Voice", "The Passive Voice and Impersonal Structures",
         ["be + past participle", "focus on the action/object", "it is said that / he is believed to"],
         "We invert the subject and object with a reciprocal crossing arrow diagram.",
         ["text", "draw arrow", "draw polygone"]),
        ("Terminale Tronc Commun", "Grammar & Modals", "Modal Verbs of Deduction and Probability (Must, Can't, Might)",
         ["degree of certainty", "deduction in the present", "past deduction: must have + past participle"],
         "Let's trace a certainty gauge ranging from zero percent impossible to one hundred percent certain.",
         ["draw line", "draw arrow", "draw polygone", "text"]),
        ("Terminale Tronc Commun", "Writing Skills", "Structuring an Argumentative Essay (PEEL Method)",
         ["thesis statement", "Point, Evidence, Explanation, Link", "counter-argument and refutation"],
         "Let's map out the four building blocks of the PEEL paragraph structure.",
         ["draw polygone", "draw line", "text", "draw arrow"]),
        ("Terminale Tronc Commun", "Writing Skills", "Advanced Linking Words and Discourse Markers",
         ["contrast: however, whereas, despite", "consequence: therefore, consequently", "addition: moreover, furthermore"],
         "Let's organize connecting words into categories of contrast, cause, and logical conclusion.",
         ["text", "draw polygone", "draw arrow"]),
        ("Terminale Tronc Commun", "Oral Skills & Debate", "Structuring a Spontaneous 5-Minute Oral Presentation",
         ["hook and introduction", "transitioning between slides", "nuanced opinion and debate phrases"],
         "Let's display the five-step oral roadmap from introduction to punchy conclusion.",
         ["draw line", "draw polygone", "text", "draw arrow"]),
        ("Terminale Tronc Commun", "Thematic Studies", "Innovations, Artificial Intelligence and Ethical Responsibility",
         ["technological progress", "ethical dilemmas", "data privacy and surveillance", "impact on labor"],
         "Let's balance the benefits and moral hazards on our analytical scale diagram.",
         ["draw line", "draw polygone", "draw arrow", "text"]),
        ("Terminale Tronc Commun", "Thematic Studies", "Art, Culture and Power: Propaganda vs Dissent",
         ["monumental art", "subversion and satire", "symbolic power", "historical memory"],
         "Let's contrast state propaganda posters with dissenting street art imagery.",
         ["draw polygone", "draw line", "text", "draw circle"])
    ]

    en_types_cycle = [
        ("cours_notion", 3),
        ("methode_resolution", 3),
        ("exemple_detaille", 1),
        ("correction_exercice", 2),
        ("synthese_revision", 1),
    ]

    idx_en = 1
    # 10 modules * 10 cours = 100 cours d'Anglais
    for mod_idx, (level, domain, theme, concepts, visual_cue, primitives) in enumerate(en_modules):
        for i in range(10):
            ped_type, _ = en_types_cycle[(i + mod_idx) % len(en_types_cycle)]
            creator = CREATORS["en_primary"] if i % 2 == 0 else CREATORS["en_secondary"]

            if ped_type == "cours_notion":
                title = f"{theme} — Comprehensive Grammar & Concepts"
                target = f"Understand the core linguistic rules and usage conventions for: {theme}."
                duration = 140
                sections = ["accroche", "prerequis", "exemple_concret", "definition_formelle", "synthese"]
            elif ped_type == "methode_resolution":
                title = f"Step-by-Step Method: How to Master {theme}"
                target = f"Acquire practical techniques and structural frameworks for {theme}."
                duration = 150
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            elif ped_type == "exemple_detaille":
                title = f"In-Depth Example & Full Breakdown: {theme}"
                target = f"Analyze an authentic high-school level model and application for {theme}."
                duration = 130
                sections = ["accroche", "exemple_concret", "decomposition", "synthese"]
            elif ped_type == "correction_exercice":
                title = f"Practice Exercise & Guided Correction: {theme}"
                target = f"Solve an exam-style challenge with full corrections and common mistakes highlighted on {theme}."
                duration = 160
                sections = ["accroche", "prerequis", "decomposition", "erreur_frequente", "synthese"]
            else:
                title = f"Revision Sheet & Key Takeaways: {theme}"
                target = f"Consolidate must-know formulas, common pitfalls, and quick reflexes for {theme}."
                duration = 110
                sections = ["accroche", "definition_formelle", "erreur_frequente", "synthese"]

            sub_concept = concepts[i % len(concepts)]
            en_creator = "BBC Learning English" if i % 2 == 0 else "mmmEnglish"
            query = f"{en_creator} {theme} {sub_concept}"
            item_id = f"LANG_EN_{idx_en:03d}"

            item = create_item(
                item_id=item_id,
                subject="Anglais",
                level=level,
                domain=domain,
                title=title,
                ped_type=ped_type,
                creator=creator,
                query=query,
                target=target,
                duration=duration,
                concepts=concepts,
                l1_sections=sections,
                l2_visual_cue=visual_cue,
                l3_primitives=primitives,
                l3_scenes=len(sections)
            )
            items.append(item)
            idx_en += 1

    return items


# ---------------------------------------------------------------------------
# POINT D'ENTRÉE PRINCIPAL
# ---------------------------------------------------------------------------

def main():
    print("=" * 70)
    print("GÉNÉRATION DU CORPUS 1 000 COURS LYCÉE POUR ILLIMMI (FINE-TUNING GEMMA)")
    print("=" * 70)

    math_courses = generate_math_courses()
    phys_courses = generate_physique_courses()
    lang_courses = generate_langues_courses()

    all_courses = math_courses + phys_courses + lang_courses

    print(f"-> Mathématiques générés    : {len(math_courses)} (cible: 500)")
    print(f"-> Physique-Chimie générés  : {len(phys_courses)} (cible: 300)")
    print(f"-> Langues générés          : {len(lang_courses)} (cible: 200)")
    print(f"   - Français               : {sum(1 for c in lang_courses if c['subject'] == 'Français')}")
    print(f"   - Anglais                : {sum(1 for c in lang_courses if c['subject'] == 'Anglais')}")
    print(f"-> TOTAL CORPUS             : {len(all_courses)} (cible: 1000)")

    assert len(math_courses) == 500, f"Erreur: {len(math_courses)} maths au lieu de 500"
    assert len(phys_courses) == 300, f"Erreur: {len(phys_courses)} physique au lieu de 300"
    assert len(lang_courses) == 200, f"Erreur: {len(lang_courses)} langues au lieu de 200"
    assert len(all_courses) == 1000, f"Erreur: {len(all_courses)} total au lieu de 1000"

    # Sauvegarde des fichiers JSON
    full_path = CATALOG_DIR / "corpus_1000_full.json"
    with open(full_path, "w", encoding="utf-8") as f:
        json.dump(all_courses, f, ensure_ascii=False, indent=2)
    print(f"[OK] Fichier sauvegardé : {full_path} ({full_path.stat().st_size // 1024} Ko)")

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

    # Sauvegarde Manifest CSV
    csv_path = CATALOG_DIR / "corpus_1000_manifest.csv"
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([
            "id", "subject", "level", "domain", "title", "pedagogical_type",
            "creator", "duration_target_sec", "scenes_count", "search_query"
        ])
        for c in all_courses:
            writer.writerow([
                c["id"],
                c["subject"],
                c["level"],
                c["domain"],
                c["title"],
                c["pedagogical_type"],
                c["creator"],
                c["layer1_spec"]["duration_target"],
                c["layer3_spec"]["recommended_scene_count"],
                c["search_query"]
            ])
    print(f"[OK] Manifeste CSV sauvegardé : {csv_path}")
    print("=" * 70)
    print("SUCCÈS : 1 000 COURS GÉNÉRÉS ET STRUCTURÉS POUR ILLIMMI")
    print("=" * 70)

if __name__ == "__main__":
    main()
