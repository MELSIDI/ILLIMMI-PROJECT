course "Méthode pas à pas : Comment résoudre un problème de Valeur absolue et distance sur la droite réelle" id 18 idgap 500 for 407.8s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction intuitive et droite des réels (0.0s -> 33.5s)
    # =========================================================================

    text id 1 start 0.5s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Droite des réels & Notion géométrique[/color][/bold]'' ;
    draw line id 501 start 1.9s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 3.2s for 2.2s at (4.0, 22.0) ''[color=#FBBF24][bold]Objectif du cours :[/bold][/color]'' ;
    text id 3 start 5.8s for 3.0s at (4.0, 31.0) ''Comprendre la [bold]valeur absolue[/bold] d'un réel et calculer'' ;
    text id 4 start 9.3s for 2.5s at (4.0, 40.0) ''avec précision la [bold]distance entre deux nombres[/bold].'' ;

    text id 5 start 15.6s for 3.2s at (4.0, 56.0) ''Soit $x \in \mathbb{R}$ et le point $M$ d'abscisse $x$ sur la droite réelle.'' ;

    # Right column : Horizontal graduated axis
    draw arrow id 502 start 22.0s for 1.5s color (248, 250, 252, 0.95) width 2.0 at [(96.0, 52.0), (170.0, 52.0)] ;
    text id 6 start 24.5s at (168.0, 46.0) ''[color=#38BDF8]$\mathbb{R}$[/color]'' ;

    # Origin O(0)
    draw line id 503 start 26.5s for 0.6s color (248, 250, 252, 0.95) width 2.2 at [(118.0, 48.0), (118.0, 56.0)] ;
    text id 7 start 27.5s at (116.5, 42.0) ''[bold][color=#38BDF8]$O$[/color][/bold]'' ;
    text id 8 start 28.7s at (116.8, 59.0) ''$0$'' ;

    # Point M(x)
    draw line id 504 start 29.8s for 0.6s color (52, 211, 153, 1) width 2.2 at [(152.0, 48.0), (152.0, 56.0)] ;
    text id 9 start 30.8s at (150.5, 42.0) ''[bold][color=#34D399]$M$[/color][/bold]'' ;
    text id 10 start 31.9s at (151.0, 59.0) ''[color=#34D399]$x$[/color]'' ;

    # =========================================================================
    # SCENE 2 : Définition géométrique et algébrique de |x| (33.5s -> 129.5s)
    # =========================================================================

    erase id 2001 start 33.5s ;

    text id 11 start 34.0s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Définition de la valeur absolue & Distance à zéro[/color][/bold]'' ;
    draw line id 521 start 35.6s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 12 start 37.0s for 2.2s at (4.0, 21.0) ''[color=#38BDF8][bold]Définition géométrique :[/bold][/color]'' ;
    text id 13 start 41.2s for 3.2s at (4.0, 30.0) ''La [bold]valeur absolue[/bold] de $x$, notée $|x|$, est la distance $OM$ :'' ;
    text id 14 start 46.5s for 2.4s at (4.0, 40.0) ''$$\mathbf{|x| = OM = \text{distance de } O \text{ à } M}$$'' ;

    # Right column visual : axis with highlighted OM segment
    draw arrow id 522 start 43.5s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(96.0, 52.0), (170.0, 52.0)] ;
    draw line id 523 start 45.0s for 0.4s color (248, 250, 252, 0.95) width 2.0 at [(118.0, 48.0), (118.0, 56.0)] ;
    text id 15 start 45.6s at (116.5, 42.0) ''[color=#38BDF8]$O(0)$[/color]'' ;

    draw line id 524 start 46.2s for 0.4s color (52, 211, 153, 1) width 2.0 at [(152.0, 48.0), (152.0, 56.0)] ;
    text id 16 start 46.8s at (150.5, 42.0) ''[color=#34D399]$M(x)$[/color]'' ;

    # Segment OM highlighted in amber
    draw line id 525 start 48.5s for 1.2s color (251, 191, 36, 1) width 5.0 at [(118.0, 52.0), (152.0, 52.0)] ;
    # Bracket above OM
    draw path id 526 start 51.5s for 1.0s color (251, 191, 36, 1) width 2.0 at [(118.0, 37.0), (118.0, 34.0), (152.0, 34.0), (152.0, 37.0)] ;
    text id 17 start 53.0s at (126.0, 28.0) ''[bold][color=#FBBF24]$|x| = OM$[/color][/bold]'' ;

    # Left column : Positivity and algebraic rule
    text id 18 start 60.5s for 3.2s at (4.0, 53.0) ''[color=#34D399][bold]Règle d'or :[/bold][/color] Une distance est [bold]toujours positive ou nulle[/bold] :'' ;
    text id 19 start 64.5s for 2.0s at (24.0, 62.0) ''[color=#34D399]$$\mathbf{|x| \ge 0}$$[/color]'' ;

    text id 20 start 71.5s for 2.5s at (4.0, 71.0) ''[color=#FBBF24][bold]Calcul selon le signe de $x$ :[/bold][/color]'' ;
    text id 21 start 77.0s for 2.6s at (6.0, 80.0) ''$\bullet$ Si $x \ge 0$ : la distance $OM = x$, donc [bold]$|x| = x$[/bold]'' ;
    text id 22 start 88.0s for 3.0s at (6.0, 89.0) ''$\bullet$ Si $x < 0$ : la distance $OM = -x$, donc [bold]$|x| = -x$[/bold]'' ;

    # Right column lower box : Distance to zero takeaway
    draw polygone id 527 start 106.5s for 1.2s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.5 at [(96.0, 68.0), (170.0, 68.0), (170.0, 93.0), (96.0, 93.0)] ;
    text id 23 start 108.5s for 2.2s at (100.0, 72.0) ''[bold][color=#38BDF8]Formule algébrique générale :[/color][/bold]'' ;
    text id 24 start 111.5s for 3.0s at (102.0, 78.0) ''$$|x| = \begin{cases} x & \text{si } x \ge 0 \\ -x & \text{si } x < 0 \end{cases}$$'' ;
    text id 25 start 121.5s for 2.8s at (100.0, 87.5) ''[color=#FBBF24]$|x|$ est appelée la [bold]distance à zéro[/bold].[/color]'' ;

    # =========================================================================
    # SCENE 3 : Exemples numériques et propriété des opposés (129.5s -> 213.0s)
    # =========================================================================

    erase id 2002 start 129.5s ;

    text id 31 start 130.0s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Exemples numériques & Symétrie des opposés[/color][/bold]'' ;
    draw line id 551 start 131.6s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Left Column : Direct calculations
    text id 32 start 134.5s for 2.0s at (4.0, 21.0) ''[color=#38BDF8][bold]1. Valeurs absolues directes :[/bold][/color]'' ;

    text id 33 start 138.0s for 2.5s at (6.0, 31.0) ''$\bullet$ $|4| = \mathbf{4}$  (car $4 \ge 0$)'' ;
    text id 34 start 145.5s for 3.2s at (6.0, 43.0) ''$\bullet$ $|-12| = -(-12) = \mathbf{12}$  (opposé positif)'' ;
    text id 35 start 158.0s for 3.0s at (6.0, 56.0) ''$\bullet$ $\left|-\frac{4}{3}\right| = -\left(-\frac{4}{3}\right) = \mathbf{\frac{4}{3}}$  (positif)'' ;
    text id 36 start 168.0s for 2.2s at (6.0, 68.0) ''$\bullet$ $|0| = \mathbf{0}$'' ;

    # Right Column : Opposites comparison
    text id 37 start 173.5s for 2.5s at (94.0, 21.0) ''[color=#FBBF24][bold]2. Cas des opposés :[/bold][/color]'' ;

    text id 38 start 179.0s for 2.5s at (96.0, 31.0) ''$\bullet$ $|-4| = 4$  et  $|4| = 4$  $\implies |-4| = |4|$'' ;
    text id 39 start 185.0s for 2.5s at (96.0, 43.0) ''$\bullet$ $|12| = 12$  et  $|-12| = 12$  $\implies |12| = |-12|$'' ;
    text id 40 start 191.5s for 2.8s at (96.0, 56.0) ''$\bullet$ $\left|\frac{4}{3}\right| = \frac{4}{3}$  et  $\left|-\frac{4}{3}\right| = \frac{4}{3}$'' ;

    # Fundamental theorem card at bottom
    draw polygone id 552 start 197.5s for 1.2s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.12) width 1.8 at [(10.0, 77.0), (168.0, 77.0), (168.0, 95.0), (10.0, 95.0)] ;
    text id 41 start 200.0s for 2.0s at (14.0, 81.0) ''[color=#34D399][bold]Propriété fondamentale remarquable :[/bold][/color]'' ;
    text id 42 start 205.0s for 3.0s at (24.0, 88.0) ''$$\mathbf{\forall x \in \mathbb{R}, \quad |x| = |-x|}$$'' ;
    text id 43 start 209.0s at (82.0, 88.5) ''[color=#F8FAFC]Un nombre et son opposé ont la [bold]même distance à zéro[/bold].[/color]'' ;

    # =========================================================================
    # SCENE 4 : Distance entre deux réels sur la droite (213.0s -> 264.0s)
    # =========================================================================

    erase id 2003 start 213.0s ;

    text id 51 start 213.5s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Distance entre deux nombres réels sur la droite graduée[/color][/bold]'' ;
    draw line id 571 start 215.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Left Column : Formal definitions & Formula
    text id 52 start 216.5s for 2.5s at (4.0, 21.0) ''[color=#38BDF8][bold]Définition géométrique :[/bold][/color]'' ;
    text id 53 start 221.0s for 3.0s at (4.0, 30.0) ''Soient deux points $A(a)$ et $B(b)$ sur la droite graduée.'' ;
    text id 54 start 230.5s for 3.0s at (4.0, 40.0) ''La distance entre les réels $a$ et $b$ est la longueur $AB$ :'' ;
    text id 55 start 235.5s for 2.8s at (8.0, 50.0) ''[color=#34D399]$$\mathbf{d(a, b) = AB = |b - a|}$$[/color]'' ;

    text id 56 start 242.0s for 2.6s at (8.0, 61.0) ''[color=#FBBF24]$$\mathbf{d(a, b) = |b - a| = |a - b|}$$[/color]'' ;

    text id 57 start 247.5s for 2.8s at (4.0, 73.0) ''[color=#38BDF8][bold]Pourquoi cette égalité ?[/bold][/color]'' ;
    text id 58 start 252.5s for 3.0s at (4.0, 81.0) ''Car $(a - b) = -(b - a)$ : ce sont deux nombres opposés !'' ;
    text id 59 start 258.0s for 2.8s at (4.0, 89.0) ''Puisque $|X| = |-X|$, [bold]l'ordre de soustraction est indifférent[/bold].'' ;

    # Right Column : Visual line with segment AB
    draw arrow id 572 start 225.8s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 52.0), (172.0, 52.0)] ;

    # Point A(a)
    draw line id 573 start 228.0s for 0.5s color (56, 189, 248, 1) width 2.2 at [(114.0, 48.0), (114.0, 56.0)] ;
    text id 60 start 228.8s at (112.5, 42.0) ''[bold][color=#38BDF8]$A$[/color][/bold]'' ;
    text id 61 start 229.4s at (113.0, 59.0) ''[color=#38BDF8]$a$[/color]'' ;

    # Point B(b)
    draw line id 574 start 229.8s for 0.5s color (52, 211, 153, 1) width 2.2 at [(154.0, 48.0), (154.0, 56.0)] ;
    text id 62 start 230.4s at (152.5, 42.0) ''[bold][color=#34D399]$B$[/color][/bold]'' ;
    text id 63 start 231.0s at (153.0, 59.0) ''[color=#34D399]$b$[/color]'' ;

    # Segment AB highlighted in sky cyan
    draw line id 575 start 233.0s for 1.2s color (56, 189, 248, 1) width 5.0 at [(114.0, 52.0), (154.0, 52.0)] ;

    # Distance bracket above AB
    draw path id 576 start 237.5s for 1.0s color (251, 191, 36, 1) width 2.0 at [(114.0, 36.0), (114.0, 33.0), (154.0, 33.0), (154.0, 36.0)] ;
    text id 64 start 239.5s at (122.0, 27.0) ''[bold][color=#FBBF24]$AB = |b - a| = |a - b|$[/color][/bold]'' ;

    # =========================================================================
    # SCENE 5 : Décomposition pas à pas : Distance entre -7 et 2 (264.0s -> 341.2s)
    # =========================================================================

    erase id 2004 start 264.0s ;

    text id 71 start 264.5s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Méthode pas à pas : Calcul de la distance entre -7 et 2[/color][/bold]'' ;
    draw line id 601 start 266.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Left Column : Calculations
    text id 72 start 268.8s for 2.2s at (4.0, 21.0) ''[color=#FBBF24][bold]Problème :[/bold][/color] Calculer la distance entre $a = -7$ et $b = 2$.'' ;

    # Method 1 : |b - a|
    text id 73 start 280.8s for 2.4s at (4.0, 31.0) ''[color=#38BDF8][bold]1ère méthode : Formule $|b - a|$[/bold][/color]'' ;
    text id 74 start 286.5s for 2.6s at (8.0, 39.0) ''$$d = |2 - (-7)|$$'' ;
    text id 75 start 293.5s for 2.8s at (8.0, 48.0) ''$$d = |2 + 7| = |9| = \mathbf{9}$$'' ;

    # Method 2 : |a - b|
    text id 76 start 304.0s for 2.5s at (4.0, 59.0) ''[color=#34D399][bold]2nde méthode : Formule $|a - b|$[/bold][/color]'' ;
    text id 77 start 309.5s for 2.6s at (8.0, 67.0) ''$$d = |-7 - 2| = |-9|$$'' ;
    text id 78 start 315.0s for 2.5s at (8.0, 76.0) ''$$d = -(-9) = \mathbf{9}$$'' ;

    text id 79 start 322.0s for 2.5s at (4.0, 88.0) ''[color=#FBBF24][bold]Résultat identique :[/bold][/color] La distance entre $-7$ et $2$ est $\mathbf{9}$.'' ;

    # Right Column : Visual number line
    draw arrow id 602 start 272.5s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 52.0), (172.0, 52.0)] ;

    # Origin O(0)
    draw line id 603 start 274.5s for 0.4s color (248, 250, 252, 0.95) width 2.0 at [(142.0, 48.0), (142.0, 56.0)] ;
    text id 80 start 275.2s at (141.0, 42.0) ''$O$'' ;
    text id 81 start 275.8s at (141.2, 59.0) ''$0$'' ;

    # Point A(-7)
    draw line id 604 start 277.0s for 0.5s color (56, 189, 248, 1) width 2.2 at [(104.0, 48.0), (104.0, 56.0)] ;
    text id 82 start 278.0s at (102.5, 42.0) ''[bold][color=#38BDF8]$A$[/color][/bold]'' ;
    text id 83 start 278.8s at (101.5, 59.0) ''[color=#38BDF8]$-7$[/color]'' ;

    # Point B(2)
    draw line id 605 start 279.5s for 0.5s color (52, 211, 153, 1) width 2.2 at [(153.0, 48.0), (153.0, 56.0)] ;
    text id 84 start 280.2s at (151.5, 42.0) ''[bold][color=#34D399]$B$[/color][/bold]'' ;
    text id 85 start 280.8s at (152.0, 59.0) ''[color=#34D399]$2$[/color]'' ;

    # Highlighted segment AB
    draw line id 606 start 282.0s for 1.2s color (251, 191, 36, 1) width 5.0 at [(104.0, 52.0), (153.0, 52.0)] ;

    # Verification brackets below the axis
    # Sub-bracket 1: from -7 to 0 (7 units)
    draw path id 607 start 331.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(104.0, 68.0), (104.0, 71.0), (142.0, 71.0), (142.0, 68.0)] ;
    text id 86 start 332.5s at (118.0, 74.0) ''[color=#38BDF8]$7\text{ unités}$[/color]'' ;

    # Sub-bracket 2: from 0 to 2 (2 units)
    draw path id 608 start 334.8s for 0.6s color (52, 211, 153, 1) width 1.8 at [(142.0, 68.0), (142.0, 71.0), (153.0, 71.0), (153.0, 68.0)] ;
    text id 87 start 336.0s at (144.0, 74.0) ''[color=#34D399]$2\text{ u.}$[/color]'' ;

    # Total check
    text id 88 start 338.5s for 2.0s at (116.0, 85.0) ''[bold][color=#FBBF24]Distance totale : $7 + 2 = 9$ unités[/color][/bold]'' ;

    # =========================================================================
    # SCENE 6 : Erreur fréquente : Piège des parenthèses (341.2s -> 369.0s)
    # =========================================================================

    erase id 2005 start 341.2s ;

    text id 101 start 341.6s for 1.4s at (4.0, 7.5) ''[bold][color=#F87171]6. Erreur fréquente : Piège du signe moins & Parenthèses[/color][/bold]'' ;
    draw line id 631 start 343.2s for 0.8s color (248, 113, 113, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Left Column : Trap demonstration
    text id 102 start 344.5s for 2.5s at (4.0, 21.0) ''[color=#F87171][bold]Le piège classique à l'examen :[/bold][/color]'' ;
    text id 103 start 348.5s for 3.0s at (4.0, 30.0) ''Oublier les parenthèses lors de la soustraction d'un négatif !'' ;

    text id 104 start 352.5s for 2.8s at (8.0, 42.0) ''[color=#F87171]$\mathbf{\times}$ FAUX : $\quad 2 - 7 = -5$[/color]'' ;
    text id 105 start 356.5s for 2.8s at (8.0, 52.0) ''[color=#34D399]$\mathbf{\checkmark}$ VRAI : $\quad 2 - (-7) = 2 + 7 = \mathbf{9}$[/color]'' ;

    text id 106 start 361.0s for 2.8s at (4.0, 66.0) ''[color=#FBBF24][bold]Règle absolue :[/bold][/color] Une distance n'est [bold]jamais négative[/bold] !'' ;
    text id 107 start 365.0s for 2.8s at (4.0, 76.0) ''Si ton résultat est négatif, ton calcul comporte une erreur.'' ;

    # Right Column : Golden rule reminder card
    draw polygone id 632 start 346.0s for 1.2s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.12) width 1.8 at [(94.0, 24.0), (172.0, 24.0), (172.0, 88.0), (94.0, 88.0)] ;
    text id 108 start 348.0s for 2.0s at (98.0, 30.0) ''[bold][color=#38BDF8]Le réflexe de calcul sécurisé :[/color][/bold]'' ;
    text id 109 start 353.5s for 2.5s at (98.0, 40.0) ''Toujours écrire les parenthèses de protection :'' ;
    text id 110 start 357.0s for 2.5s at (114.0, 50.0) ''[color=#FBBF24]$$\mathbf{|b - (a)|}$$[/color]'' ;
    text id 111 start 362.0s for 2.8s at (98.0, 62.0) ''Ici avec $a = -7$ et $b = 2$ :'' ;
    text id 112 start 365.5s for 2.5s at (106.0, 72.0) ''[color=#34D399]$$|2 - (-7)| = |2 + 7| = 9 \ge 0$$[/color]'' ;

    # =========================================================================
    # SCENE 7 : Synthèse & Réflexes pour le lycée (369.0s -> 407.8s)
    # =========================================================================

    erase id 2006 start 369.0s ;

    text id 121 start 369.6s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Synthèse : Les 3 Réflexes Fondamentaux du Lycée[/color][/bold]'' ;
    draw line id 651 start 371.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Reflex 1 : Distance to zero
    text id 122 start 373.8s for 2.5s at (4.0, 22.0) ''[color=#38BDF8][bold]1. Valeur absolue = Distance à zéro[/bold][/color]'' ;
    text id 123 start 377.0s for 3.0s at (6.0, 31.0) ''$|x| = OM \ge 0 \quad$ avec $\quad |x| = \begin{cases} x & \text{si } x \ge 0 \\ -x & \text{si } x < 0 \end{cases}$'' ;

    # Reflex 2 : Distance between two reals
    text id 124 start 386.0s for 2.6s at (4.0, 45.0) ''[color=#34D399][bold]2. Distance entre deux nombres réels[/bold][/color]'' ;
    text id 125 start 389.5s for 3.0s at (6.0, 54.0) ''[color=#34D399]$$\mathbf{d(a, b) = AB = |b - a| = |a - b| \ge 0}$$[/color]'' ;

    # Reflex 3 : Symmetry of opposites
    text id 126 start 395.0s for 2.5s at (4.0, 68.0) ''[color=#FBBF24][bold]3. Symétrie des nombres opposés[/bold][/color]'' ;
    text id 127 start 398.0s for 2.5s at (6.0, 77.0) ''[color=#FBBF24]$$\mathbf{|x| = |-x|}$$[/color]'' ;

    # Right Column : Final certification card
    draw polygone id 652 start 372.5s for 1.2s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.12) width 1.8 at [(94.0, 22.0), (172.0, 22.0), (172.0, 88.0), (94.0, 88.0)] ;
    text id 128 start 375.0s for 2.0s at (104.0, 28.0) ''[bold][color=#34D399]Bilan Visuel & Méthodologique[/color][/bold]'' ;

    # Mini axis in right card
    draw arrow id 653 start 378.5s for 1.0s color (248, 250, 252, 0.9) width 1.8 at [(98.0, 52.0), (168.0, 52.0)] ;
    draw line id 654 start 381.0s for 0.4s color (56, 189, 248, 1) width 2.0 at [(116.0, 48.0), (116.0, 56.0)] ;
    text id 129 start 381.8s at (114.5, 42.0) ''[color=#38BDF8]$A(a)$[/color]'' ;

    draw line id 655 start 383.0s for 0.4s color (52, 211, 153, 1) width 2.0 at [(150.0, 48.0), (150.0, 56.0)] ;
    text id 130 start 383.8s at (148.5, 42.0) ''[color=#34D399]$B(b)$[/color]'' ;

    draw line id 656 start 388.0s for 1.0s color (251, 191, 36, 1) width 4.5 at [(116.0, 52.0), (150.0, 52.0)] ;
    text id 131 start 390.5s at (122.0, 36.0) ''[color=#FBBF24]$AB = |b - a|$[/color]'' ;

    text id 132 start 401.5s for 2.5s at (100.0, 78.0) ''[bold][color=#34D399]Méthode validée avec succès ![/color][/bold]'' ;

}
