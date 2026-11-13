course "Méthode pas à pas : Variations de fonctions et extrema" id 32 idgap 500 for 343.0s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : OBJECTIF & PROPRIÉTÉ DE L'EXTREMUM PAR LA DÉRIVÉE
    # =========================================================================

    text id 1 start 0.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Objectif & Propriété de l'Extremum par la Dérivée[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Énoncé & Propriété clé
    text id 2 start 12.4s for 3.6s at (4.0, 19.0) ''[color=#F8FAFC]Fonction étudiée sur $\mathbb{R}$ :[/color]'' ;
    text id 3 start 16.4s for 3.5s at (4.0, 26.5) ''[color=#FBBF24][bold]$$f(x) = 5x^2 - 3x + 4$$[/bold][/color]'' ;
    text id 4 start 20.4s for 3.8s at (4.0, 39.0) ''[color=#38BDF8][bold]Objectif :[/bold] Variations de $f$ et extremum[/color]'' ;

    # Colonne droite : Courbe illustrative de l'idée géométrique
    draw 2drep id 502 start 25.3s for 1.2s at (133.0, 71.0) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-1, 5] ;
    draw 2dfunc id 503 start 26.8s for 1.6s color (56, 189, 248, 1) width 2.5 at 502 y = 0.5*x^2 + 1 ;
    draw line id 504 start 28.6s for 0.8s color (251, 191, 36, 1) width 2.2 at [(119.0, 63.0), (147.0, 63.0)] ;
    draw circle id 505 start 29.6s for 0.5s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) at (133.0, 63.0) radius 1.4 ;
    text id 5 start 30.3s for 1.6s at (114.0, 21.0) ''[color=#34D399][bold]Idée géométrique : extremum en $c$[/bold][/color]'' ;

    # Propriété & plan
    text id 6 start 32.8s for 3.6s at (4.0, 49.0) ''[color=#34D399][bold]Propriété clé :[/bold] Si $f^{\prime}(c) = 0$[/color]'' ;
    text id 7 start 36.8s for 4.2s at (4.0, 57.5) ''[color=#34D399]et $f^{\prime}(x)$ [bold]change de signe[/bold] en $c$,[/color]'' ;
    text id 8 start 41.5s for 3.8s at (4.0, 66.0) ''[color=#FBBF24]$\implies f$ admet un [bold]extremum[/bold] en $x = c$[/color]'' ;
    text id 9 start 47.9s for 2.2s at (4.0, 77.5) ''[color=#C084FC]Plan : 1) Dériver $f$   2) $f^{\prime}(x)=0$   3) Signe[/color]'' ;
    text id 10 start 50.4s for 2.0s at (112.0, 84.5) ''[color=#FBBF24]Tangente horizontale : $f^{\prime}(c) = 0$[/color]'' ;
    mouse move id 1501 start 52.6s for 1.2s at [(133.0, 78.0), (133.0, 64.5)] ;

    erase id 2001 start 54.6s ;

    # =========================================================================
    # SCÈNE 2 : ÉTAPE 1 — CALCUL DE LA FONCTION DÉRIVÉE f'(x)
    # =========================================================================

    text id 11 start 54.7s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Étape 1 : Calcul de la Fonction Dérivée $f^{\prime}(x)$[/color][/bold]'' ;
    draw line id 506 start 56.7s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Dérivation terme à terme
    text id 12 start 58.6s for 3.2s at (4.0, 19.0) ''[color=#F8FAFC]$f(x) = 5x^2 - 3x + 4$  (polynôme degré 2)[/color]'' ;
    text id 13 start 63.0s for 2.4s at (4.0, 29.0) ''[color=#38BDF8][bold]Dérivation terme à terme :[/bold][/color]'' ;
    text id 14 start 66.0s for 3.5s at (4.0, 39.0) ''[color=#FBBF24]$(5x^2)^{\prime} = 5 \times 2x = 10x$[/color]'' ;

    # Colonne droite : Schéma terme 1
    draw polygone id 507 start 69.8s for 0.6s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.14) at [(98.0, 22.0), (124.0, 22.0), (124.0, 33.0), (98.0, 33.0)] ;
    text id 19 start 70.6s at (105.0, 25.0) ''[color=#FBBF24]$5x^2$[/color]'' ;
    draw arrow id 508 start 70.8s for 0.6s color (251, 191, 36, 1) width 2.0 at [(125.0, 27.5), (140.0, 27.5)] ;
    draw polygone id 509 start 71.6s for 0.6s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.14) at [(141.0, 22.0), (168.0, 22.0), (168.0, 33.0), (141.0, 33.0)] ;
    text id 20 start 72.4s at (148.5, 25.0) ''[color=#FBBF24]$10x$[/color]'' ;

    # Terme 2 gauche + droite
    text id 15 start 73.6s for 3.5s at (4.0, 50.0) ''[color=#34D399]$(-3x)^{\prime} = -3 \times 1 = -3$[/color]'' ;
    draw polygone id 510 start 77.5s for 0.6s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.14) at [(98.0, 41.0), (124.0, 41.0), (124.0, 52.0), (98.0, 52.0)] ;
    text id 21 start 78.3s at (104.5, 44.0) ''[color=#34D399]$-3x$[/color]'' ;
    draw arrow id 511 start 78.6s for 0.6s color (52, 211, 153, 1) width 2.0 at [(125.0, 46.5), (140.0, 46.5)] ;
    draw polygone id 512 start 79.5s for 0.6s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.14) at [(141.0, 41.0), (168.0, 41.0), (168.0, 52.0), (141.0, 52.0)] ;
    text id 22 start 80.3s at (149.5, 44.0) ''[color=#34D399]$-3$[/color]'' ;

    # Terme 3 gauche + droite
    text id 16 start 82.6s for 2.8s at (4.0, 61.0) ''[color=#C084FC]$(+4)^{\prime} = 0$  (constante)[/color]'' ;
    draw polygone id 513 start 85.6s color (192, 132, 252, 0.9) width 1.5 fillcolor (192, 132, 252, 0.14) at [(98.0, 60.0), (124.0, 60.0), (124.0, 71.0), (98.0, 71.0)] ;
    text id 23 start 85.8s at (106.5, 63.0) ''[color=#C084FC]$+4$[/color]'' ;
    draw arrow id 514 start 86.0s color (192, 132, 252, 1) width 2.0 at [(125.0, 65.5), (140.0, 65.5)] ;
    draw polygone id 515 start 86.2s color (192, 132, 252, 0.9) width 1.5 fillcolor (192, 132, 252, 0.14) at [(141.0, 60.0), (168.0, 60.0), (168.0, 71.0), (141.0, 71.0)] ;
    text id 24 start 86.4s at (152.0, 63.0) ''[color=#C084FC]$0$[/color]'' ;

    # Réduction et résultat final
    text id 17 start 87.1s for 3.2s at (4.0, 72.5) ''[color=#F8FAFC]$f^{\prime}(x) = 5 \times 2x - 3 \times 1 + 0$[/color]'' ;
    draw line id 516 start 91.0s for 0.8s color (52, 211, 153, 0.8) width 1.8 at [(98.0, 76.0), (168.0, 76.0)] ;
    text id 25 start 92.0s for 1.8s at (108.0, 80.5) ''[color=#34D399][bold]Rappel : $(x^n)^{\prime} = nx^{n-1}$[/bold][/color]'' ;
    text id 18 start 94.2s for 3.5s at (4.0, 84.0) ''[color=#34D399][bold]$$f^{\prime}(x) = 10x - 3$$[/bold][/color]'' ;
    mouse move id 1502 start 97.9s for 1.1s at [(10.0, 85.0), (45.0, 85.0)] ;

    erase id 2002 start 99.3s ;

    # =========================================================================
    # SCÈNE 3 : ÉTAPE 2 — RÉSOLUTION DE f'(x) = 0 & ÉTUDE DU SIGNE
    # =========================================================================

    text id 31 start 99.4s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Étape 2 : Résolution de $f^{\prime}(x)=0$ & Signe[/color][/bold]'' ;
    draw line id 521 start 101.4s for 0.5s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Résolution & étude affine
    text id 32 start 104.8s for 2.5s at (4.0, 18.5) ''[color=#F8FAFC][bold]1) Résoudre $f^{\prime}(x) = 0$ :[/bold][/color]'' ;
    text id 33 start 107.6s for 3.2s at (4.0, 27.5) ''[color=#FBBF24]$$10x - 3 = 0$$[/color]'' ;
    text id 34 start 112.8s for 3.2s at (4.0, 39.0) ''[color=#F8FAFC]$$10x = 3$$[/color]'' ;
    text id 35 start 116.5s for 2.6s at (4.0, 50.5) ''[color=#34D399][bold]$$x = \frac{3}{10} = 0{,}3$$[/bold][/color]'' ;
    text id 36 start 122.6s for 4.2s at (4.0, 64.0) ''[color=#F87171][bold]Attention :[/bold] Il faut aussi un changement de signe ![/color]'' ;
    text id 37 start 132.6s for 4.0s at (4.0, 74.0) ''[color=#38BDF8]$f^{\prime}(x) = 10x - 3$ : fonction affine ($a = 10 > 0$)[/color]'' ;

    # Colonne droite : Repère & droite affine f'(x) = 10x - 3
    text id 39 start 142.2s for 1.6s at (110.0, 18.0) ''[color=#38BDF8][bold]Représentation de $f^{\prime}(x) = 10x - 3$[/bold][/color]'' ;
    draw 2drep id 522 start 144.0s for 1.5s at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-4, 4] ;
    draw 2dfunc id 523 start 145.8s for 2.0s color (251, 191, 36, 1) width 2.5 at 522 y = 10*x - 3 ;

    text id 38 start 152.9s for 3.8s at (4.0, 84.0) ''[color=#34D399]Droite croissante : $-$ avant $\frac{3}{10}$, $+$ après $\frac{3}{10}$[/color]'' ;

    draw circle id 524 start 158.7s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.35) at (135.1, 55.0) radius 1.4 ;
    draw arrow id 525 start 160.0s for 0.8s color (52, 211, 153, 1) width 1.8 at [(135.1, 68.0), (135.1, 56.8)] ;
    text id 40 start 161.0s for 1.6s at (126.0, 86.0) ''[color=#34D399]Racine : $x = \frac{3}{10}$[/color]'' ;
    text id 41 start 164.0s for 2.2s at (96.5, 62.0) ''[color=#F87171][bold]$-$[/bold] ($f^{\prime}<0$)[/color]'' ;
    text id 42 start 169.0s for 2.2s at (156.0, 38.0) ''[color=#34D399][bold]$+$[/bold] ($f^{\prime}>0$)[/color]'' ;
    mouse move id 1503 start 172.8s for 1.5s at [(132.0, 63.0), (138.0, 42.0)] ;

    erase id 2003 start 180.0s ;

    # =========================================================================
    # SCÈNE 4 : ÉTAPE 3 — TABLEAU DE SIGNES DE f' & VARIATIONS DE f
    # =========================================================================

    text id 51 start 180.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Étape 3 : Tableau de Signes & Variations[/color][/bold]'' ;
    draw line id 531 start 182.2s for 0.5s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 52 start 183.1s for 3.6s at (4.0, 19.0) ''[color=#F8FAFC][bold]Tableau complet sur $\mathbb{R}$ :[/bold][/color]'' ;

    # Structure du tableau à droite
    draw line id 532 start 188.1s color (248, 250, 252, 0.85) width 1.5 at [(92.0, 22.0), (172.0, 22.0)] ;
    draw line id 533 start 188.3s color (248, 250, 252, 0.85) width 1.5 at [(92.0, 36.0), (172.0, 36.0)] ;
    draw line id 534 start 188.5s color (248, 250, 252, 0.85) width 1.5 at [(92.0, 54.0), (172.0, 54.0)] ;
    draw line id 535 start 188.7s color (248, 250, 252, 0.85) width 1.5 at [(92.0, 82.0), (172.0, 82.0)] ;
    draw line id 536 start 188.9s color (248, 250, 252, 0.85) width 1.5 at [(92.0, 22.0), (92.0, 82.0)] ;
    draw line id 537 start 189.1s color (248, 250, 252, 0.85) width 1.5 at [(114.0, 22.0), (114.0, 82.0)] ;
    draw line id 538 start 189.3s color (248, 250, 252, 0.85) width 1.5 at [(172.0, 22.0), (172.0, 82.0)] ;

    text id 53 start 190.4s for 1.4s at (100.5, 26.0) ''[color=#F8FAFC]$x$[/color]'' ;
    text id 54 start 192.7s for 1.8s at (95.5, 42.0) ''[color=#38BDF8]$f^{\prime}(x)$[/color]'' ;
    text id 55 start 195.1s for 1.6s at (96.5, 65.0) ''[color=#34D399]$f(x)$[/color]'' ;

    # Bornes sur R
    text id 56 start 197.4s for 2.6s at (4.0, 29.0) ''[color=#38BDF8]Domaine : $D_f = \mathbb{R} = \, ]-\infty ; +\infty[$[/color]'' ;
    text id 57 start 200.2s at (116.0, 26.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 58 start 200.8s at (161.0, 26.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;

    # Valeur 3/10 et zéro
    text id 59 start 206.8s for 1.8s at (141.0, 24.5) ''[color=#FBBF24]$\frac{3}{10}$[/color]'' ;
    draw line id 539 start 210.0s color (248, 250, 252, 0.5) width 1.0 at [(143.0, 36.0), (143.0, 41.0)] ;
    draw line id 540 start 210.3s color (248, 250, 252, 0.5) width 1.0 at [(143.0, 49.0), (143.0, 54.0)] ;
    text id 60 start 212.1s for 1.6s at (142.1, 42.0) ''[color=#FBBF24][bold]$0$[/bold][/color]'' ;
    text id 61 start 214.0s for 2.6s at (4.0, 39.0) ''[color=#FBBF24]Racine : $f^{\prime}\!\left(\frac{3}{10}\right) = 0$[/color]'' ;

    # Signes - et +
    text id 62 start 222.0s for 1.6s at (127.0, 42.0) ''[color=#F87171][bold]$-$[/bold][/color]'' ;
    text id 63 start 225.3s for 1.6s at (156.0, 42.0) ''[color=#34D399][bold]$+$[/bold][/color]'' ;

    # Variations & flèches
    text id 64 start 232.8s for 3.6s at (4.0, 50.0) ''[color=#F87171]$f^{\prime}(x) < 0 \implies f$ est [bold]décroissante[/bold][/color]'' ;
    draw arrow id 541 start 237.7s for 1.2s color (248, 113, 113, 1) width 2.5 at [(120.0, 58.0), (136.0, 73.0)] ;
    text id 65 start 239.5s for 3.0s at (4.0, 61.0) ''[color=#34D399]$f^{\prime}(x) > 0 \implies f$ est [bold]croissante[/bold][/color]'' ;
    draw arrow id 542 start 242.9s for 1.2s color (52, 211, 153, 1) width 2.5 at [(150.0, 73.0), (166.0, 58.0)] ;
    text id 66 start 245.0s for 3.2s at (4.0, 73.5) ''[color=#FBBF24][bold]Conclusion :[/bold] Minimum en $x = \frac{3}{10}$[/color]'' ;
    text id 67 start 248.4s at (137.0, 72.5) ''[color=#FBBF24]$f(\frac{3}{10})$[/color]'' ;

    erase id 2004 start 249.5s ;

    # =========================================================================
    # SCÈNE 5 : ÉTAPE 4 — CALCUL DU MINIMUM & COURBE DE f(x)
    # =========================================================================

    text id 71 start 249.8s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Étape 4 : Calcul du Minimum & Piège Classique[/color][/bold]'' ;
    draw line id 551 start 251.8s for 0.5s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Calcul exact & mise en garde
    text id 72 start 254.2s for 3.6s at (4.0, 18.5) ''[color=#F87171][bold]Piège classique :[/bold] Calculer $f(\frac{3}{10})$, PAS $f^{\prime}(\frac{3}{10})$ ![/color]'' ;
    text id 73 start 266.4s for 4.0s at (4.0, 29.0) ''[color=#F8FAFC]$f\!\left(\frac{3}{10}\right) = 5\left(\frac{3}{10}\right)^2 - 3\left(\frac{3}{10}\right) + 4$[/color]'' ;
    text id 74 start 273.2s for 3.8s at (4.0, 41.5) ''[color=#FBBF24]$= 5 \times \frac{9}{100} - \frac{9}{10} + 4 = \frac{45}{100} - \frac{90}{100} + \frac{400}{100}$[/color]'' ;
    text id 75 start 288.6s for 3.6s at (4.0, 55.0) ''[color=#38BDF8]$= \frac{355}{100} = \frac{71}{20} = 3{,}55$[/color]'' ;
    text id 76 start 296.7s for 3.8s at (4.0, 69.0) ''[color=#34D399][bold]Minimum :[/bold] $\frac{71}{20}$, atteint en $x = \frac{3}{10}$[/color]'' ;

    # Colonne droite : Parabole f(x) = 5x^2 - 3x + 4 et sommet
    text id 77 start 303.5s for 1.5s at (106.0, 18.0) ''[color=#38BDF8][bold]Courbe de $f(x) = 5x^2 - 3x + 4$[/bold][/color]'' ;
    draw 2drep id 552 start 305.2s for 1.2s at (130.0, 83.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 3] y_range = [0, 8] ;
    draw 2dfunc id 553 start 306.7s for 1.8s color (56, 189, 248, 1) width 2.5 at 552 y = 5*x^2 - 3*x + 4 ;
    draw circle id 554 start 308.7s for 0.6s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) at (132.1, 58.15) radius 1.4 ;
    draw line id 555 start 309.5s color (251, 191, 36, 0.7) width 1.2 at [(132.1, 58.15), (132.1, 83.0)] ;
    draw line id 556 start 309.8s color (251, 191, 36, 0.7) width 1.2 at [(130.0, 58.15), (132.1, 58.15)] ;
    draw arrow id 557 start 310.1s for 0.6s color (52, 211, 153, 1) width 1.8 at [(154.0, 52.0), (134.0, 57.6)] ;
    text id 78 start 310.9s for 1.5s at (154.5, 49.0) ''[color=#34D399]$S(\frac{3}{10} ; \frac{71}{20})$[/color]'' ;
    mouse move id 1504 start 312.6s for 1.0s at [(132.1, 58.15), (140.0, 38.0)] ;

    erase id 2005 start 314.3s ;

    # =========================================================================
    # SCÈNE 6 : SYNTHÈSE — LES 4 RÉFLEXES DE LA MÉTHODE
    # =========================================================================

    text id 91 start 314.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Synthèse : Les 4 Réflexes de la Méthode[/color][/bold]'' ;
    draw line id 571 start 316.5s for 0.5s color (56, 189, 248, 0.7) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Réflexe 1
    text id 92 start 320.0s for 2.2s at (4.0, 21.0) ''[color=#38BDF8][bold]1.[/bold] Calculer la dérivée $f^{\prime}(x)$[/color]'' ;
    draw polygone id 572 start 322.4s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.14) at [(104.0, 18.0), (164.0, 18.0), (164.0, 28.0), (104.0, 28.0)] ;
    text id 93 start 322.5s at (114.0, 20.5) ''[color=#38BDF8]Étape 1 : Dériver $f(x)$[/color]'' ;

    # Réflexe 2
    draw arrow id 573 start 322.8s color (248, 250, 252, 0.8) width 1.5 at [(134.0, 28.5), (134.0, 34.5)] ;
    text id 94 start 323.1s for 3.6s at (4.0, 36.0) ''[color=#FBBF24][bold]2.[/bold] Résoudre $f^{\prime}(x)=0$ & vérifier signe[/color]'' ;
    draw polygone id 574 start 327.0s for 0.6s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.14) at [(104.0, 35.0), (164.0, 35.0), (164.0, 46.0), (104.0, 46.0)] ;
    text id 95 start 327.8s at (110.0, 38.0) ''[color=#FBBF24]Étape 2 : $f^{\prime}(x)=0$ & signe[/color]'' ;

    # Réflexe 3
    draw arrow id 575 start 328.7s color (248, 250, 252, 0.8) width 1.5 at [(134.0, 46.5), (134.0, 52.5)] ;
    text id 96 start 329.0s for 3.2s at (4.0, 52.0) ''[color=#34D399][bold]3.[/bold] Dresser signes de $f^{\prime}$ & variations de $f$[/color]'' ;
    draw polygone id 576 start 332.4s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.14) at [(104.0, 53.0), (164.0, 53.0), (164.0, 64.0), (104.0, 64.0)] ;
    text id 97 start 332.6s at (113.0, 56.0) ''[color=#34D399]Étape 3 : Tableau complet[/color]'' ;

    # Réflexe 4
    draw arrow id 577 start 333.4s color (248, 250, 252, 0.8) width 1.5 at [(134.0, 64.5), (134.0, 70.5)] ;
    text id 98 start 333.7s for 3.8s at (4.0, 68.0) ''[color=#C084FC][bold]4.[/bold] Calculer l'extremum dans $f(x)$ (jamais $f^{\prime}$ !)[/color]'' ;
    draw polygone id 578 start 337.7s for 0.6s color (192, 132, 252, 0.9) width 1.5 fillcolor (192, 132, 252, 0.14) at [(104.0, 71.0), (164.0, 71.0), (164.0, 82.0), (104.0, 82.0)] ;
    text id 99 start 338.5s at (116.0, 74.0) ''[color=#C084FC]Étape 4 : Image $f(c)$[/color]'' ;

    # Bilan final
    text id 100 start 339.8s for 2.2s at (4.0, 84.0) ''[color=#34D399][bold]Résultat clé :[/bold] $\min f = f\!\left(\frac{3}{10}\right) = \frac{71}{20}$[/color]'' ;

}
