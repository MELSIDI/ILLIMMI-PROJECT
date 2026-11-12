course "Généralités sur les fonctions et lecture graphique" id 22 idgap 500 for 718s audio "narration.wav" {

    # ========================================================
    # SCÈNE 1 : Introduction & Les deux axes du repère (0s - 114s)
    # ========================================================
    text id 1 start 0.6s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]1. Introduction : Généralités sur les fonctions & Repère du plan[/color][/bold]'' ;

    draw line id 501 start 2.8s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 8.0s for 3.2s at (5.0, 20.0)
         ''[color=#F8FAFC]Objectif Lycée : Déterminer [color=#38BDF8]images[/color], [color=#34D399]antécédents[/color] et [color=#FBBF24]extremums[/color][/color]'' ;

    text id 3 start 23.0s for 3.0s at (5.0, 32.0)
         ''[color=#FBBF24]Cas concret :[/color] [color=#F8FAFC]On étudie la courbe $\mathcal{C}_f$ sans formule algébrique[/color]'' ;

    draw 2drep id 502 start 51.5s for 1.5s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    text id 8 start 54.0s for 1.2s at (161.0, 53.0)
         ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;

    text id 9 start 56.0s for 1.2s at (126.0, 19.0)
         ''[color=#34D399]$y = f(x)$[/color]'' ;

    text id 4 start 58.0s for 3.5s at (5.0, 44.0)
         ''[bold][color=#38BDF8]Axe horizontal (Abscisses) :[/color][/bold] [color=#F8FAFC]Valeurs de la variable $x$ (entrée)[/color]'' ;

    text id 5 start 69.0s for 3.5s at (5.0, 56.0)
         ''[bold][color=#34D399]Axe vertical (Ordonnées) :[/color][/bold] [color=#F8FAFC]Valeurs de sortie $f(x)$ (images)[/color]'' ;

    text id 6 start 79.0s for 2.0s at (5.0, 68.0)
         ''[color=#F8FAFC]Machine fonctionnelle : [/color] [color=#38BDF8]$x$[/color] [color=#F8FAFC]$\xrightarrow{\quad f \quad}$[/color] [color=#34D399]$f(x)$[/color]'' ;

    draw 2dfunc id 503 start 82.0s for 2.0s
         color (56, 189, 248, 1) width 2.5
         at 502 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 10 start 85.0s at (160.0, 36.0)
         ''[bold][color=#38BDF8]$\mathcal{C}_f$[/color][/bold]'' ;

    text id 7 start 95.0s for 3.0s at (5.0, 80.0)
         ''[color=#F8FAFC]Tout point $M \in \mathcal{C}_f$ a pour coordonnées : [color=#FBBF24]$M(x ; f(x))$[/color][/color]'' ;

    erase id 2001 start 114.0s ;

    # ========================================================
    # SCÈNE 2 : Première image : f(2) = -1 (114s - 184s)
    # ========================================================
    text id 11 start 115.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]2. Déterminer une image : Cas $x = 2 \implies f(2) = -1$[/color][/bold]'' ;

    draw line id 504 start 117.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 505 start 118.5s for 1.2s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    draw 2dfunc id 506 start 120.0s for 1.5s
         color (56, 189, 248, 1) width 2.5
         at 505 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 12 start 122.5s for 2.5s at (5.0, 20.0)
         ''[color=#FBBF24]Question 1a :[/color] [color=#F8FAFC]Que vaut l'image de $2$ par $f$ ?[/color]'' ;

    text id 13 start 128.5s for 2.5s at (5.0, 32.0)
         ''[color=#F8FAFC]On pose la variable d'entrée : [color=#38BDF8]$x = 2$[/color][/color]'' ;

    text id 14 start 137.0s for 1.2s at (5.0, 44.0)
         ''[color=#38BDF8]1. Départ :[/color] [color=#F8FAFC]Sur l'axe des abscisses à $x = 2$[/color]'' ;

    draw circle id 507 start 138.5s for 0.6s
         color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) width 2
         radius 1.2 at (146.0, 55.0) ;

    draw arrow id 508 start 142.0s for 1.0s
         color (251, 191, 36, 1) width 2
         at [(146.0, 55.0), (146.0, 61.5)] ;

    text id 15 start 144.5s for 2.5s at (5.0, 56.0)
         ''[color=#38BDF8]2. Trajet :[/color] [color=#F8FAFC]Descendre verticalement vers $\mathcal{C}_f$[/color]'' ;

    draw circle id 509 start 148.5s for 0.6s
         color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) width 2
         radius 1.4 at (146.0, 61.5) ;

    draw arrow id 510 start 152.0s for 0.8s
         color (52, 211, 153, 1) width 2
         at [(146.0, 61.5), (133.0, 61.5)] ;

    text id 16 start 153.0s for 2.5s at (5.0, 68.0)
         ''[color=#34D399]3. Arrivée :[/color] [color=#F8FAFC]Projeter horizontalement vers l'axe $y$[/color]'' ;

    draw circle id 511 start 158.0s for 0.6s
         color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) width 2
         radius 1.2 at (133.0, 61.5) ;

    text id 18 start 160.0s at (160.0, 60.0)
         ''[bold][color=#34D399]$y = -1$[/color][/bold]'' ;

    text id 17 start 166.0s for 3.0s at (5.0, 80.0)
         ''[bold][color=#34D399]Conclusion : $\mathbf{f(2) = -1}$[/color][/bold] [color=#F8FAFC](Point $P(2 ; -1)$)[/color]'' ;

    erase id 2002 start 184.0s ;

    # ========================================================
    # SCÈNE 3 : Images de -2 et 3 : f(-2) = 1 et f(3) = 0 (184s - 288s)
    # ========================================================
    text id 19 start 185.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]3. Images de nombres négatifs et nuls : $f(-2) = 1$ et $f(3) = 0$[/color][/bold]'' ;

    draw line id 512 start 187.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 513 start 188.5s for 1.2s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    draw 2dfunc id 514 start 190.0s for 1.5s
         color (56, 189, 248, 1) width 2.5
         at 513 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 20 start 193.0s for 2.5s at (5.0, 20.0)
         ''[color=#FBBF24]Premier cas :[/color] [color=#F8FAFC]Image de $-2 \implies x = -2$[/color]'' ;

    draw circle id 515 start 203.8s for 0.5s
         color (56, 189, 248, 1) width 2 radius 1.2 at (120.0, 55.0) ;

    draw arrow id 516 start 205.0s for 0.6s
         color (251, 191, 36, 1) width 2
         at [(120.0, 55.0), (120.0, 48.5)] ;

    text id 21 start 206.0s for 2.5s at (5.0, 31.0)
         ''[color=#F8FAFC]Monter verticalement vers $\mathcal{C}_f$ : [color=#38BDF8]Point $(-2 ; 1)$[/color][/color]'' ;

    draw circle id 517 start 210.0s for 0.5s
         color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) width 2
         radius 1.4 at (120.0, 48.5) ;

    draw arrow id 518 start 213.0s for 0.8s
         color (52, 211, 153, 1) width 2
         at [(120.0, 48.5), (133.0, 48.5)] ;

    text id 27 start 217.0s at (160.0, 47.0)
         ''[bold][color=#34D399]$y = 1$[/color][/bold]'' ;

    text id 22 start 222.0s for 2.5s at (5.0, 42.0)
         ''[bold][color=#34D399]Résultat : $\mathbf{f(-2) = 1}$[/color][/bold]'' ;

    text id 23 start 237.0s for 2.5s at (5.0, 53.0)
         ''[color=#FBBF24]Deuxième cas :[/color] [color=#F8FAFC]Image de $3 \implies x = 3$[/color]'' ;

    draw circle id 519 start 242.0s for 0.6s
         color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) width 2
         radius 1.2 at (152.5, 55.0) ;

    text id 24 start 245.5s for 2.0s at (5.0, 64.0)
         ''[color=#F8FAFC]La courbe coupe l'axe horizontal en $x = 3$ ![/color]'' ;

    draw circle id 520 start 250.0s for 0.6s
         color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) width 2
         radius 1.4 at (152.5, 55.0) ;

    text id 28 start 253.0s at (160.0, 56.0)
         ''[bold][color=#F87171]$A(3 ; 0)$[/color][/bold]'' ;

    text id 25 start 264.0s for 2.5s at (5.0, 74.0)
         ''[bold][color=#34D399]Résultat : $\mathbf{f(3) = 0}$[/color][/bold] [color=#F8FAFC](Point $A(3 ; 0)$)[/color]'' ;

    text id 26 start 277.0s for 3.0s at (5.0, 85.0)
         ''[bold][color=#FBBF24]Règle d'or :[/color][/bold] [color=#F8FAFC]Image $\implies x \to \text{courbe} \to y = f(x)$ (unique)[/color]'' ;

    erase id 2003 start 288.0s ;

    # ========================================================
    # SCÈNE 4 : Antécédents de 3 : f(x) = 3 (288s - 380s)
    # ========================================================
    text id 29 start 289.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]4. Déterminer un antécédent : Résoudre graphiquement $f(x) = 3$[/color][/bold]'' ;

    draw line id 521 start 291.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 522 start 292.5s for 1.2s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    draw 2dfunc id 523 start 294.0s for 1.5s
         color (56, 189, 248, 1) width 2.5
         at 522 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 30 start 297.0s for 2.5s at (5.0, 20.0)
         ''[color=#FBBF24]Question 2a :[/color] [color=#F8FAFC]Quels sont les antécédents de $3$ par $f$ ?[/color]'' ;

    text id 31 start 305.0s for 3.0s at (5.0, 32.0)
         ''[color=#F8FAFC]On cherche $x$ tel que la sortie soit : [color=#34D399]$f(x) = 3$[/color][/color]'' ;

    text id 32 start 325.5s for 2.5s at (5.0, 44.0)
         ''[color=#34D399]1. Départ :[/color] [color=#F8FAFC]Sur l'axe des ordonnées à $y = 3$[/color]'' ;

    draw circle id 524 start 329.0s for 0.6s
         color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) width 2
         radius 1.2 at (133.0, 35.5) ;

    draw arrow id 525 start 333.0s for 1.0s
         color (52, 211, 153, 1) width 2
         at [(133.0, 35.5), (113.5, 35.5)] ;

    text id 33 start 338.0s for 3.0s at (5.0, 56.0)
         ''[color=#38BDF8]2. Trajet :[/color] [color=#F8FAFC]Ligne horizontale vers la gauche jusqu'à $\mathcal{C}_f$[/color]'' ;

    draw circle id 526 start 345.0s for 0.6s
         color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.8) width 2
         radius 1.4 at (113.5, 35.5) ;

    draw arrow id 527 start 349.0s for 1.0s
         color (251, 191, 36, 1) width 2
         at [(113.5, 35.5), (113.5, 55.0)] ;

    text id 34 start 355.0s for 3.0s at (5.0, 68.0)
         ''[color=#38BDF8]3. Arrivée :[/color] [color=#F8FAFC]Descendre verticalement vers l'axe $x$[/color]'' ;

    draw circle id 528 start 361.0s for 0.6s
         color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) width 2
         radius 1.2 at (113.5, 55.0) ;

    text id 36 start 363.0s at (110.0, 76.0)
         ''[bold][color=#38BDF8]$x = -3$[/color][/bold]'' ;

    text id 35 start 366.0s for 3.0s at (5.0, 80.0)
         ''[bold][color=#34D399]Conclusion : Un antécédent de $3$ est $-3$[/color][/bold] [color=#F8FAFC]($f(-3) = 3$)[/color]'' ;

    erase id 2004 start 380.0s ;

    # ========================================================
    # SCÈNE 5 : Antécédents multiples : f(x) = 0 (380s - 471s)
    # ========================================================
    text id 37 start 381.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]5. Antécédents multiples : Résoudre graphiquement $f(x) = 0$[/color][/bold]'' ;

    draw line id 529 start 383.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 530 start 384.5s for 1.2s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    draw 2dfunc id 531 start 386.0s for 1.5s
         color (56, 189, 248, 1) width 2.5
         at 530 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 38 start 389.0s for 2.5s at (5.0, 20.0)
         ''[color=#FBBF24]Question 2b :[/color] [color=#F8FAFC]Quels sont les antécédents de $0$ par $f$ ?[/color]'' ;

    text id 39 start 394.0s for 2.5s at (5.0, 31.0)
         ''[color=#F8FAFC]On cherche les points d'intersection avec la droite : [color=#34D399]$y = 0$[/color][/color]'' ;

    draw line id 532 start 398.0s for 1.2s
         color (251, 191, 36, 0.9) width 2.5
         at [(107.0, 55.0), (159.0, 55.0)] ;

    text id 40 start 409.0s at (5.0, 42.0)
         ''[color=#38BDF8]1er point :[/color] [color=#F8FAFC]$x_1 = 3$ car $f(3) = 0$ (chemin réciproque)[/color]'' ;

    draw circle id 533 start 410.0s for 0.6s
         color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.8) width 2
         radius 1.5 at (152.5, 55.0) ;

    text id 44 start 412.0s at (160.0, 54.0)
         ''[bold][color=#34D399]$x_1 = 3$[/color][/bold]'' ;

    text id 41 start 423.0s for 3.0s at (5.0, 53.0)
         ''[bold][color=#FBBF24]Attention :[/color][/bold] [color=#F8FAFC]Un nombre peut avoir plusieurs antécédents ![/color]'' ;

    text id 42 start 443.0s for 1.5s at (5.0, 64.0)
         ''[color=#38BDF8]2e point :[/color] [color=#F8FAFC]À gauche, intersection à environ [color=#FBBF24]$x_2 \approx -1{,}5$[/color][/color]'' ;

    draw circle id 534 start 445.0s for 0.6s
         color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.8) width 2
         radius 1.5 at (123.25, 55.0) ;

    text id 45 start 447.0s at (116.0, 76.0)
         ''[bold][color=#FBBF24]$x_2 \approx -1{,}5$[/color][/bold]'' ;

    text id 43 start 460.0s for 3.0s at (5.0, 76.0)
         ''[bold][color=#34D399]Conclusion : $0$ admet 2 antécédents : $\mathbf{3}$ et $\mathbf{-1{,}5}$[/color][/bold]'' ;

    erase id 2005 start 471.0s ;

    # ========================================================
    # SCÈNE 6 : Maximum de la fonction et extremum (471s - 579s)
    # ========================================================
    text id 46 start 472.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]6. Extremum : Maximum de la fonction & Abscisse associée[/color][/bold]'' ;

    draw line id 535 start 474.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 536 start 475.5s for 1.2s
         at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5
         grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;

    draw 2dfunc id 537 start 477.0s for 1.5s
         color (56, 189, 248, 1) width 2.5
         at 536 y = 0.3 * x^2 - 0.5 * x - 1.2 ;

    text id 47 start 481.0s for 3.0s at (5.0, 20.0)
         ''[bold][color=#FBBF24]Définition :[/color][/bold] [color=#F8FAFC]Le maximum est la plus grande ordonnée $f(x)$ atteinte[/color]'' ;

    text id 48 start 503.0s for 3.0s at (5.0, 31.0)
         ''[color=#38BDF8]Balayage vertical :[/color] [color=#F8FAFC]On cherche la crête la plus haute de la courbe[/color]'' ;

    text id 49 start 511.0s for 1.5s at (5.0, 42.0)
         ''[color=#F87171]Niveau $y = 4$ :[/color] [color=#F8FAFC]Aucun point sur $\mathcal{C}_f \implies$ valeur jamais atteinte[/color]'' ;

    draw line id 538 start 513.0s for 1.0s
         color (248, 113, 113, 0.6) width 1.5
         at [(107.0, 29.0), (159.0, 29.0)] ;

    text id 53 start 515.0s at (140.0, 19.0)
         ''[color=#F87171]$y = 4$ (impossible)[/color]'' ;

    text id 50 start 526.0s for 2.0s at (5.0, 53.0)
         ''[color=#34D399]Niveau $y = 3$ :[/color] [color=#F8FAFC]Sommet culminant de la courbe ![/color]'' ;

    draw line id 539 start 529.0s for 1.0s
         color (52, 211, 153, 0.9) width 2
         at [(107.0, 35.5), (133.0, 35.5)] ;

    draw circle id 540 start 532.0s for 0.6s
         color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.9) width 2
         radius 1.6 at (113.5, 35.5) ;

    draw arrow id 541 start 535.0s for 1.0s
         color (251, 191, 36, 1) width 2
         at [(113.5, 35.5), (113.5, 55.0)] ;

    text id 54 start 538.0s at (106.0, 19.0)
         ''[bold][color=#34D399]$S(-3 ; 3)$[/color][/bold]'' ;

    text id 51 start 546.0s for 2.5s at (5.0, 64.0)
         ''[bold][color=#34D399]Valeur du maximum : $\mathbf{M = 3}$[/color][/bold]'' ;

    text id 52 start 555.0s for 3.0s at (5.0, 75.0)
         ''[bold][color=#FBBF24]Atteint en : $\mathbf{x = -3}$[/color][/bold] [color=#F8FAFC](Point culminant $S(-3 ; 3)$)[/color]'' ;

    erase id 2006 start 579.0s ;

    # ========================================================
    # SCÈNE 7 : Erreurs fréquentes & Pièges de contrôle (579s - 656s)
    # ========================================================
    text id 55 start 580.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#F87171]7. Erreurs fréquentes & Pièges classiques de contrôle[/color][/bold]'' ;

    draw line id 542 start 582.2s for 0.8s
         color (248, 113, 113, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 56 start 588.5s for 1.5s at (5.0, 20.0)
         ''[bold][color=#F87171]Piège n°1 : Confusion axe $x$ et axe $y$[/color][/bold]'' ;

    draw polygone id 543 start 591.0s for 1.0s
         color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.12) width 1.5
         at [(96.0, 20.0), (170.0, 20.0), (170.0, 42.0), (96.0, 42.0)] ;

    text id 64 start 592.5s for 1.0s at (99.0, 23.0)
         ''[bold][color=#38BDF8]Sens de parcours :[/color][/bold]'' ;

    text id 57 start 595.0s for 2.0s at (5.0, 29.0)
         ''[color=#F8FAFC]Pour l'image de $2$, ne jamais chercher $2$ sur l'axe vertical ![/color]'' ;

    text id 65 start 598.0s for 2.5s at (99.0, 31.0)
         ''[color=#F8FAFC]Image : $x \to \mathcal{C}_f \to y$ | Antécédent : $y \to \mathcal{C}_f \to x$[/color]'' ;

    text id 58 start 604.0s for 3.0s at (5.0, 38.0)
         ''[color=#38BDF8]Mémo :[/color] [color=#F8FAFC]Image $\implies$ départ $x$ (abscisse), arrivée $f(x)$[/color]'' ;

    text id 59 start 619.0s for 1.5s at (5.0, 50.0)
         ''[bold][color=#F87171]Piège n°2 : Oublier des antécédents[/color][/bold]'' ;

    draw polygone id 544 start 622.0s for 1.0s
         color (251, 191, 36, 0.9) fillcolor (251, 191, 36, 0.12) width 1.5
         at [(96.0, 46.0), (170.0, 46.0), (170.0, 68.0), (96.0, 68.0)] ;

    text id 66 start 623.5s at (99.0, 49.0)
         ''[bold][color=#FBBF24]Nombre de solutions :[/color][/bold]'' ;

    text id 60 start 625.0s for 2.5s at (5.0, 59.0)
         ''[color=#F8FAFC]Tracer la droite horizontale $y = k$ d'un bout à l'autre ![/color]'' ;

    text id 67 start 629.0s for 2.5s at (99.0, 57.0)
         ''[color=#F8FAFC]Une image est UNIQUE, mais $0, 1, 2...$ antécédents[/color]'' ;

    text id 61 start 635.0s for 2.5s at (5.0, 68.0)
         ''[color=#34D399]Réflexe :[/color] [color=#F8FAFC]Compter chaque point d'intersection sur tout le graphe[/color]'' ;

    text id 62 start 639.5s for 1.5s at (5.0, 78.0)
         ''[bold][color=#F87171]Piège n°3 : Confondre maximum et son abscisse[/color][/bold]'' ;

    draw polygone id 545 start 642.0s for 1.0s
         color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.12) width 1.5
         at [(96.0, 72.0), (170.0, 72.0), (170.0, 94.0), (96.0, 94.0)] ;

    text id 68 start 643.5s at (99.0, 75.0)
         ''[bold][color=#34D399]Vocabulaire d'examen :[/color][/bold]'' ;

    text id 63 start 646.0s for 2.5s at (5.0, 87.0)
         ''[color=#FBBF24]Maximum = ordonnée ($3$)[/color] [color=#F8FAFC]versus[/color] [color=#38BDF8]Atteint en = abscisse ($-3$)[/color]'' ;

    text id 69 start 650.0s for 2.5s at (99.0, 83.0)
         ''[color=#F8FAFC]« Le maximum est $M$, atteint en $x_0$ »[/color]'' ;

    erase id 2007 start 656.0s ;

    # ========================================================
    # SCÈNE 8 : Synthèse méthodologique (656s - 718s)
    # ========================================================
    text id 70 start 657.0s for 2.0s at (4.0, 7.5)
         ''[bold][color=#38BDF8]8. Synthèse méthodologique : La grille de décision du contrôle[/color][/bold]'' ;

    draw line id 546 start 659.2s for 0.8s
         color (56, 189, 248, 0.7) width 1.5
         at [(4.0, 13.5), (173.0, 13.5)] ;

    draw polygone id 547 start 661.0s for 1.2s
         color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.08) width 2
         at [(6.0, 18.0), (171.0, 18.0), (171.0, 93.0), (6.0, 93.0)] ;

    draw line id 548 start 663.0s for 0.8s
         color (100, 116, 139, 0.6) width 1.5
         at [(6.0, 43.0), (171.0, 43.0)] ;

    draw line id 549 start 664.2s for 0.8s
         color (100, 116, 139, 0.6) width 1.5
         at [(6.0, 68.0), (171.0, 68.0)] ;

    text id 71 start 665.5s for 2.0s at (10.0, 22.0)
         ''[bold][color=#38BDF8]1. DÉTERMINER UNE IMAGE : $f(a)$[/color][/bold]'' ;

    text id 72 start 668.0s for 3.0s at (10.0, 29.0)
         ''[color=#F8FAFC]Départ $a$ sur l'axe des abscisses $\implies$ rejoindre $\mathcal{C}_f$ verticalement $\implies$ lire $f(a)$ sur l'axe des ordonnées[/color]'' ;

    text id 73 start 674.5s for 1.8s at (10.0, 36.0)
         ''[bold][color=#34D399]Propriété fondamentale : L'image d'un nombre est TOUJOURS UNIQUE[/color][/bold]'' ;

    text id 74 start 677.0s for 2.0s at (10.0, 47.0)
         ''[bold][color=#FBBF24]2. DÉTERMINER LES ANTÉCÉDENTS : Résoudre $f(x) = k$[/color][/bold]'' ;

    text id 75 start 680.0s for 3.5s at (10.0, 54.0)
         ''[color=#F8FAFC]Départ $k$ sur l'axe des ordonnées $\implies$ tracer la droite $y = k$ $\implies$ projeter chaque intersection vers l'axe $x$[/color]'' ;

    text id 76 start 690.0s for 2.5s at (10.0, 61.0)
         ''[bold][color=#FBBF24]Propriété fondamentale : Il peut y avoir $0$, $1$, ou PLUSIEURS antécédents[/color][/bold]'' ;

    text id 77 start 694.0s for 2.5s at (10.0, 72.0)
         ''[bold][color=#34D399]3. EXTREMUMS : Maximum et Minimum[/color][/bold]'' ;

    text id 78 start 697.5s for 3.0s at (10.0, 79.0)
         ''[color=#F8FAFC]Maximum = ordonnée du sommet le plus haut | Minimum = ordonnée du creux le plus bas[/color]'' ;

    text id 79 start 702.5s for 3.0s at (10.0, 86.0)
         ''[bold][color=#38BDF8]Rédaction : Le maximum est $M$, et il est atteint pour $x = x_0$[/color][/bold]'' ;

    text id 80 start 709.0s for 3.0s at (32.0, 95.0)
         ''[bold][color=#FBBF24]Bravo ! Tu maîtrises l'intégralité de la lecture graphique en Seconde ![/color][/bold]'' ;

}
