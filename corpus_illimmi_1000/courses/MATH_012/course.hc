course "Méthode pas à pas : Comment résoudre un problème de Valeur absolue et distance sur la droite réelle" id 1 idgap 500 for 648.9s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction & Enoncé du problème
    # =========================================================================

    text id 1 start 0.8s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction & Objectif du cours[/color][/bold]'' ;
    draw line id 501 start 3.0s for 1.2s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 10.5s for 2.5s at (5.0, 22.0) ''[bold][color=#F8FAFC]Problème à résoudre :[/color][/bold]'' ;
    text id 3 start 13.5s for 2.5s at (5.0, 31.0) ''[color=#FBBF24]Représenter sur la droite réelle les réels $x$ vérifiant :[/color]'' ;
    text id 4 start 17.5s for 2.8s at (12.0, 41.0) ''[bold][color=#38BDF8]$$|x - 5| \le 2$$[/color][/bold]'' ;

    text id 5 start 22.0s for 2.5s at (5.0, 56.0) ''[color=#34D399]Objectif : Traduire cette inéquation géométriquement.[/color]'' ;
    text id 6 start 29.5s for 2.5s at (5.0, 68.0) ''[color=#F8FAFC]Étape préliminaire : Comprendre la notation $|x|$.[/color]'' ;
    text id 7 start 36.5s for 2.5s at (5.0, 79.0) ''[color=#C084FC]Notation : Deux barres verticales encadrant un nombre.[/color]'' ;

    # Right side: Visual Preview of Graduated Line
    draw polygone id 502 start 12.0s for 1.2s color (56, 189, 248, 0.4) fillcolor (56, 189, 248, 0.08) width 1.5 at [(96, 22), (168, 22), (168, 86), (96, 86)] ;
    text id 8 start 14.0s for 2.0s at (102.0, 28.0) ''[bold][color=#38BDF8]Aperçu géométrique : Droite réelle[/color][/bold]'' ;
    draw arrow id 503 start 19.5s for 1.5s color (248, 250, 252, 0.8) width 2.0 at [(102, 54), (162, 54)] ;
    draw circle id 504 start 25.0s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 1.5 at (132, 54) ;
    text id 9 start 26.2s for 1.2s at (130.0, 60.0) ''[color=#FBBF24]$A(5)$[/color]'' ;
    draw line id 505 start 31.0s for 1.2s color (52, 211, 153, 0.9) width 4.0 at [(120, 54), (144, 54)] ;
    text id 10 start 33.0s for 2.0s at (106.0, 72.0) ''[color=#34D399]Zone des solutions : $d(M, A) \le 2$[/color]'' ;
    mouse move id 1501 start 41.0s for 1.5s at [(132, 70), (132, 54)] ;

    erase id 2001 start 46.5s ;

    # =========================================================================
    # SCENE 2 : Approche intuitive & Exemples concrets
    # =========================================================================

    text id 20 start 47.5s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Approche intuitive de la valeur absolue[/color][/bold]'' ;
    draw line id 510 start 49.8s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left Column: Positives
    text id 21 start 52.0s for 2.2s at (5.0, 20.0) ''[bold][color=#34D399]Nombres positifs ($a \ge 0$) :[/color][/bold]'' ;
    text id 22 start 56.0s for 2.5s at (8.0, 28.0) ''[color=#F8FAFC]$$|3| = 3$$[/color]'' ;
    text id 23 start 63.0s for 2.0s at (32.0, 29.0) ''[color=#38BDF8]Le nombre reste inchangé[/color]'' ;
    text id 24 start 72.0s for 2.0s at (8.0, 39.0) ''[color=#F8FAFC]$$|10| = 10$$[/color]'' ;
    text id 25 start 78.0s for 2.0s at (32.0, 40.0) ''[color=#38BDF8]Identique pour tout positif[/color]'' ;
    text id 26 start 82.0s for 2.5s at (8.0, 50.0) ''[color=#F8FAFC]$$|1023| = 1023$$[/color]'' ;
    text id 27 start 87.5s for 2.2s at (8.0, 61.0) ''[color=#34D399]Pour tout $a \ge 0$ : $|a| = a$[/color]'' ;

    # Right Column: Negatives
    text id 28 start 93.0s for 2.5s at (94.0, 20.0) ''[bold][color=#F87171]Nombres négatifs ($a < 0$) :[/color][/bold]'' ;
    text id 29 start 101.0s for 2.5s at (98.0, 28.0) ''[color=#F8FAFC]$$|-3| = 3$$[/color]'' ;
    text id 30 start 106.5s for 2.5s at (126.0, 29.0) ''[color=#FBBF24]L'opposé est positif[/color]'' ;
    text id 31 start 111.0s for 2.0s at (98.0, 39.0) ''[color=#F8FAFC]$$|-7| = 7$$[/color]'' ;
    text id 32 start 115.0s for 2.0s at (98.0, 50.0) ''[color=#F8FAFC]$$|-1023| = 1023$$[/color]'' ;

    # Bottom Synthesis Box
    draw polygone id 511 start 120.0s for 1.2s color (251, 191, 36, 0.6) fillcolor (251, 191, 36, 0.08) width 1.5 at [(15, 72), (163, 72), (163, 93), (15, 93)] ;
    text id 33 start 122.5s for 3.0s at (20.0, 76.0) ''[bold][color=#FBBF24]Intuition :[/color][/bold] [color=#F8FAFC]La valeur absolue isole la grandeur en effaçant le signe négatif.[/color]'' ;
    text id 34 start 128.0s for 3.5s at (20.0, 84.0) ''[color=#34D399]Règle fondamentale : La valeur absolue est TOUJOURS positive ou nulle ($|x| \ge 0$).[/color]'' ;
    mouse move id 1502 start 133.5s for 1.5s at [(88, 70), (88, 84)] ;

    erase id 2002 start 137.5s ;

    # =========================================================================
    # SCENE 3 : Définition formelle par disjonction de cas
    # =========================================================================

    text id 40 start 138.8s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Définition formelle par disjonction de cas[/color][/bold]'' ;
    draw line id 520 start 141.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left: Definition
    text id 41 start 143.0s for 2.5s at (5.0, 20.0) ''[bold][color=#F8FAFC]Définition mathématique formelle :[/color][/bold]'' ;
    draw polygone id 521 start 146.5s for 1.2s color (56, 189, 248, 0.6) fillcolor (56, 189, 248, 0.08) width 2.0 at [(5, 27), (85, 27), (85, 59), (5, 59)] ;
    text id 42 start 149.0s for 3.2s at (10.0, 32.0) ''[bold][color=#38BDF8]$$|a| = \begin{cases} a & \text{si } a \ge 0 \\ -a & \text{si } a < 0 \end{cases}$$[/color][/bold]'' ;

    text id 43 start 159.0s for 2.5s at (5.0, 65.0) ''[bold][color=#F87171]Attention au piège de l'écriture $-a$ :[/color][/bold]'' ;
    text id 44 start 163.5s for 3.2s at (5.0, 73.0) ''[color=#F8FAFC]L'écriture $-a$ ne signifie PAS que le résultat est négatif ![/color]'' ;
    text id 45 start 169.0s for 3.0s at (5.0, 82.0) ''[color=#FBBF24]$-a$ désigne l'opposé du nombre $a$.[/color]'' ;

    # Right: Step-by-step example with a = -3
    text id 46 start 175.5s for 2.5s at (94.0, 20.0) ''[bold][color=#34D399]Exemple rigoureux avec un nombre négatif :[/color][/bold]'' ;
    text id 47 start 179.0s for 2.0s at (98.0, 30.0) ''[color=#F8FAFC]Soit $a = -3 < 0$. Alors d'après la définition :[/color]'' ;
    text id 48 start 182.5s for 3.0s at (98.0, 41.0) ''[bold][color=#38BDF8]$$|a| = -a = -(-3)$$[/color][/bold]'' ;
    text id 49 start 187.0s for 2.5s at (98.0, 53.0) ''[color=#FBBF24]Règle des signes : $-(-3) = +3$[/color]'' ;
    draw arrow id 522 start 192.0s for 1.2s color (52, 211, 153, 1) width 2.0 at [(132, 57), (132, 65)] ;
    text id 50 start 194.5s for 3.0s at (98.0, 68.0) ''[color=#34D399]L'opposé d'un nombre négatif est un nombre positif ![/color]'' ;

    draw polygone id 523 start 204.0s for 1.0s color (52, 211, 153, 0.7) fillcolor (52, 211, 153, 0.1) width 1.5 at [(94, 76), (170, 76), (170, 93), (94, 93)] ;
    text id 51 start 206.0s for 3.0s at (98.0, 81.0) ''[bold][color=#34D399]Règle d'or :[/color][/bold] [color=#F8FAFC]Pour tout $x \in \mathbb{R}$, $|x| \ge 0$.[/color]'' ;
    mouse move id 1503 start 211.5s for 1.5s at [(135, 70), (135, 84)] ;

    erase id 2003 start 216.5s ;

    # =========================================================================
    # SCENE 4 : Distance géométrique sur la droite réelle
    # =========================================================================

    text id 60 start 218.0s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Distance géométrique sur la droite réelle[/color][/bold]'' ;
    draw line id 530 start 220.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left: Formula & Naive calculation
    text id 61 start 223.5s for 2.5s at (5.0, 20.0) ''[bold][color=#F8FAFC]Propriété fondamentale sur l'axe gradué :[/color][/bold]'' ;
    draw polygone id 531 start 229.0s for 1.2s color (251, 191, 36, 0.6) fillcolor (251, 191, 36, 0.08) width 2.0 at [(5, 27), (85, 27), (85, 43), (5, 43)] ;
    text id 62 start 231.5s for 3.0s at (10.0, 32.0) ''[bold][color=#FBBF24]$$AB = |a - b| = |b - a|$$[/color][/bold]'' ;

    text id 63 start 244.5s for 2.5s at (5.0, 48.0) ''[bold][color=#F87171]Pourquoi la valeur absolue est-elle nécessaire ?[/color][/bold]'' ;
    text id 64 start 254.0s for 2.5s at (5.0, 56.0) ''[color=#F8FAFC]Calcul naïf sans valeur absolue pour $A(1)$ et $B(6)$ :[/color]'' ;
    text id 65 start 263.0s for 3.0s at (10.0, 65.0) ''[color=#F87171]$$a - b = 1 - 6 = -5 < 0 \quad \text{(Impossible !)}$$[/color]'' ;
    text id 66 start 270.0s for 2.8s at (5.0, 76.0) ''[color=#F87171]Une distance géométrique est toujours positive ![/color]'' ;
    text id 67 start 303.0s for 3.5s at (5.0, 85.0) ''[bold][color=#34D399]$$AB = |1 - 6| = |-5| = 5 = |6 - 1|$$[/color][/bold]'' ;

    # Right: Graduated Line with A(1) and B(6)
    text id 68 start 253.5s for 2.0s at (94.0, 20.0) ''[bold][color=#38BDF8]Illustration géométrique :[/color][/bold]'' ;
    draw arrow id 532 start 256.0s for 1.5s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    # Ticks 0 to 7
    draw line id 533 start 258.5s color (248, 250, 252, 0.6) width 1.5 at [(100, 50), (100, 54)] ;
    draw line id 534 start 259.0s color (248, 250, 252, 0.6) width 1.5 at [(109, 50), (109, 54)] ;
    draw line id 535 start 259.5s color (248, 250, 252, 0.6) width 1.5 at [(118, 50), (118, 54)] ;
    draw line id 536 start 260.0s color (248, 250, 252, 0.6) width 1.5 at [(127, 50), (127, 54)] ;
    draw line id 537 start 260.5s color (248, 250, 252, 0.6) width 1.5 at [(136, 50), (136, 54)] ;
    draw line id 538 start 261.0s color (248, 250, 252, 0.6) width 1.5 at [(145, 50), (145, 54)] ;
    draw line id 539 start 261.5s color (248, 250, 252, 0.6) width 1.5 at [(154, 50), (154, 54)] ;
    draw line id 540 start 262.0s color (248, 250, 252, 0.6) width 1.5 at [(163, 50), (163, 54)] ;

    # Labels under ticks
    text id 69 start 264.0s at (99.0, 57.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 70 start 264.3s at (108.0, 57.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;
    text id 71 start 264.6s at (117.0, 57.0) ''[color=#94A3B8]$2$[/color]'' ;
    text id 72 start 264.9s at (126.0, 57.0) ''[color=#94A3B8]$3$[/color]'' ;
    text id 73 start 265.2s at (135.0, 57.0) ''[color=#94A3B8]$4$[/color]'' ;
    text id 74 start 265.5s at (144.0, 57.0) ''[color=#94A3B8]$5$[/color]'' ;
    text id 75 start 265.8s at (153.0, 57.0) ''[bold][color=#FBBF24]$6$[/color][/bold]'' ;
    text id 76 start 266.1s at (162.0, 57.0) ''[color=#94A3B8]$7$[/color]'' ;

    # Points A and B
    draw circle id 541 start 267.0s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 1.5 at (109, 52) ;
    text id 77 start 268.2s for 1.2s at (107.0, 44.0) ''[bold][color=#38BDF8]$A$[/color][/bold]'' ;
    draw circle id 542 start 269.8s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.4) radius 1.5 at (154, 52) ;
    text id 78 start 271.0s for 1.2s at (152.0, 44.0) ''[bold][color=#FBBF24]$B$[/color][/bold]'' ;

    # Segment AB & measurement bracket
    draw line id 543 start 285.0s for 1.8s color (52, 211, 153, 1) width 4.0 at [(109, 52), (154, 52)] ;
    draw path id 544 start 288.0s for 1.2s color (52, 211, 153, 0.9) width 1.5 at [(109, 39), (109, 36), (154, 36), (154, 39)] ;
    text id 79 start 290.5s for 2.0s at (126.0, 30.0) ''[bold][color=#34D399]$AB = 5$ unités[/color][/bold]'' ;
    text id 80 start 318.0s for 3.0s at (98.0, 74.0) ''[bold][color=#C084FC]Symétrie : $d(A, B) = d(B, A)$[/color][/bold]'' ;
    mouse move id 1504 start 323.0s for 1.5s at [(109, 36), (154, 36)] ;

    erase id 2004 start 327.5s ;

    # =========================================================================
    # SCENE 5 : Résolution pas à pas de |x - 5| <= 2
    # =========================================================================

    text id 100 start 328.8s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Résolution géométrique pas à pas : $|x - 5| \le 2$[/color][/bold]'' ;
    draw line id 550 start 331.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left: Steps
    text id 101 start 333.5s for 2.5s at (5.0, 20.0) ''[bold][color=#FBBF24]Inéquation posée : $|x - 5| \le 2$[/color][/bold]'' ;
    text id 102 start 341.0s for 2.5s at (5.0, 28.0) ''[bold][color=#F8FAFC]Traduction géométrique :[/color][/bold]'' ;
    text id 103 start 345.0s for 3.0s at (8.0, 36.0) ''[color=#38BDF8]Soit $M(x)$ et $A(5)$ sur l'axe réel gradué.[/color]'' ;
    text id 104 start 352.0s for 3.0s at (8.0, 44.0) ''[color=#F8FAFC]Alors $|x - 5| = MA$ représente la distance entre $M$ et $A$.[/color]'' ;
    text id 105 start 363.0s for 3.0s at (8.0, 54.0) ''[bold][color=#34D399]$$|x - 5| \le 2 \iff MA \le 2$$[/color][/bold]'' ;
    text id 106 start 372.0s for 3.0s at (5.0, 66.0) ''[color=#C084FC]Le point $M$ ne doit pas s'éloigner de plus de $2$ unités de $A$.[/color]'' ;
    text id 107 start 405.0s for 3.0s at (5.0, 76.0) ''[color=#38BDF8]À droite de $A$ : $x \le 5 + 2 = 7$[/color]'' ;
    text id 108 start 445.0s for 3.0s at (5.0, 85.0) ''[color=#FBBF24]À gauche de $A$ : $x \ge 5 - 2 = 3$[/color]'' ;

    # Right: The Problem Axis
    text id 109 start 381.0s for 2.0s at (94.0, 20.0) ''[bold][color=#38BDF8]Droite graduée des solutions :[/color][/bold]'' ;
    draw arrow id 551 start 383.5s for 1.5s color (248, 250, 252, 0.9) width 2.0 at [(94, 52), (170, 52)] ;

    # Ticks 1 to 9 (step = 8 canvas units)
    draw line id 552 start 385.5s color (248, 250, 252, 0.5) width 1.5 at [(98, 50), (98, 54)] ;
    draw line id 553 start 386.0s color (248, 250, 252, 0.5) width 1.5 at [(106, 50), (106, 54)] ;
    draw line id 554 start 386.5s color (248, 250, 252, 0.5) width 1.5 at [(114, 50), (114, 54)] ;
    draw line id 555 start 387.0s color (248, 250, 252, 0.5) width 1.5 at [(122, 50), (122, 54)] ;
    draw line id 556 start 387.5s color (248, 250, 252, 0.5) width 1.5 at [(130, 50), (130, 54)] ;
    draw line id 557 start 388.0s color (248, 250, 252, 0.5) width 1.5 at [(138, 50), (138, 54)] ;
    draw line id 558 start 388.5s color (248, 250, 252, 0.5) width 1.5 at [(146, 50), (146, 54)] ;
    draw line id 559 start 389.0s color (248, 250, 252, 0.5) width 1.5 at [(154, 50), (154, 54)] ;
    draw line id 560 start 389.5s color (248, 250, 252, 0.5) width 1.5 at [(162, 50), (162, 54)] ;

    # Labels
    text id 110 start 390.2s at (97.0, 57.0) ''[color=#94A3B8]$1$[/color]'' ;
    text id 111 start 390.4s at (105.0, 57.0) ''[color=#94A3B8]$2$[/color]'' ;
    text id 112 start 390.6s at (113.0, 57.0) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;
    text id 113 start 390.8s at (121.0, 57.0) ''[color=#94A3B8]$4$[/color]'' ;
    text id 114 start 391.0s at (129.0, 57.0) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 115 start 391.2s at (137.0, 57.0) ''[color=#94A3B8]$6$[/color]'' ;
    text id 116 start 391.4s at (145.0, 57.0) ''[bold][color=#38BDF8]$7$[/color][/bold]'' ;
    text id 117 start 391.6s at (153.0, 57.0) ''[color=#94A3B8]$8$[/color]'' ;
    text id 118 start 391.8s at (161.0, 57.0) ''[color=#94A3B8]$9$[/color]'' ;

    # Center Point A(5)
    draw circle id 561 start 392.5s for 1.0s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.4) radius 1.8 at (130, 52) ;
    text id 119 start 394.0s for 1.5s at (128.0, 44.0) ''[bold][color=#38BDF8]$A(5)$[/color][/bold]'' ;

    # Right distance arrow (+2)
    draw arrow id 562 start 411.0s for 1.5s color (56, 189, 248, 0.9) width 2.0 at [(130, 36), (146, 36)] ;
    text id 120 start 413.5s for 1.5s at (135.0, 30.0) ''[color=#38BDF8]$+2$[/color]'' ;
    draw line id 563 start 415.5s color (56, 189, 248, 0.5) width 1.0 at [(146, 36), (146, 50)] ;

    # Left distance arrow (-2)
    draw arrow id 564 start 448.0s for 1.5s color (251, 191, 36, 0.9) width 2.0 at [(130, 36), (114, 36)] ;
    text id 121 start 450.5s for 1.5s at (119.0, 30.0) ''[color=#FBBF24]$-2$[/color]'' ;
    draw line id 565 start 452.5s color (251, 191, 36, 0.5) width 1.0 at [(114, 36), (114, 50)] ;

    # Segment [3 ; 7] and Brackets
    draw line id 566 start 468.0s for 2.2s color (52, 211, 153, 1) width 5.0 at [(114, 52), (146, 52)] ;
    draw path id 567 start 472.0s for 1.0s color (52, 211, 153, 1) width 2.5 at [(116, 48), (114, 48), (114, 56), (116, 56)] ;
    draw path id 568 start 474.0s for 1.0s color (52, 211, 153, 1) width 2.5 at [(144, 48), (146, 48), (146, 56), (144, 56)] ;

    # Solution Banner
    draw polygone id 569 start 477.0s for 1.2s color (52, 211, 153, 0.7) fillcolor (52, 211, 153, 0.12) width 1.5 at [(96, 72), (166, 72), (166, 92), (96, 92)] ;
    text id 122 start 480.0s for 2.8s at (102.0, 76.0) ''[bold][color=#34D399]Ensemble des solutions :[/color][/bold]'' ;
    text id 123 start 484.5s for 3.0s at (116.0, 83.0) ''[bold][color=#F8FAFC]$$\mathbf{x \in [3 ; 7]}$$[/color][/bold]'' ;
    mouse move id 1505 start 490.5s for 2.0s at [(114, 52), (146, 52)] ;

    erase id 2005 start 495.0s ;

    # =========================================================================
    # SCENE 6 : Propriété algébrique générale et vérification
    # =========================================================================

    text id 140 start 496.5s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Propriété algébrique générale et vérification[/color][/bold]'' ;
    draw line id 580 start 499.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left: General theorem
    draw polygone id 581 start 501.5s for 1.2s color (251, 191, 36, 0.7) fillcolor (251, 191, 36, 0.08) width 2.0 at [(5, 20), (86, 20), (86, 44), (5, 44)] ;
    text id 141 start 503.5s for 2.0s at (9.0, 24.0) ''[bold][color=#FBBF24]Théorème officiel du lycée ($r \ge 0$) :[/color][/bold]'' ;
    text id 142 start 507.0s for 3.5s at (9.0, 32.0) ''[bold][color=#F8FAFC]$$|x - a| \le r \iff x \in [a - r ; a + r]$$[/color][/bold]'' ;

    text id 143 start 517.0s for 2.5s at (5.0, 50.0) ''[bold][color=#38BDF8]Application directe à notre exercice :[/color][/bold]'' ;
    text id 144 start 521.0s for 3.0s at (8.0, 58.0) ''[color=#F8FAFC]Dans $|x - 5| \le 2$ : centre $a = 5$ et rayon $r = 2$.[/color]'' ;

    text id 145 start 532.0s for 2.5s at (5.0, 70.0) ''[bold][color=#34D399]Calcul des bornes de l'intervalle :[/color][/bold]'' ;
    text id 146 start 536.0s for 3.5s at (8.0, 78.0) ''[color=#F8FAFC]$$a - r = 5 - 2 = 3 \quad \text{et} \quad a + r = 5 + 2 = 7$$[/color]'' ;
    text id 147 start 541.0s for 3.0s at (8.0, 88.0) ''[bold][color=#34D399]Concordance parfaite : $x \in [3 ; 7]$ ![/color][/bold]'' ;

    # Right: General schema of centered interval
    text id 148 start 504.0s for 2.0s at (94.0, 20.0) ''[bold][color=#38BDF8]Schéma général d'un intervalle centré :[/color][/bold]'' ;
    draw arrow id 582 start 507.0s for 1.8s color (248, 250, 252, 0.9) width 2.0 at [(94, 52), (170, 52)] ;

    # Center a at X = 132
    draw line id 583 start 510.0s for 0.6s color (56, 189, 248, 1) width 2.0 at [(132, 49), (132, 55)] ;
    text id 149 start 511.0s for 1.5s at (130.0, 58.0) ''[bold][color=#38BDF8]$a$[/color][/bold]'' ;
    text id 150 start 513.0s for 1.5s at (124.0, 65.0) ''[color=#38BDF8](Centre)[/color]'' ;

    # Highlighted interval [a-r ; a+r]
    draw line id 584 start 515.5s for 2.0s color (52, 211, 153, 0.9) width 4.5 at [(110, 52), (154, 52)] ;

    # Left bound a - r at X = 110
    draw line id 585 start 518.5s color (251, 191, 36, 1) width 2.0 at [(110, 49), (110, 55)] ;
    text id 151 start 519.5s for 1.8s at (104.0, 58.0) ''[bold][color=#FBBF24]$a - r$[/color][/bold]'' ;

    # Right bound a + r at X = 154
    draw line id 586 start 522.0s color (251, 191, 36, 1) width 2.0 at [(154, 49), (154, 55)] ;
    text id 152 start 523.0s for 1.8s at (148.0, 58.0) ''[bold][color=#FBBF24]$a + r$[/color][/bold]'' ;

    # Radius arrows
    draw arrow id 587 start 525.5s for 1.2s color (56, 189, 248, 0.8) width 1.5 at [(132, 38), (154, 38)] ;
    text id 153 start 527.2s for 1.5s at (141.0, 31.0) ''[color=#38BDF8]$+r$[/color]'' ;
    draw arrow id 588 start 529.5s for 1.2s color (251, 191, 36, 0.8) width 1.5 at [(132, 38), (110, 38)] ;
    text id 154 start 531.2s for 1.5s at (119.0, 31.0) ''[color=#FBBF24]$-r$[/color]'' ;

    # Brackets
    draw path id 589 start 534.0s for 1.0s color (52, 211, 153, 1) width 2.5 at [(112, 48), (110, 48), (110, 56), (112, 56)] ;
    draw path id 590 start 535.5s for 1.0s color (52, 211, 153, 1) width 2.5 at [(152, 48), (154, 48), (154, 56), (152, 56)] ;

    mouse move id 1506 start 543.0s for 1.5s at [(132, 38), (132, 52)] ;

    erase id 2006 start 548.5s ;

    # =========================================================================
    # SCENE 7 : Pièges d'examen & Synthèse en 3 étapes
    # =========================================================================

    text id 170 start 550.5s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Pièges d'examen & Méthode en 3 étapes[/color][/bold]'' ;
    draw line id 600 start 553.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Left: Traps (compact and cleanly bounded within X <= 86)
    text id 171 start 556.0s for 2.2s at (5.0, 20.0) ''[bold][color=#F87171]3 Pièges fréquents à éviter absolument :[/color][/bold]'' ;

    text id 172 start 560.5s for 2.5s at (5.0, 28.0) ''[bold][color=#FBBF24]1. Signe du centre :[/color][/bold]'' ;
    text id 173 start 564.5s for 3.5s at (8.0, 36.0) ''[color=#F8FAFC]Dans $|x - 5|$, le centre est $+5$ (et non $-5$).[/color]'' ;

    text id 174 start 581.5s for 2.5s at (5.0, 48.0) ''[bold][color=#FBBF24]2. Oubli de la symétrie :[/color][/bold]'' ;
    text id 175 start 585.5s for 3.5s at (8.0, 56.0) ''[color=#F8FAFC]La distance s'exerce des deux côtés : $\pm r$ ![/color]'' ;

    text id 176 start 597.5s for 2.5s at (5.0, 68.0) ''[bold][color=#FBBF24]3. Orientation des crochets :[/color][/bold]'' ;
    text id 177 start 601.5s for 3.5s at (8.0, 76.0) ''[color=#F8FAFC]Inégalité large $\le$ : crochets fermés $[a-r ; a+r]$.[/color]'' ;

    # Right: 3-step method recap box
    draw polygone id 601 start 618.5s for 1.5s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.1) width 2.0 at [(92, 20), (172, 20), (172, 88), (92, 88)] ;
    text id 178 start 621.0s for 2.5s at (96.0, 25.0) ''[bold][color=#34D399]Méthode infaillible en 3 étapes :[/color][/bold]'' ;

    text id 179 start 626.0s for 3.2s at (96.0, 36.0) ''[bold][color=#38BDF8]1. Identifier le centre $a$ et le rayon $r$[/color][/bold]'' ;
    text id 180 start 631.0s for 2.5s at (100.0, 43.0) ''[color=#F8FAFC]Forme canonique : $|x - a| \le r$[/color]'' ;

    text id 181 start 637.0s for 3.2s at (96.0, 52.0) ''[bold][color=#38BDF8]2. Placer $a$ et faire $\pm r$ sur l'axe[/color][/bold]'' ;
    text id 182 start 642.0s for 2.5s at (100.0, 59.0) ''[color=#F8FAFC]Borne gauche $a-r$ et borne droite $a+r$[/color]'' ;

    text id 183 start 650.0s for 3.2s at (96.0, 68.0) ''[bold][color=#38BDF8]3. Colorier et écrire l'intervalle[/color][/bold]'' ;
    text id 184 start 655.0s for 2.5s at (100.0, 75.0) ''[color=#34D399]Exemple : $\mathbf{x \in [3 ; 7]}$ (crochets fermés)[/color]'' ;

    text id 185 start 660.0s for 3.5s at (96.0, 82.0) ''[bold][color=#FBBF24]Réflexe examen Seconde acquis ![/color][/bold]'' ;
    mouse move id 1507 start 665.0s for 2.0s at [(132, 25), (132, 82)] ;

}
