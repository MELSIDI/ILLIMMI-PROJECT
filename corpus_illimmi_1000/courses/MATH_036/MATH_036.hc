course "Révision express : Variations de fonctions et extrema" id 36 idgap 500 for 558.82s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 (0.0s -> 74.05s) : Accroche, Repère, Courbe & Sens de lecture
    # =========================================================================
    text id 1 start 0.20s for 2.20s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Courbe représentative et domaine de définition[/color][/bold]'' ;
    draw line id 501 start 2.70s for 0.80s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;
    text id 2 start 5.50s for 2.50s at (4.0, 22.0) ''[bold][color=#FBBF24]Révision express Seconde : Variations & Extrema[/color][/bold]'' ;

    draw 2drep id 502 start 16.70s for 1.50s at (134, 62) color (248, 250, 252, 0.95) width 1.5 scale = 5.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 6] y_range = [-2, 5] ;
    draw path id 503 start 19.20s for 3.00s color (52, 211, 153, 1) width 3.0 at [(109.0, 44.5), (110.25, 44.71), (111.5, 45.34), (112.75, 46.33), (114.0, 47.62), (115.25, 49.13), (116.5, 50.75), (117.75, 52.37), (119.0, 53.88), (120.25, 55.17), (121.5, 56.16), (122.75, 56.79), (124.0, 57.0), (125.25, 56.74), (126.5, 56.0), (127.75, 54.8), (129.0, 53.25), (130.25, 51.44), (131.5, 49.5), (132.75, 47.56), (134.0, 45.75), (135.25, 44.2), (136.5, 43.0), (137.75, 42.26), (139.0, 42.0), (140.25, 42.95), (141.5, 45.66), (142.75, 49.72), (144.0, 54.5), (145.25, 59.28), (146.5, 63.34), (147.75, 66.05), (149.0, 67.0), (150.25, 65.49), (151.5, 62.86), (152.75, 59.75), (154.0, 56.59), (155.25, 53.73), (156.5, 51.46), (157.75, 50.0), (159.0, 49.5)] ;
    draw circle id 504 start 22.50s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.25) radius 1.1 at (109.0, 44.5) ;
    draw circle id 505 start 22.80s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.25) radius 1.1 at (159.0, 49.5) ;

    text id 3 start 35.20s for 2.40s at (4.0, 35.0) ''[bold][color=#34D399]Ensemble de définition :[/color][/bold]'' ;
    draw line id 506 start 41.60s for 0.80s color (251, 191, 36, 0.9) width 2 at [(109.0, 75.5), (159.0, 75.5)] ;
    draw line id 507 start 42.60s color (251, 191, 36, 0.9) width 2 at [(109.0, 73.5), (109.0, 77.5)] ;
    draw line id 508 start 42.90s color (251, 191, 36, 0.9) width 2 at [(159.0, 73.5), (159.0, 77.5)] ;
    text id 78 start 43.20s at (107.0, 78.5) ''[color=#FBBF24]$-5$[/color]'' ;
    text id 79 start 43.50s at (158.0, 78.5) ''[color=#FBBF24]$5$[/color]'' ;
    text id 4 start 48.10s for 2.20s at (4.0, 45.0) ''[color=#FBBF24]$D_f = [-5 ; 5]$[/color]'' ;
    text id 5 start 51.30s for 3.20s at (4.0, 57.0) ''[color=#F8FAFC]À chaque $x \in [-5 ; 5]$ correspond une image $f(x)$.[/color]'' ;

    text id 6 start 64.70s for 2.80s at (4.0, 72.0) ''[bold][color=#38BDF8]Règle d'or : lecture de GAUCHE à DROITE[/color][/bold]'' ;
    draw arrow id 509 start 67.80s for 1.20s color (56, 189, 248, 1) width 2.5 at [(109.0, 32.0), (159.0, 32.0)] ;
    mouse move id 1501 start 69.30s for 2.00s at [(109.0, 32.0), (159.0, 32.0)] ;

    erase id 2001 start 74.05s ;

    # =========================================================================
    # SCENE 2 (74.12s -> 135.85s) : Parcours intuitif : Croissance & Décroissance
    # =========================================================================
    text id 7 start 74.20s for 1.60s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Parcours intuitif : Croissance et décroissance[/color][/bold]'' ;
    draw line id 510 start 76.00s for 0.60s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;
    draw 2drep id 511 start 76.80s for 1.00s at (134, 62) color (248, 250, 252, 0.95) width 1.5 scale = 5.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 6] y_range = [-2, 5] ;
    draw path id 512 start 78.00s for 1.80s color (52, 211, 153, 1) width 3.0 at [(109.0, 44.5), (110.25, 44.71), (111.5, 45.34), (112.75, 46.33), (114.0, 47.62), (115.25, 49.13), (116.5, 50.75), (117.75, 52.37), (119.0, 53.88), (120.25, 55.17), (121.5, 56.16), (122.75, 56.79), (124.0, 57.0), (125.25, 56.74), (126.5, 56.0), (127.75, 54.8), (129.0, 53.25), (130.25, 51.44), (131.5, 49.5), (132.75, 47.56), (134.0, 45.75), (135.25, 44.2), (136.5, 43.0), (137.75, 42.26), (139.0, 42.0), (140.25, 42.95), (141.5, 45.66), (142.75, 49.72), (144.0, 54.5), (145.25, 59.28), (146.5, 63.34), (147.75, 66.05), (149.0, 67.0), (150.25, 65.49), (151.5, 62.86), (152.75, 59.75), (154.0, 56.59), (155.25, 53.73), (156.5, 51.46), (157.75, 50.0), (159.0, 49.5)] ;
    draw circle id 513 start 81.00s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 1.2 at (109.0, 44.5) ;

    mouse move id 1502 start 82.30s for 2.50s at [(109.0, 44.5), (116.5, 51.5), (124.0, 57.0)] ;
    draw arrow id 514 start 89.50s for 1.40s color (248, 113, 113, 1) width 2.5 at [(112.0, 42.5), (122.0, 52.5)] ;
    text id 8 start 91.50s for 2.20s at (4.0, 24.0) ''[bold][color=#F87171]Fonction décroissante :[/color][/bold]'' ;
    text id 9 start 94.00s for 1.60s at (4.0, 33.0) ''[color=#F8FAFC]vers la droite, la courbe descend.[/color]'' ;

    draw circle id 515 start 101.80s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 1.4 at (124.0, 57.0) ;
    mouse move id 1503 start 106.50s for 2.20s at [(124.0, 57.0), (131.5, 49.5), (139.0, 42.0)] ;
    draw arrow id 516 start 109.20s for 1.40s color (56, 189, 248, 1) width 2.5 at [(125.5, 52.5), (136.5, 41.0)] ;
    text id 10 start 111.00s for 2.20s at (4.0, 46.0) ''[bold][color=#38BDF8]Fonction croissante :[/color][/bold]'' ;
    text id 11 start 113.50s for 1.40s at (4.0, 55.0) ''[color=#F8FAFC]vers la droite, la courbe monte.[/color]'' ;

    draw circle id 517 start 118.80s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 1.4 at (139.0, 42.0) ;
    draw arrow id 518 start 120.00s for 1.20s color (248, 113, 113, 1) width 2.5 at [(142.0, 42.5), (148.0, 62.0)] ;
    draw circle id 519 start 121.50s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 1.4 at (149.0, 67.0) ;
    draw arrow id 520 start 122.60s for 1.20s color (56, 189, 248, 1) width 2.5 at [(151.5, 64.5), (158.5, 53.0)] ;

    text id 12 start 126.00s for 2.20s at (4.0, 70.0) ''[bold][color=#FBBF24]Réflexe visuel (gauche $\to$ droite) :[/color][/bold]'' ;
    text id 13 start 130.00s for 3.00s at (4.0, 80.0) ''[color=#F8FAFC]Descente = décroissante  |  Montée = croissante[/color]'' ;

    erase id 2002 start 135.85s ;

    # =========================================================================
    # SCENE 3 (135.96s -> 259.75s) : Intervalles de monotonie et extrema
    # =========================================================================
    text id 14 start 136.00s for 1.80s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Intervalles de monotonie et extrema[/color][/bold]'' ;
    draw line id 521 start 138.00s for 0.60s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;
    draw 2drep id 522 start 139.00s for 1.00s at (134, 62) color (248, 250, 252, 0.95) width 1.5 scale = 5.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 6] y_range = [-2, 5] ;
    draw path id 523 start 140.20s for 1.80s color (52, 211, 153, 1) width 3.0 at [(109.0, 44.5), (110.25, 44.71), (111.5, 45.34), (112.75, 46.33), (114.0, 47.62), (115.25, 49.13), (116.5, 50.75), (117.75, 52.37), (119.0, 53.88), (120.25, 55.17), (121.5, 56.16), (122.75, 56.79), (124.0, 57.0), (125.25, 56.74), (126.5, 56.0), (127.75, 54.8), (129.0, 53.25), (130.25, 51.44), (131.5, 49.5), (132.75, 47.56), (134.0, 45.75), (135.25, 44.2), (136.5, 43.0), (137.75, 42.26), (139.0, 42.0), (140.25, 42.95), (141.5, 45.66), (142.75, 49.72), (144.0, 54.5), (145.25, 59.28), (146.5, 63.34), (147.75, 66.05), (149.0, 67.0), (150.25, 65.49), (151.5, 62.86), (152.75, 59.75), (154.0, 56.59), (155.25, 53.73), (156.5, 51.46), (157.75, 50.0), (159.0, 49.5)] ;

    text id 15 start 142.80s for 2.80s at (4.0, 22.0) ''[bold][color=#FBBF24]Pour quels $x$ la fonction est-elle croissante ?[/color][/bold]'' ;
    draw arrow id 524 start 151.80s for 1.50s color (251, 191, 36, 0.85) width 2 at [(104.0, 62.0), (164.0, 62.0)] ;

    draw circle id 525 start 180.10s for 1.00s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.2) radius 2.0 at (124.0, 57.0) ;
    draw line id 526 start 182.40s for 0.60s color (251, 191, 36, 0.85) width 1.5 at [(124.0, 57.0), (124.0, 62.0)] ;
    text id 80 start 183.20s at (122.0, 74.0) ''[color=#FBBF24]$-2$[/color]'' ;
    draw line id 527 start 184.80s for 0.60s color (251, 191, 36, 0.85) width 1.5 at [(124.0, 57.0), (134.0, 57.0)] ;
    text id 16 start 185.80s for 2.40s at (4.0, 34.0) ''[color=#FBBF24]• Minimum relatif en $x = -2$ : $f(-2) = 1$[/color]'' ;

    draw circle id 528 start 200.20s for 1.00s color (56, 189, 248, 1) width 2.5 fillcolor (56, 189, 248, 0.2) radius 2.0 at (139.0, 42.0) ;
    draw line id 529 start 201.40s color (56, 189, 248, 0.85) width 1.5 at [(139.0, 42.0), (139.0, 62.0)] ;
    draw line id 530 start 201.70s color (56, 189, 248, 0.85) width 1.5 at [(139.0, 42.0), (134.0, 42.0)] ;
    text id 81 start 202.00s at (138.0, 74.0) ''[color=#38BDF8]$1$[/color]'' ;
    draw line id 531 start 202.50s for 1.20s color (56, 189, 248, 1) width 4.0 at [(124.0, 62.0), (139.0, 62.0)] ;
    text id 17 start 204.00s for 2.20s at (4.0, 46.0) ''[color=#38BDF8]• Maximum sur $[-5 ; 5]$ en $x = 1$ : $f(1) = 4$[/color]'' ;
    text id 18 start 206.40s for 1.80s at (4.0, 56.0) ''[bold][color=#34D399]$\implies f$ croissante sur $[-2 ; 1]$[/color][/bold]'' ;

    mouse move id 1504 start 210.80s for 2.00s at [(149.0, 67.0), (154.0, 58.0), (159.0, 49.5)] ;
    draw circle id 532 start 226.50s for 1.00s color (248, 113, 113, 1) width 2.5 fillcolor (248, 113, 113, 0.2) radius 2.0 at (149.0, 67.0) ;
    draw line id 533 start 228.00s color (248, 113, 113, 0.85) width 1.5 at [(149.0, 67.0), (149.0, 62.0)] ;
    draw line id 534 start 228.30s color (248, 113, 113, 0.85) width 1.5 at [(149.0, 67.0), (134.0, 67.0)] ;
    text id 82 start 228.60s at (148.0, 74.0) ''[color=#F87171]$3$[/color]'' ;
    draw line id 535 start 232.90s for 1.20s color (56, 189, 248, 1) width 4.0 at [(149.0, 62.0), (159.0, 62.0)] ;
    text id 83 start 234.20s at (158.0, 74.0) ''[color=#38BDF8]$5$[/color]'' ;
    text id 19 start 234.50s for 2.00s at (4.0, 67.0) ''[color=#F87171]• Minimum global en $x = 3$ : $f(3) = -1$[/color]'' ;
    text id 20 start 236.80s for 1.80s at (4.0, 77.0) ''[bold][color=#34D399]$\implies f$ aussi croissante sur $[3 ; 5]$[/color][/bold]'' ;

    text id 21 start 245.20s for 2.50s at (4.0, 88.0) ''[color=#F87171]• Décroissante sur $[-5 ; -2]$ et $[1 ; 3]$[/color]'' ;

    erase id 2003 start 259.75s ;

    # =========================================================================
    # SCENE 4 (259.84s -> 345.30s) : Tableau de variations — Structure & Ligne des x
    # =========================================================================
    text id 22 start 259.90s for 2.00s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Tableau de variations : Structure et ligne des $x$[/color][/bold]'' ;
    draw line id 536 start 262.10s for 0.60s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw polygone id 537 start 268.30s for 1.50s color (248, 250, 252, 0.95) width 2 fillcolor (56, 189, 248, 0.08) at [(90.0, 28.0), (173.0, 28.0), (173.0, 86.0), (90.0, 86.0)] ;
    draw line id 538 start 270.00s for 0.80s color (248, 250, 252, 0.95) width 2 at [(90.0, 44.0), (173.0, 44.0)] ;
    draw line id 539 start 271.00s for 0.60s color (248, 250, 252, 0.95) width 2 at [(106.0, 28.0), (106.0, 86.0)] ;

    text id 23 start 274.50s at (96.0, 33.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 24 start 275.00s for 2.20s at (4.0, 24.0) ''[color=#38BDF8]• 1re ligne : valeurs de $x$ (abscisses)[/color]'' ;

    text id 25 start 282.50s at (93.0, 62.0) ''[color=#34D399]$f(x)$[/color]'' ;
    text id 26 start 283.00s for 2.20s at (4.0, 36.0) ''[color=#34D399]• 2e ligne : variations et images $f(x)$[/color]'' ;

    text id 27 start 293.00s for 1.80s at (4.0, 50.0) ''[bold][color=#FBBF24]Étape 1 — Sur la ligne des $x$ :[/color][/bold]'' ;
    text id 28 start 295.20s for 2.00s at (4.0, 60.0) ''[color=#F8FAFC]1) Bornes du domaine : $-5$ et $5$[/color]'' ;
    text id 29 start 298.50s for 2.20s at (4.0, 70.0) ''[color=#F8FAFC]2) Changements de sens : $-2$, $1$ et $3$[/color]'' ;

    text id 30 start 310.30s at (108.5, 33.5) ''[bold][color=#F8FAFC]$-5$[/color][/bold]'' ;
    text id 31 start 311.60s at (167.5, 33.5) ''[bold][color=#F8FAFC]$5$[/color][/bold]'' ;
    text id 32 start 323.50s at (123.5, 33.5) ''[bold][color=#FBBF24]$-2$[/color][/bold]'' ;
    text id 33 start 330.40s at (139.5, 33.5) ''[bold][color=#FBBF24]$1$[/color][/bold]'' ;
    text id 34 start 337.20s at (153.5, 33.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;
    text id 35 start 341.90s for 2.20s at (4.0, 82.0) ''[bold][color=#34D399]Ordre croissant : $-5 < -2 < 1 < 3 < 5$[/color][/bold]'' ;

    erase id 2004 start 345.30s ;

    # =========================================================================
    # SCENE 5 (345.36s -> 417.45s) : Flèches de variation & Erreur fréquente
    # =========================================================================
    text id 36 start 345.40s for 2.00s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Flèches de variation et piège de l'échelle[/color][/bold]'' ;
    draw line id 540 start 347.60s for 0.50s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw polygone id 541 start 348.50s color (248, 250, 252, 0.95) width 2 fillcolor (56, 189, 248, 0.08) at [(90.0, 28.0), (173.0, 28.0), (173.0, 86.0), (90.0, 86.0)] ;
    draw line id 542 start 348.60s color (248, 250, 252, 0.95) width 2 at [(90.0, 44.0), (173.0, 44.0)] ;
    draw line id 543 start 348.70s color (248, 250, 252, 0.95) width 2 at [(106.0, 28.0), (106.0, 86.0)] ;
    text id 37 start 348.80s at (96.0, 33.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 38 start 348.90s at (93.0, 62.0) ''[color=#34D399]$f(x)$[/color]'' ;
    text id 39 start 349.00s at (108.5, 33.5) ''[bold][color=#F8FAFC]$-5$[/color][/bold]'' ;
    text id 40 start 349.10s at (123.5, 33.5) ''[bold][color=#FBBF24]$-2$[/color][/bold]'' ;
    text id 41 start 349.20s at (139.5, 33.5) ''[bold][color=#FBBF24]$1$[/color][/bold]'' ;
    text id 42 start 349.30s at (153.5, 33.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;
    text id 43 start 349.40s at (167.5, 33.5) ''[bold][color=#F8FAFC]$5$[/color][/bold]'' ;

    text id 44 start 350.20s for 2.00s at (4.0, 22.0) ''[bold][color=#34D399]Étape 2 — Tracer les flèches :[/color][/bold]'' ;

    text id 45 start 358.20s at (4.0, 33.0) ''[color=#F87171]• Sur $[-5 ; -2]$ : décroissante ($\searrow$)[/color]'' ;
    draw arrow id 544 start 360.10s for 1.50s color (248, 113, 113, 1) width 3 at [(113.0, 54.0), (124.0, 73.0)] ;

    text id 46 start 367.30s at (4.0, 43.0) ''[color=#38BDF8]• Sur $[-2 ; 1]$ : croissante ($\nearrow$)[/color]'' ;
    draw arrow id 545 start 369.00s for 1.50s color (56, 189, 248, 1) width 3 at [(128.0, 73.0), (139.0, 54.0)] ;

    text id 47 start 375.50s at (4.0, 53.0) ''[color=#F87171]• Sur $[1 ; 3]$ : décroissante ($\searrow$)[/color]'' ;
    draw arrow id 546 start 378.90s for 1.50s color (248, 113, 113, 1) width 3 at [(143.0, 54.0), (153.0, 73.0)] ;

    text id 48 start 384.10s at (4.0, 63.0) ''[color=#38BDF8]• Sur $[3 ; 5]$ : croissante ($\nearrow$)[/color]'' ;
    draw arrow id 547 start 386.00s for 1.50s color (56, 189, 248, 1) width 3 at [(157.0, 73.0), (167.0, 54.0)] ;

    text id 49 start 390.60s for 2.40s at (4.0, 76.0) ''[bold][color=#F87171]Erreur fréquente :[/color][/bold] [color=#F8FAFC]pas de dessin à l'échelle ![/color]'' ;
    mouse move id 1505 start 406.00s for 2.00s at [(112.0, 73.0), (168.0, 73.0)] ;
    text id 50 start 409.80s for 2.40s at (4.0, 86.0) ''[color=#FBBF24]Toutes les flèches peuvent avoir la même hauteur.[/color]'' ;

    erase id 2005 start 417.45s ;

    # =========================================================================
    # SCENE 6 (417.51s -> 502.92s) : Images des extrema et gestion des bornes
    # =========================================================================
    text id 51 start 417.60s for 1.80s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Placer les extrema et les bornes[/color][/bold]'' ;
    draw line id 548 start 419.60s for 0.50s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw polygone id 549 start 420.30s color (248, 250, 252, 0.95) width 2 fillcolor (56, 189, 248, 0.08) at [(90.0, 28.0), (173.0, 28.0), (173.0, 86.0), (90.0, 86.0)] ;
    draw line id 550 start 420.40s color (248, 250, 252, 0.95) width 2 at [(90.0, 44.0), (173.0, 44.0)] ;
    draw line id 551 start 420.50s color (248, 250, 252, 0.95) width 2 at [(106.0, 28.0), (106.0, 86.0)] ;
    text id 52 start 420.60s at (96.0, 33.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 53 start 420.70s at (93.0, 62.0) ''[color=#34D399]$f(x)$[/color]'' ;
    text id 54 start 420.80s at (108.5, 33.5) ''[bold][color=#F8FAFC]$-5$[/color][/bold]'' ;
    text id 55 start 420.90s at (123.5, 33.5) ''[bold][color=#FBBF24]$-2$[/color][/bold]'' ;
    text id 56 start 421.00s at (139.5, 33.5) ''[bold][color=#FBBF24]$1$[/color][/bold]'' ;
    text id 57 start 421.10s at (153.5, 33.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;
    text id 58 start 421.20s at (167.5, 33.5) ''[bold][color=#F8FAFC]$5$[/color][/bold]'' ;
    draw arrow id 552 start 421.30s color (248, 113, 113, 1) width 3 at [(113.0, 54.0), (124.0, 73.0)] ;
    draw arrow id 553 start 421.40s color (56, 189, 248, 1) width 3 at [(128.0, 73.0), (139.0, 54.0)] ;
    draw arrow id 554 start 421.50s color (248, 113, 113, 1) width 3 at [(143.0, 54.0), (153.0, 73.0)] ;
    draw arrow id 555 start 421.60s color (56, 189, 248, 1) width 3 at [(157.0, 73.0), (167.0, 54.0)] ;

    text id 59 start 423.40s for 2.00s at (4.0, 23.0) ''[bold][color=#FBBF24]Étape 3 — Images des extrema :[/color][/bold]'' ;

    text id 60 start 443.30s for 2.50s at (4.0, 35.0) ''[color=#FBBF24]• En $x = -2$ : $f(-2) = 1$ (min. relatif)[/color]'' ;
    text id 61 start 448.40s at (124.8, 76.6) ''[bold][color=#FBBF24]$1$[/color][/bold]'' ;
    draw circle id 556 start 448.80s for 0.80s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.16) radius 4.0 at (126.0, 79.0) ;

    text id 62 start 457.70s for 2.40s at (4.0, 48.0) ''[color=#38BDF8]• En $x = 1$ : $f(1) = 4$ (maximum)[/color]'' ;
    text id 63 start 464.00s at (139.8, 47.6) ''[bold][color=#38BDF8]$4$[/color][/bold]'' ;
    draw circle id 557 start 464.40s for 0.80s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.16) radius 4.0 at (141.0, 50.0) ;

    text id 64 start 470.70s for 2.40s at (4.0, 61.0) ''[color=#F87171]• En $x = 3$ : $f(3) = -1$ (min. global)[/color]'' ;
    text id 65 start 476.50s at (153.0, 76.6) ''[bold][color=#F87171]$-1$[/color][/bold]'' ;
    draw circle id 558 start 476.90s for 0.80s color (248, 113, 113, 1) width 2 fillcolor (248, 113, 113, 0.16) radius 4.2 at (155.0, 79.0) ;

    text id 66 start 480.40s for 1.80s at (4.0, 74.0) ''[bold][color=#34D399]• Bornes ($-5$ et $5$) :[/color][/bold]'' ;
    text id 67 start 487.50s for 2.40s at (4.0, 84.0) ''[color=#F8FAFC]À ajouter seulement si lecture précise ![/color]'' ;
    mouse move id 1506 start 490.50s for 1.80s at [(111.0, 50.0), (168.0, 50.0)] ;

    erase id 2006 start 502.92s ;

    # =========================================================================
    # SCENE 7 (502.99s -> 558.82s) : Fiche de synthèse — Les 3 réflexes Seconde
    # =========================================================================
    text id 68 start 503.00s for 2.00s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Fiche de synthèse : Les 3 réflexes Seconde[/color][/bold]'' ;
    draw line id 559 start 505.20s for 0.60s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 69 start 510.20s for 1.80s at (4.0, 21.0) ''[bold][color=#38BDF8]Réflexe 1 — Sens de lecture[/color][/bold]'' ;
    text id 70 start 512.30s for 2.80s at (4.0, 29.0) ''[color=#F8FAFC]De gauche à droite : $\nearrow$ croissante, $\searrow$ décroissante.[/color]'' ;
    draw polygone id 560 start 515.40s for 0.80s color (56, 189, 248, 0.9) width 2 fillcolor (56, 189, 248, 0.12) at [(96.0, 20.0), (171.0, 20.0), (171.0, 40.0), (96.0, 40.0)] ;
    draw arrow id 561 start 516.40s color (248, 250, 252, 0.9) width 2 at [(104.0, 25.0), (163.0, 25.0)] ;
    draw arrow id 562 start 516.70s color (56, 189, 248, 1) width 3 at [(112.0, 37.0), (129.0, 29.0)] ;
    draw arrow id 563 start 517.80s color (248, 113, 113, 1) width 3 at [(139.0, 29.0), (156.0, 37.0)] ;

    text id 71 start 519.50s for 1.80s at (4.0, 44.0) ''[bold][color=#34D399]Réflexe 2 — Abscisse vs Image[/color][/bold]'' ;
    text id 72 start 523.70s for 2.60s at (4.0, 52.0) ''[color=#F8FAFC]• Intervalles & position : axe horizontal ($x$)[/color]'' ;
    text id 73 start 529.90s for 2.60s at (4.0, 60.0) ''[color=#F8FAFC]• Valeur du max. / min. : axe vertical ($y = f(x)$)[/color]'' ;
    draw polygone id 564 start 533.00s for 0.80s color (52, 211, 153, 0.9) width 2 fillcolor (52, 211, 153, 0.12) at [(96.0, 44.0), (171.0, 44.0), (171.0, 64.0), (96.0, 64.0)] ;
    draw arrow id 565 start 534.00s color (56, 189, 248, 1) width 2.5 at [(104.0, 59.0), (164.0, 59.0)] ;
    draw arrow id 566 start 534.30s color (52, 211, 153, 1) width 2.5 at [(133.5, 62.0), (133.5, 46.0)] ;
    text id 74 start 534.60s at (99.0, 46.5) ''[color=#34D399]$y=f(x)$ : valeur[/color]'' ;
    text id 75 start 534.90s at (137.0, 51.0) ''[color=#38BDF8]$x$ : intervalle[/color]'' ;

    text id 76 start 535.60s for 1.80s at (4.0, 72.0) ''[bold][color=#FBBF24]Réflexe 3 — Tableau en 3 étapes[/color][/bold]'' ;
    text id 77 start 541.50s for 3.00s at (4.0, 81.0) ''[color=#F8FAFC]1. Ligne $x$ $\to$ 2. Flèches $\to$ 3. Extrema aux pointes[/color]'' ;
    draw polygone id 567 start 545.00s for 0.80s color (251, 191, 36, 0.9) width 2 fillcolor (251, 191, 36, 0.12) at [(96.0, 68.0), (171.0, 68.0), (171.0, 89.0), (96.0, 89.0)] ;
    draw line id 568 start 546.00s color (248, 250, 252, 0.9) width 2 at [(102.0, 75.0), (165.0, 75.0)] ;
    draw arrow id 569 start 546.50s color (248, 113, 113, 1) width 2.5 at [(112.0, 77.5), (130.0, 86.0)] ;
    draw arrow id 570 start 547.20s color (56, 189, 248, 1) width 2.5 at [(136.0, 86.0), (154.0, 77.5)] ;
    draw circle id 571 start 549.30s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 2.0 at (133.0, 86.0) ;
    mouse move id 1507 start 551.00s for 3.00s at [(98.0, 30.0), (98.0, 54.0), (98.0, 78.5)] ;

}
