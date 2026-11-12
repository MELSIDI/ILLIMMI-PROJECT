# =============================================================================
# HYPERCOURSE DSL — MATH_027
# Généralités sur les fonctions et lecture graphique — Cours fondamental
# =============================================================================
course "Généralités sur les fonctions et lecture graphique — Cours fondamental et définitions" id 27 idgap 500 for 745.14s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : ACCROCHE & TARIF DU SPECTACLE (0.15s -> 93.8s)
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Accroche & Modélisation Concrète : Le Tarif du Spectacle[/color][/bold]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 5.2s for 3.2s at (5.0, 21.0) ''[color=#F8FAFC]Objectifs fondamentaux du chapitre :[/color]'' ;
    text id 3 start 9.0s for 2.8s at (7.0, 29.0) ''[color=#38BDF8]• Découvrir la notion de fonction et de variable[/color]'' ;
    text id 4 start 13.0s for 2.8s at (7.0, 37.0) ''[color=#34D399]• Maîtriser le vocabulaire d'image et d'antécédent[/color]'' ;
    text id 5 start 17.5s for 3.2s at (7.0, 45.0) ''[color=#FBBF24]• Construire et exploiter une courbe représentative[/color]'' ;

    text id 6 start 29.5s for 2.5s at (5.0, 56.0) ''[color=#F8FAFC]Situation concrète : Billetterie de spectacle[/color]'' ;
    text id 7 start 33.5s for 3.2s at (7.0, 64.0) ''[color=#38BDF8]Tarif unique fixé : [bold]$20$ euros[/bold] par personne[/color]'' ;

    text id 8 start 42.2s for 2.2s at (7.0, 73.0) ''[color=#F8FAFC]• 1 personne $\implies 1 \times 20 =$ [color=#34D399]$20$ euros[/color][/color]'' ;
    text id 9 start 46.5s for 2.5s at (7.0, 80.0) ''[color=#F8FAFC]• 2 personnes $\implies 2 \times 20 =$ [color=#34D399]$40$ euros[/color][/color]'' ;
    text id 10 start 52.2s for 2.5s at (7.0, 87.0) ''[color=#F8FAFC]• 3 personnes $\implies 3 \times 20 =$ [color=#34D399]$60$ euros[/color][/color]'' ;

    # Right column: Table
    draw polygone id 502 start 64.2s for 1.2s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.12) at [(95, 30), (173, 30), (173, 68), (95, 68)] ;
    draw line id 503 start 66.0s for 0.8s color (56, 189, 248, 0.7) width 1.2 at [(95, 49), (173, 49)] ;
    draw line id 504 start 67.2s for 0.8s color (56, 189, 248, 0.7) width 1.2 at [(120, 30), (120, 68)] ;

    text id 11 start 68.2s for 2.5s at (97.0, 38.0) ''[color=#38BDF8]Nb personnes[/color]'' ;
    text id 12 start 72.2s for 2.5s at (97.0, 57.0) ''[color=#34D399]Prix (euros)[/color]'' ;

    draw line id 505 start 75.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(130, 30), (130, 68)] ;
    draw line id 506 start 76.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(140, 30), (140, 68)] ;
    draw line id 507 start 77.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(150, 30), (150, 68)] ;
    draw line id 508 start 78.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(161, 30), (161, 68)] ;

    text id 13 start 83.0s at (124.0, 38.0) ''[color=#F8FAFC]1[/color]'' ;
    text id 14 start 83.5s at (123.0, 57.0) ''[color=#34D399]20[/color]'' ;

    text id 15 start 86.2s at (134.0, 38.0) ''[color=#F8FAFC]2[/color]'' ;
    text id 16 start 86.7s at (133.0, 57.0) ''[color=#34D399]40[/color]'' ;

    text id 17 start 89.2s at (144.0, 38.0) ''[color=#F8FAFC]3[/color]'' ;
    text id 18 start 89.7s at (143.0, 57.0) ''[color=#34D399]60[/color]'' ;

    text id 19 start 91.2s at (154.5, 38.0) ''[color=#F8FAFC]5[/color]'' ;
    text id 20 start 91.6s at (153.0, 57.0) ''[color=#34D399]100[/color]'' ;

    text id 21 start 92.2s at (165.5, 38.0) ''[color=#F8FAFC]10[/color]'' ;
    text id 22 start 92.6s at (164.0, 57.0) ''[color=#34D399]200[/color]'' ;

    text id 23 start 93.0s at (98.0, 77.0) ''[color=#FBBF24]Chaque valeur de départ est associée à un prix unique[/color]'' ;

    erase id 2001 start 93.8s ;

    # =========================================================================
    # SCÈNE 2 : DE LA VARIABLE AUX NOTATIONS OFFICIELLES (94.0s -> 217.9s)
    # =========================================================================
    text id 31 start 94.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. De la Machine Mathématique aux Notations Officielles[/color][/bold]'' ;
    draw line id 521 start 96.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 32 start 98.2s for 3.2s at (5.0, 21.0) ''[color=#F8FAFC]1. La notion de variable :[/color]'' ;
    text id 33 start 104.2s for 3.5s at (7.0, 29.0) ''[color=#38BDF8]Une grandeur qui varie est appelée une [bold]variable[/bold][/color]'' ;
    text id 34 start 109.2s for 2.0s at (7.0, 36.5) ''[color=#F8FAFC]On note souvent cette variable : [color=#34D399]$\mathbf{x}$[/color][/color]'' ;

    text id 35 start 118.2s for 3.2s at (5.0, 46.0) ''[color=#F8FAFC]2. Expression générale du prix :[/color]'' ;
    text id 36 start 123.2s for 2.5s at (7.0, 53.5) ''[color=#FBBF24]Soit $P$ le prix total à payer en fonction de $x$[/color]'' ;
    text id 37 start 139.2s for 2.2s at (7.0, 61.0) ''[color=#F8FAFC]Pour $1$ pers. : $20 \times 1$ | Pour $2$ pers. : $20 \times 2$[/color]'' ;
    text id 38 start 147.2s for 2.5s at (7.0, 68.5) ''[color=#F8FAFC]Pour [color=#38BDF8]$x$[/color] personnes : [color=#34D399]$\mathbf{P = 20 \times x = 20x}$[/color][/color]'' ;

    # Right column: Machine diagram
    draw polygone id 522 start 160.5s for 1.2s color (52, 211, 153, 0.9) width 1.8 fillcolor (52, 211, 153, 0.15) at [(113, 28), (155, 28), (155, 52), (113, 52)] ;
    text id 39 start 162.0s for 1.5s at (120.0, 34.0) ''[bold][color=#34D399]MACHINE P[/color][/bold]'' ;
    text id 40 start 164.0s for 2.0s at (122.0, 42.0) ''[color=#FBBF24]Règle : $\times 20$[/color]'' ;

    draw arrow id 523 start 168.0s for 1.0s color (56, 189, 248, 1) width 2.2 at [(96, 40), (112, 40)] ;
    text id 41 start 169.5s for 1.2s at (96.0, 33.0) ''[color=#38BDF8]Entrée : $x$[/color]'' ;

    draw arrow id 524 start 174.5s for 1.0s color (52, 211, 153, 1) width 2.2 at [(156, 40), (172, 40)] ;
    text id 42 start 176.0s for 1.2s at (158.0, 33.0) ''[color=#34D399]Sortie : $20x$[/color]'' ;

    # Two official notations (left column under item 3)
    text id 43 start 180.5s for 2.5s at (5.0, 77.0) ''[color=#F8FAFC]3. Les deux notations officielles :[/color]'' ;
    text id 44 start 185.5s for 3.5s at (7.0, 84.0) ''[color=#38BDF8]• Notation fléchée : [bold]$\mathbf{P : x \mapsto 20x}$[/bold][/color]'' ;
    text id 45 start 197.5s for 3.5s at (7.0, 92.0) ''[color=#34D399]• Notation fonctionnelle : [bold]$\mathbf{P(x) = 20x}$[/bold][/color]'' ;

    erase id 2002 start 217.9s ;

    # =========================================================================
    # SCÈNE 3 : VOCABULAIRE FONDAMENTAL : IMAGE ET ANTÉCÉDENT (218.17s -> 338.7s)
    # =========================================================================
    text id 51 start 218.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Vocabulaire Fondamental : Image & Antécédent[/color][/bold]'' ;
    draw line id 531 start 220.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 52 start 224.5s for 2.0s at (5.0, 21.0) ''[color=#F8FAFC]Exemple : pour $x = 2$, on a $P(2) = 20 \times 2 = 40$[/color]'' ;

    text id 53 start 227.5s for 3.5s at (5.0, 30.0) ''[color=#38BDF8][bold]Définition 1 : L'Image (valeur de sortie)[/bold][/color]'' ;
    text id 54 start 234.5s for 3.5s at (7.0, 37.5) ''[color=#F8FAFC]• [color=#34D399]$\mathbf{40}$[/color] est [bold]l'image[/bold] de $2$ par la fonction $P$[/color]'' ;
    text id 55 start 239.5s for 2.2s at (7.0, 44.5) ''[color=#F8FAFC]• On écrit : [color=#38BDF8]$\mathbf{P(2) = 40}$[/color][/color]'' ;

    text id 56 start 252.5s for 3.0s at (5.0, 54.0) ''[color=#FBBF24][bold]Définition 2 : L'Antécédent (valeur d'entrée)[/bold][/color]'' ;
    text id 57 start 261.2s for 3.2s at (7.0, 61.5) ''[color=#F8FAFC]• [color=#38BDF8]$\mathbf{2}$[/color] est [bold]un antécédent[/bold] de $40$ par $P$[/color]'' ;
    text id 58 start 265.5s for 3.5s at (7.0, 68.5) ''[color=#94A3B8]Étymologie : [italic]anté[/italic] signifie « avant » (la valeur d'entrée)[/color]'' ;

    text id 59 start 277.5s for 2.0s at (5.0, 78.0) ''[color=#F8FAFC]Exemples issus du tableau :[/color]'' ;
    text id 60 start 282.2s for 2.5s at (7.0, 85.0) ''[color=#34D399]• Image de $3$ : $\mathbf{60}$ | Image de $1$ : $\mathbf{20}$[/color]'' ;
    text id 61 start 287.5s for 3.0s at (7.0, 92.0) ''[color=#FBBF24]• Antécédent de $100$ : $\mathbf{5}$ | Antécédent de $200$ : $\mathbf{10}$[/color]'' ;

    # Right column: Cardinality rule
    draw polygone id 532 start 306.2s for 1.2s color (248, 113, 113, 0.9) width 1.8 fillcolor (248, 113, 113, 0.12) at [(95, 25), (173, 25), (173, 72), (95, 72)] ;
    text id 62 start 307.8s for 2.2s at (105.0, 31.0) ''[bold][color=#F87171]RÈGLE FONDAMENTALE D'UNICITÉ[/color][/bold]'' ;

    text id 63 start 310.5s for 3.5s at (98.0, 41.0) ''[color=#F8FAFC]1. [bold]L'image[/bold] est [color=#34D399][bold]UNIQUE[/bold][/color] :[/color]'' ;
    text id 64 start 314.5s for 3.5s at (98.0, 48.0) ''[color=#38BDF8]Tout nombre $x$ a une [bold]unique[/bold] image $P(x)$[/color]'' ;

    text id 65 start 323.5s for 3.5s at (98.0, 56.5) ''[color=#F8FAFC]2. [bold]L'antécédent[/bold] n'est pas forcément unique :[/color]'' ;
    text id 66 start 327.5s for 3.5s at (98.0, 64.0) ''[color=#FBBF24]$0$, $1$ ou plusieurs antécédents possibles[/color]'' ;

    erase id 2003 start 338.7s ;

    # =========================================================================
    # SCÈNE 4 : PLUSIEURS ANTÉCÉDENTS : LA FONCTION CARRÉE (339.0s -> 412.8s)
    # =========================================================================
    text id 71 start 339.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Plusieurs Antécédents Possibles : La Fonction Carrée[/color][/bold]'' ;
    draw line id 541 start 341.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 72 start 342.5s for 2.5s at (5.0, 21.0) ''[color=#F8FAFC]On considère la fonction carrée : [color=#38BDF8]$\mathbf{f(x) = x^2}$[/color][/color]'' ;
    text id 73 start 345.5s for 3.2s at (5.0, 28.5) ''[color=#94A3B8]Règle : la machine multiplie le nombre par lui-même[/color]'' ;

    text id 74 start 354.2s for 3.2s at (5.0, 39.0) ''[color=#F8FAFC]• Pour $x = 2$ : $f(2) = 2^2 = 2 \times 2 = $ [color=#34D399]$\mathbf{4}$[/color][/color]'' ;
    text id 75 start 360.2s for 2.2s at (7.0, 46.0) ''[color=#38BDF8]L'image de $2$ par $f$ est $4$[/color]'' ;

    text id 76 start 363.2s for 3.2s at (5.0, 54.0) ''[color=#F8FAFC]• Pour $x = 0$ : $f(0) = 0^2 = 0 \times 0 = $ [color=#34D399]$\mathbf{0}$[/color][/color]'' ;

    text id 77 start 371.5s for 3.2s at (5.0, 63.0) ''[color=#F8FAFC]• Pour $x = -2$ : $f(-2) = (-2)^2 = (-2) \times (-2) = $ [color=#34D399]$\mathbf{4}$[/color][/color]'' ;
    text id 78 start 379.0s for 2.5s at (7.0, 70.0) ''[color=#FBBF24]Règle des signes : un nombre négatif au carré devient positif ![/color]'' ;
    text id 79 start 383.2s for 2.5s at (7.0, 77.0) ''[color=#38BDF8]L'image de $-2$ par $f$ est aussi $4$[/color]'' ;

    # Right column: Two antecedents schema
    draw polygone id 542 start 388.5s for 1.2s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.12) at [(98, 25), (173, 25), (173, 78), (98, 78)] ;
    text id 80 start 390.2s for 2.5s at (105.0, 31.0) ''[bold][color=#34D399]CONSTAT FONDAMENTAL[/color][/bold]'' ;

    text id 81 start 394.2s for 2.5s at (102.0, 40.0) ''[color=#F8FAFC]$f(2) = 4 \quad \text{et} \quad f(-2) = 4$[/color]'' ;

    draw arrow id 543 start 398.0s for 0.8s color (56, 189, 248, 1) width 2.2 at [(108, 54), (130, 58)] ;
    text id 82 start 399.5s at (102.0, 53.0) ''[color=#38BDF8]$2$[/color]'' ;

    draw arrow id 544 start 401.0s for 0.8s color (251, 191, 36, 1) width 2.2 at [(108, 66), (130, 62)] ;
    text id 83 start 402.2s at (101.0, 66.0) ''[color=#FBBF24]$-2$[/color]'' ;

    text id 84 start 403.5s for 1.5s at (133.0, 58.5) ''[bold][color=#34D399]4[/color][/bold]'' ;

    text id 85 start 405.5s for 3.2s at (100.0, 72.0) ''[color=#FBBF24]$4$ admet DEUX antécédents : $\mathbf{2}$ et $\mathbf{-2}$[/color]'' ;

    erase id 2004 start 412.8s ;

    # =========================================================================
    # SCÈNE 5 : PRÉPARATION GRAPHIQUE : TABLEAU DE VALEURS (413.0s -> 514.5s)
    # =========================================================================
    text id 91 start 413.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Préparation Graphique : Tableau de Valeurs de $f(x) = x^2 - 3$[/color][/bold]'' ;
    draw line id 551 start 415.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 92 start 424.2s for 2.5s at (5.0, 20.0) ''[color=#F8FAFC]Fonction étudiée : [color=#38BDF8]$\mathbf{f(x) = x^2 - 3}$[/color][/color]'' ;
    text id 93 start 431.2s for 2.8s at (5.0, 27.0) ''[color=#94A3B8]Règle : on calcule le carré de $x$, puis on retranche $3$[/color]'' ;

    text id 94 start 447.2s for 3.2s at (5.0, 37.0) ''[color=#F8FAFC]1. Pour $x = -2$ : $f(-2) = (-2)^2 - 3 = 4 - 3 =$ [color=#34D399]$\mathbf{1}$[/color][/color]'' ;
    text id 95 start 464.2s for 3.2s at (5.0, 48.0) ''[color=#F8FAFC]2. Pour $x = 0$ : $f(0) = 0^2 - 3 = 0 - 3 =$ [color=#34D399]$\mathbf{-3}$[/color][/color]'' ;
    text id 96 start 475.2s for 3.2s at (5.0, 59.0) ''[color=#F8FAFC]3. Pour $x = 1$ : $f(1) = 1^2 - 3 = 1 - 3 =$ [color=#34D399]$\mathbf{-2}$[/color][/color]'' ;
    text id 97 start 486.5s for 3.2s at (5.0, 70.0) ''[color=#F8FAFC]4. Pour $x = 3$ : $f(3) = 3^2 - 3 = 9 - 3 =$ [color=#34D399]$\mathbf{6}$[/color][/color]'' ;

    # Right column: Table of coordinates
    draw polygone id 552 start 496.2s for 1.2s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.12) at [(95, 25), (170, 25), (170, 68), (95, 68)] ;
    draw line id 553 start 498.0s for 0.8s color (56, 189, 248, 0.7) width 1.2 at [(95, 46), (170, 46)] ;
    draw line id 554 start 499.5s for 0.8s color (56, 189, 248, 0.7) width 1.2 at [(110, 25), (110, 68)] ;

    text id 98 start 500.5s for 1.8s at (101.0, 35.0) ''[color=#38BDF8]$\mathbf{x}$[/color]'' ;
    text id 99 start 502.5s for 1.8s at (98.0, 56.0) ''[color=#34D399]$\mathbf{f(x)}$[/color]'' ;

    draw line id 555 start 504.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(125, 25), (125, 68)] ;
    draw line id 556 start 505.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(140, 25), (140, 68)] ;
    draw line id 557 start 506.5s for 0.6s color (56, 189, 248, 0.5) width 1.0 at [(155, 25), (155, 68)] ;

    text id 100 start 507.5s at (116.5, 35.0) ''[color=#F8FAFC]-2[/color]'' ;
    text id 101 start 508.0s at (117.0, 56.0) ''[color=#34D399]1[/color]'' ;

    text id 102 start 508.8s at (131.5, 35.0) ''[color=#F8FAFC]0[/color]'' ;
    text id 103 start 509.3s at (131.0, 56.0) ''[color=#34D399]-3[/color]'' ;

    text id 104 start 510.0s at (146.5, 35.0) ''[color=#F8FAFC]1[/color]'' ;
    text id 105 start 510.5s at (146.0, 56.0) ''[color=#34D399]-2[/color]'' ;

    text id 106 start 511.2s at (161.5, 35.0) ''[color=#F8FAFC]3[/color]'' ;
    text id 107 start 511.7s at (162.0, 56.0) ''[color=#34D399]6[/color]'' ;

    text id 108 start 512.5s for 1.8s at (97.0, 78.0) ''[color=#FBBF24]Chaque couple $(x ; f(x))$ donne un point du repère[/color]'' ;

    erase id 2005 start 514.5s ;

    # =========================================================================
    # SCÈNE 6 : TRACÉ DANS LE REPÈRE CARTÉSIEN (514.75s -> 614.8s)
    # =========================================================================
    text id 111 start 515.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Tracé de la Courbe Représentative dans le Repère[/color][/bold]'' ;
    draw line id 561 start 517.0s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    # Repère 2drep
    draw 2drep id 562 start 518.2s for 1.5s at (130, 63) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 4] y_range = [-4, 7] ;

    text id 112 start 520.0s for 2.5s at (5.0, 21.0) ''[color=#38BDF8]Axe horizontal : [bold]Abscisses ($x$)[/bold][/color]'' ;
    text id 113 start 523.5s for 2.8s at (5.0, 30.0) ''[color=#34D399]Axe vertical : [bold]Ordonnées ($f(x)$)[/bold][/color]'' ;

    text id 114 start 529.5s for 2.0s at (5.0, 42.0) ''[color=#F8FAFC]Placement des 4 points du tableau :[/color]'' ;

    # Point 1: (-2, 1) -> Board (119, 57.5)
    draw circle id 563 start 534.5s for 0.8s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.4) radius 1.2 at (119.0, 57.5) ;
    text id 115 start 536.0s for 2.0s at (5.0, 50.0) ''[color=#FBBF24]• $A(-2 ; 1)$[/color]'' ;

    # Point 2: (0, -3) -> Board (130, 79.5)
    draw circle id 564 start 545.5s for 0.8s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.4) radius 1.2 at (130.0, 79.5) ;
    text id 116 start 547.0s for 2.0s at (5.0, 58.0) ''[color=#FBBF24]• $B(0 ; -3)$[/color]'' ;

    # Point 3: (1, -2) -> Board (135.5, 74.0)
    draw circle id 565 start 557.5s for 0.8s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.4) radius 1.2 at (135.5, 74.0) ;
    text id 117 start 559.0s for 2.0s at (5.0, 66.0) ''[color=#FBBF24]• $C(1 ; -2)$[/color]'' ;

    # Point 4: (3, 6) -> Board (146.5, 30.0)
    draw circle id 566 start 569.5s for 0.8s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.4) radius 1.2 at (146.5, 30.0) ;
    text id 118 start 571.0s for 2.0s at (5.0, 74.0) ''[color=#FBBF24]• $D(3 ; 6)$[/color]'' ;

    # Trace curve: parabole
    draw 2dfunc id 567 start 586.5s for 2.5s color (52, 211, 153, 1.0) width 2.8 at 562 y = x^2 - 3 ;

    text id 119 start 593.5s for 3.0s at (5.0, 84.0) ''[color=#34D399][bold]Courbe continue et lisse : Parabole[/bold][/color]'' ;
    text id 120 start 599.5s for 2.5s at (5.0, 91.0) ''[color=#94A3B8]La courbe se prolonge à gauche et à droite à l'infini[/color]'' ;

    erase id 2006 start 614.8s ;

    # =========================================================================
    # SCÈNE 7 : LECTURE GRAPHIQUE D'UNE IMAGE : f(2) (615.0s -> 666.8s)
    # =========================================================================
    text id 131 start 615.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Lecture Graphique d'une Image : Le Cas $f(2)$[/color][/bold]'' ;
    draw line id 571 start 617.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 572 start 618.5s for 1.0s at (130, 63) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 4] y_range = [-4, 7] ;
    draw 2dfunc id 573 start 620.0s for 1.5s color (52, 211, 153, 1.0) width 2.5 at 572 y = x^2 - 3 ;

    text id 132 start 622.0s for 2.5s at (5.0, 21.0) ''[color=#FBBF24][bold]Question :[/bold] Déterminer graphiquement l'image de $2$ par $f$[/color]'' ;

    text id 133 start 631.5s for 1.8s at (5.0, 31.0) ''[color=#F8FAFC]Méthode rigoureuse en 3 étapes :[/color]'' ;

    # Step 1: x = 2
    text id 134 start 633.5s for 2.8s at (7.0, 39.0) ''[color=#38BDF8]1. Repérer $\mathbf{x = 2}$ sur l'axe des abscisses[/color]'' ;
    draw circle id 574 start 636.5s for 0.6s color (56, 189, 248, 1) width 2.0 fillcolor (56, 189, 248, 0.5) radius 1.0 at (141.0, 63.0) ;

    # Step 2: vertical arrow to curve at (2, 1) -> (141.0, 57.5)
    text id 135 start 638.0s for 3.5s at (7.0, 48.0) ''[color=#38BDF8]2. Rejoindre verticalement la courbe[/color]'' ;
    draw arrow id 575 start 642.0s for 1.0s color (56, 189, 248, 1) width 2.2 at [(141.0, 63.0), (141.0, 57.5)] ;
    draw circle id 576 start 643.5s for 0.6s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.6) radius 1.2 at (141.0, 57.5) ;

    # Step 3: horizontal arrow to y-axis at (0, 1) -> (130.0, 57.5)
    text id 136 start 645.0s for 3.5s at (7.0, 57.0) ''[color=#34D399]3. Projeter horizontalement sur l'axe des ordonnées[/color]'' ;
    draw arrow id 577 start 649.0s for 1.0s color (52, 211, 153, 1) width 2.2 at [(141.0, 57.5), (130.0, 57.5)] ;
    draw circle id 578 start 650.5s for 0.6s color (52, 211, 153, 1) width 2.0 fillcolor (52, 211, 153, 0.5) radius 1.0 at (130.0, 57.5) ;

    # Conclusion & check
    text id 137 start 653.5s for 2.5s at (5.0, 69.0) ''[color=#34D399][bold]Résultat lu : $\mathbf{f(2) = 1}$[/bold][/color]'' ;
    text id 138 start 658.5s for 3.0s at (5.0, 78.0) ''[color=#F8FAFC]Vérification par le calcul : $2^2 - 3 = 4 - 3 =$ [color=#34D399]$\mathbf{1}$[/color][/color]'' ;
    text id 139 start 664.2s for 2.0s at (5.0, 87.0) ''[color=#FBBF24]Parfaite concordance entre graphique et calcul ![/color]'' ;

    erase id 2007 start 666.8s ;

    # =========================================================================
    # SCÈNE 8 : LECTURE GRAPHIQUE DES ANTÉCÉDENTS DE -2 (667.0s -> 732.8s)
    # =========================================================================
    text id 151 start 667.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. Lecture Graphique des Antécédents de $-2$[/color][/bold]'' ;
    draw line id 581 start 669.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 582 start 670.5s for 1.0s at (130, 63) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 4] y_range = [-4, 7] ;
    draw 2dfunc id 583 start 672.0s for 1.2s color (52, 211, 153, 1.0) width 2.5 at 582 y = x^2 - 3 ;

    text id 152 start 674.0s for 2.8s at (5.0, 21.0) ''[color=#FBBF24][bold]Question :[/bold] Trouver les antécédents de $-2$ par $f$[/color]'' ;

    # Step 1: y = -2
    text id 153 start 686.2s for 2.5s at (7.0, 31.0) ''[color=#38BDF8]1. Repérer $\mathbf{y = -2}$ sur l'axe des ordonnées[/color]'' ;
    draw circle id 584 start 689.0s for 0.6s color (56, 189, 248, 1) width 2.0 fillcolor (56, 189, 248, 0.5) radius 1.0 at (130.0, 74.0) ;

    # Step 2: horizontal line y = -2
    text id 154 start 690.5s for 2.8s at (7.0, 40.0) ''[color=#FBBF24]2. Tracer la ligne horizontale $\mathbf{y = -2}$[/color]'' ;
    draw line id 585 start 694.0s for 1.2s color (251, 191, 36, 0.95) width 2.0 at [(113.5, 74.0), (152.0, 74.0)] ;

    # Intersection 1: right (1, -2) -> (135.5, 74.0)
    draw circle id 586 start 697.5s for 0.6s color (52, 211, 153, 1) width 2.0 fillcolor (52, 211, 153, 0.6) radius 1.2 at (135.5, 74.0) ;
    draw arrow id 587 start 701.5s for 1.0s color (52, 211, 153, 1) width 2.0 at [(135.5, 74.0), (135.5, 63.0)] ;
    text id 155 start 703.5s for 3.2s at (7.0, 52.0) ''[color=#34D399]• 1ère intersection (droite) : [bold]$\mathbf{x_1 = 1}$[/bold][/color]'' ;

    # Intersection 2: left (-1, -2) -> (124.5, 74.0)
    draw circle id 588 start 714.5s for 0.6s color (52, 211, 153, 1) width 2.0 fillcolor (52, 211, 153, 0.6) radius 1.2 at (124.5, 74.0) ;
    draw arrow id 589 start 716.5s for 1.0s color (52, 211, 153, 1) width 2.0 at [(124.5, 74.0), (124.5, 63.0)] ;
    text id 156 start 718.5s for 3.2s at (7.0, 63.0) ''[color=#34D399]• 2ème intersection (gauche) : [bold]$\mathbf{x_2 = -1}$[/bold][/color]'' ;

    # Conclusion
    text id 157 start 723.5s for 3.0s at (5.0, 75.0) ''[color=#F8FAFC]Vérification : $(-1)^2 - 3 = 1 - 3 = -2$ et $1^2 - 3 = -2$[/color]'' ;
    text id 158 start 728.5s for 3.5s at (5.0, 85.0) ''[color=#FBBF24][bold]Conclusion : $-2$ admet DEUX antécédents : $\mathbf{1}$ et $\mathbf{-1}$[/bold][/color]'' ;

    erase id 2008 start 732.8s ;

    # =========================================================================
    # SCÈNE 9 : SYNTHÈSE & FICHE RÉFLEXE D'EXAMEN (733.0s -> 780.0s)
    # =========================================================================
    text id 171 start 733.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]9. Fiche Réflexe & Synthèse pour le Devoir[/color][/bold]'' ;
    draw line id 601 start 735.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 172 start 737.5s for 2.2s at (5.0, 21.0) ''[color=#F8FAFC][bold]Boussole mentale des axes :[/bold][/color]'' ;
    text id 173 start 740.2s for 3.5s at (7.0, 29.5) ''[color=#38BDF8]• $\mathbf{x}$ est [bold]l'antécédent[/bold] : axe [bold]horizontal[/bold] (abscisses)[/color]'' ;
    text id 174 start 748.5s for 3.5s at (7.0, 38.0) ''[color=#34D399]• $\mathbf{f(x)}$ est [bold]l'image[/bold] : axe [bold]vertical[/bold] (ordonnées)[/color]'' ;

    text id 175 start 754.5s for 3.2s at (5.0, 50.0) ''[color=#FBBF24][bold]Méthodes de lecture graphique :[/bold][/color]'' ;
    text id 176 start 758.0s for 3.0s at (7.0, 58.0) ''[color=#F8FAFC]• Image de $a$ : Partir de $x = a \to$ Courbe $\to$ Lire $y$[/color]'' ;
    text id 177 start 761.5s for 3.5s at (7.0, 66.5) ''[color=#F8FAFC]• Antécédents de $b$ : Droite $y = b \to$ Lire les $x$[/color]'' ;

    # Right column: Synthesis Box
    draw polygone id 602 start 767.5s for 1.0s color (52, 211, 153, 0.9) width 1.8 fillcolor (52, 211, 153, 0.12) at [(95, 22), (173, 22), (173, 75), (95, 75)] ;
    text id 178 start 769.5s for 2.5s at (105.0, 28.0) ''[bold][color=#34D399]RÈGLES D'OR DU CONTRÔLE[/color][/bold]'' ;

    text id 179 start 772.2s for 1.8s at (98.0, 38.0) ''[color=#F8FAFC]1. [bold]Unicité de l'image :[/bold][/color]'' ;
    text id 180 start 774.2s at (100.0, 45.0) ''[color=#38BDF8]Au maximum une seule image pour un nombre $x$[/color]'' ;

    text id 181 start 775.5s at (98.0, 54.0) ''[color=#F8FAFC]2. [bold]Multiplicité des antécédents :[/bold][/color]'' ;
    text id 182 start 777.0s at (98.0, 61.0) ''[color=#FBBF24]$0$, $1$ ou plusieurs antécédents possibles[/color]'' ;

    text id 183 start 778.2s at (100.0, 68.5) ''[color=#94A3B8]Ne jamais inverser abscisse et ordonnée ![/color]'' ;

}
