course "Correction d'exercice classique : Généralités sur les fonctions et lecture graphique" id 30 idgap 1000 for 772.2s audio "narration.wav" {

    # =========================================================
    # SCENE 0 : Accroche & Plan du QCM (0.15s -> 28.70s)
    # =========================================================
    text id 1 start 0.15s for 2.2s at (4.5, 6.5) ''[bold][color=#38BDF8]Entraînement Lycée — Généralités sur les Fonctions[/color][/bold]'' ;
    draw line id 1001 start 2.60s for 0.8s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 2 start 4.08s for 2.8s at (5.0, 20.0) ''[bold][color=#F8FAFC]Objectifs du QCM (5 questions) :[/color][/bold]'' ;
    text id 3 start 8.94s for 2.5s at (5.0, 32.0) ''[color=#34D399]1.[/color] Lire graphiquement une [bold]image[/bold] et des [bold]antécédents[/bold]'' ;
    text id 4 start 12.56s for 2.5s at (5.0, 44.0) ''[color=#34D399]2.[/color] Résoudre graphiquement une [bold]inéquation[/bold]'' ;
    text id 5 start 16.08s for 2.4s at (5.0, 56.0) ''[color=#34D399]3.[/color] Relier une [bold]courbe[/bold] à son [bold]tableau de variations[/bold]'' ;
    text id 6 start 18.72s for 3.2s at (5.0, 68.0) ''[color=#FBBF24]Méthode :[/color] 3 choix (A, B, C) par question, puis correction.'' ;

    draw polygone id 1002 start 22.31s for 0.9s color (56, 189, 248, 0.95) width 2.0 fillcolor (56, 189, 248, 0.15) at [(98.0, 22.0), (168.0, 22.0), (168.0, 76.0), (98.0, 76.0)] ;
    text id 7 start 23.48s for 1.8s at (104.0, 27.0) ''[bold][color=#38BDF8]Programme de l'épreuve :[/color][/bold]'' ;
    text id 8 start 25.50s for 1.4s at (104.0, 40.0) ''[color=#F8FAFC]• Q1 & Q2 : Image & Antécédents[/color]'' ;
    text id 9 start 27.10s for 1.2s at (104.0, 52.0) ''[color=#F8FAFC]• Q3 : Inéquation $f(x) < -1$[/color]'' ;

    erase id 4001 start 28.70s ;

    # =========================================================
    # SCENE 1 : Énoncé Question 1 (28.79s -> 50.31s)
    # =========================================================
    text id 10 start 28.79s at (4.5, 6.5) ''[bold][color=#38BDF8]QCM — Question 1 : Lecture d'une Image[/color][/bold]'' ;
    draw line id 1003 start 29.72s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw 2drep id 1004 start 30.57s for 1.2s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1005 start 32.70s for 1.5s color (56, 189, 248, 1) width 2.8 at 1004 y = x^2 - 6*x + 7 ;
    text id 11 start 34.88s for 3.6s at (5.0, 21.0) ''[bold][color=#F8FAFC]Déterminer graphiquement l'image de $2$ par $f$.[/color][/bold]'' ;
    text id 12 start 40.88s for 1.6s at (5.0, 36.0) ''[color=#FBBF24][bold]A.[/bold][/color] $f(2) = 1$'' ;
    text id 13 start 42.88s for 1.3s at (5.0, 49.0) ''[color=#FBBF24][bold]B.[/bold][/color] $f(2) = -1$'' ;
    text id 14 start 44.48s for 1.4s at (5.0, 62.0) ''[color=#FBBF24][bold]C.[/bold][/color] $f(2) = 5$'' ;
    text id 15 start 46.16s for 2.5s at (5.0, 77.0) ''[italic][color=#34D399]Mets en pause pour chercher ta réponse ![/color][/italic]'' ;

    erase id 4002 start 50.31s ;

    # =========================================================
    # SCENE 2 : Énoncé Question 2 (50.36s -> 73.96s)
    # =========================================================
    text id 16 start 50.36s at (4.5, 6.5) ''[bold][color=#38BDF8]QCM — Question 2 : Lecture d'Antécédents[/color][/bold]'' ;
    draw line id 1006 start 51.36s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw 2drep id 1007 start 52.80s for 1.2s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1008 start 54.42s for 1.5s color (56, 189, 248, 1) width 2.8 at 1007 y = x^2 - 6*x + 7 ;
    text id 17 start 56.78s for 3.6s at (5.0, 21.0) ''[bold][color=#F8FAFC]Déterminer les antécédents de $2$ par $f$.[/color][/bold]'' ;
    text id 18 start 62.64s for 2.5s at (5.0, 36.0) ''[color=#FBBF24][bold]A.[/bold][/color] Un seul antécédent : $-1$'' ;
    text id 19 start 65.92s for 2.2s at (5.0, 49.0) ''[color=#FBBF24][bold]B.[/bold][/color] $2$ et $4$'' ;
    text id 20 start 68.68s for 2.2s at (5.0, 62.0) ''[color=#FBBF24][bold]C.[/bold][/color] $1$ et $5$'' ;
    text id 21 start 71.37s for 2.0s at (5.0, 77.0) ''[italic][color=#34D399]Mets en pause pour noter ta réponse ![/color][/italic]'' ;

    erase id 4003 start 73.96s ;

    # =========================================================
    # SCENE 3 : Énoncé Question 3 (74.00s -> 111.21s)
    # =========================================================
    text id 22 start 74.00s at (4.5, 6.5) ''[bold][color=#38BDF8]QCM — Question 3 : Inéquation Graphique[/color][/bold]'' ;
    draw line id 1009 start 75.16s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 23 start 78.80s for 3.8s at (5.0, 20.0) ''[color=#F8FAFC]Soit $f(x) = x^2 - 6x + 7$[/color]'' ;
    draw 2drep id 1010 start 83.55s for 1.2s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1011 start 85.00s for 1.5s color (56, 189, 248, 1) width 2.8 at 1010 y = x^2 - 6*x + 7 ;
    text id 24 start 88.80s for 4.0s at (5.0, 32.0) ''[bold][color=#34D399]Résoudre :[/color][/bold] $x^2 - 6x + 7 < -1$'' ;
    text id 25 start 97.48s for 2.6s at (5.0, 47.0) ''[color=#FBBF24][bold]A.[/bold][/color] $S = [2 ; 4]$'' ;
    text id 26 start 100.88s for 2.6s at (5.0, 60.0) ''[color=#FBBF24][bold]B.[/bold][/color] $S = ]2 ; 4[$'' ;
    text id 27 start 104.08s for 3.6s at (5.0, 73.0) ''[color=#FBBF24][bold]C.[/bold][/color] $S = ]-\infty ; 2[ \cup ]4 ; +\infty[$'' ;

    erase id 4004 start 111.21s ;

    # =========================================================
    # SCENE 4 : Énoncé Question 4 (111.24s -> 130.75s)
    # =========================================================
    text id 28 start 111.24s at (4.5, 6.5) ''[bold][color=#38BDF8]QCM — Question 4 : Courbe et Tableau de Variations[/color][/bold]'' ;
    draw line id 1012 start 112.10s for 0.4s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw 2drep id 1013 start 112.71s for 1.0s at (130.0, 58.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 5] y_range = [-3, 4] ;
    draw path id 1014 start 114.11s for 1.4s color (52, 211, 153, 1) width 2.8 at [(110.50, 64.50), (112.13, 61.64), (113.75, 54.75), (115.38, 47.86), (117.00, 45.00), (120.25, 46.76), (123.50, 51.50), (126.75, 58.00), (130.00, 64.50), (133.25, 69.26), (136.50, 71.00), (139.75, 68.83), (143.00, 62.88), (146.25, 54.75), (149.50, 46.63), (152.75, 40.67), (156.00, 38.50)] ;
    text id 29 start 116.54s for 2.8s at (5.0, 19.0) ''[bold][color=#F8FAFC]Quel tableau correspond à la courbe ?[/color][/bold]'' ;
    text id 30 start 119.72s for 1.8s at (5.0, 33.0) ''[color=#FBBF24][bold]A.[/bold][/color] $[-3 ; -2]$ : $\searrow$ , $[-2 ; 1]$ : $\nearrow$ , $[1 ; 4]$ : $\searrow$'' ;
    text id 31 start 122.00s for 1.8s at (5.0, 48.0) ''[color=#FBBF24][bold]B.[/bold][/color] $[-1 ; 3]$ : $\nearrow$ , $[3 ; 5]$ : $\searrow$ , $[5 ; 7]$ : $\nearrow$'' ;
    text id 32 start 124.24s for 2.2s at (5.0, 63.0) ''[color=#FBBF24][bold]C.[/bold][/color] $[-3 ; -2]$ : $\nearrow$ , $[-2 ; 1]$ : $\searrow$ , $[1 ; 4]$ : $\nearrow$'' ;
    text id 33 start 127.05s for 2.0s at (5.0, 79.0) ''[italic][color=#34D399]Observe le sens initial et les bornes sur $x$ ![/color][/italic]'' ;

    erase id 4005 start 130.75s ;

    # =========================================================
    # SCENE 5 : Énoncé Question 5 (130.76s -> 160.37s)
    # =========================================================
    text id 34 start 130.76s at (4.5, 6.5) ''[bold][color=#38BDF8]QCM — Question 5 : Exploiter un Tableau de Variations[/color][/bold]'' ;
    draw line id 1015 start 132.12s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw polygone id 1016 start 133.18s for 0.8s color (248, 250, 252, 0.95) width 2.0 fillcolor (56, 189, 248, 0.12) at [(94.0, 24.0), (170.0, 24.0), (170.0, 74.0), (94.0, 74.0)] ;
    draw line id 1017 start 134.31s for 0.4s color (248, 250, 252, 0.9) width 1.6 at [(110.0, 24.0), (110.0, 74.0)] ;
    draw line id 1018 start 134.95s for 0.4s color (248, 250, 252, 0.9) width 1.6 at [(94.0, 38.0), (170.0, 38.0)] ;

    text id 35 start 135.68s at (99.0, 28.0) ''$x$'' ;
    text id 36 start 136.10s at (96.0, 52.0) ''$f(x)$'' ;
    text id 37 start 136.56s at (113.0, 28.0) ''$-5$'' ;
    text id 38 start 137.00s at (130.0, 28.0) ''$1$'' ;
    text id 39 start 137.44s at (147.0, 28.0) ''$3$'' ;
    text id 40 start 137.88s at (162.0, 28.0) ''$10$'' ;

    text id 41 start 138.30s at (113.0, 44.0) ''$-1$'' ;
    text id 42 start 138.65s at (129.0, 64.0) ''$-3$'' ;
    text id 43 start 139.00s at (147.0, 42.0) ''$2$'' ;
    text id 44 start 139.43s at (161.0, 64.0) ''$-5$'' ;

    draw arrow id 1019 start 139.87s for 0.5s color (56, 189, 248, 1) width 2.2 at [(119.0, 48.0), (128.0, 63.0)] ;
    draw arrow id 1020 start 140.68s for 0.5s color (52, 211, 153, 1) width 2.2 at [(135.0, 63.0), (146.0, 46.0)] ;
    draw arrow id 1021 start 141.41s for 0.5s color (56, 189, 248, 1) width 2.2 at [(151.0, 46.0), (160.0, 63.0)] ;

    text id 45 start 142.63s for 2.8s at (5.0, 21.0) ''[bold][color=#F8FAFC]Laquelle est toujours exacte ?[/color][/bold]'' ;
    text id 46 start 146.40s for 2.8s at (5.0, 36.0) ''[color=#FBBF24][bold]A.[/bold][/color] $-4$ possède un seul antécédent'' ;
    text id 47 start 150.08s for 3.0s at (5.0, 50.0) ''[color=#FBBF24][bold]B.[/bold][/color] L'image de $2$ est supérieure à $1$'' ;
    text id 48 start 154.20s for 3.0s at (5.0, 64.0) ''[color=#FBBF24][bold]C.[/bold][/color] $0$ possède trois antécédents'' ;

    erase id 4006 start 160.37s ;

    # =========================================================
    # SCENE 6 : Bilan des Solutions (160.40s -> 182.19s)
    # =========================================================
    text id 49 start 160.40s at (4.5, 6.5) ''[bold][color=#34D399]Bilan des Réponses au QCM[/color][/bold]'' ;
    draw line id 1022 start 161.30s for 0.6s color (52, 211, 153, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 50 start 163.28s for 1.8s at (5.0, 21.0) ''[bold][color=#F8FAFC]Question 1 :[/color][/bold]  [color=#34D399][bold]Réponse B[/bold][/color]  ($f(2) = -1$)'' ;
    text id 51 start 165.68s for 2.0s at (5.0, 33.0) ''[bold][color=#F8FAFC]Question 2 :[/color][/bold]  [color=#34D399][bold]Réponse C[/bold][/color]  ($1$ et $5$)'' ;
    text id 52 start 168.35s for 2.0s at (5.0, 45.0) ''[bold][color=#F8FAFC]Question 3 :[/color][/bold]  [color=#34D399][bold]Réponse B[/bold][/color]  ($]2 ; 4[$)'' ;
    text id 53 start 170.92s for 2.0s at (5.0, 57.0) ''[bold][color=#F8FAFC]Question 4 :[/color][/bold]  [color=#34D399][bold]Réponse C[/bold][/color]  (croissante sur $[-3 ; -2]$)'' ;
    text id 54 start 173.68s for 2.5s at (5.0, 69.0) ''[bold][color=#F8FAFC]Question 5 :[/color][/bold]  [color=#34D399][bold]Réponse A[/bold][/color]  ($-4$ a 1 antécédent)'' ;

    draw polygone id 1023 start 177.32s for 0.8s color (52, 211, 153, 0.95) width 2.0 fillcolor (52, 211, 153, 0.14) at [(100.0, 26.0), (168.0, 26.0), (168.0, 72.0), (100.0, 72.0)] ;
    text id 55 start 178.43s for 2.8s at (105.0, 36.0) ''[bold][color=#34D399]Correction Détaillée[/color][/bold]'' ;
    text id 56 start 181.45s at (105.0, 52.0) ''[color=#F8FAFC]Étape par étape au tableau[/color]'' ;

    erase id 4007 start 182.19s ;

    # =========================================================
    # SCENE 7 : Correction Question 1 (182.20s -> 229.63s)
    # =========================================================
    text id 57 start 182.20s for 1.8s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q1 : Lire l'Image de $2$[/color][/bold]'' ;
    draw line id 1024 start 184.52s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 58 start 185.37s for 2.6s at (5.0, 20.0) ''[color=#34D399][bold]Réponse B :[/bold][/color] $f(2) = -1$'' ;
    draw 2drep id 1025 start 189.84s for 1.1s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1026 start 191.25s for 1.4s color (56, 189, 248, 1) width 2.8 at 1025 y = x^2 - 6*x + 7 ;
    text id 59 start 193.80s for 3.5s at (5.0, 33.0) ''[color=#FBBF24]1.[/color] Repérer $x = 2$ sur l'axe des abscisses'' ;
    draw circle id 1027 start 199.50s for 0.6s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.22) at (126.0, 62.0) radius 1.1 ;
    draw arrow id 1028 start 207.28s for 1.2s color (251, 191, 36, 1) width 2.6 at [(126.0, 62.0), (126.0, 69.0)] ;
    draw circle id 1029 start 211.82s for 0.6s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.25) at (126.0, 69.0) radius 1.1 ;
    text id 60 start 213.72s for 2.2s at (5.0, 47.0) ''[color=#34D399]2.[/color] Rejoindre la courbe puis lire $y$'' ;
    draw arrow id 1030 start 216.23s for 1.2s color (52, 211, 153, 1) width 2.6 at [(126.0, 69.0), (112.0, 69.0)] ;
    mouse move id 3001 start 219.33s for 1.2s at [(126.0, 69.0), (112.0, 69.0)] ;
    draw circle id 1031 start 222.90s for 0.6s color (248, 113, 113, 1) width 2.5 fillcolor (248, 113, 113, 0.25) at (112.0, 69.0) radius 1.1 ;
    text id 61 start 225.18s for 2.8s at (5.0, 63.0) ''[bold][color=#34D399]Conclusion : $$f(2) = -1$$[/color][/bold]'' ;

    erase id 4008 start 229.63s ;

    # =========================================================
    # SCENE 8 : Correction Question 2 (229.64s -> 288.51s)
    # =========================================================
    text id 62 start 229.64s for 1.8s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q2 : Trouver les Antécédents de $2$[/color][/bold]'' ;
    draw line id 1032 start 231.92s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 63 start 232.75s for 3.0s at (5.0, 20.0) ''[color=#FBBF24][bold]Principe inverse :[/bold][/color] on donne $y = 2$, on cherche $x$.'' ;
    draw 2drep id 1033 start 238.60s for 1.2s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1034 start 240.40s for 1.5s color (56, 189, 248, 1) width 2.8 at 1033 y = x^2 - 6*x + 7 ;
    text id 64 start 250.84s for 3.2s at (5.0, 33.0) ''[color=#34D399]1.[/color] Repérer $y = 2$ sur l'axe des ordonnées'' ;
    draw line id 1035 start 254.71s for 1.2s color (251, 191, 36, 1) width 2.4 at [(105.0, 48.0), (161.0, 48.0)] ;
    text id 65 start 256.55s for 2.2s at (112.0, 18.5) ''[color=#FBBF24]Droite horizontale $y = 2$[/color]'' ;
    text id 66 start 261.08s for 3.2s at (5.0, 46.0) ''[color=#34D399]2.[/color] Lire les abscisses des intersections'' ;
    draw circle id 1036 start 273.64s for 0.5s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.25) at (119.0, 48.0) radius 1.1 ;
    draw arrow id 1037 start 275.44s for 1.0s color (52, 211, 153, 1) width 2.5 at [(119.0, 48.0), (119.0, 62.0)] ;
    draw circle id 1038 start 277.04s for 0.5s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.25) at (147.0, 48.0) radius 1.1 ;
    draw arrow id 1039 start 278.04s for 1.2s color (52, 211, 153, 1) width 2.5 at [(147.0, 48.0), (147.0, 62.0)] ;
    text id 67 start 280.99s for 3.0s at (5.0, 59.0) ''Vérification : $f(1) = 2$ et $f(5) = 2$'' ;
    text id 68 start 284.80s for 2.8s at (5.0, 73.0) ''[bold][color=#34D399]Réponse C : antécédents $1$ et $5$[/color][/bold]'' ;

    erase id 4009 start 288.51s ;

    # =========================================================
    # SCENE 9 : Correction Q3 Partie 1 (288.52s -> 415.26s)
    # =========================================================
    text id 69 start 288.52s for 2.0s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q3 : Résoudre $f(x) < -1$[/color][/bold]'' ;
    draw line id 1040 start 291.16s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 70 start 294.12s for 3.4s at (5.0, 20.0) ''$x^2 - 6x + 7 < -1 \iff f(x) < -1$'' ;
    text id 71 start 317.56s for 3.4s at (5.0, 32.0) ''Chercher $x$ tel que la courbe soit [bold]sous $-1$[/bold]'' ;
    draw 2drep id 1041 start 329.04s for 1.2s at (112.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 7] y_range = [-3, 5] ;
    draw 2dfunc id 1042 start 330.71s for 1.4s color (56, 189, 248, 1) width 2.8 at 1041 y = x^2 - 6*x + 7 ;
    draw line id 1043 start 332.60s for 1.2s color (248, 113, 113, 1) width 2.5 at [(105.0, 69.0), (161.0, 69.0)] ;
    text id 72 start 335.11s for 2.2s at (112.0, 18.5) ''[color=#F87171]Droite limite : $y = -1$[/color]'' ;
    draw circle id 1044 start 352.96s for 0.6s color (248, 113, 113, 1) width 2.4 fillcolor (248, 113, 113, 0.25) at (122.5, 60.25) radius 1.1 ;
    text id 73 start 358.99s for 3.2s at (5.0, 44.0) ''[color=#F87171]Essai $x = 1{,}5$ :[/color] $f(1{,}5) = 0{,}25 > -1$ (rejeté)'' ;
    draw circle id 1045 start 366.65s for 0.6s color (52, 211, 153, 1) width 2.4 fillcolor (52, 211, 153, 0.25) at (129.5, 74.25) radius 1.1 ;
    text id 74 start 372.52s for 3.4s at (5.0, 56.0) ''[color=#34D399]Essai $x = 2{,}5$ :[/color] $f(2{,}5) = -1{,}75 < -1$ (validé)'' ;
    draw circle id 1046 start 382.00s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (126.0, 69.0) radius 1.0 ;
    draw circle id 1047 start 383.30s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (140.0, 69.0) radius 1.0 ;
    text id 75 start 384.44s for 3.2s at (5.0, 68.0) ''[color=#38BDF8]Zone sous $y = -1$ :[/color] entre $x = 2$ et $x = 4$'' ;
    draw arrow id 1048 start 395.20s for 0.8s color (52, 211, 153, 1) width 2.2 at [(126.0, 69.0), (126.0, 62.0)] ;
    draw arrow id 1049 start 396.58s for 0.8s color (52, 211, 153, 1) width 2.2 at [(140.0, 69.0), (140.0, 62.0)] ;
    draw line id 1050 start 399.56s for 1.2s color (52, 211, 153, 1) width 4.5 at [(126.0, 62.0), (140.0, 62.0)] ;
    text id 76 start 410.24s for 2.8s at (5.0, 80.0) ''[bold][color=#FBBF24]Reste à trancher :[/color][/bold] prend-on $2$ et $4$ ?'' ;

    erase id 4010 start 415.26s ;

    # =========================================================
    # SCENE 10 : Correction Q3 Partie 2 (415.27s -> 480.47s)
    # =========================================================
    text id 77 start 415.27s for 2.0s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q3 : Bornes Ouvertes ou Fermées ?[/color][/bold]'' ;
    draw line id 1051 start 417.84s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 78 start 421.76s for 3.2s at (5.0, 21.0) ''Hésitation : $[2 ; 4]$ (A) ou $]2 ; 4[$ (B) ?'' ;
    text id 79 start 427.96s for 3.2s at (5.0, 34.0) ''[color=#F87171]Éliminé :[/color] C ($]-\infty ; 2[ \cup ]4 ; +\infty[$) car $f(x) > -1$'' ;
    text id 80 start 443.72s for 3.6s at (5.0, 48.0) ''[color=#FBBF24][bold]Inégalité stricte :[/bold][/color] $f(x) < -1$ (on exclut $-1$)'' ;

    draw arrow id 1052 start 452.00s for 1.0s color (248, 250, 252, 0.95) width 2.2 at [(98.0, 56.0), (168.0, 56.0)] ;
    text id 81 start 453.36s at (116.5, 64.0) ''$2$'' ;
    text id 82 start 454.98s at (146.5, 64.0) ''$4$'' ;
    draw line id 1053 start 456.64s for 1.0s color (52, 211, 153, 1) width 5.0 at [(118.0, 56.0), (148.0, 56.0)] ;
    text id 83 start 461.32s for 2.6s at (5.0, 62.0) ''Or $f(2) = -1$ et $f(4) = -1$ : bornes [color=#F87171][bold]exclues[/bold][/color] !'' ;
    draw path id 1054 start 468.99s for 0.8s color (248, 113, 113, 1) width 3.0 at [(115.0, 50.0), (118.0, 50.0), (118.0, 62.0), (115.0, 62.0)] ;
    draw path id 1055 start 470.31s for 0.8s color (248, 113, 113, 1) width 3.0 at [(151.0, 50.0), (148.0, 50.0), (148.0, 62.0), (151.0, 62.0)] ;
    text id 84 start 475.36s for 3.2s at (5.0, 76.0) ''[bold][color=#34D399]Réponse B : $$S = ]2 ; 4[$$[/color][/bold]'' ;

    erase id 4011 start 480.47s ;

    # =========================================================
    # SCENE 11 : Correction Question 4 (480.48s -> 568.91s)
    # =========================================================
    text id 85 start 480.48s for 1.8s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q4 : Courbe et Tableau de Variations[/color][/bold]'' ;
    draw line id 1056 start 482.84s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw 2drep id 1057 start 484.38s for 1.2s at (130.0, 58.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 5] y_range = [-3, 4] ;
    draw path id 1058 start 485.82s for 1.4s color (56, 189, 248, 1) width 2.8 at [(110.50, 64.50), (112.13, 61.64), (113.75, 54.75), (115.38, 47.86), (117.00, 45.00), (120.25, 46.76), (123.50, 51.50), (126.75, 58.00), (130.00, 64.50), (133.25, 69.26), (136.50, 71.00), (139.75, 68.83), (143.00, 62.88), (146.25, 54.75), (149.50, 46.63), (152.75, 40.67), (156.00, 38.50)] ;

    text id 86 start 487.80s for 2.2s at (5.0, 20.0) ''[color=#F8FAFC][bold]A.[/bold] $[-3 ; -2]$ : $\searrow$ (décroissante)[/color]'' ;
    text id 87 start 490.40s for 2.2s at (5.0, 34.0) ''[color=#F8FAFC][bold]B.[/bold] $[-1 ; 3]$ : $\nearrow$ (croissante)[/color]'' ;
    text id 88 start 493.00s for 2.2s at (5.0, 48.0) ''[color=#F8FAFC][bold]C.[/bold] $[-3 ; -2]$ : $\nearrow$ , $[-2 ; 1]$ : $\searrow$ , $[1 ; 4]$ : $\nearrow$[/color]'' ;

    draw arrow id 1059 start 508.84s for 1.0s color (52, 211, 153, 1) width 2.8 at [(110.5, 64.5), (117.0, 45.0)] ;
    text id 89 start 512.52s for 2.5s at (5.0, 62.0) ''[color=#F87171][bold]A éliminé :[/bold][/color] la courbe monte au départ ($\nearrow$)'' ;

    draw circle id 1060 start 537.87s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (110.5, 64.5) radius 1.0 ;
    draw circle id 1061 start 541.42s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (117.0, 45.0) radius 1.0 ;
    draw circle id 1062 start 544.14s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (136.5, 71.0) radius 1.0 ;
    draw circle id 1063 start 546.08s for 0.5s color (251, 191, 36, 1) width 2.4 fillcolor (251, 191, 36, 0.25) at (156.0, 38.5) radius 1.0 ;

    text id 90 start 547.72s for 2.6s at (108.0, 22.0) ''[color=#FBBF24]Croissante sur $[-3 ; -2]$[/color]'' ;
    text id 91 start 553.38s for 2.8s at (5.0, 74.0) ''[color=#F87171][bold]B faux :[/bold][/color] bornes $[-1 ; 3] \ne [-3 ; -2]$'' ;
    text id 92 start 564.68s for 2.8s at (5.0, 85.0) ''[bold][color=#34D399]Réponse C validée ![/color][/bold]'' ;

    erase id 4012 start 568.91s ;

    # =========================================================
    # SCENE 12 : Correction Q5 Partie 1 (568.92s -> 630.37s)
    # =========================================================
    text id 93 start 568.92s for 2.0s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q5 : Tracer une Courbe depuis le Tableau[/color][/bold]'' ;
    draw line id 1064 start 571.20s for 0.6s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    draw 2drep id 1065 start 578.02s for 1.2s at (123.0, 49.0) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 11] y_range = [-6, 3] ;

    text id 94 start 585.88s for 2.8s at (5.0, 20.0) ''[bold][color=#FBBF24]Tableau sur $[-5 ; 10]$ :[/color][/bold] $(-5 ; -1) \searrow (1 ; -3) \nearrow (3 ; 2) \searrow (10 ; -5)$'' ;
    text id 95 start 590.64s for 2.5s at (5.0, 34.0) ''[color=#38BDF8]1.[/color] Point de départ : $(-5 ; -1)$'' ;
    draw circle id 1066 start 594.24s for 0.6s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) at (103.0, 53.0) radius 1.1 ;

    text id 96 start 600.92s for 2.6s at (5.0, 47.0) ''[color=#38BDF8]2.[/color] Décroissante jusqu'à $(1 ; -3)$'' ;
    draw circle id 1067 start 604.95s for 0.5s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) at (127.0, 61.0) radius 1.1 ;
    draw path id 1068 start 606.55s for 1.2s color (56, 189, 248, 1) width 2.8 at [(103.0, 53.0), (109.0, 54.17), (115.0, 57.0), (121.0, 59.83), (127.0, 61.0)] ;

    text id 97 start 611.27s for 2.6s at (5.0, 60.0) ''[color=#34D399]3.[/color] Croissante jusqu'à $(3 ; 2)$'' ;
    draw circle id 1069 start 614.96s for 0.5s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) at (135.0, 41.0) radius 1.1 ;
    draw path id 1070 start 616.31s for 1.2s color (52, 211, 153, 1) width 2.8 at [(127.0, 61.0), (129.0, 57.0), (131.0, 51.0), (131.8, 49.0), (133.0, 44.6), (135.0, 41.0)] ;

    text id 98 start 619.66s for 2.8s at (5.0, 73.0) ''[color=#38BDF8]4.[/color] Décroissante jusqu'à $(10 ; -5)$'' ;
    draw circle id 1071 start 623.33s for 0.5s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) at (163.0, 69.0) radius 1.1 ;
    draw path id 1072 start 625.60s for 1.4s color (56, 189, 248, 1) width 2.8 at [(135.0, 41.0), (137.0, 42.2), (139.8, 45.4), (143.0, 49.0), (151.0, 57.0), (159.0, 65.0), (163.0, 69.0)] ;

    erase id 4013 start 630.37s ;

    # =========================================================
    # SCENE 13 : Correction Q5 Partie 2 & Synthèse (630.38s -> 772.2s)
    # =========================================================
    text id 99 start 630.38s for 1.8s at (4.5, 6.5) ''[bold][color=#38BDF8]Correction Q5 : Vérification des Affirmations[/color][/bold]'' ;
    draw line id 1073 start 632.47s for 0.5s color (56, 189, 248, 0.9) width 2.0 at [(4.0, 13.0), (173.0, 13.0)] ;
    text id 100 start 633.83s for 3.0s at (5.0, 20.0) ''[bold][color=#34D399]A. $-4$ a un seul antécédent :[/bold][/color]'' ;
    draw 2drep id 1074 start 638.04s for 1.1s at (123.0, 49.0) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-6, 11] y_range = [-6, 3] ;
    draw path id 1075 start 639.40s for 1.2s color (56, 189, 248, 1) width 2.8 at [(103.0, 53.0), (109.0, 54.17), (115.0, 57.0), (121.0, 59.83), (127.0, 61.0), (129.0, 57.0), (131.0, 51.0), (131.8, 49.0), (133.0, 44.6), (135.0, 41.0), (137.0, 42.2), (139.8, 45.4), (143.0, 49.0), (151.0, 57.0), (159.0, 65.0), (163.0, 69.0)] ;
    draw line id 1076 start 642.43s for 1.2s color (52, 211, 153, 1) width 2.4 at [(99.0, 65.0), (167.0, 65.0)] ;
    text id 101 start 646.26s for 2.2s at (106.0, 77.0) ''[color=#34D399]Droite $y = -4$ : $1$ seule intersection[/color]'' ;
    draw circle id 1077 start 665.44s for 0.6s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.28) at (159.0, 65.0) radius 1.2 ;
    text id 102 start 673.80s for 2.0s at (5.0, 31.0) ''[color=#34D399][bold]VRAI :[/bold][/color] $1$ seule coupe sur $[3 ; 10]$ ($y = -4$)'' ;

    text id 103 start 680.28s for 3.2s at (5.0, 44.0) ''[bold][color=#FBBF24]B. $f(2) > 1$ toujours ?[/color][/bold]'' ;
    draw line id 1078 start 685.23s for 0.8s color (251, 191, 36, 0.9) width 2.0 at [(99.0, 45.0), (167.0, 45.0)] ;
    draw circle id 1079 start 697.52s for 0.6s color (248, 113, 113, 1) width 2.5 fillcolor (248, 113, 113, 0.25) at (131.0, 51.0) radius 1.1 ;
    text id 104 start 715.18s for 3.2s at (5.0, 55.0) ''[color=#F87171][bold]FAUX :[/bold][/color] contre-exemple $f(2) \approx -0{,}5 < 1$'' ;

    text id 105 start 723.46s for 3.2s at (5.0, 68.0) ''[bold][color=#C084FC]C. $0$ a $3$ antécédents ?[/color][/bold]'' ;
    draw circle id 1080 start 748.75s for 0.6s color (192, 132, 252, 1) width 2.5 fillcolor (192, 132, 252, 0.25) at (131.8, 49.0) radius 1.1 ;
    draw circle id 1081 start 755.63s for 0.6s color (192, 132, 252, 1) width 2.5 fillcolor (192, 132, 252, 0.25) at (143.0, 49.0) radius 1.1 ;
    text id 106 start 758.77s for 3.2s at (5.0, 79.0) ''[color=#F87171][bold]FAUX :[/bold][/color] $y = 0$ coupe $2$ fois (pas $3$)'' ;
    text id 107 start 763.92s for 3.5s at (106.0, 24.0) ''[bold][color=#38BDF8]Réflexe :[/color][/bold] tracer une courbe compatible !'' ;
}
