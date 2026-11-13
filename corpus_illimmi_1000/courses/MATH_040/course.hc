course "Correction d'exercice classique : Variations de fonctions et extrema (Entraînement Lycée)" id 40 idgap 500 for 494.5s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : 1. Accroche & Théorème des Variations (0.0s -> 80.0s)
    # =========================================================================
    text id 1 start 0.2s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]1. Signe de la dérivée & Variations de f[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.8s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 4.0s for 2.6s at (4.0, 19.5) ''[bold][color=#FBBF24]Théorème des variations :[/color][/bold]'' ;
    text id 3 start 18.3s for 2.5s at (4.0, 27.5) ''[color=#F8FAFC]Objectif : relier le signe de $f'(x)$ aux variations de $f$.[/color]'' ;

    # Sens croissant
    text id 4 start 36.8s for 3.2s at (4.0, 38.5) ''[color=#34D399]• Si $f'(x) \ge 0$ sur $I \implies f$ est [bold]croissante[/bold] sur $I$[/color]'' ;
    text id 5 start 42.0s for 1.6s at (96.0, 21.0) ''[bold][color=#34D399]$f'(x) \ge 0$ : fonction croissante[/color][/bold]'' ;
    draw arrow id 502 start 44.6s for 1.2s color (52, 211, 153, 1) width 3.0 at [(100.0, 44.0), (124.0, 29.5)] ;
    draw line id 556 start 46.2s color (248, 250, 252, 0.45) width 1.2 at [(134.0, 46.5), (168.0, 46.5)] ;
    draw line id 557 start 46.2s color (248, 250, 252, 0.45) width 1.2 at [(134.0, 46.5), (134.0, 27.0)] ;
    draw path id 503 start 46.4s for 1.4s color (52, 211, 153, 1) width 2.8 at [(136.0, 45.0), (141.0, 44.2), (146.0, 42.3), (151.0, 39.2), (156.0, 35.5), (161.0, 31.8), (166.0, 28.5)] ;

    # Sens décroissant
    text id 6 start 49.1s for 3.2s at (4.0, 50.0) ''[color=#F87171]• Si $f'(x) \le 0$ sur $I \implies f$ est [bold]décroissante[/bold] sur $I$[/color]'' ;
    draw line id 504 start 53.4s color (248, 250, 252, 0.35) width 1.2 at [(94.0, 53.0), (170.0, 53.0)] ;
    text id 7 start 54.1s for 1.6s at (96.0, 57.0) ''[bold][color=#F87171]$f'(x) \le 0$ : fonction décroissante[/color][/bold]'' ;
    draw arrow id 505 start 56.6s for 1.2s color (248, 113, 113, 1) width 3.0 at [(100.0, 66.0), (124.0, 81.5)] ;
    draw line id 558 start 58.7s color (248, 250, 252, 0.45) width 1.2 at [(134.0, 83.5), (168.0, 83.5)] ;
    draw line id 559 start 58.7s color (248, 250, 252, 0.45) width 1.2 at [(134.0, 83.5), (134.0, 64.0)] ;
    draw path id 506 start 58.9s for 1.4s color (248, 113, 113, 1) width 2.8 at [(136.0, 65.5), (141.0, 66.8), (146.0, 69.0), (151.0, 72.2), (156.0, 75.8), (161.0, 79.2), (166.0, 82.0)] ;

    # Compléments du tableau au lycée
    text id 8 start 63.4s for 2.8s at (4.0, 63.0) ''[color=#F8FAFC]Dans un tableau de variations complet :[/color]'' ;
    text id 9 start 67.7s for 2.5s at (6.0, 71.0) ''[color=#C084FC]- Valeurs aux bornes et extrema[/color]'' ;
    text id 10 start 72.2s for 2.5s at (6.0, 79.0) ''[color=#C084FC]- Valeurs interdites (Première & Terminale)[/color]'' ;

    erase id 2001 start 80.0s ;

    # =========================================================================
    # SCENE 2 : 2. Exemple 1 — Du Signe de f' aux Variations et au Minimum
    # =========================================================================
    text id 11 start 80.2s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]2. Exemple 1 : Signe de f' vers Variations de f[/color][/bold]'' ;
    draw line id 507 start 82.2s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Structure du tableau de variations à gauche (instant pour la grille)
    draw line id 508 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (84.0, 20.0)] ;
    draw line id 509 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 28.0), (84.0, 28.0)] ;
    draw line id 510 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 37.0), (84.0, 37.0)] ;
    draw line id 511 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 56.0), (84.0, 56.0)] ;
    draw line id 512 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (4.0, 56.0)] ;
    draw line id 513 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(22.0, 20.0), (22.0, 56.0)] ;
    draw line id 514 start 82.8s color (248, 250, 252, 0.85) width 1.6 at [(84.0, 20.0), (84.0, 56.0)] ;

    # Entêtes de lignes synchronisées
    text id 12 start 87.3s at (11.5, 22.0) ''[bold][color=#F8FAFC]$x$[/color][/bold]'' ;
    text id 13 start 88.4s at (6.5, 30.5) ''[bold][color=#FBBF24]$f'(x)$[/color][/bold]'' ;
    text id 14 start 90.7s at (6.5, 44.0) ''[bold][color=#38BDF8]$f(x)$[/color][/bold]'' ;

    # Données de l'énoncé
    text id 15 start 97.2s at (37.0, 30.5) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    text id 16 start 98.5s at (24.0, 22.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 17 start 100.2s at (52.0, 22.0) ''[color=#F8FAFC]$2$[/color]'' ;
    text id 18 start 100.9s at (52.0, 30.5) ''[bold][color=#F8FAFC]$0$[/color][/bold]'' ;
    text id 19 start 103.3s at (66.5, 30.5) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 20 start 105.6s at (75.5, 22.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    text id 21 start 107.3s for 1.8s at (4.0, 61.0) ''[color=#F8FAFC]Donnée : $f(2) = -1$[/color]'' ;

    # Flèches de variation + conclusion écrite
    draw arrow id 515 start 120.1s for 1.5s color (248, 113, 113, 1) width 3.0 at [(28.0, 41.0), (49.0, 51.0)] ;
    draw arrow id 516 start 130.1s for 1.5s color (52, 211, 153, 1) width 3.0 at [(58.0, 51.0), (79.0, 41.0)] ;

    text id 22 start 139.2s for 2.6s at (4.0, 69.0) ''[color=#F87171]• $f$ décroissante sur $]-\infty ; 2]$[/color]'' ;
    text id 23 start 143.0s for 2.6s at (4.0, 76.5) ''[color=#34D399]• $f$ croissante sur $[2 ; +\infty[$[/color]'' ;

    # Placement de f(2) = -1 dans le tableau
    text id 24 start 152.6s at (51.0, 49.5) ''[bold][color=#FBBF24]$-1$[/color][/bold]'' ;

    # Repère et courbe représentative à droite : f(x) = 0.5*(x-2)^2 - 1
    draw 2drep id 517 start 159.4s for 1.5s at (116.0, 63.5) color (248, 250, 252, 0.95) width 1.5 scale = 8.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 5] y_range = [-2, 4] ;
    draw 2dfunc id 518 start 162.9s for 2.5s color (56, 189, 248, 1) width 3.0 at 517 y = 0.5 * (x - 2)^2 - 1 ;
    draw circle id 519 start 171.2s for 1.0s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.22) radius 1.4 at (133.0, 72.0) ;
    text id 25 start 172.5s at (117.0, 21.5) ''[bold][color=#FBBF24]Minimum : $(2 ; -1)$[/color][/bold]'' ;
    text id 26 start 174.8s for 2.2s at (4.0, 84.5) ''[bold][color=#FBBF24]Minimum de $f$ : $-1$ (atteint en $x = 2$)[/color][/bold]'' ;

    erase id 2002 start 178.1s ;

    # =========================================================================
    # SCENE 3 : 3. Exemple 2 — Sens Réciproque, Maximum & Zéro de f'
    # =========================================================================
    text id 27 start 178.3s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]3. Exemple 2 : Variations de f vers Signe de f'[/color][/bold]'' ;
    draw line id 520 start 180.3s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Structure du tableau à gauche
    draw line id 521 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (84.0, 20.0)] ;
    draw line id 522 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 28.0), (84.0, 28.0)] ;
    draw line id 523 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 37.0), (84.0, 37.0)] ;
    draw line id 524 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 56.0), (84.0, 56.0)] ;
    draw line id 525 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (4.0, 56.0)] ;
    draw line id 526 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(22.0, 20.0), (22.0, 56.0)] ;
    draw line id 527 start 184.5s color (248, 250, 252, 0.85) width 1.6 at [(84.0, 20.0), (84.0, 56.0)] ;

    text id 28 start 186.5s at (11.5, 22.0) ''[bold][color=#F8FAFC]$x$[/color][/bold]'' ;
    text id 29 start 187.0s at (6.5, 30.5) ''[bold][color=#FBBF24]$f'(x)$[/color][/bold]'' ;
    text id 30 start 187.5s at (6.5, 44.0) ''[bold][color=#38BDF8]$f(x)$[/color][/bold]'' ;

    # Variations données
    text id 31 start 190.9s at (24.0, 22.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 32 start 192.2s at (75.5, 22.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    draw arrow id 528 start 193.7s for 1.3s color (52, 211, 153, 1) width 3.0 at [(28.0, 51.0), (49.0, 41.0)] ;
    text id 33 start 195.6s at (52.0, 22.0) ''[color=#F8FAFC]$4$[/color]'' ;
    draw arrow id 529 start 196.6s for 1.3s color (248, 113, 113, 1) width 3.0 at [(58.0, 41.0), (79.0, 51.0)] ;
    text id 34 start 200.6s at (51.8, 39.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;

    text id 35 start 206.0s for 2.2s at (4.0, 61.0) ''[bold][color=#FBBF24]Objectif : retrouver le signe de $f'(x)$[/color][/bold]'' ;
    text id 36 start 218.5s for 3.2s at (4.0, 68.5) ''[color=#CBD5E1]Méthode usuelle : dériver $\to$ signe de $f'$ $\to$ variations[/color]'' ;

    # Déduction réciproque
    text id 37 start 236.6s for 3.0s at (4.0, 76.0) ''[color=#34D399]• $f$ croissante sur $]-\infty ; 4] \implies f'(x) \ge 0$[/color]'' ;
    text id 38 start 247.5s at (37.0, 30.5) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 39 start 258.5s for 3.0s at (4.0, 83.5) ''[color=#F87171]• $f$ décroissante sur $[4 ; +\infty[ \implies f'(x) \le 0$[/color]'' ;
    text id 40 start 264.5s at (66.5, 30.5) ''[bold][color=#F87171]$-$[/color][/bold]'' ;

    # Courbe à droite : f(x) = -0.25*(x-4)^2 + 3
    draw 2drep id 530 start 273.9s for 1.2s at (107.0, 64.8) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [0, 8] y_range = [-1, 4] ;
    draw 2dfunc id 531 start 275.3s for 2.2s color (56, 189, 248, 1) width 3.0 at 530 y = -0.25 * (x - 4)^2 + 3 ;
    draw circle id 532 start 279.7s for 1.0s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.22) radius 1.4 at (133.0, 45.3) ;
    text id 41 start 281.0s at (117.0, 30.0) ''[bold][color=#FBBF24]Maximum : $(4 ; 3)$[/color][/bold]'' ;

    # Détail crucial : le zéro sur la ligne de f'(x) et la tangente horizontale
    text id 42 start 290.1s at (52.0, 30.5) ''[bold][color=#FBBF24]$0$[/color][/bold]'' ;
    draw circle id 533 start 291.2s for 1.0s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.16) radius 2.8 at (53.2, 32.5) ;
    text id 43 start 307.0s for 3.2s at (4.0, 91.0) ''[bold][color=#FBBF24]Changement de signe en $4 \implies f'(4) = 0$[/color][/bold]'' ;
    draw line id 534 start 325.1s for 1.4s color (251, 191, 36, 1) width 2.5 at [(118.0, 45.3), (148.0, 45.3)] ;
    text id 44 start 326.8s at (98.0, 20.5) ''[color=#FBBF24]Tangente horizontale ($f'(4) = 0$)[/color]'' ;

    erase id 2003 start 328.2s ;

    # =========================================================================
    # SCENE 4 : 4. Exemple 3 — Lecture Graphique d'une Parabole vers le Tableau
    # =========================================================================
    text id 45 start 328.3s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]4. Exemple 3 : Lecture Graphique vers Tableau[/color][/bold]'' ;
    draw line id 535 start 330.3s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Tableau vide au départ à gauche
    draw line id 536 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (84.0, 20.0)] ;
    draw line id 537 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 28.0), (84.0, 28.0)] ;
    draw line id 538 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 37.0), (84.0, 37.0)] ;
    draw line id 539 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 56.0), (84.0, 56.0)] ;
    draw line id 540 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(4.0, 20.0), (4.0, 56.0)] ;
    draw line id 541 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(22.0, 20.0), (22.0, 56.0)] ;
    draw line id 542 start 331.2s color (248, 250, 252, 0.85) width 1.6 at [(84.0, 20.0), (84.0, 56.0)] ;

    text id 46 start 336.4s at (6.5, 30.5) ''[bold][color=#FBBF24]$f'(x)$[/color][/bold]'' ;
    text id 47 start 338.5s at (6.5, 44.0) ''[bold][color=#38BDF8]$f(x)$[/color][/bold]'' ;
    text id 48 start 343.6s at (11.5, 22.0) ''[bold][color=#F8FAFC]$x$[/color][/bold]'' ;
    text id 49 start 344.2s at (24.0, 22.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 50 start 344.4s at (75.5, 22.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;

    # Représentation graphique à droite : parabole f(x) = -0.5*(x+2)^2 + 5
    draw 2drep id 543 start 345.6s for 1.5s at (146.0, 68.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 2] y_range = [-2, 6] ;
    draw 2dfunc id 544 start 358.9s for 2.5s color (56, 189, 248, 1) width 3.0 at 543 y = -0.5 * (x + 2)^2 + 5 ;

    # Étape 1 : lecture du sens de variation
    text id 51 start 366.2s for 2.2s at (4.0, 61.0) ''[color=#34D399]1. Courbe monte puis descend :[/color]'' ;
    draw arrow id 545 start 377.7s for 1.2s color (52, 211, 153, 1) width 3.0 at [(28.0, 51.0), (49.0, 41.0)] ;
    draw arrow id 546 start 379.5s for 1.2s color (248, 113, 113, 1) width 3.0 at [(58.0, 41.0), (79.0, 51.0)] ;

    # Étape 2 : lecture de l'abscisse du sommet x = -2
    draw line id 547 start 392.3s for 1.0s color (251, 191, 36, 0.85) width 2.0 at [(133.0, 35.5), (133.0, 68.0)] ;
    draw circle id 548 start 393.6s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.22) radius 1.4 at (133.0, 35.5) ;
    text id 52 start 401.5s at (50.5, 22.0) ''[bold][color=#FBBF24]$-2$[/color][/bold]'' ;
    text id 53 start 403.1s for 2.2s at (4.0, 68.5) ''[color=#FBBF24]2. Changement de variation en $x = -2$[/color]'' ;

    # Étape 3 : déduction du signe de f'(x)
    text id 54 start 424.8s at (37.0, 30.5) ''[bold][color=#34D399]$+$[/color][/bold]'' ;
    text id 55 start 431.4s at (66.5, 30.5) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    text id 56 start 435.0s at (52.0, 30.5) ''[bold][color=#FBBF24]$0$[/color][/bold]'' ;
    text id 57 start 436.2s for 2.2s at (4.0, 76.0) ''[color=#38BDF8]3. Signe de $f'$ : $+$, puis $0$ en $-2$, puis $-$[/color]'' ;

    # Étape 4 : lecture de l'ordonnée du sommet y = 5
    draw line id 549 start 451.1s for 1.0s color (192, 132, 252, 0.85) width 2.0 at [(133.0, 35.5), (146.0, 35.5)] ;
    text id 58 start 452.7s at (119.5, 21.5) ''[bold][color=#C084FC]Sommet $(-2 ; 5)$[/color][/bold]'' ;
    text id 59 start 457.8s for 2.5s at (4.0, 83.5) ''[bold][color=#C084FC]4. Maximum : $f(-2) = 5$[/color][/bold]'' ;
    text id 60 start 462.2s at (51.8, 39.5) ''[bold][color=#C084FC]$5$[/color][/bold]'' ;

    erase id 2004 start 466.4s ;

    # =========================================================================
    # SCENE 5 : 5. Synthèse & Réflexe Examen (466.6s -> 494.5s)
    # =========================================================================
    text id 61 start 466.6s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]5. Synthèse : Le Réflexe Examen[/color][/bold]'' ;
    draw line id 550 start 468.6s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 62 start 469.5s for 3.0s at (4.0, 21.5) ''[bold][color=#FBBF24]Équivalence fondamentale :[/color][/bold]'' ;
    text id 63 start 474.9s for 2.2s at (4.0, 33.5) ''[color=#34D399]• $f'(x) \ge 0 \iff f$ croissante ($\nearrow$)[/color]'' ;
    text id 64 start 477.8s for 2.2s at (4.0, 45.5) ''[color=#F87171]• $f'(x) \le 0 \iff f$ décroissante ($\searrow$)[/color]'' ;
    text id 65 start 481.1s for 2.8s at (4.0, 57.5) ''[color=#C084FC]• Changement de signe de $f'$ avec $f'(a) = 0$ :[/color]'' ;
    text id 66 start 484.4s at (8.0, 66.5) ''[bold][color=#C084FC]$\implies$ Extremum (minimum ou maximum) en $a$[/color][/bold]'' ;
    text id 67 start 486.5s for 2.8s at (4.0, 79.5) ''[bold][color=#38BDF8]Maîtriser les 2 sens : Tableau $\leftrightarrow$ Graphique[/color][/bold]'' ;

    # Schéma triangulaire de synthèse à droite
    text id 68 start 489.6s at (118.0, 25.5) ''[bold][color=#FBBF24]Signe de $f'(x)$[/color][/bold]'' ;
    text id 69 start 489.6s at (93.5, 68.0) ''[bold][color=#34D399]Variations de $f$[/color][/bold]'' ;
    text id 70 start 489.6s at (139.5, 68.0) ''[bold][color=#38BDF8]Courbe & Extrema[/color][/bold]'' ;

    draw arrow id 551 start 490.0s for 1.0s color (251, 191, 36, 0.95) width 2.5 at [(124.0, 33.0), (108.0, 62.0)] ;
    draw arrow id 552 start 491.2s color (52, 211, 153, 0.95) width 2.5 at [(112.0, 64.0), (128.0, 35.0)] ;
    draw arrow id 553 start 491.2s color (56, 189, 248, 0.95) width 2.5 at [(136.0, 35.0), (151.0, 62.0)] ;
    draw arrow id 554 start 491.2s color (192, 132, 252, 0.95) width 2.5 at [(122.0, 70.0), (135.0, 70.0)] ;
    draw arrow id 555 start 491.2s color (192, 132, 252, 0.95) width 2.5 at [(135.0, 73.0), (122.0, 73.0)] ;
}
