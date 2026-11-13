course "Problème type Bac : Fonctions affines et droites du plan" id 45 idgap 500 for 266.0s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : ÉNONCÉ DU PROBLÈME & FORME RÉDUITE (0.0s -> 55.5s)
    # =========================================================================

    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]1. Énoncé du Problème & Forme Réduite d'une Droite[/bold][/color]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 4.8s for 2.2s at (4.0, 20.0) ''[color=#F8FAFC]Objectif : Déterminer l'équation d'une droite passant par deux points[/color]'' ;
    text id 3 start 8.5s for 2.2s at (4.0, 28.0) ''[color=#FBBF24][bold]Données :[/bold][/color] Deux points distincts grand A et grand B sur la droite $(d)$'' ;

    # Repère orthonormé à droite (X in [92, 173], Y in [18, 92])
    draw 2drep id 502 start 12.2s for 1.5s at (119.0, 69.0) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 6] y_range = [-3, 8] ;

    # Placement du point A(4 ; -1)
    draw circle id 503 start 23.5s for 0.8s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) radius 1.2 at (141.0, 74.5) ;
    text id 4 start 24.5s for 1.2s at (6.0, 36.0) ''[color=#F87171]• Point grand A :[/color]  $A(4 \; ; \; -1)$'' ;
    text id 5 start 26.0s for 0.8s at (10.0, 42.0) ''[color=#94A3B8]Abscisse $x_A = 4$, Ordonnée $y_A = -1$[/color]'' ;

    # Placement du point B(3 ; 5)
    draw circle id 504 start 28.5s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.8) radius 1.2 at (135.5, 41.5) ;
    text id 6 start 29.5s for 1.2s at (6.0, 49.0) ''[color=#34D399]• Point grand B :[/color]  $B(3 \; ; \; 5)$'' ;
    text id 7 start 31.0s for 0.8s at (10.0, 55.0) ''[color=#94A3B8]Abscisse $x_B = 3$, Ordonnée $y_B = 5$[/color]'' ;

    # Forme générale
    text id 8 start 35.0s for 2.0s at (4.0, 63.0) ''[color=#38BDF8][bold]Forme générale de l'équation réduite :[/bold][/color]'' ;
    text id 9 start 39.5s for 2.2s at (8.0, 71.0) ''[color=#F8FAFC]$\mathbf{y = ax + b}$[/color]'' ;

    # Stratégie en 2 étapes
    text id 10 start 47.5s for 2.0s at (4.0, 79.0) ''[color=#FBBF24]• Étape 1 :[/color] Trouver le coefficient directeur [color=#FBBF24]$\mathbf{a}$[/color]'' ;
    text id 11 start 51.0s for 2.0s at (4.0, 86.0) ''[color=#C084FC]• Étape 2 :[/color] Trouver l'ordonnée à l'origine [color=#C084FC]$\mathbf{b}$[/color]'' ;

    erase id 2001 start 55.8s ;

    # =========================================================================
    # SCÈNE 2 : RÔLE & FORMULE DU COEFFICIENT DIRECTEUR (56.0s -> 94.5s)
    # =========================================================================

    text id 26 start 56.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]2. Rôle & Formule du Coefficient Directeur[/bold][/color]'' ;
    draw line id 526 start 58.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 27 start 59.5s for 2.2s at (4.0, 20.0) ''Dans l'équation [color=#F8FAFC]$\mathbf{y = ax + b}$[/color], le nombre [color=#FBBF24]$\mathbf{a}$[/color] est crucial :'' ;
    text id 28 start 64.5s for 2.5s at (4.0, 28.0) ''[color=#FBBF24][bold]Coefficient directeur :[/bold][/color] Il caractérise la [bold]pente[/bold] et la [bold]direction[/bold]'' ;
    text id 29 start 69.0s for 2.0s at (8.0, 36.0) ''• Si $a > 0$ : la droite monte  |  Si $a < 0$ : la droite descend'' ;

    # Encadré mnémotechnique à droite
    draw polygone id 527 start 75.0s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 2.0 at [(102, 26), (168, 26), (168, 84), (102, 84)] ;
    text id 33 start 77.0s for 1.2s at (106.0, 33.0) ''[color=#FBBF24][bold]Règle Mnémotechnique Lycée[/bold][/color]'' ;

    text id 30 start 78.5s for 1.8s at (4.0, 48.0) ''[color=#34D399][bold]Formule fondamentale du coefficient directeur :[/bold][/color]'' ;
    text id 31 start 81.0s for 1.8s at (10.0, 59.0) ''[color=#38BDF8]$\mathbf{a = \frac{y_B - y_A}{x_B - x_A}}$[/color]'' ;

    text id 34 start 83.0s for 1.8s at (106.0, 44.0) ''[color=#38BDF8][bold]Haut (Numérateur) :[/bold][/color] Les ordonnées $y$'' ;
    text id 35 start 86.0s for 1.3s at (106.0, 53.0) ''[color=#94A3B8]Les ordonnées montent au ciel ($\Delta y$)[/color]'' ;

    text id 32 start 87.5s for 1.3s at (10.0, 72.0) ''[color=#F8FAFC]$\mathbf{a = \frac{\Delta y}{\Delta x} = \frac{\text{variation } y}{\text{variation } x}}$[/color]'' ;

    draw line id 528 start 89.0s for 0.6s color (248, 250, 252, 0.4) width 1.0 at [(106, 62), (164, 62)] ;
    text id 36 start 90.0s for 1.8s at (106.0, 68.0) ''[color=#34D399][bold]Bas (Dénominateur) :[/bold][/color] Les abscisses $x$'' ;
    text id 37 start 92.5s at (106.0, 76.0) ''[color=#94A3B8]L'écart horizontal ($\Delta x = x_B - x_A$)[/color]'' ;

    erase id 2002 start 95.0s ;

    # =========================================================================
    # SCÈNE 3 : CALCUL NUMÉRIQUE PAS À PAS DE a (95.5s -> 140.5s)
    # =========================================================================

    text id 51 start 95.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]3. Calcul Numérique Pas à Pas de a[/bold][/color]'' ;
    draw line id 551 start 97.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 52 start 98.0s for 1.8s at (4.0, 20.0) ''Rappel des coordonnées :  [color=#F87171]$A(4 \; ; \; -1)$[/color]  et  [color=#34D399]$B(3 \; ; \; 5)$[/color]'' ;
    text id 53 start 101.0s for 1.5s at (4.0, 28.0) ''[color=#38BDF8]Numérateur ($\Delta y$) :[/color] $y_B - y_A = 5 - (-1)$'' ;

    # Encadré de vigilance à droite
    draw polygone id 552 start 103.0s for 0.8s color (248, 113, 113, 0.8) fillcolor (248, 113, 113, 0.12) width 2.0 at [(100, 22), (170, 22), (170, 85), (100, 85)] ;
    text id 60 start 104.0s for 1.5s at (104.0, 28.0) ''[color=#F87171][bold]Vigilance : Le Piège des Signes ![/bold][/color]'' ;

    text id 54 start 106.5s for 2.0s at (4.0, 37.0) ''[color=#34D399]Dénominateur ($\Delta x$) :[/color] $x_B - x_A = 3 - 4$'' ;
    text id 61 start 109.0s for 1.5s at (104.0, 38.0) ''• Soustraction d'un nombre négatif :'' ;
    text id 62 start 112.5s for 1.0s at (108.0, 46.0) ''[color=#FBBF24]$5 - (-1) = 5 + 1 = 6$[/color]'' ;

    text id 55 start 114.0s for 1.8s at (4.0, 46.0) ''Écriture du quotient :  $\mathbf{a = \frac{5 - (-1)}{3 - 4}}$'' ;
    text id 63 start 116.0s for 1.5s at (108.0, 54.0) ''[color=#94A3B8](Ne pas écrire 5 - 1 = 4 !)[/color]'' ;

    text id 56 start 118.5s for 1.3s at (4.0, 56.0) ''[color=#FBBF24]Calcul pas à pas :[/color]  $5 - (-1) = 6$  et  $3 - 4 = -1$'' ;
    draw line id 553 start 120.0s for 0.6s color (248, 250, 252, 0.3) width 1.0 at [(104, 61), (166, 61)] ;

    text id 64 start 122.0s for 1.5s at (104.0, 68.0) ''• Signe du résultat :'' ;
    text id 57 start 126.5s for 1.3s at (4.0, 66.0) ''$\mathbf{a = \frac{6}{-1} = -6}$'' ;
    text id 65 start 128.0s for 1.8s at (108.0, 76.0) ''$a = -6 < 0 \implies$ la droite descend !'' ;

    text id 58 start 132.5s for 1.8s at (4.0, 76.0) ''[color=#34D399][bold]Valeur trouvée :[/bold][/color] Le coefficient directeur vaut [color=#F87171]$\mathbf{a = -6}$[/color]'' ;
    text id 59 start 136.0s for 2.5s at (4.0, 85.0) ''[color=#38BDF8][bold]Équation provisoire :[/bold][/color]  $\mathbf{y = -6x + b}$'' ;

    erase id 2003 start 141.0s ;

    # =========================================================================
    # SCÈNE 4 : DÉTERMINATION DE L'ORDONNÉE À L'ORIGINE b (141.5s -> 205.0s)
    # =========================================================================

    text id 76 start 141.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]4. Détermination de l'Ordonnée à l'Origine b[/bold][/color]'' ;
    draw line id 576 start 143.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 77 start 144.5s for 2.0s at (4.0, 20.0) ''Équation en cours : [color=#38BDF8]$\mathbf{y = -6x + b}$[/color]'' ;
    text id 78 start 148.5s for 1.3s at (4.0, 28.0) ''On utilise un point de la droite : $A(4 \; ; \; -1)$ ou $B(3 \; ; \; 5)$.'' ;

    # Encadré méthode à droite
    draw polygone id 577 start 150.0s for 0.8s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.12) width 2.0 at [(102, 22), (168, 22), (168, 85), (102, 85)] ;
    text id 85 start 151.0s for 1.5s at (106.0, 28.0) ''[color=#34D399][bold]Principe d'Appartenance[/bold][/color]'' ;

    text id 79 start 155.0s for 2.5s at (4.0, 37.0) ''[color=#34D399][bold]Choix du point B :[/bold][/color] $B(3 \; ; \; 5) \in (d) \iff \mathbf{y_B = -6 x_B + b}$'' ;
    text id 86 start 158.0s for 1.8s at (106.0, 38.0) ''Un point $M(x_M \; ; \; y_M)$ est sur $(d)$'' ;
    text id 87 start 162.0s for 1.8s at (106.0, 46.0) ''si et seulement si ses coordonnées'' ;
    text id 88 start 166.0s for 1.8s at (106.0, 54.0) ''[bold]vérifient l'équation[/bold] :'' ;

    text id 80 start 168.0s for 2.5s at (4.0, 47.0) ''Substituons $x = 3$ et $y = 5$ dans l'équation :'' ;
    text id 89 start 172.0s for 2.0s at (110.0, 63.0) ''[color=#FBBF24]$y_M = a \cdot x_M + b$[/color]'' ;

    text id 81 start 175.5s for 2.3s at (8.0, 56.0) ''$\mathbf{5 = -6 \times 3 + b}$'' ;
    draw line id 578 start 178.0s for 0.6s color (248, 250, 252, 0.3) width 1.0 at [(106, 70), (164, 70)] ;
    text id 90 start 180.0s for 1.8s at (106.0, 76.0) ''C'est une équation du premier degré'' ;
    text id 91 start 183.0s for 1.5s at (106.0, 81.0) ''à une seule inconnue : [color=#34D399]$\mathbf{b}$[/color] !'' ;

    text id 82 start 185.0s for 2.5s at (8.0, 65.0) ''$\mathbf{5 = -18 + b}$'' ;

    text id 83 start 193.0s for 2.5s at (4.0, 75.0) ''On isole $b$ en transposant $-18$ :'' ;
    text id 84 start 199.5s for 2.5s at (8.0, 84.0) ''$b = 5 + 18 \iff$ [color=#34D399]$\mathbf{b = 23}$[/color]'' ;

    erase id 2004 start 205.5s ;

    # =========================================================================
    # SCÈNE 5 : VÉRIFICATION AVEC LE POINT A & CONCLUSION (206.0s -> 245.5s)
    # =========================================================================

    text id 101 start 206.0s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]5. Vérification avec A & Équation Réduite Finale[/bold][/color]'' ;
    draw line id 601 start 207.8s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 102 start 209.0s for 2.2s at (4.0, 20.0) ''[color=#FBBF24][bold]Vérification avec le second point A(4 ; -1) :[/bold][/color]'' ;
    text id 103 start 213.5s for 2.5s at (6.0, 27.5) ''$-6 \times x_A + 23 = -6 \times 4 + 23$'' ;
    text id 104 start 217.0s for 2.5s at (6.0, 35.0) ''$= -24 + 23 =$ [color=#34D399]$\mathbf{-1 = y_A}$[/color] $\implies$ Validé !'' ;

    # Repère avec les deux points et la droite tracée
    draw 2drep id 602 start 220.0s for 1.5s at (119.0, 69.0) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 6] y_range = [-3, 8] ;
    draw circle id 603 start 222.0s for 0.5s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) radius 1.2 at (141.0, 74.5) ;

    text id 109 start 223.0s for 0.8s at (6.0, 43.0) ''• Point A :  [color=#F87171]$A(4 \; ; \; -1)$[/color]'' ;
    text id 105 start 224.5s for 2.0s at (4.0, 51.0) ''[color=#38BDF8][bold]Conclusion :[/bold][/color] En remplaçant $a = -6$ et $b = 23$ :'' ;

    draw circle id 604 start 227.0s for 0.5s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.8) radius 1.2 at (135.5, 41.5) ;
    text id 110 start 228.0s for 0.8s at (6.0, 58.0) ''• Point B :  [color=#34D399]$B(3 \; ; \; 5)$[/color]'' ;

    text id 106 start 229.5s for 3.0s at (8.0, 66.0) ''[color=#34D399]$\mathbf{(d) : \quad y = -6x + 23}$[/color]'' ;
    text id 107 start 234.0s for 1.2s at (4.0, 75.0) ''[color=#F8FAFC]• Coefficient directeur :[/color] [color=#F87171]$\mathbf{a = -6}$[/color]'' ;

    # Tracé de la droite passant par B et A
    draw line id 605 start 235.5s for 1.5s color (56, 189, 248, 1) width 2.5 at [(132.75, 25.0), (142.65, 84.4)] ;
    text id 108 start 237.5s for 1.5s at (4.0, 83.0) ''[color=#F8FAFC]• Ordonnée à l'origine :[/color] [color=#38BDF8]$\mathbf{b = 23}$[/color]'' ;

    text id 111 start 239.5s for 1.2s at (6.0, 90.0) ''[color=#38BDF8]$\implies$ La droite coupe $(Oy)$ en $(0 \; ; \; 23)$[/color]'' ;
    draw arrow id 606 start 241.0s for 0.8s color (248, 113, 113, 1) width 2.0 at [(147.0, 36.0), (139.0, 48.0)] ;
    text id 112 start 242.0s for 1.8s at (50.0, 75.0) ''[color=#F87171]$\implies$ Pente raide[/color]'' ;

    erase id 2005 start 245.8s ;

    # =========================================================================
    # SCÈNE 6 : SYNTHÈSE MÉTHODIQUE & RÉFLEXES EXAMEN (246.5s -> 266.0s)
    # =========================================================================

    text id 126 start 246.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]6. Synthèse Méthodique & Réflexes Examen[/bold][/color]'' ;
    draw line id 626 start 248.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 127 start 249.0s for 1.3s at (4.0, 20.0) ''[color=#FBBF24][bold]Méthode Universelle en Deux Étapes :[/bold][/color]'' ;
    draw polygone id 627 start 250.5s for 0.8s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 2.0 at [(102, 20), (170, 20), (170, 88), (102, 88)] ;

    text id 128 start 251.5s for 1.8s at (6.0, 29.0) ''[color=#38BDF8][bold]Étape 1 :[/bold][/color] Calculer le coefficient directeur $a$ avec la formule :'' ;
    text id 133 start 253.5s for 1.0s at (106.0, 26.0) ''[color=#FBBF24][bold]Checklist du Baccalauréat[/bold][/color]'' ;

    text id 129 start 254.8s for 1.8s at (12.0, 38.0) ''$\mathbf{a = \frac{y_B - y_A}{x_B - x_A}}$  [color=#94A3B8](Ordonnées $y$ au numérateur !)[/color]'' ;
    text id 134 start 256.8s for 1.0s at (106.0, 36.0) ''[color=#34D399]•[/color] Toujours $\mathbf{\Delta y}$ en haut, $\mathbf{\Delta x}$ en bas'' ;

    text id 130 start 258.0s for 1.5s at (6.0, 49.0) ''[color=#34D399][bold]Étape 2 :[/bold][/color] Remplacer $x$ et $y$ par un point connu ($A$ ou $B$) :'' ;
    text id 135 start 259.8s for 1.0s at (106.0, 46.0) ''[color=#34D399]•[/color] Protéger les négatifs : $5 - (-1) = 6$'' ;

    text id 131 start 261.0s for 1.2s at (12.0, 58.0) ''$y_B = a \cdot x_B + b \implies$ [color=#34D399]résoudre pour isoler $b$[/color]'' ;
    text id 136 start 262.5s for 1.0s at (106.0, 56.0) ''[color=#34D399]•[/color] L'appartenance donne une équation en $b$'' ;

    text id 132 start 263.8s for 1.0s at (6.0, 69.0) ''[color=#C084FC][bold]Étape 3 :[/bold][/color] Écrire l'équation finale [color=#38BDF8]$\mathbf{y = ax + b}$[/color] et vérifier avec le 2e point.'' ;
    text id 137 start 265.0s at (106.0, 66.0) ''[color=#34D399]•[/color] Toujours tester le second point'' ;
    text id 138 start 265.4s at (106.0, 78.0) ''[color=#38BDF8][bold]Score garanti à l'épreuve ![/bold][/color]'' ;
}
