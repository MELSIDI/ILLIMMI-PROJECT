course "Exemple guidé : Généralités sur les fonctions et lecture graphique" id 23 idgap 500 for 297.5s audio "narration.wav" {
    # =========================================================================
    # SCÈNE 1 : INTRODUCTION & REPÈRE ORTHOGONAL
    # =========================================================================
    text id 1 start 0.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Généralités sur les fonctions : Lecture graphique[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 3.4s for 3.0s at (5.0, 24.0) ''[color=#F8FAFC]Objectif du cours :[/color]'' ;
    text id 3 start 6.8s for 2.2s at (7.0, 38.0) ''[color=#34D399]• Déterminer graphiquement l'image d'un nombre[/color]'' ;
    text id 4 start 9.2s for 2.4s at (7.0, 52.0) ''[color=#FBBF24]• Déterminer les antécédents d'un nombre[/color]'' ;

    draw 2drep id 502 start 12.0s for 2.6s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 5] y_range = [-4, 4] ;
    draw 2dfunc id 503 start 15.0s for 2.5s color (52, 211, 153, 1.0) width 2.8 at 502 y = 0 - 0.0159*x^3 - 0.27*x^2 + 0.651*x + 2.905 ;
    text id 5 start 17.8s at (105.0, 20.0) ''[color=#34D399]Courbe en vert : $\mathcal{C}_f$[/color]'' ;

    text id 6 start 19.5s for 3.5s at (5.0, 68.0) ''[color=#94A3B8]Compétence clé du programme de Seconde[/color]'' ;
    text id 7 start 23.5s for 2.2s at (5.0, 82.0) ''[color=#38BDF8]Lien direct entre coordonnées et fonction[/color]'' ;

    erase id 2001 start 26.05s ;

    # =========================================================================
    # SCÈNE 2 : MÉTHODE POUR DÉTERMINER L'IMAGE D'UN NOMBRE
    # =========================================================================
    text id 11 start 26.2s for 1.6s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Méthode : Déterminer l'image d'un nombre[/color][/bold]'' ;
    draw line id 511 start 28.0s for 0.7s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 12 start 29.8s for 2.8s at (5.0, 24.0) ''[color=#F8FAFC]Définition :[/color]'' ;
    text id 13 start 33.0s for 3.5s at (5.0, 36.0) ''[color=#38BDF8]L'image de $x$ par $f$ est la valeur de sortie $f(x)$[/color]'' ;
    text id 14 start 37.5s for 2.5s at (5.0, 50.0) ''[color=#FBBF24][bold]Règle fondamentale des axes :[/bold][/color]'' ;

    draw arrow id 512 start 40.4s for 0.8s color (52, 211, 153, 1) width 2.5 at [(102, 60), (164, 60)] ;
    text id 15 start 41.6s for 3.8s at (7.0, 64.0) ''[color=#34D399]1. Valeur de départ $x$ : axe des abscisses (horizontal)[/color]'' ;
    text id 16 start 45.8s for 0.8s at (148.0, 64.0) ''[color=#34D399]$x$ (abscisse)[/color]'' ;

    draw arrow id 513 start 46.8s for 0.8s color (56, 189, 248, 1) width 2.5 at [(133, 85), (133, 25)] ;
    text id 17 start 48.0s for 3.6s at (7.0, 78.0) ''[color=#38BDF8]2. Valeur d'arrivée $y = f(x)$ : axe des ordonnées (vertical)[/color]'' ;
    text id 18 start 52.0s for 0.8s at (136.0, 28.0) ''[color=#38BDF8]$y$ (ordonnée)[/color]'' ;

    erase id 2002 start 53.35s ;

    # =========================================================================
    # SCÈNE 3 : EXEMPLE 1 — IMAGE DE -4
    # =========================================================================
    text id 21 start 53.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Exemple 1 : Déterminer l'image de $-4$[/color][/bold]'' ;
    draw line id 521 start 55.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 522 start 56.5s for 1.0s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 5] y_range = [-4, 4] ;
    draw 2dfunc id 523 start 57.8s for 1.5s color (52, 211, 153, 1.0) width 2.8 at 522 y = 0 - 0.0159*x^3 - 0.27*x^2 + 0.651*x + 2.905 ;

    text id 22 start 59.5s for 2.0s at (5.0, 22.0) ''[color=#FBBF24][bold]Question :[/bold] Déterminer l'image de $-4$ par $f$[/color]'' ;
    text id 23 start 62.0s for 2.8s at (5.0, 34.0) ''[color=#F8FAFC]1. Entrée : on pose [color=#34D399]$x = -4$[/color] (axe horizontal)[/color]'' ;
    draw circle id 524 start 68.2s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 0.8 at (111.0, 55.0) ;

    text id 24 start 69.2s for 2.4s at (5.0, 46.0) ''[color=#F8FAFC]2. On descend verticalement vers $\mathcal{C}_f$[/color]'' ;
    draw arrow id 525 start 75.0s for 1.8s color (251, 191, 36, 1) width 2.2 at [(111.0, 55.0), (111.0, 71.5)] ;
    draw circle id 526 start 80.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.0 at (111.0, 71.5) ;

    text id 25 start 82.5s for 2.8s at (5.0, 58.0) ''[color=#F8FAFC]3. Projection horizontale vers l'axe vertical[/color]'' ;
    draw arrow id 527 start 85.5s for 1.8s color (251, 191, 36, 1) width 2.2 at [(111.0, 71.5), (133.0, 71.5)] ;
    draw circle id 528 start 89.5s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 0.8 at (133.0, 71.5) ;

    text id 26 start 92.6s for 3.2s at (5.0, 70.0) ''[color=#38BDF8][bold]Résultat :[/bold] L'image de $-4$ par $f$ est [bold]$-3$[/bold][/color]'' ;
    text id 27 start 97.2s for 2.5s at (5.0, 82.0) ''[color=#F8FAFC]Notation : [bold][color=#34D399]$f(-4) = -3$[/color][/bold][/color]'' ;
    text id 28 start 102.5s for 2.8s at (45.0, 82.0) ''[color=#F8FAFC]ou [bold][color=#38BDF8]$f : -4 \mapsto -3$[/color][/bold][/color]'' ;

    erase id 2003 start 108.3s ;

    # =========================================================================
    # SCÈNE 4 : EXEMPLE 2 — IMAGE DE 2
    # =========================================================================
    text id 31 start 108.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Exemple 2 : Déterminer l'image de $2$[/color][/bold]'' ;
    draw line id 531 start 110.5s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 532 start 111.5s for 0.8s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 5] y_range = [-4, 4] ;
    draw 2dfunc id 533 start 112.5s for 0.8s color (52, 211, 153, 1.0) width 2.8 at 532 y = 0 - 0.0159*x^3 - 0.27*x^2 + 0.651*x + 2.905 ;

    text id 32 start 113.5s for 2.2s at (5.0, 22.0) ''[color=#FBBF24][bold]Question :[/bold] Déterminer l'image de $2$ par $f$[/color]'' ;
    text id 33 start 116.0s for 2.6s at (5.0, 34.0) ''[color=#F8FAFC]1. Entrée : on pose [color=#34D399]$x = 2$[/color] sur l'axe horizontal[/color]'' ;
    draw circle id 534 start 119.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 0.8 at (144.0, 55.0) ;

    text id 34 start 120.0s for 2.8s at (5.0, 46.0) ''[color=#F8FAFC]2. On monte verticalement vers $\mathcal{C}_f$[/color]'' ;
    draw arrow id 535 start 125.5s for 1.8s color (251, 191, 36, 1) width 2.2 at [(144.0, 55.0), (144.0, 38.5)] ;
    draw circle id 536 start 128.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.0 at (144.0, 38.5) ;

    text id 35 start 129.2s for 2.8s at (5.0, 58.0) ''[color=#F8FAFC]3. Projection horizontale vers la gauche[/color]'' ;
    draw arrow id 537 start 132.2s for 1.4s color (251, 191, 36, 1) width 2.2 at [(144.0, 38.5), (133.0, 38.5)] ;
    draw circle id 538 start 134.0s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 0.8 at (133.0, 38.5) ;

    text id 36 start 136.7s for 2.8s at (5.0, 70.0) ''[color=#38BDF8][bold]Résultat :[/bold] L'image de $2$ par $f$ est [bold]$3$[/bold][/color]'' ;
    text id 37 start 140.0s for 2.2s at (5.0, 82.0) ''[color=#F8FAFC]Notation : [bold][color=#34D399]$f(2) = 3$[/color][/bold][/color]'' ;

    erase id 2004 start 142.95s ;

    # =========================================================================
    # SCÈNE 5 : CHEMIN INVERSE — DÉFINITION DES ANTÉCÉDENTS
    # =========================================================================
    text id 41 start 143.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Le chemin inverse : Notion d'antécédent[/color][/bold]'' ;
    draw line id 541 start 145.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 42 start 146.5s for 2.5s at (5.0, 24.0) ''[color=#F8FAFC]Principe fondamental :[/color]'' ;
    text id 43 start 149.5s for 3.8s at (5.0, 36.0) ''[color=#FBBF24]Chercher les antécédents de $k$, c'est résoudre $f(x) = k$[/color]'' ;
    text id 44 start 153.8s for 3.5s at (5.0, 50.0) ''[color=#38BDF8]On connaît la sortie $y$, on cherche le départ $x$[/color]'' ;

    draw arrow id 542 start 157.8s for 1.2s color (251, 191, 36, 1) width 2.5 at [(155, 60), (105, 60)] ;
    text id 45 start 159.5s for 1.2s at (98.0, 52.0) ''[color=#34D399]$x$ (antécédents)[/color]'' ;
    text id 46 start 161.0s for 1.2s at (140.0, 52.0) ''[color=#38BDF8]$y$ (image donnée)[/color]'' ;

    text id 47 start 163.7s for 3.5s at (5.0, 68.0) ''[color=#F8FAFC]Point de départ : [bold][color=#34D399]axe des ordonnées $y$[/color][/bold][/color]'' ;
    text id 48 start 167.5s for 1.2s at (5.0, 82.0) ''[color=#94A3B8]Puis tracé d'une droite horizontale pour couper $\mathcal{C}_f$[/color]'' ;

    erase id 2005 start 169.05s ;

    # =========================================================================
    # SCÈNE 6 : EXEMPLE 3 — ANTÉCÉDENTS DE 2
    # =========================================================================
    text id 51 start 169.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Exemple 3 : Déterminer les antécédents de $2$[/color][/bold]'' ;
    draw line id 551 start 171.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 552 start 172.2s for 0.8s at (133, 55) color (248, 250, 252, 0.95) width 1.5 scale = 5.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 5] y_range = [-4, 4] ;
    draw 2dfunc id 553 start 173.2s for 0.8s color (52, 211, 153, 1.0) width 2.8 at 552 y = 0 - 0.0159*x^3 - 0.27*x^2 + 0.651*x + 2.905 ;

    text id 52 start 174.2s for 1.8s at (5.0, 20.0) ''[color=#FBBF24][bold]Question :[/bold] Résoudre graphiquement $f(x) = 2$[/color]'' ;
    draw circle id 554 start 176.2s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 0.8 at (133.0, 44.0) ;

    draw line id 555 start 178.2s for 2.0s color (248, 113, 113, 1) width 2.0 at [(105.0, 44.0), (161.0, 44.0)] ;
    text id 53 start 181.0s for 2.5s at (5.0, 31.0) ''[color=#F8FAFC]1. Droite horizontale [color=#F87171]$y = 2$[/color][/color]'' ;

    draw circle id 556 start 188.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.0 at (149.5, 44.0) ;
    draw arrow id 557 start 191.0s for 1.5s color (251, 191, 36, 1) width 2.2 at [(149.5, 44.0), (149.5, 55.0)] ;
    draw circle id 558 start 194.5s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) radius 0.8 at (149.5, 55.0) ;
    text id 54 start 196.0s for 2.6s at (5.0, 42.0) ''[color=#34D399]Premier antécédent à droite : [bold]$x_1 = 3$[/bold][/color]'' ;

    draw circle id 559 start 203.5s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.0 at (127.5, 44.0) ;
    draw arrow id 560 start 206.5s for 1.5s color (251, 191, 36, 1) width 2.2 at [(127.5, 44.0), (127.5, 55.0)] ;
    draw circle id 561 start 209.5s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.4) radius 0.8 at (127.5, 55.0) ;
    text id 55 start 211.5s for 2.6s at (5.0, 53.0) ''[color=#34D399]Second antécédent à gauche : [bold]$x_2 = -1$[/bold][/color]'' ;

    text id 56 start 215.0s for 3.0s at (5.0, 65.0) ''[color=#38BDF8][bold]Conclusion :[/bold] Les antécédents de $2$ sont [bold]$3$ et $-1$[/bold][/color]'' ;
    text id 57 start 219.0s for 2.8s at (5.0, 77.0) ''[color=#F8FAFC]Preuve : [color=#34D399]$f(3) = 2$[/color] et [color=#34D399]$f(-1) = 2$[/color][/color]'' ;
    text id 58 start 222.5s for 2.8s at (5.0, 88.0) ''[color=#FBBF24]L'équation $f(x) = 2$ possède deux solutions distinctes[/color]'' ;

    erase id 2006 start 226.25s ;

    # =========================================================================
    # SCÈNE 7 : ERREUR FRÉQUENTE — UNICITÉ VS MULTIPLICITÉ
    # =========================================================================
    text id 61 start 226.5s for 1.8s at (4.0, 7.5) ''[bold][color=#F87171]7. Piège d'examen : Image vs Antécédents[/color][/bold]'' ;
    draw line id 571 start 228.5s for 0.8s color (248, 113, 113, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 62 start 229.5s for 3.2s at (5.0, 22.0) ''[color=#FBBF24][bold]Attention à la confusion fréquente ![/bold][/color]'' ;

    draw polygone id 572 start 233.0s for 1.2s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.12) width 1.5 at [(5, 28), (86, 28), (86, 56), (5, 56)] ;
    text id 63 start 234.5s for 3.5s at (7.0, 33.0) ''[color=#34D399][bold]L'IMAGE (au singulier) :[/bold][/color]'' ;
    text id 64 start 238.5s for 3.5s at (7.0, 41.0) ''[color=#F8FAFC]• Un nombre $x$ a [bold]AU PLUS UNE[/bold] image[/color]'' ;
    text id 65 start 242.5s for 3.0s at (7.0, 49.0) ''[color=#94A3B8]• Une abscisse $x$ donne une seule hauteur $y$[/color]'' ;

    draw polygone id 573 start 246.0s for 1.2s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.5 at [(5, 60), (86, 60), (86, 91), (5, 91)] ;
    text id 66 start 247.5s for 3.5s at (7.0, 65.0) ''[color=#38BDF8][bold]LES ANTÉCÉDENTS (au pluriel) :[/bold][/color]'' ;
    text id 67 start 251.5s for 3.2s at (7.0, 73.0) ''[color=#F8FAFC]• Un nombre $y$ peut avoir [bold]$0, 1$ ou plusieurs[/bold] antécédents[/color]'' ;
    text id 68 start 255.2s for 3.2s at (7.0, 81.0) ''[color=#94A3B8]• Une droite horizontale peut couper la courbe plusieurs fois[/color]'' ;

    draw polygone id 574 start 258.8s for 1.0s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.15) width 1.5 at [(96, 28), (170, 28), (170, 88), (96, 88)] ;
    text id 69 start 260.0s at (100.0, 35.0) ''[color=#FBBF24][bold]Règle d'or du vocabulaire :[/bold][/color]'' ;
    text id 70 start 260.4s at (100.0, 48.0) ''[color=#F8FAFC]« L'image de $x$ » mais « Un antécédent de $y$ »[/color]'' ;

    erase id 2007 start 261.45s ;

    # =========================================================================
    # SCÈNE 8 : SYNTHÈSE & RÉFLEXES POUR LE CONTRÔLE
    # =========================================================================
    text id 71 start 261.6s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. Synthèse & Réflexes Méthodologiques[/color][/bold]'' ;
    draw line id 581 start 263.6s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 582 start 265.0s for 1.0s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.15) width 1.5 at [(5, 20), (86, 20), (86, 52), (5, 52)] ;
    text id 72 start 266.2s for 2.5s at (7.0, 25.0) ''[color=#34D399][bold]1. Lire une Image :[/bold][/color]'' ;
    text id 73 start 269.0s for 3.2s at (7.0, 34.0) ''[color=#F8FAFC]Départ : [bold]Axe des abscisses $x$[/bold][/color]'' ;
    text id 74 start 272.5s for 3.2s at (7.0, 43.0) ''[color=#38BDF8]Arrivée : [bold]Axe des ordonnées $y = f(x)$[/bold][/color]'' ;

    draw polygone id 583 start 276.2s for 1.0s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.15) width 1.5 at [(5, 56), (86, 56), (86, 91), (5, 91)] ;
    text id 75 start 277.5s for 2.5s at (7.0, 61.0) ''[color=#FBBF24][bold]2. Lire des Antécédents :[/bold][/color]'' ;
    text id 76 start 280.5s for 3.2s at (7.0, 70.0) ''[color=#F8FAFC]Départ : [bold]Axe des ordonnées $y$[/bold][/color]'' ;
    text id 77 start 284.2s for 3.8s at (7.0, 79.0) ''[color=#34D399]Arrivée : [bold]Axe des abscisses $x$ ($0, 1$ ou $+$)[/bold][/color]'' ;

    draw polygone id 584 start 288.5s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 1.5 at [(96, 20), (170, 20), (170, 88), (96, 88)] ;
    text id 78 start 289.8s for 2.5s at (100.0, 27.0) ''[color=#38BDF8][bold]Les 3 conseils pour le contrôle :[/bold][/color]'' ;
    text id 79 start 292.5s for 2.5s at (100.0, 42.0) ''[color=#F8FAFC]1. Trace toujours des pointillés nets[/color]'' ;
    text id 80 start 295.2s for 2.1s at (100.0, 58.0) ''[color=#34D399]2. Indique le sens des flèches[/color]'' ;
    text id 81 start 297.5s at (100.0, 74.0) ''[color=#FBBF24]3. Soigne les notations formelles[/color]'' ;
}
