course "Intervalles et encadrements de réels" id 7 idgap 500 for 636s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION & DROITE RÉELLE (0.0s - 44.8s)
    # =========================================================================
    text id 1 start 0.5s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction et Problématique des Intervalles[/color][/bold]'' ;
    draw line id 501 start 2.3s for 0.6s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 5.5s for 2.0s at (5.0, 24.0) ''[bold]Cadre d'étude :[/bold] L'ensemble des nombres réels [color=#38BDF8]$\mathbb{R}$[/color]'' ;
    text id 3 start 14.1s for 2.5s at (5.0, 39.0) ''[bold]Objectif :[/bold] Traduire des inégalités algébriques en [color=#FBBF24]intervalles géométriques[/color].'' ;
    text id 4 start 34.0s for 2.2s at (5.0, 55.0) ''L'axe gradué donne une [color=#34D399]forme concrète[/color] aux ensembles de nombres.'' ;
    text id 5 start 38.8s for 2.5s at (5.0, 70.0) ''Une méthode visuelle infaillible pour [color=#38BDF8]l'intersection[/color] et [color=#38BDF8]la réunion[/color].'' ;

    # Axe gradué d'introduction à droite
    draw arrow id 502 start 25.0s for 1.2s color (248, 250, 252, 0.9) width 1.8 at [(94, 52), (172, 52)] ;
    text id 6 start 26.5s at (168.0, 57.0) ''[color=#38BDF8]$x$[/color]'' ;

    # Graduations régulières sur l'axe
    draw line id 503 start 27.0s color (248, 250, 252, 0.6) width 1.5 at [(106, 49.5), (106, 54.5)] ;
    text id 7 start 27.0s at (104.0, 58.0) ''$-4$'' ;
    draw line id 504 start 27.5s color (248, 250, 252, 0.6) width 1.5 at [(130, 49.5), (130, 54.5)] ;
    text id 8 start 27.5s at (129.0, 58.0) ''$0$'' ;
    draw line id 505 start 28.0s color (248, 250, 252, 0.6) width 1.5 at [(142, 49.5), (142, 54.5)] ;
    text id 9 start 28.0s at (141.0, 58.0) ''$2$'' ;
    draw line id 506 start 28.5s color (248, 250, 252, 0.6) width 1.5 at [(160, 49.5), (160, 54.5)] ;
    text id 10 start 28.5s at (159.0, 58.0) ''$5$'' ;

    erase id 2001 start 44.8s ;

    # =========================================================================
    # SCÈNE 2 : PREMIER INTERVALLE BORNÉ I = [-4 ; 5[ (44.9s - 208.3s)
    # =========================================================================
    text id 11 start 45.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Intervalle Borné : De l'Encadrement à la Droite Graduée[/color][/bold]'' ;
    draw line id 511 start 47.3s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 12 start 53.8s for 2.5s at (5.0, 20.0) ''[bold]Encadrement à représenter :[/bold] [color=#FBBF24]$\mathbf{-4 \le x < 5}$[/color]'' ;

    # Axe gradué
    draw arrow id 512 start 60.8s for 1.2s color (248, 250, 252, 0.9) width 1.8 at [(94, 52), (172, 52)] ;
    text id 19 start 62.2s at (168.0, 57.0) ''[color=#38BDF8]$x$[/color]'' ;
    draw line id 513 start 63.0s color (248, 250, 252, 0.6) width 1.5 at [(106, 49.5), (106, 54.5)] ;
    text id 20 start 63.0s at (104.0, 58.0) ''$-4$'' ;
    draw line id 514 start 63.5s color (248, 250, 252, 0.6) width 1.5 at [(130, 49.5), (130, 54.5)] ;
    text id 29 start 63.5s at (129.0, 58.0) ''$0$'' ;
    draw line id 515 start 64.0s color (248, 250, 252, 0.6) width 1.5 at [(142, 49.5), (142, 54.5)] ;
    text id 30 start 64.0s at (141.0, 58.0) ''$2$'' ;
    draw line id 516 start 64.5s color (248, 250, 252, 0.6) width 1.5 at [(160, 49.5), (160, 54.5)] ;
    text id 38 start 64.5s at (159.0, 58.0) ''$5$'' ;

    text id 13 start 86.5s for 2.2s at (5.0, 31.0) ''Zone sur l'axe : segment entre les bornes [color=#F87171]$-4$[/color] et [color=#F87171]$5$[/color]'' ;

    # Coloration rouge du segment [-4 ; 5]
    draw line id 520 start 94.4s for 1.8s color (248, 113, 113, 0.95) width 5.0 at [(106, 52), (160, 52)] ;

    # Étude de la borne -4
    text id 14 start 115.2s for 2.5s at (5.0, 42.0) ''[bold]Borne gauche $-4$ :[/bold] $x \ge -4 \implies$ [color=#34D399]$\mathbf{-4 \text{ est inclus}}$[/color]'' ;
    text id 15 start 128.0s for 2.5s at (5.0, 51.0) ''Le crochet [color=#34D399]attrape[/color] $-4$ : tourné vers [color=#34D399]l'intérieur[/color]'' ;
    # Crochet rouge fermé en -4 tourné vers la droite
    draw path id 521 start 137.7s for 1.0s color (248, 113, 113, 1) width 3.0 at [(108.5, 47), (106, 47), (106, 57), (108.5, 57)] ;

    # Étude de la borne 5
    text id 16 start 152.9s for 2.5s at (5.0, 62.0) ''[bold]Borne droite $5$ :[/bold] $x < 5 \text{ (strict)} \implies$ [color=#F87171]$\mathbf{5 \text{ est exclu}}$[/color]'' ;
    text id 17 start 165.8s for 2.5s at (5.0, 71.0) ''Le crochet [color=#F87171]repousse[/color] $5$ : tourné vers [color=#F87171]l'extérieur[/color]'' ;
    # Crochet rouge ouvert en 5 tourné vers la droite
    draw path id 522 start 173.0s for 1.0s color (248, 113, 113, 1) width 3.0 at [(162.5, 47), (160, 47), (160, 57), (162.5, 57)] ;

    # Notation finale
    text id 18 start 198.0s for 2.5s at (5.0, 83.0) ''[bold]Notation finale :[/bold] [color=#38BDF8]$\mathbf{I = [-4 ; 5[}$[/color] (fermé en $-4$, ouvert en $5$)'' ;

    erase id 2002 start 208.3s ;

    # =========================================================================
    # SCÈNE 3 : INTERVALLE NON BORNÉ J = [2 ; +infini[ (208.4s - 306.6s)
    # =========================================================================
    text id 21 start 209.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Intervalle Non Borné : La Demi-Droite et l'Infini[/color][/bold]'' ;
    draw line id 531 start 211.2s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 22 start 215.6s for 2.5s at (5.0, 20.0) ''[bold]Condition à représenter :[/bold] [color=#FBBF24]$\mathbf{x \ge 2}$[/color]'' ;
    text id 23 start 223.1s for 2.5s at (5.0, 29.0) ''On part de $2$ et on prend toutes les valeurs vers la droite.'' ;

    # Axe gradué
    draw arrow id 532 start 226.5s for 1.0s color (248, 250, 252, 0.9) width 1.8 at [(94, 55), (172, 55)] ;
    text id 39 start 228.0s at (168.0, 60.0) ''[color=#38BDF8]$x$[/color]'' ;
    draw line id 535 start 228.5s color (248, 250, 252, 0.6) width 1.5 at [(130, 52.5), (130, 57.5)] ;
    text id 40 start 228.5s at (129.0, 61.0) ''$0$'' ;
    draw line id 536 start 229.0s color (248, 250, 252, 0.6) width 1.5 at [(142, 52.5), (142, 57.5)] ;
    text id 51 start 229.0s at (141.0, 61.0) ''$2$'' ;

    # Demi-droite verte au-dessus
    draw arrow id 533 start 233.8s for 1.8s color (52, 211, 153, 1) width 4.0 at [(142, 42), (172, 42)] ;

    # Borne 2
    text id 24 start 247.7s for 2.5s at (5.0, 42.0) ''[bold]Borne $2$ :[/bold] $x \ge 2 \implies$ [color=#34D399]$\mathbf{2 \text{ est inclus}}$[/color] (crochet vers l'ensemble)'' ;
    # Crochet vert fermé en 2
    draw path id 534 start 253.6s for 1.0s color (52, 211, 153, 1) width 3.0 at [(144.5, 37), (142, 37), (142, 47), (144.5, 47)] ;

    # Infini
    text id 25 start 271.8s for 2.5s at (5.0, 56.0) ''[bold]Vers l'infini :[/bold] $+\infty$ n'est pas un nombre réel, mais une limite.'' ;
    text id 27 start 279.0s for 0.8s at (166.0, 35.0) ''[color=#34D399]$\mathbf{+\infty}$[/color]'' ;
    text id 26 start 281.0s for 2.5s at (5.0, 65.0) ''Au voisinage de $\pm\infty$, le crochet est [color=#F87171]toujours ouvert[/color] !'' ;

    # Notation finale
    text id 28 start 287.2s for 2.5s at (5.0, 78.0) ''[bold]Notation finale :[/bold] [color=#34D399]$\mathbf{J = [2 ; +\infty[}$[/color] (fermé en $2$, ouvert en $+\infty$)'' ;

    erase id 2003 start 306.6s ;

    # =========================================================================
    # SCÈNE 4 : INTERSECTION I inter J (306.7s - 403.4s)
    # =========================================================================
    text id 31 start 307.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Intersection d'Intervalles : La Conjonction 'ET'[/color][/bold]'' ;
    draw line id 541 start 309.3s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 32 start 316.0s for 2.5s at (5.0, 20.0) ''[bold]Intersection :[/bold] [color=#FBBF24]$\mathbf{I \cap J}$[/color] (symbole inter $\cap$)'' ;
    text id 33 start 322.0s for 2.5s at (5.0, 29.0) ''Condition logique [color=#FBBF24]ET[/color] : $x \in I \cap J \iff (x \in I \text{ \textbf{et} } x \in J)$'' ;

    # Axe et les deux intervalles
    draw arrow id 542 start 325.0s for 0.8s color (248, 250, 252, 0.9) width 1.8 at [(94, 52), (172, 52)] ;
    draw line id 543 start 326.5s for 0.8s color (248, 113, 113, 0.95) width 4.0 at [(106, 52), (160, 52)] ;
    draw arrow id 544 start 328.0s for 0.8s color (52, 211, 153, 1) width 3.5 at [(142, 42), (172, 42)] ;
    text id 52 start 329.0s at (104.0, 58.0) ''$-4$'' ;
    text id 53 start 329.0s at (141.0, 58.0) ''$2$'' ;
    text id 54 start 329.0s at (159.0, 58.0) ''$5$'' ;
    text id 55 start 329.5s at (110.0, 46.0) ''[color=#F87171]$\mathbf{I}$[/color]'' ;
    text id 56 start 329.5s at (162.0, 36.0) ''[color=#34D399]$\mathbf{J}$[/color]'' ;

    # Test de 0
    text id 34 start 341.6s for 2.5s at (5.0, 42.0) ''[bold]Test $x = 0$ :[/bold] $0 \in I$ mais $0 \notin J \implies$ [color=#F87171]$\mathbf{0 \notin I \cap J}$[/color]'' ;

    # Test de 3
    text id 35 start 362.5s for 2.5s at (5.0, 54.0) ''[bold]Test $x = 3$ :[/bold] $3 \in I$ et $3 \in J \implies$ [color=#34D399]$\mathbf{3 \in I \cap J}$[/color]'' ;

    # Règle visuelle
    text id 36 start 382.6s for 2.5s at (5.0, 67.0) ''[bold]Règle visuelle :[/bold] zone où les deux couleurs [color=#FBBF24]se superposent[/color].'' ;
    text id 37 start 393.3s for 2.0s at (5.0, 78.0) ''Superposition bicolore : zone comprise entre [color=#FBBF24]$2$[/color] et [color=#FBBF24]$5$[/color].'' ;

    # Cadre de superposition
    draw polygone id 545 start 396.0s for 1.2s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.22) width 1.5 at [(142, 36), (160, 36), (160, 60), (142, 60)] ;

    erase id 2004 start 403.4s ;

    # =========================================================================
    # SCÈNE 5 : STATUT DES BORNES DANS L'INTERSECTION (403.5s - 498.8s)
    # =========================================================================
    text id 41 start 404.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Statut des Bornes dans l'Intersection[/color][/bold]'' ;
    draw line id 551 start 406.6s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 42 start 408.2s for 2.5s at (5.0, 20.0) ''[bold]Question cruciale :[/bold] Quel est le statut de $2$ et $5$ dans $I \cap J$ ?'' ;
    text id 43 start 419.4s for 2.5s at (5.0, 29.0) ''Pour être dans $I \cap J$, la borne doit être [color=#FBBF24]dans les deux[/color] ensembles.'' ;

    # Axe zoomé
    draw arrow id 552 start 422.5s for 0.8s color (248, 250, 252, 0.9) width 1.8 at [(94, 52), (172, 52)] ;
    draw line id 556 start 423.5s color (248, 250, 252, 0.6) width 1.5 at [(142, 49.5), (142, 54.5)] ;
    text id 57 start 423.5s at (141.0, 58.0) ''$2$'' ;
    draw line id 557 start 424.0s color (248, 250, 252, 0.6) width 1.5 at [(160, 49.5), (160, 54.5)] ;
    text id 58 start 424.0s at (159.0, 58.0) ''$5$'' ;

    # Examen de 2
    text id 44 start 424.6s for 2.0s at (5.0, 40.0) ''[bold]Examen de la borne $2$ :[/bold]'' ;
    text id 45 start 429.0s for 2.5s at (7.0, 47.0) ''• $2 \in J$ ($2 \ge 2$) et $2 \in I$ (entre $-4$ et $5$)'' ;
    text id 46 start 444.4s for 2.0s at (7.0, 54.0) ''$\implies$ [color=#34D399]$\mathbf{2 \in I \cap J}$[/color] : crochet [color=#34D399]fermé[/color] en $2$'' ;
    # Crochet fermé en 2
    draw path id 553 start 448.2s for 1.0s color (52, 211, 153, 1) width 3.0 at [(144.5, 47), (142, 47), (142, 57), (144.5, 57)] ;

    # Examen de 5
    text id 47 start 452.0s for 2.0s at (5.0, 63.0) ''[bold]Examen de la borne $5$ :[/bold]'' ;
    text id 48 start 456.5s for 2.5s at (7.0, 70.0) ''• $5 \in J$ ($5 \ge 2$) mais [color=#F87171]$5 \notin I$[/color] ($x < 5$ strict)'' ;
    text id 49 start 480.5s for 2.0s at (7.0, 77.0) ''$\implies$ [color=#F87171]$\mathbf{5 \notin I \cap J}$[/color] : crochet [color=#F87171]ouvert[/color] en $5$'' ;
    # Crochet ouvert en 5
    draw path id 554 start 483.7s for 1.0s color (248, 113, 113, 1) width 3.0 at [(162.5, 47), (160, 47), (160, 57), (162.5, 57)] ;

    # Segment résultat
    draw line id 555 start 487.0s for 1.0s color (56, 189, 248, 1) width 4.5 at [(142, 52), (160, 52)] ;

    # Bilan
    text id 50 start 490.8s for 2.5s at (5.0, 87.0) ''[bold]Bilan :[/bold] [color=#38BDF8]$\mathbf{I \cap J = [2 ; 5[}$[/color] (fermé en $2$, ouvert en $5$)'' ;

    erase id 2005 start 498.8s ;

    # =========================================================================
    # SCÈNE 6 : RÉUNION I union J (498.9s - 608.8s)
    # =========================================================================
    text id 61 start 500.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Réunion d'Intervalles : La Disjonction 'OU'[/color][/bold]'' ;
    draw line id 561 start 502.2s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 62 start 506.8s for 2.5s at (5.0, 20.0) ''[bold]Réunion :[/bold] [color=#FBBF24]$\mathbf{I \cup J}$[/color] (symbole union $\cup$)'' ;
    text id 63 start 516.0s for 2.5s at (5.0, 29.0) ''Condition logique [color=#FBBF24]OU[/color] : $x \in I \cup J \iff (x \in I \text{ \textbf{ou} } x \in J)$'' ;
    text id 64 start 524.0s for 2.5s at (5.0, 38.0) ''Il suffit d'appartenir à [color=#38BDF8]au moins l'un des deux[/color] ensembles !'' ;

    # Axe et les deux ensembles
    draw arrow id 562 start 529.5s for 0.8s color (248, 250, 252, 0.9) width 1.8 at [(98, 50), (172, 50)] ;
    draw line id 563 start 531.5s for 0.8s color (248, 113, 113, 0.95) width 3.5 at [(106, 50), (160, 50)] ;
    draw arrow id 564 start 533.5s for 0.8s color (52, 211, 153, 1) width 3.5 at [(142, 42), (172, 42)] ;
    text id 59 start 534.5s at (104.0, 55.0) ''$-4$'' ;
    text id 60 start 534.5s at (141.0, 55.0) ''$2$'' ;
    text id 87 start 534.5s at (159.0, 55.0) ''$5$'' ;

    # Balayage
    text id 65 start 540.0s for 2.5s at (5.0, 49.0) ''[bold]Balayage :[/bold] toute portion avec [color=#FBBF24]au moins une couleur[/color].'' ;
    text id 66 start 553.0s for 2.5s at (5.0, 58.0) ''• Début en [color=#F87171]$-4$[/color] (début de la zone rouge)'' ;
    text id 67 start 567.0s for 2.2s at (5.0, 65.0) ''• La zone verte continue ensuite indéfiniment jusqu'à [color=#34D399]$+\infty$[/color] !'' ;

    # Couverture totale union
    draw arrow id 565 start 570.0s for 1.8s color (56, 189, 248, 1) width 4.5 at [(106, 62), (172, 62)] ;

    # Statut des bornes
    text id 68 start 578.0s for 2.5s at (5.0, 74.0) ''[bold]Borne $-4$ :[/bold] $-4 \in I \implies$ [color=#34D399]$\mathbf{-4 \in I \cup J}$[/color] (crochet fermé)'' ;
    # Crochet fermé en -4
    draw path id 566 start 594.0s for 1.0s color (56, 189, 248, 1) width 3.0 at [(108.5, 57), (106, 57), (106, 67), (108.5, 67)] ;

    text id 69 start 596.5s for 2.0s at (5.0, 81.0) ''[bold]Borne $+\infty$ :[/bold] crochet [color=#F87171]toujours ouvert[/color]'' ;

    # Bilan
    text id 70 start 601.9s for 2.5s at (5.0, 89.0) ''[bold]Bilan :[/bold] [color=#38BDF8]$\mathbf{I \cup J = [-4 ; +\infty[}$[/color] (fermé en $-4$, ouvert en $+\infty$)'' ;

    erase id 2006 start 608.8s ;

    # =========================================================================
    # SCÈNE 7 : SYNTHÈSE MÉTHODOLOGIQUE & TABLEAU RÉCAPITULATIF (608.9s - 660s)
    # =========================================================================
    text id 71 start 609.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Pièges Fréquents et Synthèse Méthodologique[/color][/bold]'' ;
    draw line id 571 start 611.6s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    # Réflexes gauche
    text id 72 start 613.8s for 1.5s at (5.0, 21.0) ''[bold][color=#FBBF24]1. Intersection $\cap$ ('ET')[/color][/bold]'' ;
    draw polygone id 572 start 615.8s for 0.8s color (56, 189, 248, 0.7) fillcolor (56, 189, 248, 0.08) width 1.5 at [(95, 20), (172, 20), (172, 88), (95, 88)] ;
    text id 81 start 617.0s at (104.0, 24.0) ''[bold][color=#38BDF8]TABLEAU RÉCAPITULATIF[/color][/bold]'' ;
    draw line id 573 start 617.5s color (56, 189, 248, 0.4) width 1.0 at [(98, 29), (169, 29)] ;

    text id 73 start 617.0s for 2.0s at (7.0, 28.0) ''Chercher la [color=#FBBF24]double couleur[/color] (zone commune).'' ;
    text id 74 start 620.0s for 2.0s at (7.0, 35.0) ''L'intersection [color=#F87171]rétrécit[/color] : $\mathbf{I \cap J = [2 ; 5[}$'' ;
    text id 82 start 622.0s at (98.0, 34.0) ''• $x \in [-4 ; 5[ \iff$ [color=#F87171]$\mathbf{-4 \le x < 5}$[/color]'' ;

    text id 75 start 622.8s for 1.5s at (5.0, 45.0) ''[bold][color=#38BDF8]2. Réunion $\cup$ ('OU')[/color][/bold]'' ;
    text id 83 start 625.0s at (98.0, 44.0) ''• $x \in [2 ; +\infty[ \iff$ [color=#34D399]$\mathbf{x \ge 2}$[/color]'' ;
    draw line id 574 start 625.5s color (248, 250, 252, 0.25) width 1.0 at [(98, 52), (169, 52)] ;

    text id 76 start 625.5s for 2.0s at (7.0, 52.0) ''Rassembler [color=#38BDF8]toutes les couleurs[/color] sans exception.'' ;
    text id 77 start 629.5s for 2.0s at (7.0, 59.0) ''La réunion [color=#34D399]élargit[/color] : $\mathbf{I \cup J = [-4 ; +\infty[}$'' ;

    text id 78 start 632.0s for 1.5s at (5.0, 69.0) ''[bold][color=#34D399]3. Règle absolue des bornes[/color][/bold]'' ;
    text id 84 start 634.5s for 1.8s at (98.0, 58.0) ''• [color=#FBBF24]$\mathbf{I \cap J = [2 ; 5[}$[/color] (zone commune 'ET')'' ;

    text id 79 start 637.0s for 2.5s at (7.0, 76.0) ''Pour $\cap$ : exclue d'un seul $\implies$ [color=#F87171]exclue de $\cap$[/color] !'' ;
    text id 85 start 640.5s for 1.8s at (98.0, 68.0) ''• [color=#38BDF8]$\mathbf{I \cup J = [-4 ; +\infty[}$[/color] (couverture 'OU')'' ;

    text id 80 start 645.0s for 2.5s at (7.0, 83.0) ''En $-\infty$ et $+\infty$ : crochet [color=#FBBF24]toujours ouvert[/color] !'' ;
    text id 86 start 651.0s for 2.5s at (98.0, 78.0) ''[bold]Règle d'or :[/bold] [color=#34D399]2 couleurs pour l'axe, 0 faute ![/color]'' ;
}
