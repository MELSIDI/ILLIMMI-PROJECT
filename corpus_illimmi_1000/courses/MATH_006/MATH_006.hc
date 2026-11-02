course "Révision express & Fiche de synthèse : Tout retenir sur Intervalles et encadrements de réels" id 6 idgap 500 for 493.82s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 0 : INTRODUCTION & OBJECTIFS DU COURS (0.0s -> 24.2s)
    # =========================================================================

    text id 1 start 0.2s for 2.0s at (4.0, 7.5) ''[color=#38BDF8][bold]INTERVALLES & ENCADREMENTS DE RÉELS[/bold][/color]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 4.0s for 2.5s at (5.0, 24.0) ''[color=#F8FAFC]Objectif du cours : Maîtriser le passage immédiat entre 3 langages :[/color]'' ;

    text id 3 start 7.2s for 1.8s at (8.0, 38.0) ''[color=#34D399][bold]1. Inégalités & Encadrements :[/bold][/color] $a \leqslant x < b$'' ;
    text id 4 start 9.5s for 1.8s at (8.0, 52.0) ''[color=#FBBF24][bold]2. Notations d'intervalles :[/bold][/color] $x \in [a \,;\, b[$'' ;
    text id 5 start 12.0s for 1.8s at (8.0, 66.0) ''[color=#C084FC][bold]3. Droites graduées :[/bold][/color] portion coloriée et orientation des crochets'' ;

    draw arrow id 502 start 14.5s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(96, 52), (168, 52)] ;
    draw line id 503 start 16.2s for 0.8s color (52, 211, 153, 1) width 4.5 at [(114, 52), (150, 52)] ;
    text id 6 start 17.5s at (112.0, 60.0) ''[color=#34D399][bold]$a$[/bold][/color]'' ;
    text id 7 start 18.0s at (148.0, 60.0) ''[color=#F87171][bold]$b$[/bold][/color]'' ;
    draw path id 504 start 18.8s for 0.8s color (52, 211, 153, 1) width 2.5 at [(116, 47), (114, 47), (114, 57), (116, 57)] ;
    draw path id 505 start 20.0s for 0.8s color (248, 113, 113, 1) width 2.5 at [(152, 47), (150, 47), (150, 57), (152, 57)] ;

    erase id 2001 start 24.2s ;

    # =========================================================================
    # SCÈNE 1 : CAS D'ÉCOLE FONDAMENTAL : 1 <= x < 5 (24.36s -> 107.4s)
    # =========================================================================

    text id 8 start 24.4s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]1. CAS D'ÉCOLE : L'ENCADREMENT $1 \leqslant x < 5$[/bold][/color]'' ;
    draw line id 506 start 26.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 9 start 27.8s for 2.2s at (6.0, 24.0) ''[color=#38BDF8][bold]$$\mathbf{1 \leqslant x < 5}$$[/bold][/color]'' ;
    text id 10 start 35.5s for 2.8s at (6.0, 36.0) ''[color=#F8FAFC]Lecture : $\mathbf{x \geqslant 1}$ [color=#34D399](sup. ou égal à 1)[/color] et $\mathbf{x < 5}$ [color=#F87171](strict. inf. à 5)[/color][/color]'' ;
    text id 11 start 42.5s for 2.8s at (6.0, 48.0) ''[color=#FBBF24][bold]Sens concret :[/bold][/color] [color=#F8FAFC]$x$ est entre $1$ et $5$, en incluant $1$ mais [bold]pas 5[/bold].[/color]'' ;
    text id 12 start 52.5s for 2.8s at (6.0, 60.0) ''[color=#C084FC][bold]Infinité de réels :[/bold][/color] $1 \,\,;\,\, 2 \,\,;\,\, 2{,}5 \,\,;\,\, 3{,}14 \,\,;\,\, 4{,}87 \,\,;\,\, 4{,}999\dots$'' ;

    draw polygone id 507 start 68.5s for 1.0s color (248, 113, 113, 0.8) fillcolor (248, 113, 113, 0.15) width 1.5 at [(102, 20), (174, 20), (174, 46), (102, 46)] ;
    text id 13 start 70.3s for 2.2s at (105.0, 26.0) ''[color=#F87171][bold]Borne 5 : Inégalité stricte « < »[/bold][/color]'' ;
    text id 14 start 73.5s for 2.4s at (105.0, 36.0) ''[color=#F8FAFC]$x < 5 \implies$ le nombre [bold]5 est EXCLU[/bold][/color]'' ;

    draw polygone id 508 start 83.7s for 1.0s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.15) width 1.5 at [(102, 50), (174, 50), (174, 76), (102, 76)] ;
    text id 15 start 85.5s for 2.2s at (105.0, 56.0) ''[color=#34D399][bold]Borne 1 : Inégalité large « $\leqslant$ »[/bold][/color]'' ;
    text id 16 start 91.0s for 2.4s at (105.0, 66.0) ''[color=#F8FAFC]$1 \leqslant x \implies$ le nombre [bold]1 est INCLUS[/bold][/color]'' ;

    text id 17 start 102.0s for 2.8s at (6.0, 84.0) ''[color=#FBBF24][bold]Règle :[/bold][/color] [color=#F8FAFC]« $\leqslant$ ou $\geqslant$ » $\implies$ égalité permise  |  « $<$ ou $>$ » $\implies$ exclu[/color]'' ;

    erase id 2002 start 107.4s ;

    # =========================================================================
    # SCÈNE 2 : DÉFINITION D'UN INTERVALLE & SENS DES CROCHETS (107.66s -> 170.5s)
    # =========================================================================

    text id 18 start 107.7s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]2. NOTATION D'INTERVALLE & SENS DES CROCHETS[/bold][/color]'' ;
    draw line id 509 start 110.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 510 start 114.2s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.5 at [(5, 20), (95, 20), (95, 42), (5, 42)] ;
    text id 19 start 116.5s for 2.5s at (8.0, 26.0) ''[color=#38BDF8][bold]Définition :[/bold][/color] [color=#F8FAFC]Ensemble des réels compris entre 2 bornes.[/color]'' ;

    text id 20 start 126.5s for 2.5s at (6.0, 50.0) ''[color=#FBBF24][bold]Symbole d'appartenance :[/bold][/color] $\mathbf{\in}$ [color=#F8FAFC](« appartient à »)[/color]'' ;
    text id 21 start 132.2s for 2.5s at (6.0, 62.0) ''[color=#F8FAFC]Écriture : [color=#34D399]crochet 1[/color] [color=#F8FAFC]borne 1[/color] [color=#38BDF8];[/color] [color=#F8FAFC]borne 2[/color] [color=#F87171]crochet 2[/color][/color]'' ;

    draw polygone id 511 start 140.2s for 0.8s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 1.5 at [(102, 20), (174, 20), (174, 45), (102, 45)] ;
    text id 22 start 142.0s for 2.5s at (105.0, 26.0) ''[color=#34D399][bold]Crochet vers l'INTÉRIEUR : $[$ ou $]$[/bold][/color]'' ;
    text id 23 start 146.0s for 2.2s at (105.0, 36.0) ''[color=#F8FAFC]Enserre le nombre $\implies$ [bold]BORNE INCLUSE[/bold][/color]'' ;

    draw polygone id 512 start 152.4s for 0.8s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.15) width 1.5 at [(102, 50), (175, 50), (175, 75), (102, 75)] ;
    text id 24 start 154.5s for 2.5s at (105.0, 56.0) ''[color=#F87171][bold]Crochet vers l'EXTÉRIEUR : $]$ ou $[$[/bold][/color]'' ;
    text id 25 start 158.8s for 2.2s at (105.0, 66.0) ''[color=#F8FAFC]Tourne le dos $\implies$ [bold]BORNE EXCLUE[/bold][/color]'' ;

    text id 26 start 166.5s for 2.2s at (6.0, 75.0) ''[color=#38BDF8][bold]$$\mathbf{x \in [1 \,;\, 5[}$$[/bold][/color]'' ;
    text id 27 start 169.2s at (6.0, 88.0) ''[color=#34D399]1 inclus (crochet intérieur)[/color] [color=#F8FAFC]et[/color] [color=#F87171]5 exclu (crochet extérieur)[/color]'' ;

    erase id 2003 start 170.5s ;

    # =========================================================================
    # SCÈNE 3 : REPRÉSENTATION SUR L'AXE GRADUÉ (170.77s -> 212.6s)
    # =========================================================================

    text id 28 start 170.8s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]3. REPRÉSENTATION SUR L'AXE GRADUÉ : $[1 \,;\, 5[$[/bold][/color]'' ;
    draw line id 513 start 172.5s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 29 start 173.5s for 1.5s at (6.0, 24.0) ''[color=#38BDF8][bold]Méthode graphique en 3 étapes :[/bold][/color]'' ;
    draw arrow id 514 start 175.2s for 1.0s color (248, 250, 252, 0.95) width 2.5 at [(88, 50), (172, 50)] ;

    draw line id 515 start 176.5s color (248, 250, 252, 0.6) width 1.5 at [(94, 47), (94, 53)] ;
    draw line id 516 start 176.7s color (248, 250, 252, 0.6) width 1.5 at [(106, 47), (106, 53)] ;
    draw line id 517 start 176.9s color (248, 250, 252, 0.6) width 1.5 at [(118, 47), (118, 53)] ;
    draw line id 518 start 177.1s color (248, 250, 252, 0.6) width 1.5 at [(130, 47), (130, 53)] ;
    draw line id 519 start 177.3s color (248, 250, 252, 0.6) width 1.5 at [(142, 47), (142, 53)] ;
    draw line id 520 start 177.5s color (248, 250, 252, 0.6) width 1.5 at [(154, 47), (154, 53)] ;
    draw line id 521 start 177.7s color (248, 250, 252, 0.6) width 1.5 at [(166, 47), (166, 53)] ;

    text id 35 start 177.9s at (92.5, 58.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 36 start 178.1s at (104.5, 58.0) ''[color=#34D399][bold]$1$[/bold][/color]'' ;
    text id 37 start 178.3s at (116.5, 58.0) ''[color=#94A3B8]$2$[/color]'' ;
    text id 38 start 178.5s at (128.5, 58.0) ''[color=#94A3B8]$3$[/color]'' ;
    text id 39 start 178.7s at (140.5, 58.0) ''[color=#94A3B8]$4$[/color]'' ;
    text id 40 start 178.9s at (152.5, 58.0) ''[color=#F87171][bold]$5$[/bold][/color]'' ;
    text id 41 start 179.1s at (164.5, 58.0) ''[color=#94A3B8]$6$[/color]'' ;

    text id 30 start 179.8s for 1.8s at (8.0, 36.0) ''[color=#F8FAFC]1. Placer les deux bornes $\mathbf{1}$ et $\mathbf{5}$ sur la droite.[/color]'' ;
    draw line id 522 start 182.0s for 1.2s color (56, 189, 248, 0.95) width 5.5 at [(106, 50), (154, 50)] ;

    text id 31 start 183.5s for 2.0s at (8.0, 48.0) ''[color=#F8FAFC]2. Surligner toute la portion comprise entre $1$ et $5$.[/color]'' ;

    text id 32 start 189.3s for 2.5s at (8.0, 60.0) ''[color=#F8FAFC]3. Reporter les crochets orientés dans le même sens :[/color]'' ;
    text id 33 start 195.8s for 1.8s at (10.0, 72.0) ''[color=#34D399]$\bullet$ En 1 : crochet intérieur vers la zone (1 inclus)[/color]'' ;
    draw path id 523 start 198.0s for 0.8s color (52, 211, 153, 1) width 3.0 at [(109, 43), (106, 43), (106, 57), (109, 57)] ;

    text id 34 start 203.0s for 1.8s at (10.0, 84.0) ''[color=#F87171]$\bullet$ En 5 : crochet extérieur tournant le dos (5 exclu)[/color]'' ;
    draw path id 524 start 205.0s for 0.8s color (248, 113, 113, 1) width 3.0 at [(157, 43), (154, 43), (154, 57), (157, 57)] ;

    text id 42 start 208.5s for 1.8s at (120.0, 36.0) ''[color=#38BDF8][bold]$x \in [1 \,;\, 5[$[/bold][/color]'' ;

    erase id 2004 start 212.6s ;

    # =========================================================================
    # SCÈNE 4 : ENTRAÎNEMENT 1 : DE ]-2 ; 2] À L'INÉGALITÉ (212.89s -> 275.0s)
    # =========================================================================

    text id 43 start 213.0s for 1.6s at (4.0, 7.5) ''[color=#38BDF8][bold]4. EXERCICE 1 : DE L'INTERVALLE $]-2 \,;\, 2]$ À L'INÉGALITÉ[/bold][/color]'' ;
    draw line id 525 start 214.8s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 44 start 223.4s for 2.0s at (6.0, 24.0) ''[color=#FBBF24][bold]Donnée de départ :[/bold][/color] [color=#38BDF8]$$\mathbf{x \in \,]-2 \,;\, 2]}$$[/color]'' ;

    draw arrow id 526 start 227.0s for 1.0s color (248, 250, 252, 0.95) width 2.5 at [(90, 48), (174, 48)] ;
    draw line id 527 start 228.5s color (248, 250, 252, 0.6) width 1.5 at [(108, 45), (108, 51)] ;
    draw line id 528 start 228.7s color (248, 250, 252, 0.6) width 1.5 at [(136, 45), (136, 51)] ;
    draw line id 529 start 228.9s color (248, 250, 252, 0.6) width 1.5 at [(164, 45), (164, 51)] ;

    text id 45 start 231.5s at (105.0, 56.0) ''[color=#F87171][bold]$-2$[/bold][/color]'' ;
    text id 46 start 232.5s at (134.5, 56.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 47 start 233.0s at (162.5, 56.0) ''[color=#34D399][bold]$2$[/bold][/color]'' ;

    draw line id 530 start 234.8s for 1.2s color (56, 189, 248, 0.95) width 5.5 at [(108, 48), (164, 48)] ;

    text id 48 start 240.0s for 1.8s at (6.0, 40.0) ''[color=#F87171]$\bullet$ Devant $-2$ : crochet [bold]ouvert[/bold] $]$ $\implies -2$ est [bold]exclu[/bold][/color]'' ;
    draw path id 531 start 242.0s for 0.8s color (248, 113, 113, 1) width 3.0 at [(105, 41), (108, 41), (108, 55), (105, 55)] ;

    text id 49 start 247.0s for 1.8s at (6.0, 52.0) ''[color=#34D399]$\bullet$ Après $2$ : crochet [bold]fermé[/bold] $]$ $\implies 2$ est [bold]inclus[/bold][/color]'' ;
    draw path id 532 start 249.0s for 0.8s color (52, 211, 153, 1) width 3.0 at [(161, 41), (164, 41), (164, 55), (161, 55)] ;

    text id 50 start 258.5s for 1.8s at (6.0, 65.0) ''[color=#FBBF24][bold]Déduction de l'inégalité :[/bold][/color]'' ;
    text id 51 start 260.8s for 1.8s at (8.0, 75.0) ''[color=#F8FAFC]$-2$ exclu $\implies x > -2$ (inégalité stricte)[/color]'' ;
    text id 52 start 264.0s for 1.8s at (8.0, 85.0) ''[color=#F8FAFC]$2$ inclus $\implies x \leqslant 2$ (inégalité large)[/color]'' ;

    draw polygone id 533 start 269.4s for 0.8s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.15) width 2.0 at [(100, 68), (170, 68), (170, 92), (100, 92)] ;
    text id 53 start 270.6s for 2.2s at (106.0, 77.0) ''[color=#38BDF8][bold]$$\mathbf{-2 < x \leqslant 2}$$[/bold][/color]'' ;

    erase id 2005 start 275.0s ;

    # =========================================================================
    # SCÈNE 5 : ENTRAÎNEMENT 2 : x <= 3 ET LA NOTION D'INFINI (275.44s -> 352.0s)
    # =========================================================================

    text id 54 start 275.6s for 1.6s at (4.0, 7.5) ''[color=#38BDF8][bold]5. EXERCICE 2 : L'INÉGALITÉ $x \leqslant 3$ ET LE SYMBOLE INFINI $\infty$[/bold][/color]'' ;
    draw line id 534 start 277.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 55 start 279.0s for 2.0s at (6.0, 24.0) ''[color=#FBBF24][bold]Inégalité donnée :[/bold][/color] [color=#38BDF8]$$\mathbf{x \leqslant 3}$$[/color]'' ;
    text id 56 start 284.0s for 2.5s at (6.0, 37.0) ''[color=#FBBF24][bold]Sens concret :[/bold][/color] [color=#F8FAFC]Tous les réels inférieurs ou égaux à $3$[/color]'' ;

    draw arrow id 535 start 289.5s for 1.0s color (248, 250, 252, 0.95) width 2.5 at [(96, 48), (172, 48)] ;
    draw line id 536 start 291.0s color (248, 250, 252, 0.6) width 1.5 at [(118, 45), (118, 51)] ;
    draw line id 537 start 291.2s color (248, 250, 252, 0.6) width 1.5 at [(156, 45), (156, 51)] ;

    text id 57 start 292.5s at (116.5, 56.0) ''[color=#94A3B8]$0$[/color]'' ;
    text id 58 start 293.0s at (154.5, 56.0) ''[color=#34D399][bold]$3$[/bold][/color]'' ;

    draw path id 538 start 299.5s for 0.8s color (52, 211, 153, 1) width 3.0 at [(153, 41), (156, 41), (156, 55), (153, 55)] ;
    draw line id 539 start 303.5s for 1.2s color (56, 189, 248, 0.95) width 5.5 at [(96, 48), (156, 48)] ;
    text id 59 start 308.0s for 1.2s at (96.0, 56.0) ''[color=#FBBF24][bold]$-\infty$[/bold][/color]'' ;

    text id 60 start 314.5s for 2.5s at (6.0, 48.0) ''[color=#C084FC][bold]Pas de borne finie à gauche :[/bold][/color] la demi-droite est infinie'' ;
    text id 61 start 322.5s for 2.5s at (6.0, 58.0) ''[color=#F8FAFC]Symbole [bold]$\infty$[/bold] (huit horizontal) $\implies$ vers la gauche : [color=#FBBF24]$\mathbf{-\infty}$[/color][/color]'' ;

    draw polygone id 540 start 331.0s for 0.8s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.15) width 2.0 at [(6, 68), (86, 68), (86, 92), (6, 92)] ;
    text id 62 start 332.5s for 2.2s at (12.0, 77.0) ''[color=#38BDF8][bold]$$\mathbf{x \in \,]-\infty \,;\, 3]}$$[/bold][/color]'' ;

    draw polygone id 541 start 337.5s for 0.8s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.15) width 2.0 at [(96, 68), (172, 68), (172, 92), (96, 92)] ;
    text id 63 start 339.5s for 2.0s at (100.0, 73.0) ''[color=#F87171][bold]RÈGLE D'OR ABSOLUE :[/bold][/color]'' ;
    text id 64 start 344.5s for 2.5s at (100.0, 82.0) ''[color=#F8FAFC]Le crochet est [bold]TOUJOURS OUVERT[/bold] en $-\infty$ et $+\infty$ ![/color]'' ;

    erase id 2006 start 352.0s ;

    # =========================================================================
    # SCÈNE 6 : EXERCICES 3 & 4 : DEMI-DROITES ]0 ; +inf[ ET ]-inf ; 4[ (352.32s -> 440.0s)
    # =========================================================================

    text id 65 start 352.5s for 1.6s at (4.0, 7.5) ''[color=#38BDF8][bold]6. EXERCICES 3 & 4 : LES DEMI-DROITES INFINIES[/bold][/color]'' ;
    draw line id 542 start 354.3s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 66 start 355.5s for 1.8s at (6.0, 22.0) ''[color=#34D399][bold]Exemple 3 :[/bold][/color] $\mathbf{x \in \,]0 \,;\, +\infty[}$'' ;
    draw arrow id 543 start 359.5s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96, 28), (172, 28)] ;

    draw line id 544 start 363.0s color (248, 250, 252, 0.6) width 1.5 at [(114, 25), (114, 31)] ;
    text id 67 start 364.5s at (112.5, 36.0) ''[color=#F87171][bold]$0$[/bold][/color]'' ;

    draw path id 545 start 367.0s for 0.8s color (248, 113, 113, 1) width 2.5 at [(111, 23), (114, 23), (114, 33), (111, 33)] ;
    draw line id 546 start 376.5s for 1.2s color (52, 211, 153, 0.95) width 4.5 at [(114, 28), (172, 28)] ;
    text id 68 start 380.5s for 1.0s at (162.0, 36.0) ''[color=#FBBF24][bold]$+\infty$[/bold][/color]'' ;

    text id 69 start 388.0s for 2.0s at (6.0, 33.0) ''[color=#F8FAFC]$0$ exclu $\implies$ réels strictement positifs :[/color]'' ;
    text id 70 start 391.5s for 1.6s at (20.0, 42.0) ''[color=#34D399][bold]$$\mathbf{x > 0}$$[/bold][/color]'' ;

    draw line id 547 start 393.5s for 0.6s color (148, 163, 184, 0.4) width 1.0 at [(6, 51), (170, 51)] ;

    text id 71 start 395.0s for 2.0s at (6.0, 57.0) ''[color=#FBBF24][bold]Exemple 4 :[/bold][/color] [color=#F8FAFC]Demi-droite à gauche de $4$ ($4$ exclu) :[/color]'' ;
    draw arrow id 548 start 398.0s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96, 68), (172, 68)] ;

    draw line id 549 start 401.0s color (248, 250, 252, 0.6) width 1.5 at [(148, 65), (148, 71)] ;
    text id 72 start 402.0s at (146.5, 76.0) ''[color=#F87171][bold]$4$[/bold][/color]'' ;

    draw line id 550 start 403.5s for 1.2s color (56, 189, 248, 0.95) width 4.5 at [(96, 68), (148, 68)] ;
    draw path id 551 start 407.0s for 0.8s color (248, 113, 113, 1) width 2.5 at [(151, 63), (148, 63), (148, 73), (151, 73)] ;
    text id 73 start 412.0s for 1.0s at (96.0, 76.0) ''[color=#FBBF24][bold]$-\infty$[/bold][/color]'' ;

    text id 74 start 416.0s for 2.2s at (6.0, 68.0) ''[color=#F8FAFC]De $-\infty$ (ouvert) jusqu'à $4$ (exclu) :[/color]'' ;
    text id 75 start 429.5s for 2.2s at (6.0, 79.0) ''[color=#38BDF8][bold]$$\mathbf{x \in \,]-\infty \,;\, 4[}$$[/bold][/color]'' ;
    text id 76 start 437.5s for 1.8s at (46.0, 79.0) ''[color=#FBBF24][bold]$$\mathbf{\iff x < 4}$$[/bold][/color]'' ;

    erase id 2007 start 440.0s ;

    # =========================================================================
    # SCÈNE 7 : SYNTHÈSE & RÉFLEXES POUR L'EXAMEN (440.24s -> 493.82s)
    # =========================================================================

    text id 77 start 440.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]7. FICHE DE SYNTHÈSE : TABLEAU RÉCAPITULATIF & RÉFLEXES CONTRÔLE[/bold][/color]'' ;
    draw line id 552 start 442.2s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 553 start 444.0s for 0.8s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.12) width 1.5 at [(5, 18), (95, 18), (95, 68), (5, 68)] ;
    draw line id 554 start 445.2s color (56, 189, 248, 0.6) width 1.2 at [(5, 28), (95, 28)] ;
    draw line id 555 start 445.5s color (56, 189, 248, 0.6) width 1.2 at [(38, 18), (38, 68)] ;
    draw line id 556 start 445.8s color (56, 189, 248, 0.6) width 1.2 at [(68, 18), (68, 68)] ;

    draw line id 557 start 446.1s color (148, 163, 184, 0.4) width 1.0 at [(5, 38), (95, 38)] ;
    draw line id 558 start 446.4s color (148, 163, 184, 0.4) width 1.0 at [(5, 48), (95, 48)] ;
    draw line id 559 start 446.7s color (148, 163, 184, 0.4) width 1.0 at [(5, 58), (95, 58)] ;

    text id 78 start 447.0s at (8.0, 22.0) ''[color=#38BDF8][bold]Inégalité[/bold][/color]'' ;
    text id 79 start 447.4s at (42.0, 22.0) ''[color=#34D399][bold]Intervalle[/bold][/color]'' ;
    text id 80 start 447.8s at (72.0, 22.0) ''[color=#FBBF24][bold]Crochets[/bold][/color]'' ;

    text id 81 start 448.5s at (8.0, 32.0) ''$a \leqslant x \leqslant b$'' ;
    text id 82 start 449.0s at (42.0, 32.0) ''$[a \,;\, b]$'' ;
    text id 83 start 449.5s at (72.0, 32.0) ''[color=#34D399]2 intérieurs[/color]'' ;

    text id 84 start 450.5s at (8.0, 42.0) ''$a < x < b$'' ;
    text id 85 start 451.0s at (42.0, 42.0) ''$]a \,;\, b[$'' ;
    text id 86 start 451.5s at (72.0, 42.0) ''[color=#F87171]2 extérieurs[/color]'' ;

    text id 87 start 452.5s at (8.0, 52.0) ''$x \geqslant a$'' ;
    text id 88 start 453.0s at (42.0, 52.0) ''$[a \,;\, +\infty[$'' ;
    text id 89 start 453.5s at (72.0, 52.0) ''[color=#34D399]int.[/color] puis [color=#F87171]ext.[/color]'' ;

    text id 90 start 454.5s at (8.0, 62.0) ''$x < b$'' ;
    text id 91 start 455.0s at (42.0, 62.0) ''$]-\infty \,;\, b[$'' ;
    text id 92 start 455.5s at (72.0, 62.0) ''[color=#F87171]2 extérieurs[/color]'' ;

    draw polygone id 560 start 456.0s for 0.8s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.15) width 1.5 at [(102, 18), (172, 18), (172, 34), (102, 34)] ;
    text id 93 start 457.0s for 1.8s at (105.0, 22.0) ''[color=#F87171][bold]1. Inégalité stricte « < , > »[/bold][/color]'' ;
    text id 94 start 460.0s for 2.0s at (105.0, 28.5) ''$\implies$ Borne [bold]exclue[/bold] $\implies$ Crochet [bold]extérieur[/bold]'' ;

    draw polygone id 561 start 464.4s for 0.8s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 1.5 at [(102, 37), (172, 37), (172, 53), (102, 53)] ;
    text id 95 start 465.5s for 1.8s at (105.0, 41.0) ''[color=#34D399][bold]2. Inégalité large « $\leqslant$ , $\geqslant$ »[/bold][/color]'' ;
    text id 96 start 469.0s for 2.0s at (105.0, 47.5) ''$\implies$ Borne [bold]incluse[/bold] $\implies$ Crochet [bold]intérieur[/bold]'' ;

    draw polygone id 562 start 475.0s for 0.8s color (251, 191, 36, 0.9) fillcolor (251, 191, 36, 0.15) width 1.5 at [(102, 56), (172, 56), (172, 72), (102, 72)] ;
    text id 97 start 476.0s for 1.8s at (105.0, 60.0) ''[color=#FBBF24][bold]3. Symbole infini $-\infty$ ou $+\infty$[/bold][/color]'' ;
    text id 98 start 479.0s for 2.2s at (105.0, 66.5) ''$\implies$ [bold]TOUJOURS crochet extérieur[/bold] $]...[$'' ;

    text id 99 start 484.0s for 2.5s at (8.0, 84.0) ''[color=#38BDF8][bold]Tu as toutes les clés pour réussir brillamment tes devoirs sur les intervalles ![/bold][/color]'' ;
}
