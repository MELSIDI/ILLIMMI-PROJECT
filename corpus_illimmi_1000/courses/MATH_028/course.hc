course "Méthode pas à pas : Généralités sur les fonctions et lecture graphique" id 28 idgap 500 for 346.22s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 0 : Vocabulaire fondamental du repère cartésien (0.0s - 78.5s)
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold]1. Vocabulaire fondamental du repère cartésien[/bold]'' ;
    draw line id 501 start 2.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 6.0s for 2.2s at (5.0, 22.0) ''[bold]Objectifs d'apprentissage :[/bold]'' ;
    text id 3 start 9.0s for 2.0s at (5.0, 30.0) ''$\bullet$ Lire graphiquement l'[color=#38BDF8]image[/color] d'un nombre'' ;
    text id 4 start 11.4s for 2.5s at (5.0, 38.0) ''$\bullet$ Déterminer graphiquement les [color=#34D399]antécédents[/color]'' ;

    text id 5 start 26.0s for 2.0s at (5.0, 50.0) ''[bold]Le repère orthonormé $(O ; \vec{i}, \vec{j})$ :[/bold]'' ;

    draw 2drep id 502 start 33.5s for 2.0s at (133, 56) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 3] ;

    text id 6 start 38.5s for 2.2s at (5.0, 59.0) ''[color=#38BDF8]$\mathbf{1.\; Axe\; horizontal\; (Ox)}$[/color] : [bold]axe des abscisses[/bold]'' ;
    text id 7 start 42.0s for 2.2s at (5.0, 67.0) ''$\implies$ porte les valeurs de départ [color=#38BDF8]$x$[/color]'' ;
    draw arrow id 503 start 45.0s for 1.0s color (56, 189, 248, 1) width 2.0 at [(133, 56), (155, 56)] ;

    text id 8 start 47.5s for 2.2s at (5.0, 76.0) ''[color=#34D399]$\mathbf{2.\; Axe\; vertical\; (Oy)}$[/color] : [bold]axe des ordonnées[/bold]'' ;
    text id 9 start 52.0s for 2.0s at (5.0, 84.0) ''$\implies$ porte les images d'arrivée [color=#34D399]$f(x)$[/color]'' ;
    draw arrow id 504 start 54.5s for 1.0s color (52, 211, 153, 1) width 2.0 at [(133, 56), (133, 34)] ;

    text id 10 start 66.5s for 2.2s at (5.0, 92.0) ''[bold]Analogie de la machine :[/bold] $x \;\xrightarrow{\quad f \quad}\; f(x)$'' ;

    # =========================================================================
    # SCÈNE 1 : Méthode pas à pas : Lire une image (78.6s - 162.5s)
    # =========================================================================
    erase id 2001 start 78.6s ;

    text id 20 start 79.0s for 1.6s at (4.0, 7.5) ''[bold]2. Méthode pas à pas : Lire graphiquement une image[/bold]'' ;
    draw line id 510 start 81.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 511 start 82.5s for 1.5s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3.5, 3.5] y_range = [-3.5, 4.5] ;
    draw 2dfunc id 512 start 84.5s for 2.2s color (56, 189, 248, 1) width 2.5 at 511 y = (2 * x^3 - 8 * x) / 3 + 1 ;
    text id 21 start 87.5s for 1.0s at (160.5, 23.0) ''[color=#38BDF8]$\mathcal{C}_f$[/color]'' ;

    text id 22 start 89.5s for 2.0s at (5.0, 20.0) ''[bold]Exemple 1 : Déterminer l'image de 1 par $f$[/bold]'' ;
    text id 23 start 96.0s for 2.0s at (5.0, 27.0) ''1. Placer $x = 1$ sur l'axe des abscisses'' ;
    draw circle id 513 start 99.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 0.8 at (140.5, 55) ;

    text id 24 start 102.0s for 2.0s at (5.0, 34.0) ''2. Rejoindre verticalement la courbe $\mathcal{C}_f$'' ;
    draw arrow id 514 start 104.5s for 1.0s color (251, 191, 36, 1) width 2.0 at [(140.5, 55), (140.5, 62.5)] ;
    draw circle id 515 start 106.0s for 0.8s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.3) radius 0.8 at (140.5, 62.5) ;

    text id 25 start 109.0s for 2.0s at (5.0, 41.0) ''3. Projeter horizontalement vers l'axe $(Oy)$'' ;
    draw arrow id 516 start 111.5s for 1.0s color (251, 191, 36, 1) width 2.0 at [(140.5, 62.5), (133, 62.5)] ;
    draw circle id 517 start 113.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 0.8 at (133, 62.5) ;

    text id 26 start 117.0s for 2.0s at (5.0, 48.0) ''[color=#34D399][bold]$\implies$ Lecture sur l'axe vertical : $y = -1$[/bold][/color]'' ;
    text id 27 start 123.5s for 2.2s at (5.0, 56.0) ''[color=#34D399]$$\mathbf{f(1) = -1}$$[/color]'' ;

    text id 28 start 131.0s for 2.0s at (5.0, 65.0) ''[bold]Exemple 2 : Déterminer l'image de $-1$ par $f$[/bold]'' ;
    draw circle id 518 start 139.0s for 0.8s color (192, 132, 252, 1) fillcolor (192, 132, 252, 0.3) radius 0.8 at (125.5, 55) ;

    text id 29 start 144.0s for 2.0s at (5.0, 72.0) ''1. Placer $x = -1$ et monter vers $\mathcal{C}_f$'' ;
    draw arrow id 519 start 147.5s for 1.0s color (192, 132, 252, 1) width 2.0 at [(125.5, 55), (125.5, 32.5)] ;
    draw circle id 520 start 149.0s for 0.8s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.3) radius 0.8 at (125.5, 32.5) ;

    text id 30 start 152.0s for 1.6s at (5.0, 79.0) ''2. Projeter horizontalement vers l'axe $(Oy)$'' ;
    draw arrow id 521 start 154.0s for 1.0s color (192, 132, 252, 1) width 2.0 at [(125.5, 32.5), (133, 32.5)] ;
    draw circle id 522 start 156.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 0.8 at (133, 32.5) ;

    text id 31 start 158.5s for 2.2s at (5.0, 87.0) ''[color=#C084FC]$$\mathbf{f(-1) = 3}$$[/color]'' ;

    # =========================================================================
    # SCÈNE 2 : Méthode pas à pas : Déterminer un antécédent (162.6s - 223.0s)
    # =========================================================================
    erase id 2002 start 162.6s ;

    text id 40 start 163.5s for 1.6s at (4.0, 7.5) ''[bold]3. Méthode pas à pas : Déterminer un antécédent[/bold]'' ;
    draw line id 530 start 165.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 531 start 167.0s for 1.5s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3.5, 3.5] y_range = [-3.5, 4.5] ;
    draw 2dfunc id 532 start 169.0s for 2.2s color (56, 189, 248, 1) width 2.5 at 531 y = (2 * x^3 - 8 * x) / 3 + 1 ;

    text id 41 start 173.0s for 2.0s at (5.0, 22.0) ''[bold]Question posée :[/bold]'' ;
    text id 42 start 176.0s for 2.2s at (5.0, 30.0) ''Déterminer un [color=#FBBF24]antécédent de 3[/color] par $f$'' ;
    text id 43 start 180.0s for 2.5s at (5.0, 39.0) ''$\iff$ Résoudre graphiquement [color=#38BDF8]$f(x) = 3$[/color]'' ;

    text id 44 start 188.0s for 2.0s at (5.0, 50.0) ''[bold]Étapes de résolution :[/bold]'' ;
    text id 45 start 192.0s for 1.6s at (5.0, 58.0) ''1. Se placer en $y = 3$ sur l'axe des ordonnées'' ;
    draw circle id 533 start 194.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 0.8 at (133, 32.5) ;

    text id 46 start 197.0s for 2.0s at (5.0, 66.0) ''2. Tracer la droite horizontale [color=#FBBF24]$y = 3$[/color]'' ;
    draw line id 534 start 199.5s for 1.5s color (251, 191, 36, 0.9) width 2.2 at [(109, 32.5), (157, 32.5)] ;

    text id 47 start 204.0s for 2.0s at (5.0, 74.0) ''3. Repérer l'intersection avec la courbe $\mathcal{C}_f$'' ;
    draw circle id 535 start 206.5s for 0.8s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.3) radius 0.9 at (125.5, 32.5) ;

    text id 48 start 209.0s for 1.6s at (5.0, 82.0) ''4. Projeter verticalement sur l'axe des abscisses'' ;
    draw arrow id 536 start 211.0s for 1.0s color (52, 211, 153, 1) width 2.0 at [(125.5, 32.5), (125.5, 55)] ;
    draw circle id 537 start 213.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 0.8 at (125.5, 55) ;

    text id 49 start 215.5s for 2.5s at (5.0, 90.0) ''[color=#34D399][bold]$\implies -1$ est un antécédent de 3 par $f$ ($f(-1) = 3$)[/bold][/color]'' ;

    # =========================================================================
    # SCÈNE 3 : Multiplicité des antécédents (223.1s - 287.5s)
    # =========================================================================
    erase id 2003 start 223.1s ;

    text id 60 start 224.0s for 1.6s at (4.0, 7.5) ''[bold]4. Cas particulier : Multiplicité des antécédents[/bold]'' ;
    draw line id 550 start 226.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 61 start 227.0s for 1.6s at (5.0, 20.0) ''[bold]Propriété fondamentale :[/bold]'' ;
    text id 62 start 229.0s for 2.2s at (5.0, 27.0) ''Un nombre peut avoir [color=#F87171]0, 1 ou plusieurs[/color] antécédents !'' ;

    text id 63 start 236.0s for 2.2s at (5.0, 36.0) ''[bold]Exemple :[/bold] Déterminer les antécédents de 1'' ;
    text id 64 start 241.0s for 1.6s at (5.0, 43.0) ''$\iff$ Résoudre l'équation [color=#38BDF8]$f(x) = 1$[/color]'' ;

    draw 2drep id 551 start 243.0s for 1.5s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3.5, 3.5] y_range = [-3.5, 4.5] ;
    draw 2dfunc id 552 start 245.0s for 2.2s color (56, 189, 248, 1) width 2.5 at 551 y = (2 * x^3 - 8 * x) / 3 + 1 ;

    draw line id 553 start 251.5s for 1.2s color (248, 113, 113, 0.95) width 2.2 at [(109, 47.5), (157, 47.5)] ;
    text id 65 start 253.0s for 1.5s at (158.0, 46.5) ''[color=#F87171]$y = 1$[/color]'' ;

    text id 66 start 258.0s for 1.6s at (5.0, 52.0) ''$\mathbf{3}$ points d'intersection avec la courbe $\mathcal{C}_f$ :'' ;
    draw circle id 554 start 260.0s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 0.8 at (118, 47.5) ;
    draw circle id 555 start 260.8s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 0.8 at (133, 47.5) ;
    draw circle id 556 start 261.6s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 0.8 at (148, 47.5) ;

    draw arrow id 557 start 263.0s for 0.6s color (52, 211, 153, 1) width 1.8 at [(118, 47.5), (118, 55)] ;
    draw arrow id 558 start 264.0s for 0.6s color (52, 211, 153, 1) width 1.8 at [(133, 47.5), (133, 55)] ;
    draw arrow id 559 start 265.0s for 0.6s color (52, 211, 153, 1) width 1.8 at [(148, 47.5), (148, 55)] ;

    text id 67 start 268.0s for 2.0s at (5.0, 60.0) ''$\bullet$ Premier point : [color=#34D399]$x_1 = -2$[/color]'' ;
    text id 68 start 271.0s for 2.0s at (5.0, 67.0) ''$\bullet$ Deuxième point : [color=#34D399]$x_2 = 0$[/color]'' ;
    text id 69 start 274.0s for 2.0s at (5.0, 74.0) ''$\bullet$ Troisième point : [color=#34D399]$x_3 = 2$[/color]'' ;

    text id 70 start 279.0s for 2.5s at (5.0, 82.0) ''$$f(-2) = 1 \quad;\quad f(0) = 1 \quad;\quad f(2) = 1$$'' ;
    text id 71 start 284.0s for 2.5s at (5.0, 91.0) ''[color=#38BDF8][bold]Les antécédents de 1 par $f$ sont : $\{-2 \;;\; 0 \;;\; 2\}$[/bold][/color]'' ;

    # =========================================================================
    # SCÈNE 4 : Fiche réflexe & Erreurs fréquentes d'examen (287.6s - 347.0s)
    # =========================================================================
    erase id 2004 start 287.6s ;

    text id 80 start 288.2s for 1.8s at (4.0, 7.5) ''[bold]5. Fiche réflexe : Synthèse & Pièges d'examen[/bold]'' ;
    draw line id 570 start 290.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 571 start 295.0s for 1.2s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.12) width 1.5 at [(5, 19), (86, 19), (86, 68), (5, 68)] ;
    text id 81 start 296.5s for 2.0s at (8.0, 23.0) ''[bold][color=#38BDF8]MÉTHODE : LIRE UNE IMAGE $f(x)$[/color][/bold]'' ;
    text id 82 start 301.0s for 2.2s at (8.0, 31.0) ''[bold]1. Départ :[/bold] Axe des abscisses en $x$'' ;
    text id 83 start 306.0s for 2.2s at (8.0, 39.0) ''[bold]2. Trajet :[/bold] Rejoindre $\mathcal{C}_f$ verticalement'' ;
    text id 84 start 311.0s for 2.2s at (8.0, 47.0) ''[bold]3. Arrivée :[/bold] Lire $f(x)$ sur l'axe vertical $(Oy)$'' ;
    text id 85 start 315.0s for 1.6s at (8.0, 57.0) ''[color=#34D399]$\mathbf{\implies}$ L'image d'un réel est UNIQUE ![/color]'' ;

    draw polygone id 572 start 317.0s for 1.2s color (251, 191, 36, 0.9) fillcolor (251, 191, 36, 0.12) width 1.5 at [(93, 19), (173, 19), (173, 68), (93, 68)] ;
    text id 86 start 318.5s for 2.0s at (96.0, 23.0) ''[bold][color=#FBBF24]MÉTHODE : LIRE LES ANTÉCÉDENTS[/color][/bold]'' ;
    text id 87 start 321.0s for 2.2s at (96.0, 31.0) ''[bold]1. Départ :[/bold] Axe des ordonnées en $y = k$'' ;
    text id 88 start 324.0s for 2.2s at (96.0, 39.0) ''[bold]2. Trajet :[/bold] Tracer la droite horizontale $y = k$'' ;
    text id 89 start 327.0s for 2.2s at (96.0, 47.0) ''[bold]3. Arrivée :[/bold] Projeter les intersections vers $(Ox)$'' ;
    text id 90 start 329.5s for 2.0s at (96.0, 57.0) ''[color=#FBBF24]$\mathbf{\implies}$ Peut avoir 0, 1 ou plusieurs solutions ![/color]'' ;

    draw polygone id 573 start 332.0s for 1.2s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.12) width 1.5 at [(5, 73), (173, 73), (173, 94), (5, 94)] ;
    text id 91 start 333.5s for 2.2s at (8.0, 77.0) ''[bold][color=#F87171]PIÈGE D'EXAMEN : NE JAMAIS INVERSER LE SENS DE LECTURE ![/color][/bold]'' ;
    text id 92 start 336.5s for 2.5s at (8.0, 84.0) ''[color=#F8FAFC]Image : $\mathbf{\text{Abscisse } x \longrightarrow \text{Ordonnée } y}$ $\quad\vert\quad$ Antécédent : $\mathbf{\text{Ordonnée } y \longrightarrow \text{Abscisse } x}$[/color]'' ;

}
