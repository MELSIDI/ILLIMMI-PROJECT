course "Méthode : Résoudre un problème d'intervalles" id 1 idgap 500 for 302.44s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION ET PRINCIPE DE L'INTERSECTION (0.0s -> 20.3s)
    # =========================================================================

    # En-tête
    text id 1 start 0.2s for 3.8s at (4.0, 7.0) ''[bold][color=#38BDF8]MÉTHODE : INTERSECTION DE DEUX INTERVALLES[/color][/bold]'' ;
    draw line id 501 start 0.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Notions fondamentales
    text id 2 start 2.8s for 4.6s at (4.0, 18.0) ''[bold][color=#F8FAFC]Compétence clé de Seconde :[/color][/bold] Intervalles et encadrements'' ;
    text id 3 start 5.5s for 2.1s at (4.0, 27.0) ''[bold][color=#38BDF8]Définition de l'Intersection :[/color][/bold]'' ;
    text id 4 start 8.0s for 1.2s at (4.0, 36.0) ''L'intersection $I \cap J$ est l'ensemble des réels $x$ vérifiant :'' ;
    text id 5 start 11.0s for 3.8s at (4.0, 46.0) ''[color=#34D399]$$x \in I \quad \text{ET} \quad x \in J$$[/color]'' ;

    # Colonne droite : Diagramme de Venn
    draw circle id 502 start 7.5s for 1.0s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 2.0 radius 18.0 at (118.0, 55.0) ;
    draw circle id 503 start 10.0s for 1.0s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.15) width 2.0 radius 18.0 at (142.0, 55.0) ;
    text id 6 start 8.5s for 1.8s at (108.0, 40.0) ''[bold][color=#34D399]Ensemble $I$[/color][/bold]'' ;
    text id 7 start 11.0s for 1.8s at (144.0, 40.0) ''[bold][color=#F87171]Ensemble $J$[/color][/bold]'' ;
    text id 8 start 13.0s for 1.8s at (123.0, 53.0) ''[bold][color=#38BDF8]$I \cap J$[/color][/bold]'' ;
    text id 9 start 15.0s for 3.8s at (110.0, 80.0) ''[italic][color=#FBBF24]Zone commune aux deux ensembles[/color][/italic]'' ;

    # Transition Scène 1 -> Scène 2
    erase id 2001 start 20.3s ;

    # =========================================================================
    # SCÈNE 2 : PREMIER CAS — I = [-1 ; 3] ET J = ]0 ; 4[ (20.5s -> 211.8s)
    # =========================================================================

    # En-tête
    text id 10 start 20.6s for 4.8s at (4.0, 7.0) ''[bold][color=#38BDF8]CAS 1 : $I = [-1 ; 3]$ ET $J = ]0 ; 4[$ — ANALYSE GÉOMÉTRIQUE[/color][/bold]'' ;
    draw line id 504 start 20.8s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Démarche et analyse
    text id 11 start 22.0s for 2.8s at (4.0, 16.5) ''[bold][color=#FBBF24]Données du problème :[/color][/bold]'' ;
    text id 12 start 26.0s for 4.8s at (4.0, 24.0) ''$\bullet$ [color=#34D399]$I = [-1 ; 3]$[/color] : fermé (crochets vers l'intérieur, bornes incluses)'' ;
    text id 13 start 41.0s for 4.8s at (4.0, 32.0) ''$\bullet$ [color=#F87171]$J = ]0 ; 4[$[/color] : ouvert (crochets vers l'extérieur, bornes exclues)'' ;
    text id 14 start 99.5s for 4.5s at (4.0, 42.0) ''[bold][color=#38BDF8]Recherche de l'intersection :[/color][/bold] éléments appartenant à $I$ [bold]ET[/bold] à $J$'' ;
    text id 15 start 120.5s for 3.8s at (4.0, 50.0) ''[bold][color=#FBBF24]Zone commune :[/color][/bold] chevauchement visible de $0$ à $3$'' ;
    text id 16 start 137.0s for 5.5s at (4.0, 58.5) ''[bold]Test borne $0$ :[/bold] $0 \notin J \implies$ [color=#F87171]$0 \notin I \cap J$[/color] (crochet ouvert en $0$)'' ;
    text id 17 start 162.0s for 5.5s at (4.0, 67.0) ''[bold]Test borne $3$ :[/bold] $3 \in I$ et $3 \in J \implies$ [color=#34D399]$3 \in I \cap J$[/color] (crochet fermé en $3$)'' ;
    text id 18 start 192.0s for 2.8s at (4.0, 77.0) ''[bold][color=#38BDF8]Conclusion Cas 1 :[/color][/bold]'' ;
    text id 19 start 198.0s for 2.8s at (4.0, 85.0) ''[color=#38BDF8]$$\mathbf{I \cap J = ]0 ; 3]}$$[/color]'' ;

    # Colonne droite : Droite graduée et intervalles
    text id 20 start 63.0s for 1.9s at (96.0, 16.5) ''[bold][color=#F8FAFC]Représentation sur l'axe des réels :[/color][/bold]'' ;
    draw arrow id 505 start 64.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(98.0, 35.0), (170.0, 35.0)] ;
    text id 21 start 65.0s at (171.0, 34.0) ''[color=#F8FAFC]$x$[/color]'' ;

    # Graduations de l'axe
    draw line id 506 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(104.0, 33.5), (104.0, 36.5)] ;
    draw line id 507 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(112.5, 33.5), (112.5, 36.5)] ;
    draw line id 508 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(121.0, 33.5), (121.0, 36.5)] ;
    draw line id 509 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(129.5, 33.5), (129.5, 36.5)] ;
    draw line id 510 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(138.0, 33.5), (138.0, 36.5)] ;
    draw line id 511 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(146.5, 33.5), (146.5, 36.5)] ;
    draw line id 512 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(155.0, 33.5), (155.0, 36.5)] ;
    draw line id 513 start 65.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(163.5, 33.5), (163.5, 36.5)] ;

    text id 22 start 66.0s at (102.5, 38.0) ''[color=#94A3B8]$-2$[/color]'' ;
    text id 23 start 66.0s at (111.0, 38.0) ''[color=#94A3B8]$-1$[/color]'' ;
    text id 24 start 66.0s at (120.0, 38.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 25 start 66.0s at (128.5, 38.0) ''[color=#94A3B8]$1$[/color]'' ;
    text id 26 start 66.0s at (137.0, 38.0) ''[color=#94A3B8]$2$[/color]'' ;
    text id 27 start 66.0s at (145.5, 38.0) ''[color=#94A3B8]$3$[/color]'' ;
    text id 28 start 66.0s at (154.0, 38.0) ''[color=#94A3B8]$4$[/color]'' ;
    text id 29 start 66.0s at (162.5, 38.0) ''[color=#94A3B8]$5$[/color]'' ;

    # Intervalle I en vert à y = 49.0
    text id 30 start 68.0s for 1.8s at (124.0, 43.5) ''[bold][color=#34D399]$I = [-1 ; 3]$[/color][/bold]'' ;
    draw line id 514 start 75.0s for 1.2s color (52, 211, 153, 1) width 3.5 at [(112.5, 49.0), (146.5, 49.0)] ;
    draw path id 515 start 76.5s for 0.5s color (52, 211, 153, 1) width 2.5 at [(114.5, 46.5), (112.5, 46.5), (112.5, 51.5), (114.5, 51.5)] ;
    draw path id 516 start 77.5s for 0.5s color (52, 211, 153, 1) width 2.5 at [(144.5, 46.5), (146.5, 46.5), (146.5, 51.5), (144.5, 51.5)] ;

    # Intervalle J en rouge à y = 59.0
    text id 31 start 84.0s for 1.8s at (132.0, 53.5) ''[bold][color=#F87171]$J = ]0 ; 4[$[/color][/bold]'' ;
    draw line id 517 start 91.0s for 1.2s color (248, 113, 113, 1) width 3.5 at [(121.0, 59.0), (155.0, 59.0)] ;
    draw path id 518 start 92.5s for 0.5s color (248, 113, 113, 1) width 2.5 at [(119.0, 56.5), (121.0, 56.5), (121.0, 61.5), (119.0, 61.5)] ;
    draw path id 519 start 93.5s for 0.5s color (248, 113, 113, 1) width 2.5 at [(157.0, 56.5), (155.0, 56.5), (155.0, 61.5), (157.0, 61.5)] ;

    # Zone de chevauchement et Intersection I inter J à y = 71.0
    draw polygone id 520 start 117.0s for 0.8s color (56, 189, 248, 0.6) fillcolor (56, 189, 248, 0.15) width 1.5 at [(121.0, 45.0), (146.5, 45.0), (146.5, 63.0), (121.0, 63.0)] ;
    text id 32 start 121.0s for 1.8s at (128.0, 65.5) ''[bold][color=#38BDF8]$I \cap J$[/color][/bold]'' ;
    draw line id 521 start 123.0s for 1.0s color (56, 189, 248, 1) width 4.0 at [(121.0, 71.0), (146.5, 71.0)] ;
    draw path id 522 start 158.0s for 0.5s color (56, 189, 248, 1) width 2.5 at [(119.0, 68.5), (121.0, 68.5), (121.0, 73.5), (119.0, 73.5)] ;
    draw arrow id 523 start 159.0s for 0.5s color (248, 113, 113, 1) width 1.8 at [(121.0, 80.0), (121.0, 74.5)] ;
    text id 33 start 160.0s for 2.8s at (105.0, 82.5) ''[color=#F87171]$0 \notin J \implies$ exclu[/color]'' ;

    draw path id 524 start 188.0s for 0.5s color (56, 189, 248, 1) width 2.5 at [(144.5, 68.5), (146.5, 68.5), (146.5, 73.5), (144.5, 73.5)] ;
    draw arrow id 525 start 189.0s for 0.5s color (52, 211, 153, 1) width 1.8 at [(146.5, 80.0), (146.5, 74.5)] ;
    text id 34 start 190.0s for 2.8s at (142.0, 82.5) ''[color=#34D399]$3 \in I, J \implies$ inclus[/color]'' ;

    # Transition Scène 2 -> Scène 3
    erase id 2002 start 211.8s ;

    # =========================================================================
    # SCÈNE 3 : DEUXIÈME CAS — I = ]-inf ; 0] ET J = [1 ; 4] (212.0s -> 296.8s)
    # =========================================================================

    # En-tête
    text id 35 start 212.2s for 3.8s at (4.0, 7.0) ''[bold][color=#38BDF8]CAS 2 : $I = ]-\infty ; 0]$ ET $J = [1 ; 4]$ — ENSEMBLE VIDE[/color][/bold]'' ;
    draw line id 526 start 212.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Démarche et analyse
    text id 36 start 213.5s for 2.8s at (4.0, 16.5) ''[bold][color=#FBBF24]Données du deuxième cas :[/color][/bold]'' ;
    text id 37 start 216.0s for 5.5s at (4.0, 24.0) ''$\bullet$ [color=#34D399]$I = ]-\infty ; 0]$[/color] : demi-droite ($0$ inclus, $-\infty$ toujours exclu)'' ;
    text id 38 start 232.0s for 3.8s at (4.0, 32.0) ''$\bullet$ [color=#F87171]$J = [1 ; 4]$[/color] : intervalle [color=#F87171]fermé[/color] ($1$ et $4$ inclus)'' ;
    text id 39 start 263.0s for 3.8s at (4.0, 42.0) ''[bold][color=#38BDF8]Recherche des éléments communs :[/color][/bold]'' ;
    text id 40 start 271.0s for 4.4s at (4.0, 50.0) ''Constat : les deux intervalles [color=#F87171]ne se chevauchent pas[/color].'' ;
    text id 41 start 276.0s for 3.9s at (4.0, 58.0) ''Aucun nombre réel n'appartient à la fois à $I$ et à $J$.'' ;
    text id 42 start 282.5s for 3.8s at (4.0, 67.0) ''On dit que les intervalles $I$ et $J$ sont [bold][color=#FBBF24]disjoints[/color][/bold].'' ;
    text id 43 start 289.0s for 3.8s at (4.0, 76.0) ''[bold][color=#38BDF8]Symbole ensemble vide :[/color][/bold] $\emptyset$ (zéro barré)'' ;
    text id 44 start 294.0s for 2.6s at (4.0, 85.0) ''[color=#38BDF8]$$\mathbf{I \cap J = \emptyset}$$[/color]'' ;

    # Colonne droite : Axe gradué et demi-droite
    text id 45 start 241.5s for 1.4s at (96.0, 16.5) ''[bold][color=#F8FAFC]Représentation sur l'axe gradué :[/color][/bold]'' ;
    draw arrow id 527 start 242.0s for 1.2s color (248, 250, 252, 0.9) width 2.0 at [(98.0, 35.0), (170.0, 35.0)] ;
    text id 46 start 243.0s at (171.0, 34.0) ''[color=#F8FAFC]$x$[/color]'' ;

    # Graduations de l'axe
    draw line id 528 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(104.0, 33.5), (104.0, 36.5)] ;
    draw line id 529 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(113.0, 33.5), (113.0, 36.5)] ;
    draw line id 530 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(122.0, 33.5), (122.0, 36.5)] ;
    draw line id 531 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(131.0, 33.5), (131.0, 36.5)] ;
    draw line id 532 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(140.0, 33.5), (140.0, 36.5)] ;
    draw line id 533 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(149.0, 33.5), (149.0, 36.5)] ;
    draw line id 534 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(158.0, 33.5), (158.0, 36.5)] ;
    draw line id 535 start 243.5s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(167.0, 33.5), (167.0, 36.5)] ;

    text id 47 start 244.0s at (102.5, 38.0) ''[color=#94A3B8]$-2$[/color]'' ;
    text id 48 start 244.0s at (111.5, 38.0) ''[color=#94A3B8]$-1$[/color]'' ;
    text id 49 start 244.0s at (121.0, 38.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 50 start 244.0s at (130.0, 38.0) ''[color=#94A3B8]$1$[/color]'' ;
    text id 51 start 244.0s at (139.0, 38.0) ''[color=#94A3B8]$2$[/color]'' ;
    text id 52 start 244.0s at (148.0, 38.0) ''[color=#94A3B8]$3$[/color]'' ;
    text id 53 start 244.0s at (157.0, 38.0) ''[color=#94A3B8]$4$[/color]'' ;
    text id 54 start 244.0s at (166.0, 38.0) ''[color=#94A3B8]$5$[/color]'' ;

    # Intervalle I = ]-inf ; 0] en vert à y = 50.0
    text id 55 start 248.0s for 2.8s at (107.0, 43.5) ''[bold][color=#34D399]$I = ]-\infty ; 0]$[/color][/bold]'' ;
    draw line id 536 start 249.0s for 1.2s color (52, 211, 153, 1) width 3.5 at [(98.0, 50.0), (122.0, 50.0)] ;
    text id 56 start 250.0s for 1.8s at (96.0, 43.5) ''[color=#34D399]$-\infty$[/color]'' ;
    draw arrow id 537 start 250.5s for 0.5s color (52, 211, 153, 1) width 3.0 at [(103.0, 50.0), (98.0, 50.0)] ;
    draw path id 538 start 252.5s for 0.5s color (52, 211, 153, 1) width 2.5 at [(120.0, 47.5), (122.0, 47.5), (122.0, 52.5), (120.0, 52.5)] ;

    # Intervalle J = [1 ; 4] en rouge à y = 59.0
    text id 57 start 256.0s for 0.5s at (138.0, 52.5) ''[bold][color=#F87171]$J = [1 ; 4]$[/color][/bold]'' ;
    draw line id 539 start 257.0s for 1.0s color (248, 113, 113, 1) width 3.5 at [(131.0, 59.0), (158.0, 59.0)] ;
    draw path id 540 start 259.0s for 0.5s color (248, 113, 113, 1) width 2.5 at [(133.0, 56.5), (131.0, 56.5), (131.0, 61.5), (133.0, 61.5)] ;
    draw path id 541 start 260.5s for 0.5s color (248, 113, 113, 1) width 2.5 at [(156.0, 56.5), (158.0, 56.5), (158.0, 61.5), (156.0, 61.5)] ;

    # Zone de séparation / aucun chevauchement
    draw line id 542 start 271.0s for 0.5s color (251, 191, 36, 1) width 2.0 at [(122.0, 70.0), (131.0, 70.0)] ;
    draw line id 543 start 271.5s for 0.3s color (251, 191, 36, 1) width 2.0 at [(122.0, 68.0), (122.0, 72.0)] ;
    draw line id 544 start 271.5s for 0.3s color (251, 191, 36, 1) width 2.0 at [(131.0, 68.0), (131.0, 72.0)] ;
    text id 58 start 273.0s for 2.8s at (114.0, 74.0) ''[bold][color=#FBBF24]Pas de chevauchement ![/color][/bold]'' ;

    # Encadré conclusion ensemble vide
    draw polygone id 545 start 286.0s for 0.8s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 1.5 at [(105.0, 80.0), (162.0, 80.0), (162.0, 93.0), (105.0, 93.0)] ;
    text id 59 start 287.0s for 2.8s at (114.0, 82.5) ''[bold][color=#38BDF8]INTERSECTION VIDE[/color][/bold]'' ;
    text id 60 start 293.0s for 2.8s at (122.0, 87.0) ''[color=#F8FAFC]$$\mathbf{I \cap J = \emptyset}$$[/color]'' ;

    # Transition Scène 3 -> Scène 4
    erase id 2003 start 296.8s ;

    # =========================================================================
    # SCÈNE 4 : SYNTHÈSE MÉTHODOLOGIQUE ET RÉFLEXES DE CONTRÔLE (297.0s -> 302.44s)
    # =========================================================================

    # En-tête
    text id 61 start 297.2s for 3.8s at (4.0, 7.0) ''[bold][color=#38BDF8]SYNTHÈSE : MÉTHODE INFAILLIBLE EN 3 ÉTAPES[/color][/bold]'' ;
    draw line id 546 start 297.4s for 0.5s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Les 3 étapes
    text id 62 start 298.0s for 1.2s at (4.0, 18.0) ''[bold][color=#FBBF24]1. Tracer l'axe gradué orienté[/color][/bold]'' ;
    text id 63 start 299.5s for 2.7s at (4.0, 25.5) ''Placer une échelle régulière avec le sens croissant vers $+\infty$.'' ;
    text id 64 start 301.0s for 1.2s at (4.0, 35.0) ''[bold][color=#34D399]2. Représenter chaque intervalle[/color][/bold]'' ;
    text id 65 start 302.5s at (4.0, 42.5) ''Deux couleurs distinctes, crochets orientés ([color=#34D399]inclus[/color] vs [color=#F87171]exclu[/color]).'' ;
    text id 66 start 304.0s at (4.0, 52.0) ''[bold][color=#38BDF8]3. Identifier la zone commune et tester les bornes[/color][/bold]'' ;
    text id 67 start 305.5s at (4.0, 59.5) ''Une borne est dans $I \cap J \iff$ elle est dans [bold]les deux[/bold] !'' ;
    text id 68 start 307.0s at (4.0, 69.0) ''[italic][color=#C084FC]Si aucun chevauchement $\implies I \cap J = \emptyset$ (ensemble vide).[/color][/italic]'' ;

    # Colonne droite : Fiches mémo
    draw polygone id 547 start 298.0s for 0.8s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.15) width 1.5 at [(94.0, 18.0), (172.0, 18.0), (172.0, 52.0), (94.0, 52.0)] ;
    text id 69 start 298.5s for 0.8s at (98.0, 21.0) ''[bold][color=#FBBF24]RÈGLE D'OR DES BORNES[/color][/bold]'' ;
    text id 70 start 299.5s at (98.0, 28.0) ''$\bullet$ Si une borne est [color=#F87171]exclue[/color] de l'un des intervalles,'' ;
    text id 71 start 300.5s for 0.8s at (102.0, 35.0) ''elle est [bold][color=#F87171]strictement exclue[/color][/bold] de l'intersection.'' ;
    text id 72 start 301.5s for 0.7s at (98.0, 42.0) ''$\bullet$ Pour être [color=#34D399]incluse[/color], elle doit appartenir'' ;
    text id 73 start 302.5s at (102.0, 47.5) ''obligatoirement aux [bold][color=#34D399]DEUX[/color][/bold] ensembles à la fois !'' ;

    draw polygone id 548 start 303.0s for 0.8s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 1.5 at [(94.0, 56.0), (172.0, 56.0), (172.0, 88.0), (94.0, 88.0)] ;
    text id 74 start 303.5s at (98.0, 59.0) ''[bold][color=#38BDF8]RÉFLEXES DES DEUX EXEMPLES[/color][/bold]'' ;
    text id 75 start 304.5s at (98.0, 66.5) ''[color=#38BDF8]$$[-1 ; 3] \;\cap\; ]0 ; 4[ \;=\; ]0 ; 3]$$[/color]'' ;
    text id 76 start 306.0s at (98.0, 77.0) ''[color=#F8FAFC]$$]-\infty ; 0] \;\cap\; [1 ; 4] \;=\; \emptyset$$[/color]'' ;

}
