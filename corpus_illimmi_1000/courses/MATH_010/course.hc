course "Correction d'exercice : Intervalles et encadrements de réels" id 10 idgap 500 for 629.4s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction & Le Triple Registre Mathématique (0.0s -> 54.0s)
    # =========================================================================

    text id 1 start 0.5s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Correction d'exercice : Intervalles & Encadrements[/bold][/color]'' ;
    draw line id 501 start 3.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 8.0s for 3.0s at (6.0, 20.0) ''[color=#F8FAFC]Objectif Lycée : Maîtriser le passage fluide entre les trois registres fondamentaux[/color]'' ;

    text id 3 start 18.5s for 2.5s at (6.0, 29.0) ''[color=#FBBF24][bold]Le Triple Langage Mathématique : Un Tableau à Trois Colonnes[/bold][/color]'' ;

    # Grille du tableau des 3 registres
    draw line id 502 start 22.0s color (248, 250, 252, 0.4) width 1.5 at [(6.0, 36.0), (170.0, 36.0)] ;
    draw line id 503 start 22.3s color (248, 250, 252, 0.4) width 1.5 at [(6.0, 68.0), (170.0, 68.0)] ;
    draw line id 504 start 22.6s color (248, 250, 252, 0.4) width 1.5 at [(60.0, 36.0), (60.0, 68.0)] ;
    draw line id 505 start 22.9s color (248, 250, 252, 0.4) width 1.5 at [(116.0, 36.0), (116.0, 68.0)] ;

    # Colonne 1 : Inégalité
    text id 4 start 24.5s for 2.0s at (8.0, 42.0) ''[color=#38BDF8][bold]1. Inégalité / Encadrement[/bold][/color]'' ;
    text id 5 start 27.5s for 2.5s at (8.0, 50.0) ''[color=#F8FAFC]Comparaison algébrique : $a \le x \le b$[/color]'' ;
    text id 6 start 30.5s at (8.0, 58.0) ''[color=#94A3B8]Notation issue du collège[/color]'' ;

    # Colonne 2 : Notation Intervalle
    text id 7 start 32.0s for 2.0s at (64.0, 42.0) ''[color=#34D399][bold]2. Notation Intervalle[/bold][/color]'' ;
    text id 8 start 35.0s for 2.5s at (64.0, 50.0) ''[color=#F8FAFC]Ensemble de réels : $x \in [a ; b]$[/color]'' ;
    text id 9 start 38.0s at (64.0, 58.0) ''[color=#94A3B8]Outil central introduit en Seconde[/color]'' ;

    # Colonne 3 : Axe Gradué
    text id 10 start 40.5s for 2.0s at (120.0, 42.0) ''[color=#C084FC][bold]3. Axe Gradué[/bold][/color]'' ;
    text id 11 start 44.5s for 2.5s at (120.0, 50.0) ''[color=#F8FAFC]Visualisation géométrique directe[/color]'' ;
    text id 12 start 48.0s at (120.0, 58.0) ''[color=#94A3B8]Donne tout son sens aux crochets[/color]'' ;

    text id 13 start 51.0s for 2.2s at (18.0, 78.0) ''[color=#FBBF24]Chaque registre traduit rigoureusement la même réalité mathématique.[/color]'' ;

    erase id 2001 start 54.0s ;

    # =========================================================================
    # SCENE 2 : Cas 1 : Encadrement Fermé [2 ; 4] (54.0s -> 201.0s)
    # =========================================================================

    text id 14 start 56.5s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Cas 1 : Encadrement Fermé — Bornes Incluses[/bold][/color]'' ;
    draw line id 506 start 58.7s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 15 start 59.5s for 2.5s at (6.0, 22.0) ''[color=#FBBF24][bold]Inégalité donnée :[/bold][/color] [color=#F8FAFC]$$2 \le x \le 4$$[/color]'' ;
    text id 16 start 67.5s for 2.5s at (6.0, 36.0) ''[color=#F8FAFC]Lecture : $x$ est compris entre $2$ et $4$.[/color]'' ;
    text id 17 start 73.5s for 2.5s at (6.0, 47.0) ''[color=#38BDF8]Zone de déplacement : de la borne $2$ à la borne $4$.[/color]'' ;

    # Axe gradué à droite
    draw arrow id 507 start 84.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 56.0), (170.0, 56.0)] ;
    text id 18 start 86.0s at (168.0, 62.0) ''[color=#F8FAFC]$x$[/color]'' ;

    # Graduations de 0 à 5
    draw line id 508 start 87.0s color (248, 250, 252, 0.6) width 1.5 at [(98.0, 54.0), (98.0, 58.0)] ;
    text id 19 start 87.2s at (97.0, 62.0) ''[color=#94A3B8]$0$[/color]'' ;

    draw line id 509 start 88.0s color (248, 250, 252, 0.6) width 1.5 at [(109.0, 54.0), (109.0, 58.0)] ;
    text id 20 start 88.2s at (108.0, 62.0) ''[color=#94A3B8]$1$[/color]'' ;

    draw line id 510 start 89.0s color (248, 250, 252, 0.6) width 1.5 at [(120.0, 54.0), (120.0, 58.0)] ;
    text id 21 start 89.2s at (119.0, 62.0) ''[color=#F8FAFC][bold]$2$[/bold][/color]'' ;

    draw line id 511 start 90.0s color (248, 250, 252, 0.6) width 1.5 at [(131.0, 54.0), (131.0, 58.0)] ;
    text id 22 start 90.2s at (130.0, 62.0) ''[color=#94A3B8]$3$[/color]'' ;

    draw line id 512 start 91.0s color (248, 250, 252, 0.6) width 1.5 at [(142.0, 54.0), (142.0, 58.0)] ;
    text id 23 start 91.2s at (141.0, 62.0) ''[color=#F8FAFC][bold]$4$[/bold][/color]'' ;

    draw line id 513 start 92.0s color (248, 250, 252, 0.6) width 1.5 at [(153.0, 54.0), (153.0, 58.0)] ;
    text id 24 start 92.2s at (152.0, 62.0) ''[color=#94A3B8]$5$[/color]'' ;

    # Surlignage de la zone [2, 4]
    draw line id 514 start 100.5s for 1.5s color (56, 189, 248, 1) width 5.5 at [(120.0, 56.0), (142.0, 56.0)] ;

    text id 25 start 110.0s for 2.5s at (6.0, 58.0) ''[color=#FBBF24][bold]Analyse des bornes :[/bold][/color] [color=#F8FAFC]Que valent les extrémités ?[/color]'' ;
    text id 26 start 120.0s for 2.5s at (6.0, 67.0) ''[color=#34D399]Borne $2$ : $x \ge 2 \implies 2$ fait partie de l'ensemble ![/color]'' ;

    # Crochet en 2 fermé (tourné vers l'intérieur, vers la droite : bras vers 121.5)
    draw path id 515 start 137.5s for 1.0s color (56, 189, 248, 1) width 3.2 at [(121.5, 51.5), (120.0, 51.5), (120.0, 60.5), (121.5, 60.5)] ;
    text id 27 start 142.5s for 2.0s at (104.0, 72.0) ''[color=#38BDF8]Crochet en $2$ : fermé[/color]'' ;

    text id 28 start 156.0s for 2.2s at (6.0, 76.0) ''[color=#34D399]Borne $4$ : $x \le 4 \implies 4$ est également autorisé ![/color]'' ;

    # Crochet en 4 fermé (tourné vers l'intérieur, vers la gauche : bras vers 140.5)
    draw path id 516 start 163.5s for 1.0s color (56, 189, 248, 1) width 3.2 at [(140.5, 51.5), (142.0, 51.5), (142.0, 60.5), (140.5, 60.5)] ;

    text id 29 start 182.5s for 2.5s at (6.0, 86.0) ''[color=#FBBF24][bold]Notation Intervalle :[/bold][/color] [color=#38BDF8]$\mathbf{x \in [2 ; 4]}$[/color]'' ;
    text id 30 start 196.0s for 2.5s at (104.0, 82.0) ''[color=#34D399][bold]Intervalle fermé[/bold][/color]'' ;

    erase id 2002 start 201.0s ;

    # =========================================================================
    # SCENE 3 : Cas 2 : Inégalité Stricte ]-1 ; 3] (201.0s -> 311.5s)
    # =========================================================================

    text id 31 start 203.0s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Cas 2 : Inégalité Stricte & Borne Exclue[/bold][/color]'' ;
    draw line id 517 start 205.2s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 32 start 206.0s for 2.5s at (6.0, 22.0) ''[color=#FBBF24][bold]Inégalité donnée :[/bold][/color] [color=#F8FAFC]$$-1 < x \le 3$$[/color]'' ;

    # Axe gradué
    draw arrow id 518 start 210.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 56.0), (170.0, 56.0)] ;

    # Graduations de -2 à 5 (base 104, pas 9)
    draw line id 519 start 213.0s color (248, 250, 252, 0.6) width 1.5 at [(104.0, 54.0), (104.0, 58.0)] ;
    text id 33 start 213.2s at (102.5, 62.0) ''[color=#94A3B8]$-2$[/color]'' ;

    draw line id 520 start 213.5s color (248, 250, 252, 0.6) width 1.5 at [(113.0, 54.0), (113.0, 58.0)] ;
    text id 34 start 213.7s at (111.5, 62.0) ''[color=#F8FAFC][bold]$-1$[/bold][/color]'' ;

    draw line id 521 start 214.0s color (248, 250, 252, 0.6) width 1.5 at [(122.0, 54.0), (122.0, 58.0)] ;
    text id 35 start 214.2s at (121.0, 62.0) ''[color=#94A3B8]$0$[/color]'' ;

    draw line id 522 start 214.5s color (248, 250, 252, 0.6) width 1.5 at [(131.0, 54.0), (131.0, 58.0)] ;
    text id 36 start 214.7s at (130.0, 62.0) ''[color=#94A3B8]$1$[/color]'' ;

    draw line id 523 start 215.0s color (248, 250, 252, 0.6) width 1.5 at [(140.0, 54.0), (140.0, 58.0)] ;
    text id 37 start 215.2s at (139.0, 62.0) ''[color=#94A3B8]$2$[/color]'' ;

    draw line id 524 start 215.5s color (248, 250, 252, 0.6) width 1.5 at [(149.0, 54.0), (149.0, 58.0)] ;
    text id 38 start 215.7s at (148.0, 62.0) ''[color=#F8FAFC][bold]$3$[/bold][/color]'' ;

    draw line id 525 start 216.0s color (248, 250, 252, 0.6) width 1.5 at [(158.0, 54.0), (158.0, 58.0)] ;
    text id 39 start 216.2s at (157.0, 62.0) ''[color=#94A3B8]$4$[/color]'' ;

    draw line id 526 start 216.5s color (248, 250, 252, 0.6) width 1.5 at [(167.0, 54.0), (167.0, 58.0)] ;
    text id 40 start 216.7s at (166.0, 62.0) ''[color=#94A3B8]$5$[/color]'' ;

    # Surlignage de la zone ]-1, 3]
    draw line id 527 start 226.0s for 1.5s color (52, 211, 153, 1) width 5.5 at [(113.0, 56.0), (149.0, 56.0)] ;

    text id 41 start 237.5s for 2.5s at (6.0, 36.0) ''[color=#FBBF24][bold]Borne $-1$ (inégalité stricte) :[/bold][/color]'' ;
    text id 42 start 243.0s for 2.5s at (6.0, 45.0) ''[color=#F87171]$x > -1 \implies x$ ne peut JAMAIS valoir $-1$ ![/color]'' ;
    text id 43 start 256.5s for 2.5s at (6.0, 54.0) ''[color=#F8FAFC]On rejette $-1$ : la borne est dite [bold]ouverte[/bold].[/color]'' ;

    # Crochet en -1 ouvert (tourné vers la gauche, dos à la zone : bras vers 111.5)
    draw path id 528 start 261.0s for 1.0s color (52, 211, 153, 1) width 3.2 at [(111.5, 51.5), (113.0, 51.5), (113.0, 60.5), (111.5, 60.5)] ;
    text id 44 start 264.0s for 2.0s at (104.0, 72.0) ''[color=#F87171]Crochet en $-1$ : ouvert[/color]'' ;

    text id 45 start 276.0s for 2.5s at (6.0, 66.0) ''[color=#34D399][bold]Borne $3$ :[/bold] $x \le 3 \implies 3$ est inclus (crochet fermé)[/color]'' ;

    # Crochet en 3 fermé (tourné vers la gauche, vers la zone : bras vers 147.5)
    draw path id 529 start 283.0s for 1.0s color (52, 211, 153, 1) width 3.2 at [(147.5, 51.5), (149.0, 51.5), (149.0, 60.5), (147.5, 60.5)] ;

    text id 46 start 293.0s for 2.5s at (6.0, 78.0) ''[color=#FBBF24][bold]Notation Intervalle :[/bold][/color] [color=#34D399]$\mathbf{x \in ]-1 ; 3]}$[/color]'' ;
    text id 47 start 308.0s for 2.0s at (6.0, 88.0) ''[color=#38BDF8]Intervalle semi-ouvert à gauche (ouvert en $-1$, fermé en $3$)[/color]'' ;

    erase id 2003 start 311.5s ;

    # =========================================================================
    # SCENE 4 : Cas 3 : Non Borné à Gauche ]-infini ; 2[ (311.5s -> 447.0s)
    # =========================================================================

    text id 48 start 314.0s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Cas 3 : Intervalle Non Borné à Gauche[/bold][/color]'' ;
    draw line id 530 start 316.2s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 49 start 317.0s for 2.5s at (6.0, 22.0) ''[color=#FBBF24][bold]Intervalle donné :[/bold][/color] [color=#F8FAFC]$$\mathbf{x \in ]-\infty ; 2[}$$[/color]'' ;
    text id 50 start 331.0s for 2.5s at (6.0, 36.0) ''[color=#38BDF8]Symbole $-\infty$ : aucune limite inférieure à gauche[/color]'' ;
    text id 51 start 345.0s for 2.5s at (6.0, 46.0) ''[color=#F8FAFC]$x$ peut valoir $-100$, $-1\,000$, $-1\,000\,000$... sans obstacle ![/color]'' ;

    # Axe gradué
    draw arrow id 531 start 358.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 56.0), (170.0, 56.0)] ;

    # Graduations de -4 à 4 (base 96, pas 9)
    draw line id 532 start 360.0s color (248, 250, 252, 0.6) width 1.5 at [(96.0, 54.0), (96.0, 58.0)] ;
    text id 52 start 360.1s at (94.5, 62.0) ''[color=#94A3B8]$-4$[/color]'' ;

    draw line id 533 start 360.3s color (248, 250, 252, 0.6) width 1.5 at [(105.0, 54.0), (105.0, 58.0)] ;
    text id 53 start 360.4s at (103.5, 62.0) ''[color=#94A3B8]$-3$[/color]'' ;

    draw line id 534 start 360.6s color (248, 250, 252, 0.6) width 1.5 at [(114.0, 54.0), (114.0, 58.0)] ;
    text id 54 start 360.7s at (112.5, 62.0) ''[color=#94A3B8]$-2$[/color]'' ;

    draw line id 535 start 360.9s color (248, 250, 252, 0.6) width 1.5 at [(123.0, 54.0), (123.0, 58.0)] ;
    text id 55 start 361.0s at (121.5, 62.0) ''[color=#94A3B8]$-1$[/color]'' ;

    draw line id 536 start 361.2s color (248, 250, 252, 0.6) width 1.5 at [(132.0, 54.0), (132.0, 58.0)] ;
    text id 56 start 361.3s at (131.0, 62.0) ''[color=#94A3B8]$0$[/color]'' ;

    draw line id 537 start 361.5s color (248, 250, 252, 0.6) width 1.5 at [(141.0, 54.0), (141.0, 58.0)] ;
    text id 57 start 361.6s at (140.0, 62.0) ''[color=#94A3B8]$1$[/color]'' ;

    draw line id 538 start 361.8s color (248, 250, 252, 0.6) width 1.5 at [(150.0, 54.0), (150.0, 58.0)] ;
    text id 58 start 361.9s at (149.0, 62.0) ''[color=#F8FAFC][bold]$2$[/bold][/color]'' ;

    draw line id 539 start 362.1s color (248, 250, 252, 0.6) width 1.5 at [(159.0, 54.0), (159.0, 58.0)] ;
    text id 59 start 362.2s at (158.0, 62.0) ''[color=#94A3B8]$3$[/color]'' ;

    draw line id 540 start 362.4s color (248, 250, 252, 0.6) width 1.5 at [(168.0, 54.0), (168.0, 58.0)] ;
    text id 60 start 362.5s at (167.0, 62.0) ''[color=#94A3B8]$4$[/color]'' ;

    # Demi-droite de gauche jusqu'à 2
    draw line id 541 start 363.0s for 1.5s color (251, 191, 36, 1) width 5.5 at [(94.0, 56.0), (150.0, 56.0)] ;

    text id 61 start 372.0s for 2.5s at (6.0, 57.0) ''[color=#FBBF24]$-\infty$ n'est pas un réel : aucun crochet à gauche sur l'axe[/color]'' ;

    # Crochet en 2 ouvert (tourné vers la droite, dos à la zone : bras vers 151.5)
    draw path id 542 start 399.0s for 1.0s color (251, 191, 36, 1) width 3.2 at [(151.5, 51.5), (150.0, 51.5), (150.0, 60.5), (151.5, 60.5)] ;
    text id 62 start 402.0s for 2.0s at (104.0, 72.0) ''[color=#F87171]Crochet en $2$ : ouvert[/color]'' ;

    text id 63 start 420.0s for 2.5s at (6.0, 68.0) ''[color=#FBBF24][bold]Inégalité correspondante :[/bold][/color] [color=#34D399]$$\mathbf{x < 2}$$[/color]'' ;
    text id 64 start 433.0s for 3.0s at (6.0, 80.0) ''[color=#F87171][bold]Règle d'or :[/bold] Ne JAMAIS écrire $-\infty < x$ ![/color]'' ;
    text id 65 start 440.0s for 2.5s at (6.0, 90.0) ''[color=#F8FAFC]L'inégalité $x < 2$ suffit totalement et contient toute l'information.[/color]'' ;

    erase id 2004 start 447.0s ;

    # =========================================================================
    # SCENE 5 : Cas 4 : Non Borné à Droite [1 ; +infini[ (447.0s -> 541.5s)
    # =========================================================================

    text id 66 start 450.0s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Cas 4 : Demi-Droite Non Bornée à Droite[/bold][/color]'' ;
    draw line id 543 start 452.2s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Axe gradué
    draw arrow id 544 start 460.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(94.0, 56.0), (170.0, 56.0)] ;

    # Graduations de -1 à 5 (base 98, pas 10)
    draw line id 545 start 462.0s color (248, 250, 252, 0.6) width 1.5 at [(98.0, 54.0), (98.0, 58.0)] ;
    text id 67 start 462.1s at (96.5, 62.0) ''[color=#94A3B8]$-1$[/color]'' ;

    draw line id 546 start 462.3s color (248, 250, 252, 0.6) width 1.5 at [(108.0, 54.0), (108.0, 58.0)] ;
    text id 68 start 462.4s at (107.0, 62.0) ''[color=#94A3B8]$0$[/color]'' ;

    draw line id 547 start 462.6s color (248, 250, 252, 0.6) width 1.5 at [(118.0, 54.0), (118.0, 58.0)] ;
    text id 69 start 462.7s at (117.0, 62.0) ''[color=#F8FAFC][bold]$1$[/bold][/color]'' ;

    draw line id 548 start 462.9s color (248, 250, 252, 0.6) width 1.5 at [(128.0, 54.0), (128.0, 58.0)] ;
    text id 70 start 463.0s at (127.0, 62.0) ''[color=#94A3B8]$2$[/color]'' ;

    draw line id 549 start 463.2s color (248, 250, 252, 0.6) width 1.5 at [(138.0, 54.0), (138.0, 58.0)] ;
    text id 71 start 463.3s at (137.0, 62.0) ''[color=#94A3B8]$3$[/color]'' ;

    draw line id 550 start 463.5s color (248, 250, 252, 0.6) width 1.5 at [(148.0, 54.0), (148.0, 58.0)] ;
    text id 72 start 463.6s at (147.0, 62.0) ''[color=#94A3B8]$4$[/color]'' ;

    draw line id 551 start 463.8s color (248, 250, 252, 0.6) width 1.5 at [(158.0, 54.0), (158.0, 58.0)] ;
    text id 73 start 463.9s at (157.0, 62.0) ''[color=#94A3B8]$5$[/color]'' ;

    # Demi-droite de 1 jusqu'à droite
    draw line id 552 start 466.0s for 1.5s color (192, 132, 252, 1) width 5.5 at [(118.0, 56.0), (170.0, 56.0)] ;

    # Crochet en 1 fermé (tourné vers la droite, vers la zone : bras vers 119.5)
    draw path id 553 start 468.0s for 1.0s color (192, 132, 252, 1) width 3.2 at [(119.5, 51.5), (118.0, 51.5), (118.0, 60.5), (119.5, 60.5)] ;
    text id 74 start 470.0s for 2.0s at (104.0, 72.0) ''[color=#C084FC]Crochet en $1$ : fermé[/color]'' ;

    text id 75 start 480.0s for 2.5s at (6.0, 24.0) ''[color=#FBBF24][bold]Axe donné :[/bold][/color] [color=#F8FAFC]Départ en $1$ inclus, vers la droite sans fin[/color]'' ;
    text id 76 start 489.0s for 2.5s at (6.0, 38.0) ''[color=#FBBF24][bold]Déduction de l'intervalle :[/bold][/color]'' ;
    text id 77 start 496.0s for 2.5s at (6.0, 48.0) ''[color=#C084FC]$$\mathbf{x \in [1 ; +\infty[}$$[/color]'' ;

    text id 78 start 506.0s for 2.5s at (6.0, 62.0) ''[color=#F87171]L'infini est TOUJOURS exclu : crochet ouvert à droite ![/color]'' ;
    text id 79 start 520.0s for 2.5s at (6.0, 74.0) ''[color=#FBBF24][bold]Traduction en inégalité :[/bold][/color]'' ;
    text id 80 start 526.0s for 2.5s at (6.0, 84.0) ''[color=#34D399]$$\mathbf{x \ge 1}$$[/color]'' ;

    erase id 2005 start 541.5s ;

    # =========================================================================
    # SCENE 6 : Erreurs Fréquentes & Pièges d'Examen (541.5s -> 596.5s)
    # =========================================================================

    text id 81 start 543.5s for 2.0s at (4.0, 7.5) ''[color=#F87171][bold]Attention : Les 3 Pièges Classiques au Lycée[/bold][/color]'' ;
    draw line id 554 start 545.7s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 82 start 550.0s for 2.5s at (6.0, 22.0) ''[color=#FBBF24][bold]Piège 1 : Le sens des crochets sur l'axe[/bold][/color]'' ;
    text id 83 start 555.0s for 2.5s at (6.0, 31.0) ''[color=#34D399]Inclus ($\le, \ge$) : bras vers la zone colorée (protection)[/color]'' ;
    text id 84 start 562.0s for 2.5s at (6.0, 40.0) ''[color=#F87171]Exclu ($<, >$) : bras vers l'extérieur (rejet)[/color]'' ;

    text id 85 start 569.0s for 2.5s at (6.0, 52.0) ''[color=#FBBF24][bold]Piège 2 : Fermer le crochet sur l'infini[/bold][/color]'' ;
    text id 86 start 573.0s for 2.5s at (6.0, 61.0) ''[color=#F87171]$[1 ; +\infty]$ est STRICTEMENT FAUX ![/color] [color=#34D399]Écrire $[1 ; +\infty[$[/color]'' ;

    text id 87 start 582.0s for 2.5s at (6.0, 73.0) ''[color=#FBBF24][bold]Piège 3 : Écrire l'infini dans une inégalité[/bold][/color]'' ;
    text id 88 start 587.0s for 2.5s at (6.0, 82.0) ''[color=#F87171]$-\infty < x < 2$ est MALADROIT et REDONDANT ![/color]'' ;
    text id 89 start 592.0s for 2.5s at (6.0, 91.0) ''[color=#34D399]Écrire uniquement $x < 2$ ou $x \ge 1$.[/color]'' ;

    # Cadres récapitulatifs à droite
    draw polygone id 555 start 552.0s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.15) at [(102.0, 20.0), (170.0, 20.0), (170.0, 44.0), (102.0, 44.0)] ;
    text id 90 start 554.0s at (105.0, 26.0) ''[color=#34D399][bold]Règle d'or des crochets :[/bold][/color]'' ;
    text id 91 start 557.0s at (105.0, 34.0) ''[color=#F8FAFC]Face à la zone = OUI / Dos à la zone = NON[/color]'' ;

    draw polygone id 556 start 570.0s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.15) at [(102.0, 52.0), (170.0, 52.0), (170.0, 92.0), (102.0, 92.0)] ;
    text id 92 start 572.0s at (105.0, 58.0) ''[color=#F87171][bold]Interdictions formelles :[/bold][/color]'' ;
    text id 93 start 576.0s at (105.0, 68.0) ''[color=#F8FAFC]1. Jamais de crochet fermé en $\pm\infty$[/color]'' ;
    text id 94 start 584.0s at (105.0, 78.0) ''[color=#F8FAFC]2. Pas d'infini dans les inégalités[/color]'' ;

    erase id 2006 start 596.5s ;

    # =========================================================================
    # SCENE 7 : Synthèse Méthodologique & Contrôle (596.5s -> 629.4s)
    # =========================================================================

    text id 95 start 598.0s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]Synthèse & Méthode Universelle pour le Lycée[/bold][/color]'' ;
    draw line id 557 start 600.2s color (248, 250, 252, 0.9) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 96 start 603.5s for 2.5s at (6.0, 20.0) ''[color=#FBBF24][bold]Tableau Récapitulatif des 4 Situations d'Exercice :[/bold][/color]'' ;

    draw line id 558 start 605.0s color (248, 250, 252, 0.5) width 1.5 at [(6.0, 26.0), (170.0, 26.0)] ;
    text id 97 start 606.0s at (10.0, 31.0) ''[color=#38BDF8][bold]Inégalité[/bold][/color]'' ;
    text id 98 start 606.0s at (60.0, 31.0) ''[color=#34D399][bold]Intervalle[/bold][/color]'' ;
    text id 99 start 606.0s at (115.0, 31.0) ''[color=#C084FC][bold]Type de Borne / Axe[/bold][/color]'' ;
    draw line id 559 start 607.0s color (248, 250, 252, 0.5) width 1.5 at [(6.0, 35.0), (170.0, 35.0)] ;

    # Ligne 1
    text id 100 start 608.0s at (10.0, 40.0) ''[color=#F8FAFC]$2 \le x \le 4$[/color]'' ;
    text id 101 start 608.0s at (60.0, 40.0) ''[color=#38BDF8]$[2 ; 4]$[/color]'' ;
    text id 102 start 608.0s at (115.0, 40.0) ''[color=#F8FAFC]Fermé (2 et 4 inclus)[/color]'' ;

    # Ligne 2
    text id 103 start 610.0s at (10.0, 48.0) ''[color=#F8FAFC]$-1 < x \le 3$[/color]'' ;
    text id 104 start 610.0s at (60.0, 48.0) ''[color=#34D399]$]-1 ; 3]$[/color]'' ;
    text id 105 start 610.0s at (115.0, 48.0) ''[color=#F8FAFC]Semi-ouvert (-1 exclu, 3 inclus)[/color]'' ;

    # Ligne 3
    text id 106 start 612.0s at (10.0, 56.0) ''[color=#F8FAFC]$x < 2$[/color]'' ;
    text id 107 start 612.0s at (60.0, 56.0) ''[color=#FBBF24]$]-\infty ; 2[$[/color]'' ;
    text id 108 start 612.0s at (115.0, 56.0) ''[color=#F8FAFC]Non borné à gauche (2 exclu)[/color]'' ;

    # Ligne 4
    text id 109 start 614.0s at (10.0, 64.0) ''[color=#F8FAFC]$x \ge 1$[/color]'' ;
    text id 110 start 614.0s at (60.0, 64.0) ''[color=#C084FC]$[1 ; +\infty[$[/color]'' ;
    text id 111 start 614.0s at (115.0, 64.0) ''[color=#F8FAFC]Non borné à droite (1 inclus)[/color]'' ;

    draw line id 560 start 615.0s color (248, 250, 252, 0.5) width 1.5 at [(6.0, 70.0), (170.0, 70.0)] ;

    text id 112 start 617.0s for 2.5s at (6.0, 78.0) ''[color=#FBBF24][bold]Réflexe de contrôle :[/bold][/color] [color=#F8FAFC]Axe au brouillon $\to$ Zone coloriée $\to$ Orientation des crochets.[/color]'' ;
    text id 113 start 624.0s for 3.0s at (6.0, 88.0) ''[color=#34D399][bold]Félicitations ! Tu as tous les automatismes pour briller en Seconde ![/bold][/color]'' ;

}
