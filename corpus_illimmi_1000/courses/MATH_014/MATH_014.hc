course "Valeur absolue et distance sur la droite réelle" id 1 idgap 500 for 449.4s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION & DÉFINITION INTUITIVE DE LA VALEUR ABSOLUE
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Découverte & Définition Intuitive de la Valeur Absolue[/color][/bold]'' ;
    draw line id 501 start 2.7s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 4.5s for 2.0s at (4.0, 18.0) ''[color=#F8FAFC]Programme de Seconde : notion de [color=#38BDF8]valeur absolue[/color].[/color]'' ;
    text id 3 start 23.5s for 1.2s at (4.0, 28.0) ''[bold][color=#FBBF24]Principe fondamental :[/color][/bold]'' ;
    text id 101 start 25.5s for 1.5s at (4.0, 36.0) ''[color=#F8FAFC]Ramener tout nombre à sa [color=#34D399]valeur positive[/color],[/color]'' ;
    text id 102 start 28.0s for 2.0s at (4.0, 44.0) ''[color=#F8FAFC]sans son signe éventuel (distance à zéro).[/color]'' ;

    # Bloc Notation à droite
    draw polygone id 502 start 37.0s for 1.0s color (56, 189, 248, 0.8) width 1.8 fillcolor (56, 189, 248, 0.12) at [(96.0, 18.0), (170.0, 18.0), (170.0, 48.0), (96.0, 48.0)] ;
    text id 6 start 38.5s for 1.0s at (100.0, 23.0) ''[bold][color=#38BDF8]Notation universelle :[/color][/bold]'' ;
    text id 103 start 39.8s for 1.4s at (100.0, 31.0) ''[color=#F8FAFC]Deux barres verticales encadrant le réel :[/color]'' ;
    text id 7 start 41.5s for 1.8s at (126.0, 40.0) ''[bold][color=#FBBF24]$\mathbf{| x |}$[/color][/bold]'' ;

    # Exemples à gauche
    text id 4 start 48.5s for 2.0s at (4.0, 58.0) ''[color=#F8FAFC]• Nombre négatif : [color=#F87171]$-5$[/color] $\longrightarrow$ [color=#34D399]$5$[/color][/color]'' ;

    # Bloc Exemples à droite
    draw polygone id 505 start 53.0s for 0.8s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.12) at [(96.0, 54.0), (170.0, 54.0), (170.0, 88.0), (96.0, 88.0)] ;
    text id 8 start 54.5s for 0.8s at (100.0, 59.0) ''[bold][color=#34D399]Exemples immédiats :[/color][/bold]'' ;
    text id 9 start 55.6s for 1.2s at (104.0, 69.0) ''[color=#F8FAFC]$|-5| = 5$   [color=#94A3B8](le signe $-$ disparaît)[/color][/color]'' ;
    text id 5 start 57.3s for 2.0s at (4.0, 70.0) ''[color=#F8FAFC]• Nombre positif : [color=#34D399]$3$[/color] $\longrightarrow$ [color=#34D399]$3$[/color] (inchangé)[/color]'' ;
    text id 10 start 64.5s for 1.5s at (104.0, 79.0) ''[color=#F8FAFC]$|3| = 3$   [color=#94A3B8](le nombre reste identique)[/color][/color]'' ;

    erase id 2001 start 75.2s ;

    # =========================================================================
    # SCÈNE 2 : CAS 1 (|-7|) ET CAS 2 (|4|)
    # =========================================================================
    text id 11 start 76.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Entraînement : Cas 1 ($|-7|$) et Cas 2 ($|4|$)[/color][/bold]'' ;
    draw line id 506 start 78.2s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 12 start 79.5s for 1.8s at (4.0, 18.0) ''[bold][color=#FBBF24]Premier cas :[/color][/bold] [color=#F8FAFC]Calculer $|-7|$[/color]'' ;
    text id 13 start 82.5s for 2.5s at (4.0, 26.0) ''[color=#F8FAFC]Comme [color=#F87171]$-7 < 0$[/color], sa valeur positive est [color=#34D399]$7$[/color].[/color]'' ;

    # Encadré Cas 1 à droite
    draw polygone id 507 start 88.8s for 1.0s color (52, 211, 153, 0.8) width 1.8 fillcolor (52, 211, 153, 0.12) at [(96.0, 18.0), (170.0, 18.0), (170.0, 46.0), (96.0, 46.0)] ;
    text id 17 start 94.5s for 1.8s at (100.0, 23.0) ''[bold][color=#34D399]Résultat Cas 1 :[/color][/bold]'' ;
    text id 18 start 97.8s for 2.0s at (118.0, 34.0) ''[bold][color=#F8FAFC]$\mathbf{| -7 | = 7}$[/color][/bold]'' ;

    # Cas 2 à gauche
    text id 14 start 103.8s for 2.0s at (4.0, 42.0) ''[bold][color=#FBBF24]Deuxième cas :[/color][/bold] [color=#F8FAFC]Calculer $|4|$ ou $|+4|$[/color]'' ;
    text id 15 start 109.8s for 2.2s at (4.0, 50.0) ''[color=#F8FAFC]Le nombre $4$ est déjà positif : il reste [color=#34D399]$4$[/color].[/color]'' ;

    # Encadré Cas 2 à droite
    draw polygone id 508 start 114.5s for 1.0s color (56, 189, 248, 0.8) width 1.8 fillcolor (56, 189, 248, 0.12) at [(96.0, 52.0), (170.0, 52.0), (170.0, 88.0), (96.0, 88.0)] ;
    text id 19 start 116.8s for 0.8s at (100.0, 57.0) ''[bold][color=#38BDF8]Résultat Cas 2 :[/color][/bold]'' ;
    text id 20 start 118.0s for 1.2s at (118.0, 67.0) ''[bold][color=#F8FAFC]$\mathbf{| 4 | = 4}$[/color][/bold]'' ;

    text id 16 start 120.0s for 1.5s at (4.0, 66.0) ''[bold][color=#38BDF8]Propriété fondamentale :[/color][/bold]'' ;
    text id 104 start 122.5s for 2.0s at (4.0, 74.0) ''[color=#F8FAFC]Pour un nombre positif, les barres sont superflues ![/color]'' ;
    text id 21 start 126.0s for 2.5s at (104.0, 78.0) ''[bold][color=#C084FC]$\mathbf{|a| = a \quad \text{pour tout } a \ge 0}$[/color][/bold]'' ;

    erase id 2002 start 132.8s ;

    # =========================================================================
    # SCÈNE 3 : CAS 3 (|pi - 2|)
    # =========================================================================
    text id 22 start 133.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Cas 3 : Expression Algébrique Positive ($|\pi - 2|$)[/color][/bold]'' ;
    draw line id 509 start 135.8s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 23 start 139.5s for 2.2s at (4.0, 18.0) ''[bold][color=#FBBF24]Énoncé :[/color][/bold] [color=#F8FAFC]Écrire sans barres [color=#38BDF8]$|\pi - 2|$[/color].[/color]'' ;
    text id 24 start 144.5s for 1.5s at (4.0, 28.0) ''[bold][color=#38BDF8]Méthode du signe intérieur :[/color][/bold]'' ;
    text id 105 start 147.0s for 2.0s at (4.0, 36.0) ''[color=#F8FAFC]$\bullet$ Si $\pi - 2 \ge 0$ : conserver $\pi - 2$.[/color]'' ;
    text id 106 start 152.0s for 2.5s at (4.0, 44.0) ''[color=#F8FAFC]$\bullet$ Si $\pi - 2 < 0$ : prendre l'opposé $-(\pi - 2)$.[/color]'' ;

    text id 25 start 167.0s for 2.2s at (4.0, 58.0) ''[bold][color=#34D399]Valeur approchée :[/color][/bold] [color=#F8FAFC]$\pi \approx 3{,}14$[/color]'' ;

    # Raisonnement pas à pas à droite
    draw polygone id 510 start 172.5s for 1.0s color (56, 189, 248, 0.8) width 1.8 fillcolor (56, 189, 248, 0.12) at [(96.0, 18.0), (170.0, 18.0), (170.0, 54.0), (96.0, 54.0)] ;
    text id 27 start 174.5s for 1.5s at (100.0, 23.0) ''[bold][color=#38BDF8]Étude du signe intérieur :[/color][/bold]'' ;
    text id 28 start 177.0s for 1.8s at (104.0, 34.0) ''[color=#F8FAFC]$\pi - 2 \approx 3{,}14 - 2 \approx +1{,}14$[/color]'' ;
    text id 29 start 180.0s for 1.8s at (104.0, 44.0) ''[bold][color=#34D399]$+1{,}14 > 0 \implies \pi - 2 > 0$[/color][/bold]'' ;

    text id 26 start 182.2s for 2.5s at (4.0, 70.0) ''[color=#F8FAFC]Comme $\pi > 2$, la différence [color=#34D399]$\pi - 2 > 0$[/color] est positive.[/color]'' ;

    # Encadré Conclusion à droite
    draw polygone id 511 start 188.0s for 1.0s color (52, 211, 153, 0.8) width 2.0 fillcolor (52, 211, 153, 0.15) at [(96.0, 60.0), (170.0, 60.0), (170.0, 88.0), (96.0, 88.0)] ;
    text id 30 start 191.0s for 2.0s at (100.0, 65.0) ''[bold][color=#34D399]Conclusion (barres inchangées) :[/color][/bold]'' ;
    text id 31 start 197.5s for 2.5s at (114.0, 76.0) ''[bold][color=#F8FAFC]$\mathbf{| \pi - 2 | = \pi - 2}$[/color][/bold]'' ;

    erase id 2003 start 201.0s ;

    # =========================================================================
    # SCÈNE 4 : CAS 4 (|1 - sqrt(2)|) & PRISE DE L'OPPOSÉ
    # =========================================================================
    text id 32 start 201.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Cas 4 : Expression Négative ($|1 - \sqrt{2}|$) & Prise de l'Opposé[/color][/bold]'' ;
    draw line id 512 start 203.8s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 33 start 205.8s for 2.2s at (4.0, 18.0) ''[bold][color=#FBBF24]Énoncé :[/color][/bold] [color=#F8FAFC]Que vaut la valeur absolue [color=#F87171]$|1 - \sqrt{2}|$[/color] ?[/color]'' ;
    text id 34 start 216.0s for 2.2s at (4.0, 27.0) ''[bold][color=#38BDF8]Approximation :[/color][/bold] [color=#F8FAFC]$\sqrt{2} \approx 1{,}414$[/color]'' ;
    text id 35 start 225.0s for 2.5s at (4.0, 36.0) ''[bold][color=#F87171]Signe intérieur :[/color][/bold] [color=#F8FAFC]$1 - 1{,}414 \approx -0{,}414 < 0$[/color]'' ;
    text id 107 start 234.0s for 2.5s at (4.0, 44.0) ''[color=#F87171]La quantité $1 - \sqrt{2}$ est strictement négative ![/color]'' ;
    text id 36 start 248.0s for 1.8s at (4.0, 56.0) ''[bold][color=#FBBF24]Règle de l'opposé :[/color][/bold]'' ;
    text id 108 start 251.0s for 2.5s at (4.0, 64.0) ''[color=#F8FAFC]Pour un nombre négatif, on applique un signe moins devant.[/color]'' ;

    # Calcul détaillé à droite
    draw polygone id 513 start 258.2s for 1.0s color (248, 113, 113, 0.8) width 1.8 fillcolor (248, 113, 113, 0.12) at [(96.0, 18.0), (170.0, 18.0), (170.0, 58.0), (96.0, 58.0)] ;
    text id 38 start 261.2s for 2.0s at (100.0, 23.0) ''[bold][color=#F87171]Calcul rigoureux :[/color][/bold]'' ;
    text id 39 start 265.5s for 2.2s at (104.0, 32.0) ''[color=#F8FAFC]$|1 - \sqrt{2}| = -(1 - \sqrt{2})$[/color]'' ;

    text id 37 start 270.0s for 2.5s at (4.0, 76.0) ''[bold][color=#38BDF8]Développement :[/color][/bold] [color=#F8FAFC]$- (1 - \sqrt{2}) = -1 + \sqrt{2}$[/color]'' ;

    text id 40 start 275.0s for 2.2s at (104.0, 41.0) ''[color=#F8FAFC]$= -1 + \sqrt{2}$[/color]'' ;
    text id 41 start 283.5s for 2.2s at (104.0, 50.0) ''[bold][color=#34D399]$= \mathbf{\sqrt{2} - 1}$[/color][/bold]'' ;

    # Contrôle de positivité à droite
    draw polygone id 514 start 296.2s for 1.0s color (52, 211, 153, 0.8) width 1.8 fillcolor (52, 211, 153, 0.15) at [(96.0, 64.0), (170.0, 64.0), (170.0, 92.0), (96.0, 92.0)] ;
    text id 42 start 298.0s for 1.8s at (100.0, 68.0) ''[bold][color=#34D399]Contrôle de positivité :[/color][/bold]'' ;
    text id 43 start 301.5s for 2.5s at (104.0, 77.0) ''[color=#F8FAFC]$\sqrt{2} - 1 \approx 1{,}414 - 1 \approx 0{,}414 > 0$[/color]'' ;
    text id 44 start 308.0s for 2.5s at (100.0, 85.0) ''[bold][color=#38BDF8]Le résultat obtenu est bien positif ![/color][/bold]'' ;

    erase id 2004 start 314.5s ;

    # =========================================================================
    # SCÈNE 5 : DÉFINITION FORMELLE PAR MORCEAUX & PIÈGE DU MOINS a
    # =========================================================================
    text id 45 start 315.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Définition Formelle par Morceaux & Piège de $\mathbf{-a}$[/color][/bold]'' ;
    draw line id 515 start 317.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Formulation encadrée à droite
    draw polygone id 516 start 324.0s for 1.0s color (56, 189, 248, 0.8) width 2.0 fillcolor (56, 189, 248, 0.12) at [(96.0, 18.0), (170.0, 18.0), (170.0, 54.0), (96.0, 54.0)] ;
    text id 50 start 325.5s for 1.0s at (100.0, 23.0) ''[bold][color=#38BDF8]Formulation par morceaux :[/color][/bold]'' ;

    text id 46 start 327.0s for 2.0s at (4.0, 18.0) ''[bold][color=#FBBF24]Définition générale :[/color][/bold] [color=#F8FAFC]Pour tout nombre réel $a \in \mathbb{R}$ :[/color]'' ;
    text id 47 start 330.0s for 2.2s at (4.0, 28.0) ''[color=#34D399]• Si $a \ge 0$ : $|a| = a$[/color] [color=#94A3B8](ex : $|4| = 4$)[/color]'' ;

    text id 51 start 335.5s for 3.0s at (108.0, 34.0) ''[bold][color=#F8FAFC]$\mathbf{|a| = \begin{cases} a & \text{si } a \ge 0 \\ -a & \text{si } a < 0 \end{cases}}$[/color][/bold]'' ;

    text id 48 start 345.5s for 2.5s at (4.0, 38.0) ''[color=#F87171]• Si $a < 0$ : $|a| = -a$[/color] [color=#94A3B8](on prend l'opposé)[/color]'' ;
    text id 49 start 353.5s for 2.0s at (4.0, 52.0) ''[bold][color=#F87171]LE PIÈGE CLASSIQUE D'EXAMEN :[/color][/bold]'' ;
    text id 109 start 357.0s for 2.5s at (4.0, 60.0) ''[color=#F8FAFC]Croire que la notation [color=#F87171]$-a$[/color] est forcément négative ![/color]'' ;
    text id 110 start 363.0s for 3.0s at (4.0, 68.0) ''[color=#F8FAFC]Si $a < 0$, alors son opposé [color=#34D399]$-a$ est STRICTEMENT POSITIF ![/color][/color]'' ;

    # Application à -7 à droite
    draw polygone id 517 start 371.0s for 1.0s color (52, 211, 153, 0.8) width 1.8 fillcolor (52, 211, 153, 0.12) at [(96.0, 60.0), (170.0, 60.0), (170.0, 92.0), (96.0, 92.0)] ;
    text id 52 start 373.8s for 1.8s at (100.0, 64.0) ''[bold][color=#34D399]Application à $a = -7$ :[/color][/bold]'' ;
    text id 53 start 377.0s for 2.2s at (104.0, 72.0) ''[color=#F8FAFC]Comme $a = -7 < 0$, on applique $|a| = -a$ :[/color]'' ;
    text id 54 start 382.5s for 2.2s at (104.0, 80.0) ''[color=#F8FAFC]$|-7| = -(-7) = +7 = 7$[/color]'' ;
    text id 55 start 390.0s for 2.2s at (100.0, 86.0) ''[bold][color=#34D399]Règle des signes : $-(-7) = +7$[/color][/bold]'' ;

    erase id 2005 start 393.8s ;

    # =========================================================================
    # SCÈNE 6 : INTERPRÉTATION GÉOMÉTRIQUE & SYNTHÈSE
    # =========================================================================
    text id 56 start 394.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Interprétation Géométrique & Réflexes d'Examen[/color][/bold]'' ;
    draw line id 518 start 396.8s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Premier axe gradué (Distance OM = |x|)
    draw arrow id 519 start 402.0s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96.0, 32.0), (168.0, 32.0)] ;
    text id 60 start 403.5s at (166.0, 36.0) ''[color=#94A3B8]$x$[/color]'' ;

    draw line id 520 start 405.5s for 0.4s color (248, 250, 252, 0.95) width 2.0 at [(120.0, 29.5), (120.0, 34.5)] ;
    text id 61 start 406.2s at (118.5, 25.0) ''[bold][color=#38BDF8]$O$[/color][/bold]'' ;
    text id 62 start 407.4s at (118.5, 37.0) ''[color=#F8FAFC]$0$[/color]'' ;

    text id 57 start 408.2s for 0.8s at (4.0, 18.0) ''[bold][color=#FBBF24]Distance à l'origine :[/color][/bold]'' ;

    draw line id 521 start 409.5s for 0.4s color (251, 191, 36, 0.9) width 2.0 at [(152.0, 29.5), (152.0, 34.5)] ;
    text id 63 start 410.2s at (150.5, 25.0) ''[bold][color=#FBBF24]$M$[/color][/bold]'' ;
    text id 64 start 411.2s at (151.0, 37.0) ''[color=#FBBF24]$x$[/color]'' ;

    text id 111 start 412.5s for 1.5s at (4.0, 25.0) ''[color=#F8FAFC]Soit $M(x)$ un point de la droite réelle :[/color]'' ;

    draw line id 522 start 414.5s for 0.8s color (56, 189, 248, 0.9) width 3.0 at [(120.0, 28.0), (152.0, 28.0)] ;
    text id 65 start 416.5s for 1.5s at (126.0, 21.0) ''[bold][color=#38BDF8]$OM = |x|$[/color][/bold]'' ;

    text id 112 start 423.0s for 2.0s at (4.0, 32.0) ''[bold][color=#38BDF8]$\mathbf{OM = |x| \ge 0}$[/color][/bold] [color=#94A3B8](distance physique)[/color]'' ;

    text id 58 start 427.5s for 1.0s at (4.0, 44.0) ''[bold][color=#34D399]Distance entre deux points :[/color][/bold]'' ;

    # Deuxième axe gradué (Distance AB = |b - a|)
    draw arrow id 523 start 429.0s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96.0, 68.0), (168.0, 68.0)] ;

    draw line id 524 start 430.5s for 0.4s color (52, 211, 153, 0.9) width 2.0 at [(114.0, 65.5), (114.0, 70.5)] ;
    text id 66 start 431.2s at (112.5, 61.0) ''[bold][color=#34D399]$A$[/color][/bold]'' ;
    text id 67 start 431.8s at (113.0, 73.0) ''[color=#34D399]$a$[/color]'' ;

    draw line id 525 start 432.8s for 0.4s color (192, 132, 252, 0.9) width 2.0 at [(152.0, 65.5), (152.0, 70.5)] ;
    text id 68 start 433.5s at (150.5, 61.0) ''[bold][color=#C084FC]$B$[/color][/bold]'' ;
    text id 69 start 434.0s at (151.0, 73.0) ''[color=#C084FC]$b$[/color]'' ;

    draw line id 526 start 435.0s for 0.8s color (251, 191, 36, 0.9) width 3.0 at [(114.0, 64.0), (152.0, 64.0)] ;
    text id 70 start 436.5s for 1.5s at (120.0, 56.0) ''[bold][color=#FBBF24]$d(A, B) = |b - a|$[/color][/bold]'' ;

    text id 59 start 438.5s for 1.5s at (4.0, 56.0) ''[bold][color=#C084FC]Les 3 réflexes d'examen :[/color][/bold]'' ;
    text id 113 start 440.5s for 1.2s at (4.0, 64.0) ''[bold][color=#34D399]$\mathbf{d(A, B) = AB = |b - a| = |a - b|}$[/color][/bold]'' ;
    text id 114 start 442.2s for 1.5s at (4.0, 72.0) ''[color=#F8FAFC]1. Une valeur absolue est [color=#34D399]toujours positive ou nulle[/color].[/color]'' ;
    text id 115 start 444.2s for 1.5s at (4.0, 79.0) ''[color=#F8FAFC]2. Tester le signe intérieur pour retirer les barres.[/color]'' ;
    text id 116 start 446.2s for 1.8s at (4.0, 86.0) ''[color=#F8FAFC]3. Valeur absolue = [color=#38BDF8]distance sur la droite réelle[/color].[/color]'' ;

}
