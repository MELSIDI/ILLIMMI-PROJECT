course "Exemple guidé et calcul détaillé : Valeur absolue et distance sur la droite réelle en pratique" id 13 idgap 500 for 369.35s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction et Définition Géométrique (0.0s -> 53.8s)
    # =========================================================================

    text id 1 start 0.5s for 1.5s at (4.0, 6.0) ''[bold][color=#FBBF24]I. Valeur Absolue et Distance sur la Droite Réelle[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4.0, 11.5), (173.0, 11.5)] ;

    # Objectif et propriété fondamentale
    text id 2 start 4.7s for 2.8s at (4.0, 17.0) ''[color=#F8FAFC]Objectif : Résoudre graphiquement des équations avec valeurs absolues.[/color]'' ;
    draw arrow id 502 start 12.0s for 1.2s color (248, 250, 252, 0.9) width 1.8 at [(96.0, 52.0), (168.0, 52.0)] ;
    draw line id 503 start 13.5s for 0.5s color (248, 250, 252, 0.7) width 1.2 at [(106.0, 50.0), (106.0, 54.0)] ;
    draw line id 504 start 14.2s for 0.5s color (248, 250, 252, 0.7) width 1.2 at [(124.0, 50.0), (124.0, 54.0)] ;
    text id 3 start 14.8s for 2.8s at (4.0, 27.0) ''[bold][color=#38BDF8]Propriété fondamentale :[/color][/bold]'' ;
    draw line id 505 start 17.8s for 0.5s color (248, 250, 252, 0.7) width 1.2 at [(150.0, 50.0), (150.0, 54.0)] ;
    text id 9 start 18.5s at (105.0, 57.0) ''[color=#94A3B8]$0$[/color]'' ;

    text id 4 start 18.8s for 1.5s at (4.0, 35.0) ''[color=#F8FAFC]Soient $A(a)$ et $B(b)$ deux points d'une droite graduée.[/color]'' ;
    draw circle id 506 start 20.5s for 0.5s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.25) radius 1.4 at (124.0, 52.0) ;
    text id 10 start 21.3s for 0.8s at (121.5, 44.0) ''[bold][color=#38BDF8]$A$[/color][/bold]'' ;
    text id 11 start 22.3s for 0.8s at (122.5, 57.0) ''[color=#38BDF8]$a$[/color]'' ;

    draw circle id 507 start 23.5s for 0.5s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.25) radius 1.4 at (150.0, 52.0) ;
    text id 12 start 24.3s for 0.8s at (148.0, 44.0) ''[bold][color=#34D399]$B$[/color][/bold]'' ;
    text id 13 start 25.3s for 0.8s at (148.5, 57.0) ''[color=#34D399]$b$[/color]'' ;

    text id 5 start 26.5s for 2.5s at (4.0, 46.0) ''[bold][color=#34D399]$\mathbf{AB = |a - b| = |b - a|}$[/color][/bold]'' ;
    draw line id 508 start 29.3s for 0.8s color (251, 191, 36, 1) width 3.0 at [(124.0, 52.0), (150.0, 52.0)] ;
    draw line id 509 start 30.3s for 0.4s color (251, 191, 36, 0.8) width 1.2 at [(124.0, 36.0), (124.0, 42.0)] ;
    draw line id 510 start 30.9s for 0.4s color (251, 191, 36, 0.8) width 1.2 at [(150.0, 36.0), (150.0, 42.0)] ;
    draw arrow id 511 start 31.5s for 0.6s color (251, 191, 36, 0.9) width 1.5 at [(137.0, 37.0), (124.0, 37.0)] ;
    draw arrow id 512 start 32.3s for 0.6s color (251, 191, 36, 0.9) width 1.5 at [(137.0, 37.0), (150.0, 37.0)] ;
    text id 14 start 33.2s for 1.8s at (127.0, 31.0) ''[bold][color=#FBBF24]$d = |a - b|$[/color][/bold]'' ;

    text id 6 start 35.6s for 2.0s at (4.0, 58.0) ''[bold][color=#FBBF24]Interprétation géométrique :[/color][/bold]'' ;
    text id 7 start 40.0s for 3.5s at (4.0, 67.0) ''[color=#F8FAFC]$|a - b|$ est la distance entre les réels $a$ et $b$.[/color]'' ;
    text id 8 start 47.0s for 3.5s at (4.0, 78.0) ''[color=#C084FC]Une distance est toujours positive ou nulle : $|a - b| \ge 0$.[/color]'' ;

    erase id 2001 start 53.8s ;

    # =========================================================================
    # SCENE 2 : Premier Exemple Guidé : |x - 5| = 2 (53.8s -> 163.0s)
    # =========================================================================

    text id 15 start 54.5s for 1.5s at (4.0, 6.0) ''[bold][color=#FBBF24]II. Premier Exemple : Résolution de $|x - 5| = 2$[/color][/bold]'' ;
    draw line id 513 start 56.3s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4.0, 11.5), (173.0, 11.5)] ;

    text id 16 start 59.5s for 2.5s at (4.0, 18.0) ''[bold][color=#38BDF8]Équation : $\mathbf{|x - 5| = 2}$[/color][/bold]'' ;
    text id 17 start 68.0s for 3.2s at (4.0, 28.0) ''[color=#F8FAFC]Traduction : Distance entre l'inconnue $x$ et $5$ égale à $2$.[/color]'' ;
    text id 18 start 78.0s for 2.5s at (4.0, 38.0) ''[bold][color=#FBBF24]$\mathbf{d(x, 5) = 2}$[/color][/bold]'' ;

    # Tracé de l'axe gradué
    draw arrow id 514 start 93.0s for 1.2s color (248, 250, 252, 0.9) width 1.8 at [(94.0, 54.0), (168.0, 54.0)] ;
    draw circle id 515 start 96.5s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.25) radius 1.5 at (132.0, 54.0) ;
    text id 22 start 97.6s for 1.0s at (130.5, 60.0) ''[bold][color=#FBBF24]$5$[/color][/bold]'' ;
    text id 23 start 99.0s for 1.5s at (125.0, 45.0) ''[color=#FBBF24]Référence[/color]'' ;

    draw line id 516 start 101.5s for 0.4s color (248, 250, 252, 0.7) width 1.2 at [(116.0, 52.0), (116.0, 56.0)] ;
    text id 24 start 102.2s at (114.5, 60.0) ''[color=#94A3B8]$3$[/color]'' ;
    draw line id 517 start 103.5s for 0.4s color (248, 250, 252, 0.7) width 1.2 at [(148.0, 52.0), (148.0, 56.0)] ;
    text id 25 start 104.2s at (146.5, 60.0) ''[color=#94A3B8]$7$[/color]'' ;

    # Flèche saut vers la gauche
    draw arrow id 518 start 110.0s for 1.5s color (52, 211, 153, 1) width 2.2 at [(132.0, 40.0), (116.0, 40.0)] ;
    text id 26 start 112.0s for 1.5s at (120.0, 34.0) ''[bold][color=#34D399]$-2$[/color][/bold]'' ;

    # Flèche saut vers la droite
    draw arrow id 520 start 116.0s for 1.5s color (56, 189, 248, 1) width 2.2 at [(132.0, 40.0), (148.0, 40.0)] ;
    text id 28 start 118.0s for 1.5s at (137.0, 34.0) ''[bold][color=#38BDF8]$+2$[/color][/bold]'' ;

    # Déductions à gauche
    text id 19 start 120.0s for 3.0s at (4.0, 50.0) ''[color=#34D399]Vers la gauche : $x_1 = 5 - 2 = 3$[/color]'' ;
    draw circle id 519 start 123.5s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 1.5 at (116.0, 54.0) ;
    text id 27 start 127.0s for 1.8s at (110.0, 68.0) ''[bold][color=#34D399]$x_1 = 3$[/color][/bold]'' ;

    text id 20 start 136.5s for 3.0s at (4.0, 62.0) ''[color=#38BDF8]Vers la droite : $x_2 = 5 + 2 = 7$[/color]'' ;
    draw circle id 521 start 140.0s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.3) radius 1.5 at (148.0, 54.0) ;
    text id 29 start 143.5s for 1.8s at (143.0, 68.0) ''[bold][color=#38BDF8]$x_2 = 7$[/color][/bold]'' ;

    text id 21 start 151.0s for 3.5s at (4.0, 75.0) ''[bold][color=#FBBF24]Deux solutions trouvées : $x = 3$ ou $x = 7$[/color][/bold]'' ;

    erase id 2002 start 163.0s ;

    # =========================================================================
    # SCENE 3 : Vérification Algébrique Détaillée (163.0s -> 221.2s)
    # =========================================================================

    text id 30 start 163.5s for 1.5s at (4.0, 6.0) ''[bold][color=#FBBF24]III. Vérification Algébrique Rigoureuse[/color][/bold]'' ;
    draw line id 522 start 165.3s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4.0, 11.5), (173.0, 11.5)] ;

    # Encadré gauche pour x = 3
    draw polygone id 523 start 166.5s for 0.8s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.12) at [(6.0, 18.0), (84.0, 18.0), (84.0, 58.0), (6.0, 58.0)] ;
    text id 31 start 167.8s for 2.2s at (10.0, 23.0) ''[bold][color=#34D399]1) Test de la solution $x = 3$ :[/color][/bold]'' ;
    text id 32 start 172.0s for 2.5s at (12.0, 32.0) ''[color=#F8FAFC]$|x - 5| = |3 - 5|$[/color]'' ;
    text id 33 start 175.5s for 2.2s at (12.0, 41.0) ''[color=#F8FAFC]$= |-2| = 2$[/color]'' ;
    text id 34 start 185.5s for 2.8s at (12.0, 50.0) ''[bold][color=#34D399]$\implies 2 = 2$ : Vrai ! $x = 3$ convient.[/color][/bold]'' ;

    # Encadré droit pour x = 7
    draw polygone id 524 start 193.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.12) at [(94.0, 18.0), (172.0, 18.0), (172.0, 58.0), (94.0, 58.0)] ;
    text id 35 start 194.2s for 2.2s at (98.0, 23.0) ''[bold][color=#38BDF8]2) Test de la solution $x = 7$ :[/color][/bold]'' ;
    text id 36 start 199.0s for 2.5s at (100.0, 32.0) ''[color=#F8FAFC]$|x - 5| = |7 - 5|$[/color]'' ;
    text id 37 start 202.5s for 2.2s at (100.0, 41.0) ''[color=#F8FAFC]$= |2| = 2$[/color]'' ;
    text id 38 start 207.0s for 2.8s at (100.0, 50.0) ''[bold][color=#38BDF8]$\implies 2 = 2$ : Vrai ! $x = 7$ convient.[/color][/bold]'' ;

    # Bannière bilan en bas
    draw polygone id 525 start 212.0s for 0.8s color (251, 191, 36, 0.9) width 1.8 fillcolor (251, 191, 36, 0.15) at [(28.0, 66.0), (150.0, 66.0), (150.0, 88.0), (28.0, 88.0)] ;
    text id 39 start 213.5s for 2.2s at (34.0, 71.0) ''[bold][color=#FBBF24]Conclusion pour la première équation :[/color][/bold]'' ;
    text id 40 start 217.0s for 3.0s at (64.0, 79.0) ''[bold][color=#F8FAFC]$\mathbf{S = \{3 ; 7\}}$[/color][/bold]'' ;

    erase id 2003 start 221.2s ;

    # =========================================================================
    # SCENE 4 : Deuxième Exemple & Piège du Signe Plus (221.2s -> 334.3s)
    # =========================================================================

    text id 41 start 221.5s for 1.5s at (4.0, 6.0) ''[bold][color=#FBBF24]IV. Deuxième Exemple : Résolution de $|x + 3| = 1$[/color][/bold]'' ;
    draw line id 526 start 223.3s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4.0, 11.5), (173.0, 11.5)] ;

    text id 42 start 229.0s for 2.5s at (4.0, 17.0) ''[bold][color=#F87171]Équation : $\mathbf{|x + 3| = 1}$[/color][/bold]'' ;
    text id 43 start 238.0s for 3.5s at (4.0, 27.0) ''[color=#F87171]Piège : On a une addition $+ 3$, pas une soustraction ![/color]'' ;
    text id 44 start 258.0s for 3.2s at (4.0, 38.0) ''[color=#38BDF8]Règle : $x + 3 = x - (-3)$ (soustraire l'opposé)[/color]'' ;
    text id 45 start 268.0s for 3.0s at (4.0, 49.0) ''[bold][color=#34D399]Forme canonique : $\mathbf{|x - (-3)| = 1}$[/color][/bold]'' ;
    text id 46 start 277.0s for 3.5s at (4.0, 60.0) ''[color=#F8FAFC]Traduction : Distance entre $x$ et $-3$ égale à $1$.[/color]'' ;

    # Tracé de l'axe à droite
    draw arrow id 527 start 286.0s for 1.2s color (248, 250, 252, 0.9) width 1.8 at [(94.0, 54.0), (168.0, 54.0)] ;
    draw circle id 528 start 289.5s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.25) radius 1.5 at (131.0, 54.0) ;
    text id 50 start 290.6s for 1.0s at (128.5, 60.0) ''[bold][color=#38BDF8]$-3$[/color][/bold]'' ;
    text id 51 start 292.0s for 1.5s at (124.0, 45.0) ''[color=#38BDF8]Référence[/color]'' ;

    draw line id 529 start 294.0s for 0.4s color (248, 250, 252, 0.7) width 1.2 at [(115.0, 52.0), (115.0, 56.0)] ;
    text id 52 start 294.6s at (113.0, 60.0) ''[color=#94A3B8]$-4$[/color]'' ;
    draw line id 530 start 295.5s for 0.4s color (248, 250, 252, 0.7) width 1.2 at [(147.0, 52.0), (147.0, 56.0)] ;
    text id 53 start 296.1s at (145.0, 60.0) ''[color=#94A3B8]$-2$[/color]'' ;

    # Sauts de 1 unité
    draw arrow id 531 start 301.5s for 1.5s color (248, 113, 113, 1) width 2.2 at [(131.0, 40.0), (115.0, 40.0)] ;
    text id 54 start 303.3s for 1.2s at (119.5, 34.0) ''[bold][color=#F87171]$-1$[/color][/bold]'' ;

    text id 47 start 308.0s for 2.2s at (4.0, 71.0) ''[color=#F87171]Vers la gauche : $x_1 = -3 - 1 = -4$[/color]'' ;
    draw circle id 532 start 310.5s for 0.8s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.3) radius 1.5 at (115.0, 54.0) ;
    text id 55 start 312.0s for 1.8s at (109.0, 68.0) ''[bold][color=#F87171]$x_1 = -4$[/color][/bold]'' ;

    draw arrow id 533 start 315.0s for 1.5s color (52, 211, 153, 1) width 2.2 at [(131.0, 40.0), (147.0, 40.0)] ;
    text id 56 start 316.8s for 0.9s at (136.0, 34.0) ''[bold][color=#34D399]$+1$[/color][/bold]'' ;

    text id 48 start 318.0s for 2.5s at (4.0, 81.0) ''[color=#38BDF8]Vers la droite : $x_2 = -3 + 1 = -2$[/color]'' ;
    draw circle id 534 start 321.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) radius 1.5 at (147.0, 54.0) ;
    text id 57 start 322.5s for 1.8s at (142.0, 68.0) ''[bold][color=#34D399]$x_2 = -2$[/color][/bold]'' ;

    text id 49 start 328.0s for 3.2s at (4.0, 91.0) ''[bold][color=#FBBF24]Solutions : $\mathbf{S = \{-4 ; -2\}}$[/color][/bold]'' ;

    erase id 2004 start 334.3s ;

    # =========================================================================
    # SCENE 5 : Synthèse Méthodologique & Réflexes Examen (334.3s -> 369.35s)
    # =========================================================================

    text id 58 start 334.6s for 1.5s at (4.0, 6.0) ''[bold][color=#FBBF24]V. Synthèse Méthodologique & Réflexes Examen[/color][/bold]'' ;
    draw line id 535 start 336.3s for 0.8s color (56, 189, 248, 0.8) width 1.2 at [(4.0, 11.5), (173.0, 11.5)] ;

    # Carte gauche : Formule standard
    draw polygone id 536 start 337.5s for 0.8s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.12) at [(6.0, 18.0), (86.0, 18.0), (86.0, 88.0), (6.0, 88.0)] ;
    text id 59 start 338.6s for 1.8s at (10.0, 24.0) ''[bold][color=#34D399]Formule Standard ($r \ge 0$) :[/color][/bold]'' ;
    text id 60 start 341.0s for 2.2s at (14.0, 36.0) ''[bold][color=#F8FAFC]$\mathbf{|x - a| = r}$[/color][/bold]'' ;
    text id 61 start 344.0s for 2.2s at (10.0, 48.0) ''[color=#F8FAFC]Distance entre $x$ et le centre $a$ vaut $r$.[/color]'' ;
    text id 62 start 347.0s for 2.8s at (10.0, 62.0) ''[bold][color=#34D399]$\mathbf{S = \{a - r \;;\; a + r\}}$[/color][/bold]'' ;
    text id 63 start 350.5s for 2.2s at (10.0, 76.0) ''[color=#FBBF24]$a - r \longleftarrow a \longrightarrow a + r$[/color]'' ;

    # Carte droite : Pièges fréquents
    draw polygone id 537 start 353.0s for 0.8s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.12) at [(94.0, 18.0), (174.0, 18.0), (174.0, 88.0), (94.0, 88.0)] ;
    text id 64 start 354.2s for 2.2s at (98.0, 24.0) ''[bold][color=#FBBF24]Piège 1 : Le signe $+$[/color][/bold]'' ;
    text id 65 start 356.8s for 2.5s at (98.0, 36.0) ''[color=#F8FAFC]$|x + c| = r \iff |x - (-c)| = r$[/color]'' ;
    text id 66 start 360.0s for 2.2s at (98.0, 48.0) ''[color=#38BDF8]Le centre de référence est $-c$.[/color]'' ;
    text id 67 start 362.5s for 2.2s at (98.0, 62.0) ''[bold][color=#F87171]Piège 2 : Rayon négatif ($r < 0$)[/color][/bold]'' ;
    text id 68 start 365.0s for 2.5s at (98.0, 74.0) ''[bold][color=#F87171]$\mathbf{|x - a| < 0 \implies S = \emptyset}$[/color][/bold]'' ;
    text id 69 start 367.8s at (98.0, 83.0) ''[color=#94A3B8]Une distance ne peut pas être négative ![/color]'' ;

}
