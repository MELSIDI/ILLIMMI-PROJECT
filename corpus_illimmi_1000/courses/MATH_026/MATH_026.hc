course "Généralités sur les fonctions : Déterminer graphiquement le signe" id 26 idgap 500 for 457s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 0 : INTRODUCTION & REPÈRE ORTHONORMÉ AVEC LA COURBE
    # =========================================================================

    text id 1 start 0.5s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction & Définitions : Le Signe d'une Fonction[/color][/bold]'' ;
    draw line id 501 start 2.8s for 1.2s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 4.5s for 2.5s at (4.0, 20.0) ''[bold][color=#F8FAFC]Objectif :[/color][/bold] [color=#F8FAFC]Déterminer le signe de $f(x)$ et dresser son tableau de signes.[/color]'' ;
    text id 3 start 18.5s for 3.0s at (4.0, 34.0) ''[bold][color=#34D399]Ensemble de définition :[/color][/bold] [color=#F8FAFC]La fonction $f$ est définie sur $[ -6 ; 7 ]$.[/color]'' ;
    text id 4 start 37.5s for 3.2s at (4.0, 48.0) ''[bold][color=#FBBF24]Tableau de signes :[/color][/bold] [color=#F8FAFC]Outil synthétisant les signes de $f(x)$ sur $\mathcal{D}_f$.[/color]'' ;

    draw polygone id 502 start 44.0s for 1.2s color (56, 189, 248, 0.7) width 1.5 fillcolor (56, 189, 248, 0.12) at [(4, 60), (84, 60), (84, 90), (4, 90)] ;
    text id 5 start 46.0s for 2.5s at (6.0, 66.0) ''[bold][color=#38BDF8]Règle fondamentale :[/color][/bold]'' ;
    text id 6 start 49.0s for 2.2s at (6.0, 74.0) ''[color=#34D399]$\bullet\ f(x) > 0 \iff$ Courbe au-dessus de l'axe des abscisses[/color]'' ;
    text id 7 start 51.5s for 2.2s at (6.0, 82.0) ''[color=#F87171]$\bullet\ f(x) < 0 \iff$ Courbe en-dessous de l'axe des abscisses[/color]'' ;

    draw 2drep id 503 start 12.5s for 1.5s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 504 start 15.0s for 2.8s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    text id 8 start 18.2s at (158.0, 28.0) ''[bold][color=#38BDF8]$\mathcal{C}_f$[/color][/bold]'' ;

    draw line id 505 start 24.5s for 1.0s color (251, 191, 36, 1) width 3.5 at [(107.0, 59.0), (159.0, 59.0)] ;
    text id 9 start 26.0s at (104.0, 78.0) ''[bold][color=#FBBF24]$-6$[/color][/bold]'' ;
    text id 10 start 28.5s at (158.0, 78.0) ''[bold][color=#FBBF24]$7$[/color][/bold]'' ;

    erase id 2001 start 54.8s ;

    # =========================================================================
    # SCÈNE 1 : BORNES DU DOMAINE ET STRUCTURE DU TABLEAU DE SIGNES
    # =========================================================================

    text id 26 start 55.2s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Première Étape : Bornes du Domaine $[-6 ; 7]$ & Tableau[/color][/bold]'' ;
    draw 2drep id 535 start 56.5s for 0.8s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 536 start 57.5s for 1.0s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    draw line id 531 start 58.7s for 0.8s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    text id 27 start 59.8s for 3.0s at (4.0, 20.0) ''[bold][color=#F8FAFC]Étape 1 :[/color][/bold] [color=#F8FAFC]Fixer les bornes de l'ensemble de définition sur la ligne des $x$.[/color]'' ;
    text id 28 start 67.0s for 0.8s at (4.0, 29.0) ''[color=#38BDF8]$\forall x \in \mathcal{D}_f,\ -6 \le x \le 7$[/color] [color=#F8FAFC]: la fonction n'existe pas en dehors.[/color]'' ;

    draw line id 537 start 68.0s for 1.0s color (251, 191, 36, 0.8) width 2 at [(107.0, 35.0), (107.0, 75.0)] ;
    draw line id 538 start 70.0s for 1.0s color (251, 191, 36, 0.8) width 2 at [(159.0, 35.0), (159.0, 75.0)] ;
    text id 34 start 71.5s at (102.0, 26.0) ''[bold][color=#FBBF24]$x = -6$[/color][/bold]'' ;
    text id 35 start 72.8s at (154.0, 26.0) ''[bold][color=#FBBF24]$x = 7$[/color][/bold]'' ;

    draw polygone id 532 start 74.0s for 1.2s color (248, 250, 252, 0.9) width 2 fillcolor (30, 41, 59, 0.25) at [(4, 42), (84, 42), (84, 76), (4, 76)] ;
    draw line id 533 start 75.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(4, 59), (84, 59)] ;
    draw line id 534 start 76.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(20, 42), (20, 76)] ;

    text id 29 start 77.5s at (8.0, 52.0) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 30 start 78.5s at (5.5, 69.0) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;

    text id 31 start 80.5s for 1.8s at (24.0, 52.0) ''[bold][color=#FBBF24]$-6$[/color][/bold]'' ;
    text id 32 start 84.0s for 1.8s at (78.0, 52.0) ''[bold][color=#FBBF24]$7$[/color][/bold]'' ;
    text id 33 start 86.5s for 1.8s at (4.0, 84.0) ''[color=#94A3B8]Les valeurs particulières viendront s'intercaler entre ces deux bornes.[/color]'' ;

    erase id 2002 start 89.0s ;

    # =========================================================================
    # SCÈNE 2 : REPÉRAGE DES VALEURS D'ANNULATION (LES ZÉROS)
    # =========================================================================

    text id 51 start 89.2s for 0.6s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Deuxième Étape : Valeurs d'Annulation & Les Zéros[/color][/bold]'' ;
    draw 2drep id 570 start 90.0s for 0.8s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 571 start 91.0s for 0.4s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    draw line id 561 start 91.5s for 1.2s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    text id 52 start 93.0s for 3.0s at (4.0, 19.0) ''[bold][color=#F8FAFC]Étape 2 :[/color][/bold] [color=#F8FAFC]Résoudre graphiquement l'équation $f(x) = 0$.[/color]'' ;
    text id 53 start 108.0s for 3.5s at (4.0, 26.5) ''[color=#38BDF8]Intersections avec $(Ox)$ :[/color] [color=#F8FAFC]la courbe traverse l'axe en $4$ points :[/color]'' ;

    draw circle id 572 start 127.0s for 0.8s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.4) radius 1.8 at (123.0, 59.0) ;
    text id 54 start 128.0s for 1.5s at (4.0, 32.5) ''[color=#38BDF8]$\bullet\ x_1 = -2 \implies f(-2) = 0$[/color]'' ;
    text id 72 start 130.0s at (120.0, 78.0) ''[bold][color=#34D399]$-2$[/color][/bold]'' ;

    draw circle id 573 start 139.5s for 0.8s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.4) radius 1.8 at (135.0, 59.0) ;
    text id 55 start 140.5s for 1.2s at (44.0, 32.5) ''[color=#38BDF8]$\bullet\ x_2 = 1 \implies f(1) = 0$[/color]'' ;
    text id 73 start 142.0s at (133.0, 78.0) ''[bold][color=#34D399]$1$[/color][/bold]'' ;

    draw circle id 574 start 145.0s for 0.4s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.4) radius 1.8 at (143.0, 59.0) ;
    text id 56 start 145.5s for 1.2s at (4.0, 37.0) ''[color=#38BDF8]$\bullet\ x_3 = 3 \implies f(3) = 0$[/color]'' ;
    text id 74 start 147.0s at (142.0, 78.0) ''[bold][color=#34D399]$3$[/color][/bold]'' ;

    draw circle id 575 start 149.0s for 0.4s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.4) radius 1.8 at (151.0, 59.0) ;
    text id 57 start 149.5s for 1.2s at (44.0, 37.0) ''[color=#38BDF8]$\bullet\ x_4 = 5 \implies f(5) = 0$[/color]'' ;
    text id 75 start 152.0s at (150.0, 78.0) ''[bold][color=#34D399]$5$[/color][/bold]'' ;

    draw polygone id 562 start 158.0s for 1.2s color (248, 250, 252, 0.9) width 2 fillcolor (30, 41, 59, 0.25) at [(4, 43), (84, 43), (84, 73), (4, 73)] ;
    draw line id 563 start 159.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(4, 57), (84, 57)] ;
    draw line id 564 start 160.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(16, 43), (16, 73)] ;

    text id 58 start 161.5s at (7.0, 51.0) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 59 start 162.5s at (5.0, 66.0) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;

    text id 60 start 164.0s at (19.0, 51.0) ''[color=#FBBF24]$-6$[/color]'' ;
    text id 61 start 168.0s at (28.5, 51.0) ''[bold][color=#38BDF8]$-2$[/color][/bold]'' ;
    text id 62 start 169.5s at (42.0, 51.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;
    text id 63 start 170.5s at (55.0, 51.0) ''[bold][color=#38BDF8]$3$[/color][/bold]'' ;
    text id 64 start 171.5s at (68.0, 51.0) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 65 start 172.5s at (80.0, 51.0) ''[color=#FBBF24]$7$[/color]'' ;

    draw line id 565 start 174.5s for 0.6s color (148, 163, 184, 0.7) width 1.2 at [(30, 57), (30, 73)] ;
    text id 66 start 175.5s at (28.8, 66.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    draw line id 566 start 177.0s for 0.6s color (148, 163, 184, 0.7) width 1.2 at [(43, 57), (43, 73)] ;
    text id 67 start 178.0s at (41.8, 66.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    draw line id 567 start 179.5s for 0.6s color (148, 163, 184, 0.7) width 1.2 at [(56, 57), (56, 73)] ;
    text id 68 start 180.5s at (54.8, 66.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    draw line id 568 start 182.0s for 0.6s color (148, 163, 184, 0.7) width 1.2 at [(69, 57), (69, 73)] ;
    text id 69 start 183.0s at (67.8, 66.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    draw polygone id 569 start 188.0s for 1.2s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.12) at [(4, 76), (84, 76), (84, 96), (4, 96)] ;
    text id 70 start 190.0s for 2.5s at (6.0, 82.0) ''[bold][color=#F87171]Attention aux bornes :[/color][/bold] [color=#F8FAFC]Pas de $0$ automatique en $-6$ ou $7$ ![/color]'' ;

    draw circle id 576 start 196.0s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.4) radius 1.8 at (107.0, 51.0) ;
    draw arrow id 577 start 197.5s for 0.8s color (251, 191, 36, 0.9) width 1.5 at [(107.0, 32.0), (107.0, 48.0)] ;
    text id 76 start 198.5s for 1.0s at (104.0, 26.0) ''[color=#FBBF24]$(-6 ; 2)$[/color]'' ;
    text id 71 start 200.0s for 3.2s at (6.0, 90.0) ''[color=#FBBF24]$f(-6) = 2 \ne 0$[/color] [color=#F8FAFC]: la courbe ne touche pas l'axe en $-6$.[/color]'' ;

    erase id 2003 start 224.0s ;

    # =========================================================================
    # SCÈNE 3 : RÈGLE FONDAMENTALE ET ANALYSE DE [-6 ; -2[ ET ]-2 ; 1[
    # =========================================================================

    text id 86 start 224.2s for 0.6s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Troisième Étape : Signe sur $[-6 ; -2[$ et $]-2 ; 1[$[/color][/bold]'' ;
    draw 2drep id 619 start 225.0s for 0.8s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 620 start 226.0s for 0.4s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    draw line id 611 start 226.5s for 1.2s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    text id 87 start 236.0s for 3.5s at (4.0, 19.5) ''[bold][color=#34D399]$\bullet$ Courbe au-dessus de $(Ox)$[/color][/bold] [color=#F8FAFC]$\implies f(x) > 0$ : signe [color=#34D399]$+$[/color][/color]'' ;
    text id 88 start 247.0s for 3.5s at (4.0, 27.0) ''[bold][color=#F87171]$\bullet$ Courbe en-dessous de $(Ox)$[/color][/bold] [color=#F8FAFC]$\implies f(x) < 0$ : signe [color=#F87171]$-$[/color][/color]'' ;

    text id 89 start 266.0s for 3.0s at (4.0, 35.0) ''[bold][color=#38BDF8]Sur $[-6 ; -2[$ :[/color][/bold] [color=#F8FAFC]Courbe au-dessus $\implies$ signe [color=#34D399]$+$[/color].[/color]'' ;
    draw polygone id 621 start 272.0s for 1.2s color (52, 211, 153, 0.6) width 1 fillcolor (52, 211, 153, 0.18) at [(107, 59), (107, 51), (111, 43.8), (115, 41), (119, 47), (123, 59)] ;

    text id 90 start 281.0s for 1.5s at (4.0, 42.5) ''[color=#94A3B8]Test : $f(-4) \approx 4{,}5 > 0$ et $f(-5) \approx 3{,}8 > 0$[/color]'' ;
    draw circle id 622 start 283.0s for 0.8s color (52, 211, 153, 1) width 2 radius 1.5 at (115.0, 41.0) ;
    text id 105 start 284.5s for 1.2s at (112.0, 26.0) ''[bold][color=#34D399]$(-4 ; 4{,}5)$[/color][/bold]'' ;

    draw polygone id 612 start 300.0s for 1.0s color (248, 250, 252, 0.9) width 2 fillcolor (30, 41, 59, 0.25) at [(4, 65), (84, 65), (84, 94), (4, 94)] ;
    draw line id 613 start 301.2s for 0.6s color (248, 250, 252, 0.8) width 1.5 at [(4, 78), (84, 78)] ;
    draw line id 614 start 302.0s for 0.6s color (248, 250, 252, 0.8) width 1.5 at [(16, 65), (16, 94)] ;
    draw line id 615 start 303.0s for 0.5s color (148, 163, 184, 0.7) width 1.2 at [(30, 78), (30, 94)] ;
    draw line id 616 start 303.8s for 0.5s color (148, 163, 184, 0.7) width 1.2 at [(43, 78), (43, 94)] ;
    draw line id 617 start 304.5s for 0.5s color (148, 163, 184, 0.7) width 1.2 at [(56, 78), (56, 94)] ;
    draw line id 618 start 305.2s for 0.5s color (148, 163, 184, 0.7) width 1.2 at [(69, 78), (69, 94)] ;

    text id 93 start 304.0s at (7.0, 72.0) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 94 start 304.5s at (5.0, 87.0) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 95 start 305.0s at (19.0, 72.0) ''[color=#FBBF24]$-6$[/color]'' ;
    text id 96 start 305.2s at (28.5, 72.0) ''[bold][color=#38BDF8]$-2$[/color][/bold]'' ;
    text id 97 start 305.4s at (42.0, 72.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;
    text id 98 start 305.6s at (55.0, 72.0) ''[bold][color=#38BDF8]$3$[/color][/bold]'' ;
    text id 99 start 305.8s at (68.0, 72.0) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 100 start 306.0s at (80.0, 72.0) ''[color=#FBBF24]$7$[/color]'' ;
    text id 101 start 306.2s at (28.8, 87.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 102 start 306.4s at (41.8, 87.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    text id 103 start 306.8s for 1.5s at (23.0, 87.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;

    text id 91 start 310.0s for 3.0s at (4.0, 50.5) ''[bold][color=#38BDF8]Sur $]-2 ; 1[$ :[/color][/bold] [color=#F8FAFC]Courbe en-dessous $\implies$ signe [color=#F87171]$-$[/color].[/color]'' ;
    draw polygone id 623 start 315.0s for 1.2s color (248, 113, 113, 0.6) width 1 fillcolor (248, 113, 113, 0.18) at [(123, 59), (127, 71), (131, 67), (135, 59)] ;

    text id 92 start 326.0s for 1.5s at (4.0, 58.0) ''[color=#94A3B8]Test : $f(-1) \approx -3 < 0$[/color]'' ;
    draw circle id 624 start 328.0s for 0.8s color (248, 113, 113, 1) width 2 radius 1.5 at (127.0, 71.0) ;
    text id 106 start 329.5s for 1.2s at (124.0, 78.0) ''[bold][color=#F87171]$(-1 ; -3)$[/color][/bold]'' ;

    text id 104 start 341.0s for 1.5s at (35.5, 87.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;

    erase id 2004 start 345.0s ;

    # =========================================================================
    # SCÈNE 4 : COMPLÉTION COMPLÈTE DU TABLEAU SUR TOUT LE DOMAINE
    # =========================================================================

    text id 121 start 345.2s for 0.6s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Complétion Complète du Tableau de Signes[/color][/bold]'' ;
    draw 2drep id 660 start 346.0s for 0.8s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 661 start 347.0s for 0.4s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    draw line id 651 start 347.5s for 0.4s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 652 start 348.0s for 0.8s color (248, 250, 252, 0.9) width 2 fillcolor (30, 41, 59, 0.3) at [(4, 42), (84, 42), (84, 76), (4, 76)] ;
    draw line id 653 start 348.9s for 0.5s color (248, 250, 252, 0.8) width 1.5 at [(4, 58), (84, 58)] ;
    draw line id 654 start 349.5s for 0.5s color (248, 250, 252, 0.8) width 1.5 at [(16, 42), (16, 76)] ;
    draw line id 655 start 350.2s for 0.4s color (148, 163, 184, 0.7) width 1.2 at [(30, 58), (30, 76)] ;
    draw line id 656 start 350.7s for 0.4s color (148, 163, 184, 0.7) width 1.2 at [(43, 58), (43, 76)] ;
    draw line id 657 start 351.2s for 0.4s color (148, 163, 184, 0.7) width 1.2 at [(56, 58), (56, 76)] ;
    draw line id 658 start 351.7s for 0.4s color (148, 163, 184, 0.7) width 1.2 at [(69, 58), (69, 76)] ;

    text id 125 start 352.2s at (7.0, 50.0) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 126 start 352.4s at (5.0, 68.0) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 127 start 352.6s at (19.0, 50.0) ''[color=#FBBF24]$-6$[/color]'' ;
    text id 128 start 352.8s at (28.5, 50.0) ''[bold][color=#38BDF8]$-2$[/color][/bold]'' ;
    text id 129 start 353.0s at (42.0, 50.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;
    text id 130 start 353.2s at (55.0, 50.0) ''[bold][color=#38BDF8]$3$[/color][/bold]'' ;
    text id 131 start 353.4s at (68.0, 50.0) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 132 start 353.6s at (80.0, 50.0) ''[color=#FBBF24]$7$[/color]'' ;

    text id 133 start 354.0s at (23.0, 68.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 134 start 354.2s at (28.8, 68.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 135 start 354.4s at (35.5, 68.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    text id 136 start 354.6s at (41.8, 68.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 137 start 354.8s at (54.8, 68.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 138 start 355.0s at (67.8, 68.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;

    draw polygone id 662 start 355.5s color (52, 211, 153, 0.5) width 1 fillcolor (52, 211, 153, 0.15) at [(107, 59), (107, 51), (111, 43.8), (115, 41), (119, 47), (123, 59)] ;
    draw polygone id 663 start 356.0s color (248, 113, 113, 0.5) width 1 fillcolor (248, 113, 113, 0.15) at [(123, 59), (127, 71), (131, 67), (135, 59)] ;

    draw polygone id 664 start 357.0s for 0.8s color (52, 211, 153, 0.5) width 1 fillcolor (52, 211, 153, 0.15) at [(135, 59), (139, 50.2), (143, 59)] ;
    text id 139 start 358.0s for 1.8s at (48.5, 68.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 122 start 352.5s for 2.0s at (4.0, 19.5) ''[bold][color=#38BDF8]Sur $]1 ; 3[$ :[/color][/bold] [color=#F8FAFC]Courbe au-dessus de $(Ox)$ $\implies$ signe [color=#34D399]$+$[/color].[/color]'' ;

    text id 123 start 361.5s for 2.5s at (4.0, 26.5) ''[bold][color=#38BDF8]Sur $]3 ; 5[$ :[/color][/bold] [color=#F8FAFC]Courbe en-dessous de $(Ox)$ $\implies$ signe [color=#F87171]$-$[/color].[/color]'' ;
    draw polygone id 665 start 369.0s for 0.8s color (248, 113, 113, 0.5) width 1 fillcolor (248, 113, 113, 0.15) at [(143, 59), (147, 66.2), (151, 59)] ;
    text id 140 start 370.0s for 1.8s at (61.5, 68.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;

    text id 124 start 374.0s for 2.5s at (4.0, 33.5) ''[bold][color=#38BDF8]Sur $]5 ; 7]$ :[/color][/bold] [color=#F8FAFC]Courbe au-dessus de $(Ox)$ $\implies$ signe [color=#34D399]$+$[/color].[/color]'' ;
    draw polygone id 666 start 385.0s for 0.8s color (52, 211, 153, 0.5) width 1 fillcolor (52, 211, 153, 0.15) at [(151, 59), (155, 51), (159, 46.2), (159, 59)] ;
    text id 141 start 386.0s for 1.8s at (74.0, 68.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;

    draw polygone id 659 start 391.0s for 1.0s color (52, 211, 153, 0.7) width 1.5 fillcolor (52, 211, 153, 0.12) at [(4, 80), (84, 80), (84, 95), (4, 95)] ;
    text id 142 start 393.0s for 3.0s at (6.0, 88.0) ''[bold][color=#34D399]Bilan :[/color][/bold] [color=#F8FAFC]Le tableau résume parfaitement les $5$ zones de signe et les $4$ zéros.[/color]'' ;

    erase id 2005 start 401.0s ;

    # =========================================================================
    # SCÈNE 5 : EXPLOITATION DU TABLEAU & PIÈGE SIGNE VS VARIATIONS
    # =========================================================================

    text id 151 start 401.2s for 0.6s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Exploitation du Tableau & Piège : Signe vs Variations[/color][/bold]'' ;
    draw 2drep id 694 start 402.0s for 0.8s at (131, 59) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-7, 8] y_range = [-4, 6] ;
    draw path id 695 start 403.0s for 0.4s color (56, 189, 248, 1) width 3 at [(107.0, 51.0), (111.0, 43.8), (115.0, 41.0), (119.0, 47.0), (123.0, 59.0), (127.0, 71.0), (131.0, 67.0), (135.0, 59.0), (139.0, 50.2), (143.0, 59.0), (147.0, 66.2), (151.0, 59.0), (155.0, 51.0), (159.0, 46.2)] ;
    draw line id 691 start 403.5s for 1.0s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 692 start 404.8s for 1.0s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.12) at [(4, 18), (84, 18), (84, 43), (4, 43)] ;
    text id 152 start 406.0s for 2.5s at (6.0, 24.0) ''[bold][color=#38BDF8]Exemple :[/color][/bold] [color=#F8FAFC]Quel est le signe de $f(6)$ ?[/color]'' ;
    text id 153 start 412.0s for 1.8s at (6.0, 31.5) ''[color=#FBBF24]$6 \in [5 ; 7]$[/color] [color=#F8FAFC]: la colonne indique directement un signe [color=#34D399]$+$[/color].[/color]'' ;

    draw circle id 696 start 414.0s for 0.8s color (52, 211, 153, 1) width 2 radius 1.8 at (155.0, 51.0) ;
    draw arrow id 697 start 415.5s for 0.8s color (52, 211, 153, 0.9) width 2 at [(155.0, 59.0), (155.0, 53.0)] ;
    text id 160 start 417.0s for 1.5s at (152.0, 26.0) ''[bold][color=#34D399]$f(6) > 0$[/color][/bold]'' ;

    text id 154 start 420.0s for 2.5s at (6.0, 38.5) ''[bold][color=#34D399]Conclusion :[/color][/bold] [color=#34D399]$f(6) > 0$[/color] [color=#F8FAFC](image strictement positive).[/color]'' ;

    draw polygone id 693 start 427.0s for 1.2s color (248, 113, 113, 0.9) width 2 fillcolor (248, 113, 113, 0.15) at [(4, 47), (84, 47), (84, 94), (4, 94)] ;
    text id 155 start 429.0s for 2.5s at (6.0, 53.0) ''[bold][color=#F87171]LE PIÈGE CLASSIQUE : SIGNE $\ne$ VARIATIONS ![/color][/bold]'' ;
    text id 156 start 437.0s for 3.0s at (6.0, 61.0) ''[color=#38BDF8]$\bullet\ f(x) > 0$[/color] [color=#F8FAFC]$\iff$ La courbe est [bold]au-dessus[/bold] de l'axe $(Ox)$[/color]'' ;
    text id 157 start 442.0s for 2.5s at (6.0, 68.0) ''[color=#FBBF24]$\bullet\ f$ croissante[/color] [color=#F8FAFC]$\iff$ La courbe [bold]monte[/bold][/color]'' ;
    text id 158 start 447.0s for 1.2s at (6.0, 77.0) ''[bold][color=#F8FAFC]Contre-exemple sur la courbe :[/color][/bold]'' ;

    draw line id 698 start 448.5s for 1.2s color (248, 113, 113, 1) width 4 at [(115.0, 41.0), (123.0, 59.0)] ;
    text id 161 start 450.0s for 0.8s at (106.0, 26.0) ''[bold][color=#F87171]Descend mais $f > 0$ ![/color][/bold]'' ;
    text id 159 start 451.0s for 3.0s at (6.0, 85.0) ''[color=#F8FAFC]Sur $[-4 ; -2]$, la courbe descend ($f \searrow$) mais reste [bold]positive[/bold] ($f > 0$) ![/color]'' ;

    erase id 2006 start 456.0s ;

    # =========================================================================
    # SCÈNE 6 : FICHE RÉFLEXE & SYNTHÈSE MÉTHODOLOGIQUE POUR LE CONTRÔLE
    # =========================================================================

    text id 181 start 456.2s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Fiche Réflexe & Synthèse Méthodologique[/color][/bold]'' ;
    draw line id 731 start 458.0s for 0.7s color (56, 189, 248, 0.8) width 2 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 732 start 458.8s for 0.2s color (52, 211, 153, 0.9) width 2 fillcolor (30, 41, 59, 0.3) at [(4, 18), (86, 18), (86, 92), (4, 92)] ;
    text id 182 start 459.0s for 0.8s at (6.0, 25.0) ''[bold][color=#34D399]1. POSER LES BORNES DU DOMAINE[/color][/bold]'' ;
    text id 183 start 460.0s at (8.0, 32.0) ''[color=#F8FAFC]$\mathcal{D}_f = [a ; b]$ : inscrire $a$ et $b$ aux extrémités de la ligne des $x$.[/color]'' ;

    draw polygone id 733 start 460.0s for 0.8s color (251, 191, 36, 0.8) width 2 fillcolor (30, 41, 59, 0.3) at [(92, 18), (173, 18), (173, 92), (92, 92)] ;
    text id 190 start 461.0s at (98.0, 25.0) ''[bold][color=#FBBF24]TABLEAU DE SYNTHÈSE COMPLET[/color][/bold]'' ;

    text id 184 start 461.5s for 0.8s at (6.0, 44.0) ''[bold][color=#38BDF8]2. REPÉRER LES ZÉROS D'ANNULATION[/color][/bold]'' ;
    text id 185 start 462.5s at (8.0, 51.0) ''[color=#F8FAFC]Intersections avec $(Ox)$ : placer les abscisses et aligner les $0$.[/color]'' ;

    draw line id 734 start 462.5s for 0.6s color (248, 250, 252, 0.8) width 1.5 at [(95, 48), (170, 48)] ;
    draw line id 735 start 463.2s for 0.6s color (248, 250, 252, 0.8) width 1.5 at [(109, 36), (109, 60)] ;

    text id 191 start 464.0s at (98.0, 42.0) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 186 start 464.2s at (8.0, 58.0) ''[color=#FBBF24]Règle : Pas de $0$ automatique aux bornes sauf si la courbe y touche $(Ox)$.[/color]'' ;
    text id 192 start 464.3s at (96.5, 54.0) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 193 start 464.6s at (111.0, 42.0) ''[color=#FBBF24]$-6$[/color]'' ;
    text id 194 start 464.8s at (120.0, 42.0) ''[color=#38BDF8]$-2$[/color]'' ;
    text id 195 start 465.0s at (129.0, 42.0) ''[color=#38BDF8]$1$[/color]'' ;
    text id 196 start 465.2s at (140.0, 42.0) ''[color=#38BDF8]$3$[/color]'' ;
    text id 197 start 465.4s at (151.0, 42.0) ''[color=#38BDF8]$5$[/color]'' ;
    text id 198 start 465.6s at (163.0, 42.0) ''[color=#FBBF24]$7$[/color]'' ;

    text id 187 start 466.0s at (6.0, 70.0) ''[bold][color=#FBBF24]3. DÉTERMINER LE SIGNE PAR INTERVALLE[/color][/bold]'' ;
    text id 199 start 466.0s at (115.5, 54.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 200 start 466.2s at (120.2, 54.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 201 start 466.4s at (124.5, 54.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    text id 202 start 466.6s at (129.2, 54.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 203 start 466.8s at (134.5, 54.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 204 start 467.0s at (140.2, 54.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 205 start 467.2s at (145.5, 54.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    text id 206 start 467.4s at (151.2, 54.0) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 207 start 467.6s at (157.0, 54.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;

    text id 188 start 467.5s at (8.0, 77.0) ''[color=#34D399]$\bullet$ Courbe au-dessus de $(Ox) \implies +$[/color]'' ;
    text id 189 start 469.0s at (8.0, 84.0) ''[color=#F87171]$\bullet$ Courbe en-dessous de $(Ox) \implies -$[/color]'' ;

    text id 208 start 470.5s for 1.2s at (98.0, 72.0) ''[bold][color=#38BDF8]Le réflexe d'examen :[/color][/bold]'' ;
    text id 209 start 472.0s for 1.8s at (98.0, 80.0) ''[color=#F8FAFC]Vérifie toujours chaque signe avec une valeur test ![/color]'' ;

}
