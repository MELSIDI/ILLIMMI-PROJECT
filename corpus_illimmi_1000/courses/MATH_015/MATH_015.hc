course "Problème type Bac : Valeur absolue et distance sur la droite réelle" id 15 idgap 500 for 540.39s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION ET DÉFINITION GÉOMÉTRIQUE DE LA VALEUR ABSOLUE
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Valeur Absolue et Distance Géométrique[/color][/bold]'' ;
    draw line id 501 start 2.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 7.5s for 3.0s at (4.0, 22.0) ''[bold]Objectif :[/bold] Résoudre des inéquations avec valeur absolue'' ;
    text id 3 start 26.0s for 3.5s at (4.0, 35.0) ''[color=#FBBF24]Lien équation / inéquation :[/color] Même interprétation géométrique'' ;
    text id 4 start 42.5s for 3.0s at (4.0, 48.0) ''[bold]Définition fondamentale :[/bold]'' ;
    text id 5 start 46.5s for 3.5s at (6.0, 59.0) ''[color=#38BDF8]$$|a - b| = \text{distance entre } a \text{ et } b$$[/color]'' ;
    text id 6 start 58.2s for 2.8s at (4.0, 72.0) ''[color=#34D399]Règle d'or : La valeur absolue d'une différence est une distance.[/color]'' ;

    # Droite graduée illustrative à droite avec points A(a) et B(b)
    draw arrow id 502 start 61.8s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 54.0), (168.0, 54.0)] ;
    draw line id 503 start 63.2s for 0.3s color (248, 250, 252, 0.9) width 2.0 at [(110.0, 50.0), (110.0, 58.0)] ;
    text id 7 start 63.7s at (108.5, 60.5) ''[bold][color=#38BDF8]$a$[/color][/bold]'' ;
    draw line id 504 start 64.2s for 0.3s color (248, 250, 252, 0.9) width 2.0 at [(150.0, 50.0), (150.0, 58.0)] ;
    text id 8 start 64.7s at (148.5, 60.5) ''[bold][color=#FBBF24]$b$[/color][/bold]'' ;
    draw line id 505 start 65.1s for 0.3s color (52, 211, 153, 0.9) width 2.0 at [(110.0, 44.0), (150.0, 44.0)] ;
    text id 9 start 65.6s at (123.0, 36.0) ''[color=#34D399]$$|a - b|$$[/color]'' ;

    erase id 2001 start 66.0s ;

    # =========================================================================
    # SCÈNE 2 : PREMIÈRE INÉQUATION — TRADUCTION DE |x - 5| <= 2 ET POINT PIVOT
    # =========================================================================
    text id 10 start 66.8s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Première Inéquation : $|x - 5| \le 2$[/color][/bold]'' ;
    draw line id 506 start 68.8s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 11 start 72.8s for 3.0s at (4.0, 22.0) ''[bold]Inéquation posée :[/bold] [color=#F8FAFC]$$|x - 5| \le 2$$[/color]'' ;
    text id 12 start 81.0s for 3.5s at (4.0, 36.0) ''[color=#38BDF8]$$|x - 5| = \text{distance entre } x \text{ et } 5$$[/color]'' ;
    text id 13 start 89.0s for 3.5s at (4.0, 50.0) ''[color=#FBBF24]Membre de droite : $2$ = rayon maximal autorisé[/color]'' ;
    text id 14 start 101.2s for 3.5s at (4.0, 62.0) ''[bold]Traduction géométrique :[/bold]'' ;
    text id 15 start 106.0s for 3.5s at (6.0, 73.0) ''[color=#34D399]$$\text{Distance}(x, 5) \le 2$$[/color]'' ;
    text id 16 start 113.0s for 3.5s at (4.0, 85.0) ''L'écart entre $x$ et le pivot $5$ ne dépasse jamais $2$.'' ;

    # Repérage du pivot 5 sur l'axe
    draw arrow id 507 start 121.5s for 0.8s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 52.0), (168.0, 52.0)] ;
    draw line id 508 start 122.5s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(110.0, 49.5), (110.0, 54.5)] ;
    draw line id 509 start 123.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(120.0, 49.5), (120.0, 54.5)] ;
    draw line id 510 start 123.5s for 0.3s color (251, 191, 36, 1.0) width 2.5 at [(130.0, 48.0), (130.0, 56.0)] ;
    draw line id 511 start 124.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(140.0, 49.5), (140.0, 54.5)] ;
    draw line id 512 start 124.5s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(150.0, 49.5), (150.0, 54.5)] ;
    text id 17 start 125.0s at (128.5, 58.5) ''[bold][color=#FBBF24]$5$[/color][/bold]'' ;
    text id 18 start 125.5s at (122.0, 66.0) ''[color=#FBBF24](point pivot)[/color]'' ;

    erase id 2002 start 128.2s ;

    # =========================================================================
    # SCÈNE 3 : PREMIÈRE INÉQUATION — CAS FRONTIÈRES ET RECHERCHE DES BORNES 3 ET 7
    # =========================================================================
    text id 19 start 128.8s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Cas Frontières : Équation $|x - 5| = 2$[/color][/bold]'' ;
    draw line id 513 start 130.8s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 20 start 136.0s for 3.0s at (4.0, 22.0) ''[bold]Cas limite (égalité) :[/bold] [color=#F8FAFC]$$\text{Distance}(x, 5) = 2$$[/color]'' ;
    text id 21 start 144.0s for 3.0s at (4.0, 36.0) ''Déplacement de $2$ pas depuis le pivot $5$ :'' ;
    text id 22 start 153.8s for 2.0s at (6.0, 48.0) ''[color=#38BDF8]Vers la droite : $x = 5 + 2 = 7$[/color]'' ;
    text id 23 start 158.5s for 2.5s at (6.0, 58.0) ''Test : $|7 - 5| = |2| = 2$ (valide)'' ;
    text id 24 start 167.0s for 2.0s at (6.0, 69.0) ''[color=#38BDF8]Vers la gauche : $x = 5 - 2 = 3$[/color]'' ;
    text id 25 start 172.0s for 2.5s at (6.0, 79.0) ''Test : $|3 - 5| = |-2| = 2$ (valide)'' ;
    text id 26 start 177.0s for 2.5s at (4.0, 90.0) ''[color=#34D399]Bornes frontières : $x = 3$ et $x = 7$[/color]'' ;

    # Axe avec flèches +2 et -2
    draw arrow id 514 start 140.0s for 0.7s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 56.0), (168.0, 56.0)] ;
    draw line id 515 start 141.0s for 0.3s color (251, 191, 36, 1.0) width 2.5 at [(130.0, 52.0), (130.0, 60.0)] ;
    text id 27 start 141.5s at (128.5, 62.0) ''[bold][color=#FBBF24]$5$[/color][/bold]'' ;

    draw arrow id 516 start 156.0s for 0.8s color (56, 189, 248, 1.0) width 2.0 at [(130.0, 46.0), (150.0, 46.0)] ;
    text id 28 start 157.0s at (137.5, 39.0) ''[color=#38BDF8]$+2$[/color]'' ;
    draw line id 517 start 157.3s for 0.3s color (56, 189, 248, 1.0) width 2.5 at [(150.0, 52.0), (150.0, 60.0)] ;
    text id 29 start 157.8s at (148.5, 62.0) ''[bold][color=#38BDF8]$7$[/color][/bold]'' ;

    draw arrow id 518 start 169.2s for 0.8s color (56, 189, 248, 1.0) width 2.0 at [(130.0, 46.0), (110.0, 46.0)] ;
    text id 30 start 170.2s at (117.5, 39.0) ''[color=#38BDF8]$-2$[/color]'' ;
    draw line id 519 start 170.5s for 0.3s color (56, 189, 248, 1.0) width 2.5 at [(110.0, 52.0), (110.0, 60.0)] ;
    text id 31 start 171.0s at (108.5, 62.0) ''[bold][color=#38BDF8]$3$[/color][/bold]'' ;

    erase id 2003 start 183.8s ;

    # =========================================================================
    # SCÈNE 4 : PREMIÈRE INÉQUATION — SEGMENT DE SOLUTIONS ET INTERVALLE [3 ; 7]
    # =========================================================================
    text id 32 start 184.4s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Segment de Solutions : $|x - 5| \le 2 \iff x \in [3 ; 7]$[/color][/bold]'' ;
    draw line id 520 start 186.4s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 33 start 188.0s for 3.0s at (4.0, 22.0) ''[bold]Condition :[/bold] [color=#38BDF8]$$\text{Distance}(x, 5) \le 2$$[/color] (zone intérieure)'' ;
    text id 34 start 201.0s for 2.0s at (4.0, 35.0) ''Test $x = 6$ : $\text{dist}(6, 5) = 1 \le 2$ $\rightarrow$ [color=#34D399]Validé[/color]'' ;
    text id 35 start 211.5s for 3.0s at (4.0, 46.0) ''Test $x = 6.5$ : $\text{dist}(6.5, 5) = 1.5 \le 2$ $\rightarrow$ [color=#34D399]Validé[/color]'' ;
    text id 36 start 224.0s for 3.0s at (4.0, 57.0) ''Par symétrie, tout point entre $3$ et $7$ convient !'' ;
    text id 37 start 251.5s for 3.0s at (4.0, 68.0) ''[color=#FBBF24]Inégalité large ($\le$) :[/color] Bornes $3$ et $7$ [bold]incluses[/bold]'' ;
    text id 38 start 277.6s for 2.5s at (4.0, 81.0) ''[bold]Solution finale :[/bold] [color=#34D399]$$\mathbf{S = [3 ; 7]}$$[/color]'' ;

    # Axe avec zone coloriée et crochets fermés
    draw arrow id 521 start 192.0s for 0.8s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 52.0), (168.0, 52.0)] ;
    draw line id 522 start 193.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(110.0, 48.0), (110.0, 56.0)] ;
    text id 39 start 193.5s at (108.5, 58.5) ''$3$'' ;
    draw line id 523 start 194.0s for 0.3s color (251, 191, 36, 1.0) width 2.0 at [(130.0, 48.0), (130.0, 56.0)] ;
    text id 40 start 194.5s at (128.5, 58.5) ''[color=#FBBF24]$5$[/color]'' ;
    draw line id 524 start 195.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(150.0, 48.0), (150.0, 56.0)] ;
    text id 41 start 195.5s at (148.5, 58.5) ''$7$'' ;

    draw circle id 525 start 203.5s for 0.5s color (52, 211, 153, 1.0) width 2.0 radius 1.5 at (140.0, 52.0) ;
    text id 42 start 204.3s at (138.5, 43.0) ''[color=#34D399]$6$[/color]'' ;

    draw line id 526 start 240.0s for 1.5s color (56, 189, 248, 1.0) width 6.0 at [(110.0, 52.0), (150.0, 52.0)] ;
    draw path id 527 start 273.5s for 0.8s color (52, 211, 153, 1.0) width 2.5 at [(108.0, 46.0), (110.0, 46.0), (110.0, 58.0), (108.0, 58.0)] ;
    draw path id 528 start 275.0s for 0.8s color (52, 211, 153, 1.0) width 2.5 at [(152.0, 46.0), (150.0, 46.0), (150.0, 58.0), (152.0, 58.0)] ;
    text id 43 start 280.5s for 1.8s at (118.0, 68.0) ''[bold][color=#34D399]$$[3 ; 7]$$[/color][/bold]'' ;

    erase id 2004 start 286.2s ;

    # =========================================================================
    # SCÈNE 5 : DEUXIÈME INÉQUATION — RÈGLE DES SIGNES ET FORME |x - (-2)| > 3
    # =========================================================================
    text id 44 start 287.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Deuxième Inéquation : $|x + 2| > 3$[/color][/bold]'' ;
    draw line id 529 start 289.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 45 start 292.8s for 2.5s at (4.0, 22.0) ''[bold]Nouvelle inéquation :[/bold] [color=#F8FAFC]$$|x + 2| > 3$$[/color]'' ;
    text id 46 start 297.0s for 2.5s at (4.0, 36.0) ''[color=#F87171]Problème :[/color] C'est une addition, pas une différence !'' ;
    text id 47 start 314.0s for 2.5s at (4.0, 49.0) ''[bold]Règle des signes :[/bold] $(-)$ par $(-)$ donne $(+)$'' ;
    text id 48 start 321.8s for 2.5s at (6.0, 60.0) ''[color=#38BDF8]$$x + 2 = x - (-2)$$[/color]'' ;
    text id 49 start 331.0s for 2.0s at (4.0, 74.0) ''[bold]Forme canonique :[/bold] [color=#34D399]$$|x - (-2)| > 3$$[/color]'' ;

    # Encadré didactique à droite
    draw polygone id 530 start 300.0s for 1.0s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 2.0 at [(102.0, 24.0), (170.0, 24.0), (170.0, 80.0), (102.0, 80.0)] ;
    text id 50 start 302.0s for 2.0s at (106.0, 30.0) ''[bold][color=#FBBF24]Analyse des composantes :[/color][/bold]'' ;
    text id 51 start 308.0s for 2.5s at (106.0, 42.0) ''$\bullet$ Modèle général : $|x - c| > r$'' ;
    text id 52 start 325.0s for 2.0s at (106.0, 54.0) ''$\bullet$ Point pivot : [color=#38BDF8]$$c = -2$$[/color]'' ;
    text id 53 start 333.5s for 1.8s at (106.0, 66.0) ''$\bullet$ Rayon seuil : [color=#FBBF24]$$r = 3$$[/color] (stricte)'' ;

    erase id 2005 start 337.8s ;

    # =========================================================================
    # SCÈNE 6 : DEUXIÈME INÉQUATION — AXE GRADUÉ ET CAS LIMITES -5 ET 1
    # =========================================================================
    text id 54 start 338.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Axe Gradué & Cas Limites : $|x - (-2)| = 3$[/color][/bold]'' ;
    draw line id 531 start 340.2s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 55 start 345.0s for 3.0s at (4.0, 22.0) ''[bold]Traduction :[/bold] [color=#38BDF8]$$\text{Distance}(x, -2) > 3$$[/color]'' ;
    text id 56 start 361.0s for 2.5s at (4.0, 36.0) ''[bold]Cas limite :[/bold] $\text{Distance}(x, -2) = 3$'' ;
    text id 57 start 367.0s for 2.0s at (6.0, 48.0) ''[color=#38BDF8]Vers la droite : $x = -2 + 3 = 1$[/color]'' ;
    text id 58 start 371.7s for 2.5s at (6.0, 58.0) ''Test : $|1 - (-2)| = |3| = 3$'' ;
    text id 59 start 376.0s for 2.0s at (6.0, 69.0) ''[color=#38BDF8]Vers la gauche : $x = -2 - 3 = -5$[/color]'' ;
    text id 60 start 381.5s for 2.0s at (6.0, 79.0) ''Test : $|-5 - (-2)| = |-3| = 3$'' ;
    text id 61 start 385.5s for 1.8s at (4.0, 90.0) ''[color=#34D399]Bornes frontières : $-5$ et $1$[/color]'' ;

    # Axe gradué centré en -2
    draw arrow id 532 start 341.5s for 0.8s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 56.0), (168.0, 56.0)] ;
    draw line id 533 start 354.8s for 0.3s color (251, 191, 36, 1.0) width 2.5 at [(130.0, 52.0), (130.0, 60.0)] ;
    text id 62 start 355.5s at (127.5, 62.0) ''[bold][color=#FBBF24]$-2$[/color][/bold]'' ;

    draw arrow id 534 start 369.2s for 0.8s color (56, 189, 248, 1.0) width 2.0 at [(130.0, 46.0), (150.0, 46.0)] ;
    text id 63 start 370.2s at (137.5, 39.0) ''[color=#38BDF8]$+3$[/color]'' ;
    draw line id 535 start 370.5s for 0.3s color (56, 189, 248, 1.0) width 2.5 at [(150.0, 52.0), (150.0, 60.0)] ;
    text id 64 start 371.0s at (148.5, 62.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;

    draw arrow id 536 start 378.2s for 0.8s color (56, 189, 248, 1.0) width 2.0 at [(130.0, 46.0), (110.0, 46.0)] ;
    text id 65 start 379.2s at (117.5, 39.0) ''[color=#38BDF8]$-3$[/color]'' ;
    draw line id 537 start 379.5s for 0.3s color (56, 189, 248, 1.0) width 2.5 at [(110.0, 52.0), (110.0, 60.0)] ;
    text id 66 start 380.0s at (107.5, 62.0) ''[bold][color=#38BDF8]$-5$[/color][/bold]'' ;

    erase id 2006 start 387.8s ;

    # =========================================================================
    # SCÈNE 7 : DEUXIÈME INÉQUATION — DEMI-DROITES EXTÉRIEURES ET RÉUNION D'INTERVALLES
    # =========================================================================
    text id 67 start 388.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Demi-droites Extérieures & Réunion d'Intervalles[/color][/bold]'' ;
    draw line id 538 start 390.2s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 68 start 392.0s for 3.0s at (4.0, 22.0) ''[bold]Condition :[/bold] [color=#F87171]$$\text{Distance}(x, -2) > 3$$[/color] (extérieur)'' ;
    text id 69 start 402.0s for 2.0s at (4.0, 35.0) ''Test $x = 2$ : $\text{dist}(2, -2) = 4 > 3$ $\rightarrow$ [color=#34D399]Validé[/color]'' ;
    text id 70 start 418.0s for 2.0s at (4.0, 46.0) ''Test $x = -6$ : $\text{dist}(-6, -2) = 4 > 3$ $\rightarrow$ [color=#34D399]Validé[/color]'' ;
    text id 71 start 443.0s for 3.0s at (4.0, 57.0) ''[color=#FBBF24]Inégalité stricte ($>$) :[/color] Bornes $-5$ et $1$ [bold]exclues[/bold]'' ;
    text id 72 start 463.0s for 3.0s at (4.0, 68.0) ''[bold]Ensemble solution (réunion) :[/bold]'' ;
    text id 73 start 473.0s for 3.0s at (6.0, 80.0) ''[color=#34D399]$$\mathbf{S = ]-\infty ; -5[} \;\cup\; \mathbf{]1 ; +\infty[}$$[/color]'' ;
    text id 74 start 482.5s for 3.5s at (4.0, 91.0) ''L'infini porte [bold]toujours[/bold] un crochet ouvert vers l'extérieur.'' ;

    # Axe avec les deux demi-droites coloriées et crochets ouverts
    draw arrow id 539 start 395.5s for 0.8s color (248, 250, 252, 0.9) width 2.0 at [(95.0, 52.0), (168.0, 52.0)] ;
    draw line id 540 start 396.5s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(110.0, 48.0), (110.0, 56.0)] ;
    text id 75 start 396.9s at (107.5, 58.5) ''$-5$'' ;
    draw line id 541 start 397.3s for 0.3s color (251, 191, 36, 1.0) width 2.0 at [(130.0, 48.0), (130.0, 56.0)] ;
    text id 76 start 397.7s at (127.5, 58.5) ''[color=#FBBF24]$-2$[/color]'' ;
    draw line id 542 start 398.1s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(150.0, 48.0), (150.0, 56.0)] ;
    text id 77 start 398.5s at (148.5, 58.5) ''$1$'' ;

    draw circle id 543 start 404.5s for 0.5s color (52, 211, 153, 1.0) width 2.0 radius 1.5 at (157.0, 52.0) ;
    text id 78 start 405.3s at (155.5, 43.0) ''[color=#34D399]$2$[/color]'' ;

    draw circle id 544 start 420.5s for 0.5s color (52, 211, 153, 1.0) width 2.0 radius 1.5 at (103.0, 52.0) ;
    text id 79 start 421.3s at (100.5, 43.0) ''[color=#34D399]$-6$[/color]'' ;

    draw line id 545 start 429.0s for 1.2s color (56, 189, 248, 1.0) width 6.0 at [(95.0, 52.0), (110.0, 52.0)] ;
    text id 80 start 430.5s at (92.0, 58.5) ''$-\infty$'' ;

    draw line id 546 start 435.0s for 1.2s color (56, 189, 248, 1.0) width 6.0 at [(150.0, 52.0), (166.0, 52.0)] ;
    text id 81 start 436.5s at (165.0, 58.5) ''$+\infty$'' ;

    draw path id 547 start 458.5s for 0.8s color (248, 113, 113, 1.0) width 2.5 at [(108.0, 46.0), (110.0, 46.0), (110.0, 58.0), (108.0, 58.0)] ;
    draw path id 548 start 460.0s for 0.8s color (248, 113, 113, 1.0) width 2.5 at [(152.0, 46.0), (150.0, 46.0), (150.0, 58.0), (152.0, 58.0)] ;

    text id 82 start 476.5s at (96.0, 68.0) ''[color=#34D399]$]-\infty ; -5[$[/color]'' ;
    text id 83 start 479.5s at (146.0, 68.0) ''[color=#34D399]$]1 ; +\infty[$[/color]'' ;

    erase id 2007 start 491.5s ;

    # =========================================================================
    # SCÈNE 8 : SYNTHÈSE MÉTHODOLOGIQUE EN 4 ÉTAPES ET RÉFLEXE D'EXAMEN
    # =========================================================================
    text id 84 start 492.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. Synthèse Méthodologique : La Méthode en 4 Étapes[/color][/bold]'' ;
    draw line id 549 start 494.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 85 start 495.2s for 3.5s at (4.0, 21.0) ''[bold][color=#FBBF24]Étape 1 : Forme pivot[/color][/bold] Écrire $|x - c| \;\substack{\le \\ >}\; r$ (ex: $x+2 = x - (-2)$)'' ;
    text id 86 start 502.2s for 3.5s at (4.0, 35.0) ''[bold][color=#FBBF24]Étape 2 : Bornes frontières[/color][/bold] Partir de $c$, faire $\pm r \rightarrow c-r \text{ et } c+r$'' ;
    text id 87 start 511.0s for 2.0s at (4.0, 49.0) ''[bold][color=#FBBF24]Étape 3 : Type de zone[/color][/bold]'' ;
    text id 88 start 514.5s for 2.5s at (8.0, 59.0) ''$\bullet$ Si $\le$ ou $<$ : [color=#38BDF8]Segment intérieur[/color] $[c-r ; c+r]$'' ;
    text id 89 start 518.0s for 2.5s at (8.0, 69.0) ''$\bullet$ Si $\ge$ ou $>$ : [color=#F87171]Demi-droites extérieures[/color] (deux zones)'' ;
    text id 90 start 523.5s for 3.5s at (4.0, 82.0) ''[bold][color=#FBBF24]Étape 4 : Crochets[/color][/bold] [color=#34D399]Large : $[a ; b]$ (inclus)[/color] | [color=#F87171]Stricte : $]a ; b[$ (exclus)[/color]'' ;

    # Encadré visuel récapitulatif à droite
    draw polygone id 550 start 499.5s for 1.2s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 2.0 at [(100.0, 20.0), (175.0, 20.0), (175.0, 92.0), (100.0, 92.0)] ;
    text id 91 start 501.0s at (105.0, 25.0) ''[bold][color=#38BDF8]Récapitulatif Visuel Clé :[/color][/bold]'' ;

    # Axe mini 1 : segment intérieur
    draw arrow id 551 start 513.5s for 0.8s color (248, 250, 252, 0.9) width 1.5 at [(104.0, 44.0), (171.0, 44.0)] ;
    draw line id 552 start 517.2s for 0.6s color (56, 189, 248, 1.0) width 4.5 at [(122.0, 44.0), (153.0, 44.0)] ;
    text id 92 start 520.8s at (112.0, 36.0) ''[color=#38BDF8]$|x - c| \le r \iff [c-r ; c+r]$[/color]'' ;

    # Axe mini 2 : demi-droites extérieures
    draw arrow id 553 start 521.2s for 0.6s color (248, 250, 252, 0.9) width 1.5 at [(104.0, 68.0), (171.0, 68.0)] ;
    draw line id 554 start 522.3s for 0.3s color (248, 113, 113, 1.0) width 4.5 at [(104.0, 68.0), (122.0, 68.0)] ;
    draw line id 555 start 522.7s for 0.3s color (248, 113, 113, 1.0) width 4.5 at [(153.0, 68.0), (171.0, 68.0)] ;
    text id 93 start 523.2s at (104.0, 60.0) ''[color=#F87171]$|x - c| > r \iff ]-\infty ; c-r[ \;\cup\; ]c+r ; +\infty[$[/color]'' ;

    text id 94 start 532.0s for 3.5s at (105.0, 80.0) ''[bold][color=#34D399]Réflexe Bac : Pense toujours distance ![/color][/bold]'' ;

}
