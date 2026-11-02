course "Valeur absolue et distance sur la droite réelle" id 17 idgap 500 for 592.0s audio "narration.wav" {
    # --- SCÈNE 1 : Mesurer une distance sur un axe gradué (0.15s -> 106.5s) ---
    text id 1 start 1.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Mesurer une distance sur un axe gradué[/color][/bold]'' ;
    draw line id 501 start 3.5s for 1.2s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;
    text id 2 start 5.8s for 2.2s at (4.0, 21.0) ''[color=#F8FAFC]Interprétation géométrique de la valeur absolue[/color]'' ;
    text id 3 start 8.5s for 2.2s at (4.0, 31.0) ''[color=#94A3B8]Situation concrète sur la droite réelle $\mathbf{R}$[/color]'' ;

    # Tracé de l'axe gradué
    draw arrow id 502 start 17.4s for 1.4s color (248, 250, 252, 0.95) width 2.0 at [(92.0, 52.0), (170.0, 52.0)] ;
    text id 4 start 19.0s at (171.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    # Origine 0
    draw line id 503 start 21.1s for 0.5s color (248, 250, 252, 0.9) width 1.8 at [(126.0, 50.0), (126.0, 54.0)] ;
    text id 5 start 21.8s for 0.6s at (124.5, 56.5) ''[bold][color=#FBBF24]$0$[/color][/bold]'' ;

    # Graduations négatives (-1, -2, -3, -4)
    draw line id 504 start 27.0s color (148, 163, 184, 0.7) width 1.5 at [(119.0, 50.5), (119.0, 53.5)] ;
    text id 6 start 27.1s at (117.2, 56.5) ''[color=#94A3B8]$-1$[/color]'' ;

    draw line id 505 start 27.5s color (148, 163, 184, 0.7) width 1.5 at [(112.0, 50.5), (112.0, 53.5)] ;
    text id 7 start 27.6s at (110.2, 56.5) ''[color=#94A3B8]$-2$[/color]'' ;

    draw line id 506 start 28.0s color (56, 189, 248, 0.9) width 2.0 at [(105.0, 50.0), (105.0, 54.0)] ;
    text id 8 start 28.1s at (103.0, 56.5) ''[bold][color=#38BDF8]$-3$[/color][/bold]'' ;

    draw line id 507 start 28.6s color (148, 163, 184, 0.7) width 1.5 at [(98.0, 50.5), (98.0, 53.5)] ;
    text id 9 start 28.7s at (96.2, 56.5) ''[color=#94A3B8]$-4$[/color]'' ;

    # Graduations positives (1, 2, 3, 4, 5)
    draw line id 508 start 33.0s color (148, 163, 184, 0.7) width 1.5 at [(133.0, 50.5), (133.0, 53.5)] ;
    text id 10 start 33.1s at (132.0, 56.5) ''[color=#94A3B8]$1$[/color]'' ;

    draw line id 509 start 33.6s color (148, 163, 184, 0.7) width 1.5 at [(140.0, 50.5), (140.0, 53.5)] ;
    text id 11 start 33.7s at (139.0, 56.5) ''[color=#94A3B8]$2$[/color]'' ;

    draw line id 510 start 34.2s color (148, 163, 184, 0.7) width 1.5 at [(147.0, 50.5), (147.0, 53.5)] ;
    text id 12 start 34.3s at (146.0, 56.5) ''[color=#94A3B8]$3$[/color]'' ;

    draw line id 511 start 34.8s color (52, 211, 153, 0.9) width 2.0 at [(154.0, 50.0), (154.0, 54.0)] ;
    text id 13 start 34.9s at (152.8, 56.5) ''[bold][color=#34D399]$4$[/color][/bold]'' ;

    draw line id 512 start 35.4s color (148, 163, 184, 0.7) width 1.5 at [(161.0, 50.5), (161.0, 53.5)] ;
    text id 14 start 35.5s at (160.0, 56.5) ''[color=#94A3B8]$5$[/color]'' ;

    # Points A(-3) et B(4)
    draw circle id 513 start 40.0s for 0.7s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.35) radius 1.4 at (105.0, 52.0) ;
    text id 15 start 41.0s for 1.2s at (101.5, 46.0) ''[bold][color=#38BDF8]$A(-3)$[/color][/bold]'' ;

    draw circle id 514 start 43.0s for 0.7s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.35) radius 1.4 at (154.0, 52.0) ;
    text id 16 start 44.0s for 1.2s at (151.0, 46.0) ''[bold][color=#34D399]$B(4)$[/color][/bold]'' ;

    # 7 arcs de pas (comptage)
    draw curve id 515 start 54.5s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(105.0, 51.5), (108.5, 47.0), (112.0, 51.5)] ;
    draw curve id 516 start 55.4s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(112.0, 51.5), (115.5, 47.0), (119.0, 51.5)] ;
    draw curve id 517 start 56.3s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(119.0, 51.5), (122.5, 47.0), (126.0, 51.5)] ;
    draw curve id 518 start 57.2s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(126.0, 51.5), (129.5, 47.0), (133.0, 51.5)] ;
    draw curve id 519 start 58.1s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(133.0, 51.5), (136.5, 47.0), (140.0, 51.5)] ;
    draw curve id 520 start 59.0s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(140.0, 51.5), (143.5, 47.0), (147.0, 51.5)] ;
    draw curve id 521 start 59.9s for 0.5s color (251, 191, 36, 0.9) width 1.8 smooth at [(147.0, 51.5), (150.5, 47.0), (154.0, 51.5)] ;

    # Segment d'écart et cote de distance
    draw line id 522 start 61.5s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(105.0, 39.0), (154.0, 39.0)] ;
    draw line id 523 start 62.4s for 0.3s color (56, 189, 248, 0.9) width 2.0 at [(105.0, 37.0), (105.0, 41.0)] ;
    draw line id 524 start 63.0s for 0.3s color (56, 189, 248, 0.9) width 2.0 at [(154.0, 37.0), (154.0, 41.0)] ;
    text id 17 start 63.8s for 1.8s at (116.0, 32.0) ''[bold][color=#38BDF8]$\mathbf{Distance = 7\text{ unités}}$[/color][/bold]'' ;

    # Colonne gauche : Propriétés
    text id 18 start 66.5s for 2.2s at (4.0, 43.0) ''[color=#F8FAFC]Distance de $-3$ à $4$ :[/color] [bold][color=#38BDF8]$d(-3 ; 4) = 7$[/color][/bold]'' ;
    text id 19 start 76.0s for 2.2s at (4.0, 57.0) ''[color=#F8FAFC]Distance de $4$ à $-3$ :[/color] [bold][color=#34D399]$d(4 ; -3) = 7$[/color][/bold]'' ;
    text id 20 start 95.0s for 2.0s at (4.0, 71.0) ''[color=#FBBF24]Symétrie :[/color] [color=#F8FAFC]$d(\mathbf{Paris}, \mathbf{Marseille}) = d(\mathbf{Marseille}, \mathbf{Paris})$[/color]'' ;
    text id 21 start 101.5s for 2.2s at (4.0, 85.0) ''[bold][color=#34D399]Propriété : $d(A, B) = d(B, A) \ge 0$[/color][/bold]'' ;

    erase id 2001 start 107.0s ;

    # --- SCÈNE 2 : La valeur absolue d'une différence (107.0s -> 285.2s) ---
    text id 22 start 108.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Le lien fondamental : la valeur absolue d'une différence[/color][/bold]'' ;
    draw line id 525 start 110.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Calcul de a - b
    text id 23 start 121.5s for 2.2s at (4.0, 20.0) ''[color=#F8FAFC]Calculons la valeur absolue de la différence :[/color]'' ;
    text id 24 start 132.5s for 2.0s at (4.0, 31.0) ''[color=#F8FAFC]Posons[/color] [bold][color=#38BDF8]$a = -3$[/color][/bold] [color=#F8FAFC]et[/color] [bold][color=#34D399]$b = 4$[/color][/bold]'' ;
    text id 25 start 151.1s for 2.2s at (4.0, 43.0) ''[color=#F8FAFC]Écrivons :[/color] [bold][color=#FBBF24]$|a - b| = |(-3) - 4|$[/color][/bold]'' ;
    text id 26 start 172.5s for 2.0s at (4.0, 55.0) ''[color=#F8FAFC]À l'intérieur :[/color] $(-3) - 4 = -7 \implies$ [bold][color=#F87171]$|-7|$[/color][/bold]'' ;

    # Encart droit : Rappel de la valeur absolue
    draw polygone id 526 start 180.5s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.5 at [(96.0, 20.0), (170.0, 20.0), (170.0, 48.0), (96.0, 48.0)] ;
    text id 27 start 182.0s for 2.0s at (100.0, 24.5) ''[bold][color=#38BDF8]Rappel : Définition de $|x|$[/color][/bold]'' ;
    text id 28 start 185.0s for 2.0s at (100.0, 32.5) ''[color=#F8FAFC]$\bullet$ Si $x \ge 0$ :[/color] [color=#34D399]$|x| = x$[/color]'' ;
    text id 29 start 188.0s for 2.0s at (100.0, 40.5) ''[color=#F8FAFC]$\bullet$ Si $x < 0$ :[/color] [color=#F87171]$|x| = -x$[/color] [color=#94A3B8](son opposé)[/color]'' ;

    # Suite calcul a - b
    text id 30 start 202.0s for 2.2s at (4.0, 67.0) ''[color=#F8FAFC]Comme $-7 < 0$ :[/color] $|-7| = -(-7) =$ [bold][color=#34D399]$7$[/color][/bold]'' ;
    text id 31 start 209.0s for 2.5s at (4.0, 79.0) ''[bold][color=#34D399]$\mathbf{|a - b| = 7 = d(a, b)}$[/color][/bold] [color=#38BDF8](distance géométrique !)[/color]'' ;

    # Colonne droite : Calcul symétrique b - a
    text id 32 start 224.8s for 2.0s at (96.0, 54.0) ''[color=#F8FAFC]Calcul symétrique :[/color] [bold][color=#34D399]$|b - a|$[/color][/bold]'' ;
    text id 33 start 246.5s for 2.2s at (96.0, 63.5) ''$|b - a| = |4 - (-3)| = |4 + 3|$'' ;
    text id 34 start 260.0s for 2.0s at (96.0, 73.0) ''$= |7| =$ [bold][color=#34D399]$7$[/color][/bold] [color=#94A3B8](car $7 > 0$)[/color]'' ;

    # Encart bilan
    draw polygone id 527 start 277.5s for 0.8s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.15) width 1.5 at [(96.0, 80.0), (170.0, 80.0), (170.0, 92.0), (96.0, 92.0)] ;
    text id 35 start 279.0s for 2.0s at (100.0, 84.5) ''[bold][color=#34D399]$\mathbf{|a - b| = |b - a| = 7 = d(a, b)}$[/color][/bold]'' ;

    erase id 2002 start 285.2s ;

    # --- SCÈNE 3 : Théorème général et piège de soustraction (285.2s -> 374.0s) ---
    text id 36 start 285.6s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Théorème général : Distance entre deux réels[/color][/bold]'' ;
    draw line id 528 start 287.6s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Boîte Théorème gauche
    draw polygone id 529 start 294.0s for 1.0s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.15) width 2.0 at [(4.0, 20.0), (88.0, 20.0), (88.0, 44.0), (4.0, 44.0)] ;
    text id 37 start 295.5s for 2.0s at (8.0, 24.5) ''[bold][color=#38BDF8]THÉORÈME FONDAMENTAL[/color][/bold]'' ;
    text id 38 start 298.5s for 2.5s at (8.0, 34.0) ''[color=#F8FAFC]Pour tous réels $a$ et $b$ :[/color] [bold][color=#34D399]$\mathbf{d(a, b) = |a - b| = |b - a|}$[/color][/bold]'' ;

    # Piège de soustraction
    text id 39 start 309.6s for 2.2s at (4.0, 51.0) ''[bold][color=#F87171]ATTENTION : $a - b \neq b - a$ ![/color][/bold]'' ;
    text id 40 start 324.0s for 2.2s at (4.0, 61.5) ''[color=#F8FAFC]$-3 - 4 = -7$[/color] [color=#F87171]$\neq$[/color] [color=#F8FAFC]$4 - (-3) = +7$[/color]'' ;
    text id 41 start 328.0s for 2.0s at (4.0, 71.0) ''[color=#94A3B8]Les deux différences sont opposées ![/color]'' ;
    text id 42 start 345.0s for 2.2s at (4.0, 81.0) ''[bold][color=#34D399]Mais leurs valeurs absolues sont égales : $|-7| = |7| = 7$[/color][/bold]'' ;

    # Boîte droite : Propriétés métriques
    draw polygone id 530 start 357.4s for 1.0s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 1.8 at [(94.0, 20.0), (172.0, 20.0), (172.0, 86.0), (94.0, 86.0)] ;
    text id 43 start 359.5s for 2.0s at (98.0, 25.0) ''[bold][color=#FBBF24]Propriétés métriques de la distance[/color][/bold]'' ;
    text id 44 start 363.0s for 2.0s at (98.0, 39.0) ''[color=#38BDF8]1. Positivité :[/color] [color=#F8FAFC]$d(a, b) = |a - b| \ge 0$[/color]'' ;
    text id 45 start 366.5s for 2.0s at (98.0, 53.0) ''[color=#38BDF8]2. Symétrie :[/color] [color=#F8FAFC]$d(a, b) = d(b, a)$[/color]'' ;
    text id 46 start 370.0s for 2.0s at (98.0, 67.0) ''[color=#38BDF8]3. Séparation :[/color] [color=#F8FAFC]$d(a, b) = 0 \iff a = b$[/color]'' ;

    erase id 2003 start 374.0s ;

    # --- SCÈNE 4 : Exemple 1 : Interpréter |x - 3| (374.0s -> 436.8s) ---
    text id 47 start 374.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Exemple 1 : Interpréter $|x - 3|$[/color][/bold]'' ;
    draw line id 531 start 376.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche
    text id 48 start 383.3s for 2.0s at (4.0, 22.0) ''[color=#F8FAFC]Expression à interpréter :[/color] [bold][color=#38BDF8]$|x - 3|$[/color][/bold]'' ;
    text id 49 start 391.6s for 2.2s at (4.0, 36.0) ''[color=#F8FAFC]On reconnaît la forme[/color] [bold][color=#FBBF24]$|a - b|$[/color][/bold]'' ;
    text id 50 start 396.0s for 2.0s at (4.0, 48.0) ''[color=#F8FAFC]avec[/color] [color=#38BDF8]$a = x$[/color] [color=#F8FAFC]et[/color] [color=#34D399]$b = 3$[/color]'' ;
    text id 51 start 405.0s for 2.2s at (4.0, 62.0) ''[color=#F8FAFC]Or[/color] $|a - b| = d(a, b)$'' ;

    draw polygone id 532 start 418.7s for 0.8s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 2.0 at [(4.0, 72.0), (88.0, 72.0), (88.0, 89.0), (4.0, 89.0)] ;
    text id 52 start 420.0s for 2.2s at (8.0, 76.5) ''[bold][color=#34D399]$\mathbf{|x - 3| = d(x, 3) = d(3, x)}$[/color][/bold]'' ;
    text id 53 start 423.5s for 2.0s at (8.0, 83.5) ''[color=#F8FAFC]Distance entre $x$ et $3$ sur la droite réelle[/color]'' ;

    # Colonne droite : Axe gradué
    draw arrow id 533 start 427.0s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 52.0), (170.0, 52.0)] ;
    text id 54 start 428.5s at (171.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw circle id 534 start 429.0s for 0.5s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) radius 1.5 at (118.0, 52.0) ;
    text id 55 start 429.8s at (115.0, 56.5) ''[bold][color=#34D399]$A(3)$[/color][/bold]'' ;

    draw circle id 535 start 430.8s for 0.5s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 1.5 at (152.0, 52.0) ;
    text id 56 start 431.6s at (149.0, 56.5) ''[bold][color=#38BDF8]$M(x)$[/color][/bold]'' ;

    draw line id 536 start 432.5s for 0.7s color (251, 191, 36, 0.9) width 2.5 at [(118.0, 42.0), (152.0, 42.0)] ;
    draw line id 537 start 433.5s for 0.3s color (251, 191, 36, 0.9) width 2.0 at [(118.0, 40.0), (118.0, 44.0)] ;
    draw line id 538 start 434.1s for 0.3s color (251, 191, 36, 0.9) width 2.0 at [(152.0, 40.0), (152.0, 44.0)] ;
    text id 57 start 434.7s for 1.8s at (126.0, 36.0) ''[bold][color=#FBBF24]$|x - 3|$[/color][/bold]'' ;

    erase id 2004 start 436.8s ;

    # --- SCÈNE 5 : Exemple 2 : Le piège du signe plus |x + 5| (436.8s -> 546.5s) ---
    text id 58 start 437.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Exemple 2 : Le piège du signe plus $|x + 5|$[/color][/bold]'' ;
    draw line id 539 start 439.2s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche
    text id 59 start 445.5s for 2.0s at (4.0, 20.0) ''[color=#F8FAFC]Expression donnée :[/color] [bold][color=#F87171]$|x + 5|$[/color][/bold]'' ;
    text id 60 start 460.2s for 2.2s at (4.0, 31.0) ''[bold][color=#F87171]PIÈGE CLASSIQUE : $|x + 5| \neq d(x, 5)$ ![/color][/bold]'' ;
    text id 61 start 475.0s for 2.2s at (4.0, 42.0) ''[color=#F8FAFC]La formule exige impérativement un[/color] [color=#FBBF24]signe moins[/color]'' ;

    # Boîte astuce algébrique
    draw polygone id 540 start 499.0s for 0.8s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 1.8 at [(4.0, 50.0), (88.0, 50.0), (88.0, 70.0), (4.0, 70.0)] ;
    text id 62 start 500.5s for 1.8s at (8.0, 54.5) ''[bold][color=#FBBF24]ASTUCE ALGÉBRIQUE[/color][/bold]'' ;
    text id 63 start 503.5s for 2.2s at (8.0, 62.5) ''[color=#F8FAFC]Ajouter, c'est soustraire l'opposé :[/color] [bold][color=#38BDF8]$+5 = -(-5)$[/color][/bold]'' ;

    text id 64 start 511.9s for 2.2s at (4.0, 75.0) ''[color=#F8FAFC]On réécrit :[/color] [bold][color=#34D399]$|x + 5| = |x - (-5)|$[/color][/bold]'' ;

    draw polygone id 541 start 539.9s for 0.8s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 2.0 at [(4.0, 83.0), (88.0, 83.0), (88.0, 96.0), (4.0, 96.0)] ;
    text id 65 start 541.0s for 2.2s at (8.0, 88.0) ''[bold][color=#34D399]$\mathbf{|x + 5| = d(x, -5) = d(-5, x)}$[/color][/bold]'' ;

    # Colonne droite : Axe gradué avec B(-5) et M(x)
    draw arrow id 542 start 522.0s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 48.0), (170.0, 48.0)] ;
    text id 66 start 523.5s at (171.0, 46.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw circle id 543 start 525.0s for 0.5s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.4) radius 1.5 at (108.0, 48.0) ;
    text id 67 start 525.8s at (104.0, 52.5) ''[bold][color=#F87171]$B(-5)$[/color][/bold]'' ;

    draw circle id 544 start 527.0s for 0.5s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 1.5 at (150.0, 48.0) ;
    text id 68 start 527.8s at (147.0, 52.5) ''[bold][color=#38BDF8]$M(x)$[/color][/bold]'' ;

    draw line id 545 start 529.0s for 0.7s color (52, 211, 153, 0.9) width 2.5 at [(108.0, 38.0), (150.0, 38.0)] ;
    draw line id 546 start 530.0s for 0.3s color (52, 211, 153, 0.9) width 2.0 at [(108.0, 36.0), (108.0, 40.0)] ;
    draw line id 547 start 530.6s for 0.3s color (52, 211, 153, 0.9) width 2.0 at [(150.0, 36.0), (150.0, 40.0)] ;
    text id 69 start 531.5s for 2.0s at (118.0, 32.0) ''[bold][color=#34D399]$d(x, -5)$[/color][/bold]'' ;

    # Carte mémo bas droite
    draw polygone id 548 start 534.5s for 0.8s color (192, 132, 252, 0.8) fillcolor (192, 132, 252, 0.12) width 1.8 at [(94.0, 64.0), (172.0, 64.0), (172.0, 94.0), (94.0, 94.0)] ;
    text id 70 start 535.8s for 1.6s at (98.0, 69.0) ''[bold][color=#C084FC]RÈGLE MÉMO[/color][/bold]'' ;
    text id 71 start 537.8s for 1.8s at (98.0, 78.0) ''[color=#38BDF8]$\bullet\ |x - c| = d(x, c)$[/color]'' ;
    text id 72 start 540.2s for 1.8s at (98.0, 86.5) ''[color=#34D399]$\bullet\ |x + c| = |x - (-c)| = d(x, -c)$[/color]'' ;

    erase id 2005 start 546.5s ;

    # --- SCÈNE 6 : Synthèse et perspective d'équations (546.5s -> 592.0s) ---
    text id 73 start 547.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Synthèse : Réflexes & Résolution d'équations[/color][/bold]'' ;
    draw line id 549 start 549.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Réflexes colonne gauche
    text id 74 start 550.5s for 2.2s at (4.0, 22.0) ''[bold][color=#38BDF8]1. Réflexe Distance fondamentale :[/color][/bold]'' ;
    text id 75 start 554.0s for 2.5s at (8.0, 32.5) ''[bold][color=#34D399]$\mathbf{d(a, b) = |a - b| = |b - a| \ge 0}$[/color][/bold]'' ;

    text id 76 start 560.0s for 2.2s at (4.0, 48.0) ''[bold][color=#FBBF24]2. Réflexe du signe plus :[/color][/bold]'' ;
    text id 77 start 564.0s for 2.5s at (8.0, 58.5) ''[bold][color=#FBBF24]$\mathbf{|x + k| = |x - (-k)| = d(x, -k)}$[/color][/bold]'' ;

    text id 78 start 571.0s for 2.2s at (4.0, 74.0) ''[color=#94A3B8]Interprétation géométrique immédiate ![/color]'' ;

    # Colonne droite : Encart application équation
    draw polygone id 550 start 574.5s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.8 at [(94.0, 20.0), (172.0, 20.0), (172.0, 92.0), (94.0, 92.0)] ;
    text id 79 start 576.0s for 2.0s at (98.0, 25.0) ''[bold][color=#38BDF8]Application : Résoudre $|x - 3| = 2$[/color][/bold]'' ;
    text id 80 start 579.0s for 2.0s at (98.0, 34.0) ''[color=#F8FAFC]$\iff d(x, 3) = 2$[/color]'' ;
    text id 81 start 582.0s for 2.0s at (98.0, 42.0) ''[color=#F8FAFC]Points situés à distance $2$ de $3$ :[/color]'' ;

    draw arrow id 551 start 584.5s for 0.8s color (248, 250, 252, 0.9) width 1.8 at [(98.0, 60.0), (168.0, 60.0)] ;

    draw circle id 552 start 585.8s for 0.4s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.4 at (133.0, 60.0) ;
    text id 82 start 586.4s at (131.5, 64.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;

    draw circle id 553 start 587.0s for 0.3s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) radius 1.4 at (113.0, 60.0) ;
    text id 83 start 587.5s at (111.5, 64.5) ''[bold][color=#34D399]$1$[/color][/bold]'' ;

    draw line id 554 start 588.0s for 0.4s color (52, 211, 153, 0.8) width 1.5 at [(113.0, 54.0), (133.0, 54.0)] ;
    text id 84 start 588.6s at (121.0, 50.5) ''[color=#34D399]$-2$[/color]'' ;

    draw circle id 555 start 589.2s for 0.3s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) radius 1.4 at (153.0, 60.0) ;
    text id 85 start 589.7s at (151.5, 64.5) ''[bold][color=#34D399]$5$[/color][/bold]'' ;

    draw line id 556 start 590.2s for 0.4s color (52, 211, 153, 0.8) width 1.5 at [(133.0, 54.0), (153.0, 54.0)] ;
    text id 86 start 590.8s at (141.0, 50.5) ''[color=#34D399]$+2$[/color]'' ;

    text id 87 start 591.3s at (98.0, 80.0) ''[bold][color=#34D399]$\mathbf{S = \{1 \;;\; 5\}}$[/color][/bold] [color=#94A3B8](lecture directe !)[/color]'' ;
}
