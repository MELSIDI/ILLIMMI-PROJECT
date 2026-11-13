course "Variations de fonctions et extrema — Cours fondamental et définitions" id 37 idgap 500 for 270.21s audio "narration.wav" {

    # ==========================================
    # SCENE 1 : 0.0s -> 48.1s (Accroche : Importance de l'intervalle)
    # ==========================================
    text id 1 start 0.2s at (4.0, 7.0) ''[bold][color=#38BDF8]1. Accroche : Pourquoi l'intervalle d'étude change tout[/color][/bold]'' ;
    draw line id 501 start 0.6s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    text id 2 start 1.5s for 3.2s at (5.0, 20.0) ''[color=#F8FAFC]Objectif : Comprendre et trouver les extrema d'une fonction.[/color]'' ;
    text id 3 start 5.2s for 3.2s at (5.0, 33.0) ''[color=#34D399]Extremum = maximum (plus haut) ou minimum (plus bas).[/color]'' ;
    text id 4 start 11.0s for 3.8s at (5.0, 47.0) ''[bold][color=#FBBF24]1re question :[/color][/bold] [color=#F8FAFC]Sur quel intervalle $I$ travaille-t-on ?[/color]'' ;

    draw 2drep id 502 start 17.7s for 1.2s at (134.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 2.2 grid = true grid_alpha = 0.7 step = 1 x_range = [-16, 16] y_range = [-4, 13] ;
    draw 2dfunc id 503 start 19.5s for 2.2s color (56, 189, 248, 1) width 2.5 at 502 y = 7 * cos(0.2244 * (x - 6)) + 4 + 8 * exp(0 - ((x + 15) / 2.8)^2) ;
    text id 5 start 22.2s at (96.0, 17.5) ''[color=#38BDF8]$C_f \text{ sur } [-15 ; 15]$[/color]'' ;
    text id 6 start 22.7s at (97.0, 73.0) ''[color=#F8FAFC]-15[/color]'' ;
    text id 7 start 23.1s at (163.0, 73.0) ''[color=#F8FAFC]15[/color]'' ;
    text id 8 start 23.5s at (132.0, 73.0) ''[color=#F8FAFC]0[/color]'' ;

    mouse move id 1501 start 25.2s for 1.5s at [(115.0, 62.0), (147.2, 37.8)] ;
    draw circle id 504 start 33.5s for 0.6s color (251, 191, 36, 1) width 2.2 fillcolor (251, 191, 36, 0.2) at (147.2, 37.8) radius 1.6 ;
    text id 9 start 34.5s for 1.6s at (140.0, 25.5) ''[color=#FBBF24]Sommet ($x \approx 6$)[/color]'' ;

    draw circle id 505 start 39.3s for 0.6s color (52, 211, 153, 1) width 2.2 fillcolor (52, 211, 153, 0.2) at (101.0, 35.6) radius 1.6 ;
    text id 10 start 40.3s for 1.6s at (96.0, 25.5) ''[color=#34D399]Plus haut à gauche ![/color]'' ;

    text id 11 start 42.4s for 3.4s at (6.0, 63.0) ''[bold][color=#FBBF24]Clé :[/color][/bold] [color=#F8FAFC]L'intervalle choisi change le résultat ![/color]'' ;
    draw polygone id 506 start 46.2s for 0.8s color (251, 191, 36, 0.85) width 1.5 fillcolor (251, 191, 36, 0.12) at [(4, 60), (85, 60), (85, 71), (4, 71)] ;

    erase id 2001 start 48.1s ;

    # ==========================================
    # SCENE 2 : 48.3s -> 127.2s (Exemple 1 : Maximum sur [-15 ; 15])
    # ==========================================
    text id 12 start 48.3s at (4.0, 7.0) ''[bold][color=#38BDF8]2. Exemple 1 : Trouver le maximum sur $[-15 ; 15]$[/color][/bold]'' ;
    draw line id 507 start 48.6s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    text id 13 start 50.6s for 3.5s at (5.0, 20.0) ''[bold][color=#FBBF24]Question :[/color][/bold] [color=#F8FAFC]Maximum de $f$ sur $[-15 ; 15]$ ?[/color]'' ;

    draw 2drep id 508 start 54.5s for 1.0s at (134.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 2.2 grid = true grid_alpha = 0.7 step = 1 x_range = [-16, 16] y_range = [-4, 13] ;
    draw 2dfunc id 509 start 55.8s for 2.0s color (56, 189, 248, 1) width 2.5 at 508 y = 7 * cos(0.2244 * (x - 6)) + 4 + 8 * exp(0 - ((x + 15) / 2.8)^2) ;
    draw path id 510 start 58.2s color (52, 211, 153, 1) width 2.5 at [(102.5, 59.5), (101.0, 59.5), (101.0, 64.5), (102.5, 64.5)] ;
    text id 14 start 58.6s at (97.0, 73.0) ''[color=#34D399]-15[/color]'' ;
    draw path id 511 start 59.5s color (52, 211, 153, 1) width 2.5 at [(165.5, 59.5), (167.0, 59.5), (167.0, 64.5), (165.5, 64.5)] ;
    text id 15 start 59.9s at (163.0, 73.0) ''[color=#34D399]15[/color]'' ;
    draw line id 512 start 62.2s for 1.2s color (52, 211, 153, 0.9) width 3.5 at [(101.0, 62.0), (167.0, 62.0)] ;

    text id 16 start 65.4s for 3.2s at (5.0, 33.0) ''[color=#F8FAFC]On cherche le point le plus haut sur $[-15 ; 15]$.[/color]'' ;
    text id 17 start 73.5s for 3.8s at (5.0, 46.0) ''[color=#38BDF8]Règle :[/color] [color=#F8FAFC]Les valeurs $f(x)$ se lisent sur $(Oy)$ ![/color]'' ;

    draw arrow id 513 start 79.9s for 0.8s color (56, 189, 248, 0.95) width 2.2 at [(134.0, 70.5), (134.0, 31.0)] ;
    text id 18 start 81.0s at (128.0, 17.5) ''[color=#38BDF8]$y = f(x)$[/color]'' ;

    draw circle id 514 start 88.2s for 0.6s color (251, 191, 36, 1) width 2.2 fillcolor (251, 191, 36, 0.2) at (147.2, 37.8) radius 1.4 ;
    draw arrow id 515 start 92.2s for 1.2s color (251, 191, 36, 0.95) width 2.0 at [(147.2, 37.8), (134.0, 37.8)] ;
    text id 19 start 96.6s at (142.0, 25.5) ''[bold][color=#FBBF24]y = 11[/color][/bold]'' ;

    draw circle id 516 start 98.6s for 0.6s color (52, 211, 153, 1) width 2.2 fillcolor (52, 211, 153, 0.2) at (101.0, 35.6) radius 1.4 ;
    draw arrow id 517 start 102.0s for 1.2s color (52, 211, 153, 0.95) width 2.0 at [(101.0, 35.6), (134.0, 35.6)] ;
    text id 20 start 107.4s at (114.0, 25.5) ''[bold][color=#34D399]y = 12[/color][/bold]'' ;

    text id 21 start 108.2s for 2.2s at (5.0, 58.0) ''[color=#FBBF24]Comparaison : $12 > 11$[/color]'' ;
    text id 22 start 115.6s for 3.6s at (6.0, 71.0) ''[bold][color=#34D399]Maximum sur $[-15 ; 15]$ : $12$[/color][/bold]'' ;
    text id 23 start 122.3s for 3.0s at (6.0, 81.0) ''[color=#F8FAFC]Atteint en $x = -15$ : $f(-15) = 12$[/color]'' ;
    draw polygone id 518 start 125.6s for 0.8s color (52, 211, 153, 0.9) width 1.8 fillcolor (52, 211, 153, 0.12) at [(4, 68), (82, 68), (82, 89), (4, 89)] ;

    erase id 2002 start 127.2s ;

    # ==========================================
    # SCENE 3 : 127.4s -> 186.8s (Exemple 2 : Minimum sur [-10 ; -3])
    # ==========================================
    text id 24 start 127.4s at (4.0, 7.0) ''[bold][color=#38BDF8]3. Exemple 2 : Trouver le minimum sur $[-10 ; -3]$[/color][/bold]'' ;
    draw line id 519 start 127.7s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    text id 25 start 132.4s for 3.2s at (5.0, 20.0) ''[bold][color=#FBBF24]Question :[/color][/bold] [color=#F8FAFC]Minimum de $f$ sur $[-10 ; -3]$ ?[/color]'' ;

    draw 2drep id 520 start 136.0s for 1.0s at (156.0, 58.0) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-12, 2] y_range = [-5, 9] ;
    draw 2dfunc id 521 start 137.2s for 1.8s color (56, 189, 248, 1) width 2.5 at 520 y = 7 * cos(0.2244 * (x - 6)) + 4 + 8 * exp(0 - ((x + 15) / 2.8)^2) ;

    draw path id 522 start 139.2s color (56, 189, 248, 1) width 2.5 at [(117.5, 55.5), (116.0, 55.5), (116.0, 60.5), (117.5, 60.5)] ;
    text id 26 start 139.6s at (112.0, 80.5) ''[color=#38BDF8]-10[/color]'' ;
    draw path id 523 start 140.0s color (56, 189, 248, 1) width 2.5 at [(142.5, 55.5), (144.0, 55.5), (144.0, 60.5), (142.5, 60.5)] ;
    text id 27 start 140.4s at (142.5, 80.5) ''[color=#38BDF8]-3[/color]'' ;
    draw line id 524 start 141.2s for 1.2s color (56, 189, 248, 0.9) width 3.5 at [(116.0, 58.0), (144.0, 58.0)] ;

    text id 28 start 146.1s for 3.4s at (5.0, 33.0) ''[color=#F8FAFC]Sur $[-10 ; -3]$, la courbe descend puis remonte.[/color]'' ;
    draw circle id 525 start 150.0s for 0.6s color (248, 113, 113, 1) width 2.2 fillcolor (248, 113, 113, 0.2) at (124.0, 70.0) radius 1.5 ;
    draw arrow id 526 start 155.8s for 1.2s color (251, 191, 36, 0.95) width 2.0 at [(124.0, 70.0), (124.0, 58.0)] ;
    text id 29 start 158.1s at (122.5, 80.5) ''[bold][color=#FBBF24]-8[/color][/bold]'' ;

    text id 30 start 160.0s for 3.8s at (5.0, 46.0) ''[color=#34D399]Vérif : $-8 \in [-10 ; -3]$ (dans l'intervalle !)[/color]'' ;

    draw arrow id 527 start 168.7s for 1.4s color (52, 211, 153, 0.95) width 2.0 at [(124.0, 70.0), (164.0, 70.0)] ;
    draw line id 528 start 173.8s color (248, 250, 252, 0.8) width 1.5 at [(154.8, 62.0), (157.2, 62.0)] ;
    draw line id 529 start 174.4s color (248, 250, 252, 0.8) width 1.5 at [(154.8, 66.0), (157.2, 66.0)] ;
    text id 31 start 175.1s at (165.5, 67.5) ''[bold][color=#F87171]y=-3[/color][/bold]'' ;

    text id 32 start 176.2s for 3.2s at (5.0, 58.0) ''[color=#FBBF24]Lecture verticale : $f(-8) = -3$[/color]'' ;
    text id 33 start 180.2s for 3.6s at (6.0, 71.0) ''[bold][color=#F87171]Minimum sur $[-10 ; -3]$ : $-3$[/color][/bold]'' ;
    text id 34 start 184.4s for 1.2s at (6.0, 81.0) ''[color=#F8FAFC]Atteint en $x = -8$[/color]'' ;
    draw polygone id 530 start 185.8s for 0.6s color (248, 113, 113, 0.9) width 1.8 fillcolor (248, 113, 113, 0.12) at [(4, 68), (82, 68), (82, 89), (4, 89)] ;

    erase id 2003 start 186.8s ;

    # ==========================================
    # SCENE 4 : 187.0s -> 230.9s (Définitions formelles & Variations)
    # ==========================================
    text id 35 start 187.0s at (4.0, 7.0) ''[bold][color=#38BDF8]4. Définitions Formelles & Lien avec les Variations[/color][/bold]'' ;
    draw line id 531 start 187.3s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    text id 36 start 192.8s for 2.4s at (5.0, 19.0) ''[color=#F8FAFC]Soit $f$ définie sur un intervalle $I$.[/color]'' ;
    text id 37 start 195.6s for 3.5s at (5.0, 31.0) ''[bold][color=#34D399]Maximum $M$ sur $I$ :[/color][/bold]'' ;
    text id 38 start 200.0s for 4.5s at (7.0, 41.0) ''[color=#F8FAFC]$\exists a \in I,\ f(a) = M \text{ et } \forall x \in I,\ f(x) \le M$[/color]'' ;

    text id 39 start 206.0s for 3.2s at (5.0, 55.0) ''[bold][color=#F87171]Minimum $m$ sur $I$ :[/color][/bold]'' ;
    text id 40 start 209.8s for 4.5s at (7.0, 65.0) ''[color=#F8FAFC]$\exists b \in I,\ f(b) = m \text{ et } \forall x \in I,\ f(x) \ge m$[/color]'' ;

    draw 2drep id 532 start 217.0s for 1.0s at (134.0, 62.0) color (248, 250, 252, 0.95) width 1.5 scale = 2.2 grid = true grid_alpha = 0.7 step = 1 x_range = [-16, 16] y_range = [-4, 13] ;
    draw 2dfunc id 533 start 218.3s for 1.5s color (56, 189, 248, 1) width 2.5 at 532 y = 7 * cos(0.2244 * (x - 6)) + 4 + 8 * exp(0 - ((x + 15) / 2.8)^2) ;

    draw arrow id 534 start 220.5s for 0.8s color (248, 113, 113, 1) width 2.2 at [(106.0, 52.0), (114.0, 66.0)] ;
    draw arrow id 535 start 221.6s for 0.8s color (52, 211, 153, 1) width 2.2 at [(119.0, 66.0), (127.0, 51.0)] ;
    text id 41 start 223.0s at (100.0, 74.0) ''[color=#F87171]Décroissante puis croissante $\Rightarrow$ Min[/color]'' ;

    draw arrow id 536 start 225.8s for 0.8s color (52, 211, 153, 1) width 2.2 at [(138.0, 46.0), (146.0, 36.0)] ;
    draw arrow id 537 start 226.9s for 0.8s color (248, 113, 113, 1) width 2.2 at [(149.0, 36.0), (157.0, 48.0)] ;
    text id 42 start 228.5s for 1.8s at (102.0, 23.0) ''[color=#34D399]Croissante puis décroissante $\Rightarrow$ Max[/color]'' ;

    erase id 2004 start 230.9s ;

    # ==========================================
    # SCENE 5 : 231.0s -> 252.3s (Erreur fréquente : Valeur vs Abscisse)
    # ==========================================
    text id 43 start 231.0s at (4.0, 7.0) ''[bold][color=#F87171]5. Piège Classique : Confondre la Valeur et l'Abscisse[/color][/bold]'' ;
    draw line id 538 start 231.3s for 0.6s color (248, 113, 113, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    draw polygone id 539 start 233.7s for 1.0s color (248, 113, 113, 0.9) width 1.8 fillcolor (248, 113, 113, 0.14) at [(4, 20), (85, 20), (85, 52), (4, 52)] ;
    text id 44 start 235.4s for 3.2s at (7.0, 25.0) ''[bold][color=#F87171]Erreur fréquente au contrôle :[/color][/bold]'' ;
    text id 45 start 239.0s for 1.1s at (7.0, 38.0) ''[color=#F8FAFC]Confondre l'abscisse $x$ et la valeur $f(x)$ ![/color]'' ;

    text id 46 start 240.5s for 3.4s at (5.0, 62.0) ''[bold][color=#34D399]Valeur de l'extremum :[/color][/bold] [color=#F8FAFC]ordonnée $f(x)$ sur $(Oy)$.[/color]'' ;

    draw arrow id 540 start 244.3s for 0.8s color (52, 211, 153, 1) width 2.5 at [(104.0, 74.0), (104.0, 26.0)] ;
    text id 47 start 245.3s at (108.0, 34.0) ''[bold][color=#34D399]Axe vertical $(Oy)$ : Valeur $f(x)$[/color][/bold]'' ;
    draw arrow id 541 start 245.8s for 0.8s color (251, 191, 36, 1) width 2.5 at [(104.0, 74.0), (168.0, 74.0)] ;
    text id 48 start 246.8s at (110.0, 79.0) ''[bold][color=#FBBF24]Axe horizontal $(Ox)$ : Abscisse $x$ (où ?)[/color][/bold]'' ;

    text id 49 start 247.4s for 3.6s at (5.0, 76.0) ''[bold][color=#FBBF24]Où il est atteint :[/color][/bold] [color=#F8FAFC]abscisse $x$ sur $(Ox)$.[/color]'' ;

    erase id 2005 start 252.3s ;

    # ==========================================
    # SCENE 6 : 252.4s -> 270.21s (Synthèse : 3 Réflexes)
    # ==========================================
    text id 50 start 252.4s at (4.0, 7.0) ''[bold][color=#38BDF8]6. Synthèse : Les 3 Réflexes pour Réussir[/color][/bold]'' ;
    draw line id 542 start 252.7s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.0), (173, 13.0)] ;

    text id 51 start 253.6s for 2.2s at (5.0, 20.0) ''[bold][color=#FBBF24]Méthode infaillible en 3 étapes :[/color][/bold]'' ;

    text id 52 start 256.2s for 3.0s at (5.0, 35.0) ''[color=#38BDF8]1. Délimiter l'intervalle $I$ sur $(Ox)$.[/color]'' ;
    draw polygone id 543 start 259.4s for 0.6s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.14) at [(96, 22), (169, 22), (169, 36), (96, 36)] ;
    text id 53 start 260.2s at (100.0, 26.5) ''[color=#38BDF8]Étape 1 : Intervalle $I \subset (Ox)$[/color]'' ;
    draw arrow id 544 start 260.5s color (248, 250, 252, 0.85) width 2.0 at [(132.5, 36), (132.5, 45)] ;

    text id 54 start 260.8s for 3.0s at (5.0, 51.0) ''[color=#FBBF24]2. Repérer le sommet ou le creux sur $C_f$.[/color]'' ;
    draw polygone id 545 start 264.0s for 0.6s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.14) at [(96, 45), (169, 45), (169, 59), (96, 59)] ;
    text id 55 start 264.8s at (100.0, 49.5) ''[color=#FBBF24]Étape 2 : Point extrême sur $C_f$[/color]'' ;

    text id 56 start 265.2s for 3.0s at (5.0, 67.0) ''[color=#34D399]3. Lire l'ordonnée $f(x)$ et préciser $x$.[/color]'' ;
    draw arrow id 546 start 268.4s color (248, 250, 252, 0.85) width 2.0 at [(132.5, 59), (132.5, 68)] ;
    draw polygone id 547 start 268.7s for 0.6s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.14) at [(96, 68), (169, 68), (169, 82), (96, 82)] ;
    text id 57 start 269.5s at (100.0, 72.5) ''[color=#34D399]Étape 3 : Valeur $f(x_0)$ en $x_0$[/color]'' ;

}
