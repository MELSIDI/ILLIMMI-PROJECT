course "Variations de fonctions et extrema — Cours fondamental et définitions" id 31 idgap 1000 for 1480.1s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 0 : Introduction & Plan du chapitre (0.2s - 40.3s)
    # =========================================================================
    text id 1 start 0.2s for 1.6s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Variations de fonctions et extrema[/color][/bold]'' ;
    draw line id 1001 start 2.0s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 12.7s for 2.5s at (4.5, 22.0) ''[bold]Programme de la leçon :[/bold]'' ;
    text id 3 start 15.5s for 3.0s at (5.0, 32.0) ''[color=#34D399]$\bullet$ Croissante, décroissante, constante[/color]'' ;
    text id 4 start 19.0s for 3.0s at (5.0, 42.0) ''[color=#FBBF24]$\bullet$ Extrema : minimum et maximum[/color]'' ;
    text id 5 start 22.7s for 3.2s at (5.0, 52.0) ''[color=#38BDF8]$\bullet$ Tableau de variation complet[/color]'' ;
    text id 6 start 26.6s for 3.2s at (5.0, 62.0) ''[color=#C084FC]$\bullet$ Fonctions de référence (Seconde)[/color]'' ;
    text id 7 start 30.2s for 2.0s at (5.0, 74.0) ''[color=#F8FAFC]Objectif : relier la courbe aux formules.[/color]'' ;

    draw 2drep id 1002 start 32.5s for 1.5s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 3] ;
    draw 2dfunc id 1003 start 34.3s for 3.0s color (56, 189, 248, 1) width 2.5 at 1002 y = 1.8 * sin(x) ;

    # =========================================================================
    # SCÈNE 1 : Fonction croissante — Intuition & Sens de lecture (40.3s - 143.6s)
    # =========================================================================
    erase id 4001 start 40.3s ;

    text id 10 start 40.5s for 1.8s at (4.0, 7.5) ''[bold][color=#34D399]2. Fonction croissante : intuition graphique[/color][/bold]'' ;
    draw line id 1010 start 42.6s for 1.0s color (52, 211, 153, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 11 start 48.8s for 3.0s at (4.5, 22.0) ''Quand une fonction croît, la courbe [color=#34D399][bold]monte[/bold][/color].'' ;

    draw 2drep id 1011 start 56.0s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-2, 3] ;
    draw 2dfunc id 1012 start 59.0s for 2.5s color (52, 211, 153, 1) width 2.8 at 1011 y = 0.04 * x^3 + 0.35 * x + 0.5 ;

    mouse move id 3001 start 72.2s for 4.0s at [(112, 69), (125, 60), (138, 52), (153, 40)] ;

    text id 12 start 85.2s for 3.0s at (4.5, 34.0) ''[color=#FBBF24]Piège :[/color] de droite à gauche, on descend !'' ;
    text id 13 start 102.9s for 3.0s at (4.5, 45.0) ''Quel sens de parcours choisir ?'' ;

    draw arrow id 1013 start 117.3s for 1.8s color (56, 189, 248, 1) width 2.8 at [(111, 77), (155, 77)] ;
    text id 14 start 119.5s for 2.5s at (107.0, 81.0) ''[color=#38BDF8]Sens des abscisses croissantes[/color]'' ;

    text id 15 start 127.1s for 3.2s at (4.5, 57.0) ''[color=#38BDF8][bold]Convention :[/bold][/color] lecture de gauche à droite.'' ;
    text id 16 start 134.5s for 3.5s at (4.5, 69.0) ''[color=#34D399]$\implies$ On monte : la fonction est croissante.[/color]'' ;

    # =========================================================================
    # SCÈNE 2 : Fonction croissante — Définition & Exemple a=1, b=2 (143.6s - 271.7s)
    # =========================================================================
    erase id 4002 start 143.6s ;

    text id 20 start 144.1s for 1.8s at (4.0, 7.5) ''[bold][color=#34D399]3. Définition formelle : fonction croissante[/color][/bold]'' ;
    draw line id 1020 start 146.2s for 1.0s color (52, 211, 153, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 21 start 150.8s for 2.5s at (4.5, 21.0) ''Soit $f$ définie sur un intervalle $I$.'' ;
    text id 22 start 154.0s for 2.8s at (4.5, 30.0) ''Pour tous réels $a, b \in I$ :'' ;
    text id 23 start 158.0s for 3.5s at (4.5, 40.0) ''[color=#34D399]$$a < b \implies f(a) \leqslant f(b)$$[/color]'' ;

    draw 2drep id 1021 start 179.3s for 1.5s at (118, 72) color (248, 250, 252, 0.95) width 1.5 scale = 8.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-0.6, 5] y_range = [-0.4, 5] ;
    draw 2dfunc id 1022 start 181.2s for 1.5s color (52, 211, 153, 1) width 2.8 at 1021 y = 0.2 * x^2 + 0.3 * x + 0.3 ;

    text id 24 start 183.0s for 3.0s at (4.5, 55.0) ''Exemple : prenons $a = 1$ et $b = 2$.'' ;

    draw circle id 1023 start 199.0s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 0.9 at (126.5, 72.0) ;
    draw circle id 1024 start 199.0s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.25) radius 0.9 at (135.0, 72.0) ;
    text id 25 start 202.5s at (119.5, 76.5) ''[color=#FBBF24]$a=1$[/color]'' ;
    text id 26 start 203.7s at (135.0, 76.5) ''[color=#38BDF8]$b=2$[/color]'' ;

    draw line id 1025 start 215.0s for 1.2s color (251, 191, 36, 0.9) width 1.8 at [(126.5, 72.0), (126.5, 65.2)] ;
    draw line id 1026 start 218.5s for 1.2s color (251, 191, 36, 0.9) width 1.8 at [(126.5, 65.2), (118.0, 65.2)] ;
    draw circle id 1027 start 220.0s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.3) radius 0.9 at (126.5, 65.2) ;
    text id 27 start 221.7s at (97.5, 62.5) ''[color=#FBBF24]$f(1)$[/color]'' ;

    draw line id 1028 start 228.4s for 1.2s color (56, 189, 248, 0.9) width 1.8 at [(135.0, 72.0), (135.0, 57.55)] ;
    draw line id 1029 start 231.5s for 1.2s color (56, 189, 248, 0.9) width 1.8 at [(135.0, 57.55), (118.0, 57.55)] ;
    draw circle id 1030 start 233.5s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.3) radius 0.9 at (135.0, 57.55) ;
    text id 28 start 235.9s at (97.5, 54.5) ''[color=#38BDF8]$f(2)$[/color]'' ;

    text id 29 start 239.4s for 2.8s at (4.5, 66.0) ''Constat : [color=#34D399]$f(2)$ est au-dessus de $f(1)$[/color].'' ;
    text id 30 start 253.0s for 3.2s at (4.5, 77.0) ''$$1 < 2 \implies f(1) < f(2)$$'' ;

    # =========================================================================
    # SCÈNE 3 : Fonction décroissante — Descente & Exemple a=1, b=3 (271.7s - 406.4s)
    # =========================================================================
    erase id 4003 start 271.7s ;

    text id 40 start 272.1s for 1.8s at (4.0, 7.5) ''[bold][color=#F87171]4. Fonction décroissante : inversion de l'ordre[/color][/bold]'' ;
    draw line id 1040 start 274.2s for 1.0s color (248, 113, 113, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 1041 start 278.0s for 1.5s at (118, 72) color (248, 250, 252, 0.95) width 1.5 scale = 8.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-0.6, 5] y_range = [-0.4, 5] ;
    draw 2dfunc id 1042 start 280.0s for 2.5s color (248, 113, 113, 1) width 2.8 at 1041 y = 4.5 - 1.1 * x + 0.08 * x^2 ;

    mouse move id 3010 start 286.1s for 4.5s at [(118, 34), (126.5, 42.4), (135, 49.5), (143.5, 55.7), (152, 60.3)] ;

    text id 41 start 315.2s for 2.5s at (4.5, 22.0) ''[bold]Définition :[/bold] $f$ décroissante sur $I$'' ;
    text id 42 start 320.5s for 2.5s at (4.5, 31.0) ''Pour tous réels $a, b \in I$ :'' ;
    text id 43 start 324.5s for 3.2s at (4.5, 41.0) ''[color=#F87171]$$a < b \implies f(a) \geqslant f(b)$$[/color]'' ;
    text id 44 start 335.5s for 3.2s at (4.5, 56.0) ''[color=#FBBF24]L'inégalité se retourne ![/color]'' ;

    text id 45 start 344.8s for 2.5s at (4.5, 67.0) ''Exemple : $a = 1$ et $b = 3$ ($1 < 3$).'' ;
    draw circle id 1043 start 348.0s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.25) radius 0.9 at (126.5, 72.0) ;
    draw circle id 1044 start 348.0s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.25) radius 0.9 at (143.5, 72.0) ;
    text id 46 start 349.0s at (124.0, 76.5) ''[color=#FBBF24]$a=1$[/color]'' ;
    text id 47 start 350.0s at (141.0, 76.5) ''[color=#38BDF8]$b=3$[/color]'' ;

    draw line id 1045 start 357.1s for 1.2s color (251, 191, 36, 0.9) width 1.8 at [(126.5, 72.0), (126.5, 42.42)] ;
    draw line id 1046 start 360.2s for 1.2s color (251, 191, 36, 0.9) width 1.8 at [(126.5, 42.42), (118.0, 42.42)] ;
    draw circle id 1047 start 361.8s color (251, 191, 36, 1) width 2 fillcolor (251, 191, 36, 0.3) radius 0.9 at (126.5, 42.42) ;
    text id 48 start 362.8s at (97.5, 39.5) ''[color=#FBBF24]$f(1)$[/color]'' ;

    draw line id 1048 start 366.1s for 1.2s color (56, 189, 248, 0.9) width 1.8 at [(143.5, 72.0), (143.5, 55.68)] ;
    draw line id 1049 start 368.5s for 1.2s color (56, 189, 248, 0.9) width 1.8 at [(143.5, 55.68), (118.0, 55.68)] ;
    draw circle id 1050 start 370.0s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.3) radius 0.9 at (143.5, 55.68) ;
    text id 49 start 371.3s at (97.5, 52.8) ''[color=#38BDF8]$f(3)$[/color]'' ;

    text id 50 start 374.1s for 3.2s at (4.5, 78.0) ''[color=#F87171]$f(1) > f(3)$[/color] : en descendant, l'image baisse.'' ;

    # =========================================================================
    # SCÈNE 4 : Fonction constante, Monotonie & Bilan sur l'ordre (406.4s - 506.1s)
    # =========================================================================
    erase id 4004 start 406.4s ;

    text id 60 start 406.6s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Fonction constante, monotonie et bilan[/color][/bold]'' ;
    draw line id 1060 start 408.8s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 61 start 415.8s for 2.5s at (4.5, 21.0) ''[bold]Fonction constante sur $I$ :[/bold]'' ;
    text id 62 start 422.6s for 3.0s at (4.5, 31.0) ''[color=#38BDF8]$$\forall a, b \in I,\quad f(a) = f(b)$$[/color]'' ;

    draw 2drep id 1061 start 430.4s for 1.5s at (133, 62) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-1, 4] ;
    draw 2dfunc id 1062 start 432.6s for 1.8s color (56, 189, 248, 1) width 2.8 at 1061 y = 2 ;

    draw line id 1063 start 446.0s for 1.0s color (251, 191, 36, 0.9) width 1.8 at [(122.5, 62), (122.5, 48)] ;
    draw line id 1064 start 447.5s for 1.0s color (251, 191, 36, 0.9) width 1.8 at [(143.5, 62), (143.5, 48)] ;
    text id 63 start 449.0s at (124.0, 26.0) ''[color=#38BDF8]$f(a) = f(b)$[/color]'' ;

    text id 64 start 460.9s for 2.5s at (4.5, 47.0) ''[bold]Fonction monotone sur $I$ :[/bold]'' ;
    text id 65 start 466.7s for 3.0s at (4.5, 56.0) ''Toujours croissante OU toujours décroissante.'' ;

    text id 66 start 477.0s for 3.5s at (4.5, 69.0) ''[color=#34D399]$\bullet$ Croissante : l'ordre est CONSERVÉ[/color]'' ;
    text id 67 start 491.1s for 3.5s at (4.5, 79.0) ''[color=#F87171]$\bullet$ Décroissante : l'ordre s'INVERSE[/color]'' ;

    # =========================================================================
    # SCÈNE 5 : Extrema — Maximum d'une fonction (506.1s - 642.4s)
    # =========================================================================
    erase id 4005 start 506.1s ;

    text id 70 start 506.3s for 1.8s at (4.0, 7.5) ''[bold][color=#FBBF24]6. Extrema : Le maximum d'une fonction[/color][/bold]'' ;
    draw line id 1070 start 508.5s for 1.0s color (251, 191, 36, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 1071 start 530.5s for 1.5s at (116, 74) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-0.5, 5] y_range = [-0.4, 4.5] ;
    draw 2dfunc id 1072 start 532.5s for 2.5s color (56, 189, 248, 1) width 2.8 at 1071 y = 3 - 0.6 * (x - 2)^2 ;

    draw circle id 1073 start 544.0s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.3) radius 1.2 at (132.0, 50.0) ;
    draw arrow id 1074 start 545.0s for 1.0s color (251, 191, 36, 1) width 2.0 at [(138.0, 39.0), (133.5, 48.0)] ;
    text id 71 start 546.5s for 2.0s at (128.0, 31.0) ''[color=#FBBF24][bold]Maximum $M = 3$[/bold][/color]'' ;

    draw line id 1075 start 562.1s for 1.2s color (251, 191, 36, 0.9) width 1.8 at [(132.0, 50.0), (116.0, 50.0)] ;
    text id 72 start 564.0s at (107.5, 47.5) ''[color=#FBBF24][bold]3[/bold][/color]'' ;

    draw line id 1076 start 571.8s for 1.2s color (56, 189, 248, 0.9) width 1.8 at [(132.0, 50.0), (132.0, 74.0)] ;
    text id 73 start 574.0s at (129.0, 78.5) ''[color=#38BDF8]$a=2$[/color]'' ;

    text id 74 start 576.3s for 3.0s at (4.5, 22.0) ''Maximum $=$ [color=#FBBF24]$3$[/color], atteint en [color=#38BDF8]$x = 2$[/color].'' ;
    text id 75 start 583.8s for 2.8s at (4.5, 34.0) ''[bold]Définition du maximum sur $I$ :[/bold]'' ;
    text id 76 start 590.0s for 3.8s at (4.5, 45.0) ''[color=#34D399]$$\forall x \in I,\quad f(x) \leqslant M \quad (M = f(a))$$[/color]'' ;

    mouse move id 3020 start 602.8s for 4.5s at [(120, 66), (125, 56), (132, 50), (140, 57), (146, 68)] ;

    text id 77 start 626.3s for 3.2s at (4.5, 62.0) ''Aucune image ne dépasse $M = 3$.'' ;
    text id 78 start 639.0s for 2.5s at (4.5, 74.0) ''Ici : $a = 2$ et $M = f(2) = 3$.'' ;

    # =========================================================================
    # SCÈNE 6 : Extrema — Minimum d'une fonction (642.4s - 726.8s)
    # =========================================================================
    erase id 4006 start 642.4s ;

    text id 80 start 642.6s for 1.8s at (4.0, 7.5) ''[bold][color=#34D399]7. Extrema : Le minimum d'une fonction[/color][/bold]'' ;
    draw line id 1080 start 644.8s for 1.0s color (52, 211, 153, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 1081 start 646.1s for 1.5s at (114, 68) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-0.5, 6] y_range = [-1.5, 3.5] ;
    draw 2dfunc id 1082 start 648.0s for 2.5s color (52, 211, 153, 1) width 2.8 at 1081 y = -1 + 0.5 * (x - 3)^2 ;

    draw circle id 1083 start 666.5s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.3) radius 1.2 at (138.0, 76.0) ;
    draw line id 1084 start 668.0s for 1.0s color (52, 211, 153, 0.9) width 1.8 at [(138.0, 76.0), (114.0, 76.0)] ;
    draw line id 1085 start 669.5s for 1.0s color (56, 189, 248, 0.9) width 1.8 at [(138.0, 76.0), (138.0, 68.0)] ;
    text id 81 start 671.0s at (105.0, 73.5) ''[color=#34D399][bold]-1[/bold][/color]'' ;
    text id 82 start 672.5s at (135.5, 81.5) ''[color=#38BDF8]$b=3$[/color]'' ;

    text id 83 start 676.0s for 2.8s at (4.5, 22.0) ''[bold]Définition du minimum sur $I$ :[/bold]'' ;
    text id 84 start 683.5s for 3.8s at (4.5, 34.0) ''[color=#38BDF8]$$\forall x \in I,\quad f(x) \geqslant m \quad (m = f(b))$$[/color]'' ;

    text id 85 start 695.8s for 3.2s at (4.5, 51.0) ''Test en $x = 1{,}5$ : $f(1{,}5) > -1$.'' ;
    mouse move id 3030 start 699.5s for 4.0s at [(126, 67), (120, 56), (142, 75), (138, 76)] ;

    text id 86 start 716.0s for 3.0s at (4.5, 64.0) ''Toutes les images restent $\geqslant -1$.'' ;
    text id 87 start 720.0s for 3.0s at (4.5, 76.0) ''Ici : $b = 3$ et $m = f(3) = -1$.'' ;

    # =========================================================================
    # SCÈNE 7 : Extremum relatif (local) vs absolu (global) (726.8s - 843.2s)
    # =========================================================================
    erase id 4007 start 726.8s ;

    text id 90 start 727.0s for 1.8s at (4.0, 7.5) ''[bold][color=#C084FC]8. Extremum relatif vs extremum absolu[/color][/bold]'' ;
    draw line id 1090 start 729.2s for 1.0s color (192, 132, 252, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 1091 start 735.2s for 1.5s at (125, 58) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 6] y_range = [-3, 4] ;
    draw curve id 1092 start 737.0s for 2.5s color (56, 189, 248, 1) width 2.8 smooth at [(108.8, 41.1), (115.2, 56.0), (121.8, 52.8), (131.5, 58.0), (144.5, 64.5), (152.3, 59.3), (160.8, 72.3)] ;

    draw line id 1093 start 746.0s for 1.2s color (52, 211, 153, 0.8) width 1.5 at [(105.5, 64.5), (164.0, 64.5)] ;
    draw circle id 1094 start 747.5s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.3) radius 1.0 at (144.5, 64.5) ;

    text id 91 start 749.0s for 3.0s at (4.5, 22.0) ''Si on prolonge la courbe :'' ;
    text id 92 start 757.0s for 3.2s at (4.5, 33.0) ''[color=#F87171]À droite, on atteint $f(x) = -2 < -1$ ![/color]'' ;

    draw circle id 1095 start 760.5s color (248, 113, 113, 1) width 2.2 fillcolor (248, 113, 113, 0.3) radius 1.1 at (160.0, 71.0) ;
    text id 93 start 762.0s at (146.0, 81.0) ''[color=#F87171]$-2 < -1$ ![/color]'' ;

    text id 94 start 780.0s for 3.5s at (4.5, 47.0) ''[color=#FBBF24][bold]Minimum relatif (local) :[/bold][/color] zone restreinte.'' ;
    text id 95 start 796.4s for 3.8s at (4.5, 60.0) ''[color=#34D399][bold]Minimum absolu (global) :[/bold][/color] sur tout le domaine.'' ;

    draw circle id 1096 start 809.0s color (192, 132, 252, 1) width 2.2 fillcolor (192, 132, 252, 0.3) radius 1.1 at (121.8, 52.8) ;
    text id 96 start 812.0s at (112.0, 25.5) ''[color=#C084FC]Max relatif $< 1$[/color]'' ;
    text id 97 start 822.7s for 3.5s at (4.5, 74.0) ''[color=#C084FC]Maximum relatif[/color] : valable au voisinage.'' ;

    # =========================================================================
    # SCÈNE 8 : Construire un tableau de variation [0 ; 5] (843.2s - 1073.3s)
    # =========================================================================
    erase id 4008 start 843.2s ;

    text id 100 start 843.4s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]9. Construire un tableau de variation[/color][/bold]'' ;
    draw line id 1100 start 845.6s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 1101 start 851.2s for 1.5s at (110, 84) color (248, 250, 252, 0.95) width 1.5 scale = 9.0 grid = true grid_alpha = 0.7 step = 1 x_range = [0, 5] y_range = [0, 7] ;
    draw 2dfunc id 1102 start 853.2s for 2.5s color (56, 189, 248, 1) width 2.8 at 1101 y = 6 - 0.96 * (x - 2.5)^2 ;

    draw polygone id 1103 start 870.4s for 1.8s color (248, 250, 252, 0.95) fillcolor (248, 250, 252, 0.06) width 2.0 at [(6, 25), (86, 25), (86, 62), (6, 62)] ;
    draw line id 1104 start 877.1s for 1.0s color (248, 250, 252, 0.9) width 1.6 at [(6, 36), (86, 36)] ;
    draw line id 1105 start 879.0s for 1.0s color (248, 250, 252, 0.9) width 1.6 at [(22, 25), (22, 62)] ;

    text id 101 start 905.1s at (12.0, 28.0) ''[bold]$x$[/bold]'' ;
    text id 102 start 924.3s at (25.0, 28.0) ''[color=#38BDF8]$0$[/color]'' ;
    text id 103 start 927.0s at (80.0, 28.0) ''[color=#38BDF8]$5$[/color]'' ;

    draw line id 1106 start 956.1s for 1.5s color (251, 191, 36, 0.95) width 1.8 at [(132.5, 30.0), (132.5, 84.0)] ;
    draw circle id 1107 start 958.0s color (251, 191, 36, 1) width 2.2 fillcolor (251, 191, 36, 0.3) radius 1.1 at (132.5, 30.0) ;
    text id 104 start 962.4s at (50.0, 28.0) ''[color=#FBBF24]$2{,}5$[/color]'' ;

    text id 105 start 981.3s at (8.0, 46.5) ''[bold]$f(x)$[/bold]'' ;

    draw arrow id 1108 start 994.4s for 1.8s color (52, 211, 153, 1) width 2.8 at [(29, 56), (49, 41)] ;
    draw arrow id 1109 start 998.4s for 1.8s color (248, 113, 113, 1) width 2.8 at [(58, 41), (78, 56)] ;

    draw circle id 1110 start 1019.0s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.3) radius 1.0 at (110.0, 84.0) ;
    text id 106 start 1023.5s at (25.0, 55.0) ''[color=#34D399]$0$[/color]'' ;

    draw circle id 1111 start 1030.0s color (248, 113, 113, 1) width 2 fillcolor (248, 113, 113, 0.3) radius 1.0 at (155.0, 84.0) ;
    text id 107 start 1036.5s at (80.0, 55.0) ''[color=#F87171]$0$[/color]'' ;

    draw line id 1112 start 1045.1s for 1.2s color (251, 191, 36, 0.9) width 1.6 at [(132.5, 30.0), (110.0, 30.0)] ;
    text id 108 start 1049.0s at (51.5, 37.5) ''[color=#FBBF24][bold]$6$[/bold][/color]'' ;

    text id 109 start 1055.0s for 3.5s at (5.0, 71.0) ''[color=#34D399]Bilan :[/color] croissante sur $[0 ; 2{,}5]$,'' ;
    text id 110 start 1062.2s for 3.5s at (5.0, 80.0) ''décroissante sur $[2{,}5 ; 5]$, Max $= 6$ en $2{,}5$.'' ;

    # =========================================================================
    # SCÈNE 9 : Fonctions de référence — Fonctions affines (1073.3s - 1161.9s)
    # =========================================================================
    erase id 4009 start 1073.3s ;

    text id 120 start 1073.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]10. Fonctions de référence : Fonctions affines[/color][/bold]'' ;
    draw line id 1120 start 1075.7s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 121 start 1086.4s for 2.8s at (4.5, 21.0) ''[bold]Forme générale :[/bold] [color=#38BDF8]$f(x) = ax + b$[/color]'' ;
    text id 122 start 1096.8s for 3.0s at (4.5, 32.0) ''Cas linéaire ($b = 0$) : $f(x) = ax$ (passe par $O$).'' ;

    draw 2drep id 1121 start 1121.0s for 1.5s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-4, 4] ;

    text id 123 start 1123.9s for 2.8s at (4.5, 45.0) ''[color=#34D399]1) $a > 0$ : croissante sur $\mathbb{R}$ (monte)[/color]'' ;
    draw 2dfunc id 1122 start 1129.4s for 1.8s color (52, 211, 153, 1) width 2.8 at 1121 y = 0.8 * x + 0.5 ;

    text id 124 start 1132.1s for 2.8s at (4.5, 58.0) ''[color=#F87171]2) $a < 0$ : décroissante sur $\mathbb{R}$ (descend)[/color]'' ;
    draw 2dfunc id 1123 start 1137.6s for 1.8s color (248, 113, 113, 1) width 2.8 at 1121 y = -0.8 * x + 0.5 ;

    text id 125 start 1140.2s for 3.0s at (4.5, 71.0) ''[color=#FBBF24]3) $a = 0$ : $f(x) = b$ (constante)[/color]'' ;
    draw 2dfunc id 1124 start 1150.0s for 1.8s color (251, 191, 36, 1) width 2.8 at 1121 y = 1.5 ;

    # =========================================================================
    # SCÈNE 10 : Fonction carré f(x) = x^2 (1161.9s - 1208.0s)
    # =========================================================================
    erase id 4010 start 1161.9s ;

    text id 130 start 1162.1s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]11. Fonction de référence : Fonction carré[/color][/bold]'' ;
    draw line id 1130 start 1164.2s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 131 start 1166.8s for 2.0s at (4.5, 22.0) ''[color=#38BDF8]$$f(x) = x^2$$[/color]'' ;
    draw 2drep id 1131 start 1169.2s for 1.4s at (133, 80) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-1, 9] ;
    draw 2dfunc id 1132 start 1171.0s for 2.2s color (56, 189, 248, 1) width 2.8 at 1131 y = x^2 ;

    text id 132 start 1173.8s for 2.8s at (4.5, 38.0) ''Courbe : une [color=#38BDF8][bold]parabole[/bold][/color] (sommet en $O$).'' ;
    text id 133 start 1195.1s for 3.2s at (4.5, 51.0) ''[color=#F87171]$\bullet$ Décroissante sur $]-\infty ; 0]$[/color]'' ;
    text id 134 start 1200.8s for 3.0s at (4.5, 63.0) ''[color=#34D399]$\bullet$ Croissante sur $[0 ; +\infty[$[/color]'' ;
    text id 135 start 1204.4s for 2.8s at (4.5, 75.0) ''[color=#FBBF24]$\bullet$ Minimum $0$ atteint en $x = 0$[/color]'' ;

    # =========================================================================
    # SCÈNE 11 : Fonction inverse f(x) = 1/x & Piège (1208.0s - 1327.5s)
    # =========================================================================
    erase id 4011 start 1208.0s ;

    text id 140 start 1208.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]12. Fonction inverse et valeur interdite[/color][/bold]'' ;
    draw line id 1140 start 1210.4s for 1.0s color (56, 189, 248, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 141 start 1211.7s for 1.8s at (4.5, 20.0) ''[color=#38BDF8]$$f(x) = \frac{1}{x}$$[/color]'' ;
    draw 2drep id 1141 start 1213.8s for 1.4s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-4, 4] ;
    draw 2dfunc id 1142 start 1215.5s for 2.2s color (56, 189, 248, 1) width 2.8 at 1141 y = 1 / x ;

    text id 142 start 1218.2s for 2.8s at (4.5, 35.0) ''Courbe : une [color=#38BDF8][bold]hyperbole[/bold][/color] (2 branches).'' ;
    text id 143 start 1224.0s for 3.5s at (4.5, 45.0) ''[color=#F87171]Valeur interdite : $x = 0$ ($\frac{1}{0}$ impossible)[/color]'' ;

    draw line id 1143 start 1251.5s for 1.5s color (248, 113, 113, 0.95) width 2.2 at [(133, 27), (133, 83)] ;
    text id 144 start 1253.5s at (135.5, 19.5) ''[color=#F87171][bold]Trou en $x = 0$[/bold][/color]'' ;

    text id 145 start 1258.4s for 2.8s at (4.5, 56.0) ''$\bullet$ Décroissante sur $]-\infty ; 0[$'' ;
    text id 146 start 1264.4s for 2.8s at (4.5, 65.0) ''$\bullet$ Décroissante sur $]0 ; +\infty[$'' ;

    text id 147 start 1275.0s for 3.5s at (4.5, 75.0) ''[color=#F87171][bold]PIÈGE :[/bold] pas sur $]-\infty;0[ \cup ]0;+\infty[$ ![/color]'' ;
    text id 148 start 1288.0s for 3.5s at (4.5, 85.0) ''Car $f(-1) = -1 < f(1) = 1$ (double barre en $0$).'' ;

    # =========================================================================
    # SCÈNE 12 : Racine carrée & Fonction cube (1327.5s - 1392.9s)
    # =========================================================================
    erase id 4012 start 1327.5s ;

    text id 150 start 1327.7s for 1.8s at (4.0, 7.5) ''[bold][color=#34D399]13. Racine carrée et fonction cube[/color][/bold]'' ;
    draw line id 1150 start 1329.8s for 1.0s color (52, 211, 153, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 151 start 1331.4s for 2.5s at (4.5, 21.0) ''[bold]4) Racine carrée :[/bold] [color=#34D399]$f(x) = \sqrt{x}$[/color]'' ;
    text id 152 start 1336.6s for 3.2s at (4.5, 31.0) ''Définie sur $[0 ; +\infty[$ (pas de $x < 0$).'' ;

    draw 2drep id 1151 start 1351.6s for 1.5s at (128, 55) color (248, 250, 252, 0.95) width 1.5 scale = 6.8 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 5] y_range = [-4, 4] ;
    draw 2dfunc id 1152 start 1353.5s for 2.2s color (52, 211, 153, 1) width 2.8 at 1151 y = sqrt(x) ;

    text id 153 start 1368.8s for 3.2s at (4.5, 43.0) ''[color=#34D399]Strictement croissante sur $[0 ; +\infty[$.[/color]'' ;

    text id 154 start 1376.1s for 2.8s at (4.5, 59.0) ''[bold]5) Fonction cube :[/bold] [color=#38BDF8]$f(x) = x^3$[/color]'' ;
    draw 2dfunc id 1153 start 1382.8s for 2.2s color (56, 189, 248, 1) width 2.8 at 1151 y = x^3 ;
    text id 155 start 1385.6s for 3.2s at (4.5, 71.0) ''[color=#38BDF8]Strictement croissante sur $\mathbb{R}$.[/color]'' ;

    # =========================================================================
    # SCÈNE 13 : Croissance large vs stricte & Synthèse (1392.9s - 1480.1s)
    # =========================================================================
    erase id 4013 start 1392.9s ;

    text id 160 start 1393.1s for 1.8s at (4.0, 7.5) ''[bold][color=#FBBF24]14. Croissance large vs croissance stricte[/color][/bold]'' ;
    draw line id 1160 start 1395.2s for 1.0s color (251, 191, 36, 0.85) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 161 start 1397.7s for 3.0s at (4.5, 22.0) ''[bold]Nuance :[/bold] croissante vs strictement croissante'' ;

    draw 2drep id 1161 start 1408.8s for 1.5s at (108, 78) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [0, 6] y_range = [0, 5] ;
    draw path id 1162 start 1411.0s for 2.8s color (251, 191, 36, 1) width 2.8 at [(111.8, 74.2), (123.0, 59.2), (134.2, 59.2), (145.5, 44.2)] ;

    draw arrow id 1163 start 1418.0s for 1.2s color (248, 113, 113, 1) width 2.0 at [(128.6, 39.5), (128.6, 57.5)] ;
    text id 162 start 1419.6s for 1.8s at (119.0, 32.5) ''[color=#F87171]Palier constant[/color]'' ;

    text id 163 start 1426.5s for 3.5s at (4.5, 34.0) ''[color=#FBBF24]Croissante (large) :[/color] palier possible ($f(a) \leqslant f(b)$).'' ;
    text id 164 start 1437.2s for 3.5s at (4.5, 46.0) ''[color=#34D399]Strictement croissante :[/color] monte toujours ($f(a) < f(b)$).'' ;
    text id 165 start 1445.7s for 3.2s at (4.5, 58.0) ''La fonction $x^3$ n'a aucun palier autour de $0$.'' ;

    text id 166 start 1462.8s for 3.5s at (4.5, 72.0) ''[bold][color=#38BDF8]À retenir :[/color][/bold] Variations, Extrema, Tableau & Références.'' ;
    text id 167 start 1470.8s for 3.5s at (4.5, 83.0) ''[color=#34D399]Passe aux exercices pour ancrer ces réflexes ![/color]'' ;

}
