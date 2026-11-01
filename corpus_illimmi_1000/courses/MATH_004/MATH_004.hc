course "Correction d'exercice classique : Intervalles et encadrements de réels (Entraînement Lycée)" id 1 idgap 500 for 541.28s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : 0.0s -> 113.0s (Accolades vs Crochets)
    # =========================================================================
    text id 1 start 0.5s for 4.2s at (4.0, 7.0) ''[bold][color=#38BDF8]1. Distinction Fondamentale : Accolades vs Crochets[/color][/bold]'' ;
    draw line id 501 start 0.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 2 start 2.0s for 4.3s at (5.0, 18.0) ''[color=#F8FAFC]Objectif : Maîtriser les intervalles et encadrements[/color]'' ;
    text id 3 start 18.5s for 4.3s at (5.0, 27.0) ''[bold][color=#FBBF24]Question clé :[/color][/bold]  [color=#F8FAFC]Différence entre[/color]  [color=#F87171]$\{1 ; 5\}$[/color]  [color=#F8FAFC]et[/color]  [color=#38BDF8]$[1 ; 5]$[/color]  ?'' ;

    text id 4 start 32.0s for 3.8s at (5.0, 38.0) ''[bold][color=#F87171]1. Notation entre accolades $\{1 ; 5\}$ :[/color][/bold]'' ;
    text id 5 start 36.8s for 3.8s at (7.0, 46.0) ''[color=#F8FAFC]Désigne uniquement deux nombres isolés : [/color][bold][color=#F87171]$1$[/color][/bold][color=#F8FAFC] et [/color][bold][color=#F87171]$5$[/color][/bold]'' ;
    text id 6 start 48.3s for 3.5s at (7.0, 54.0) ''[color=#F8FAFC]Exemple : Solutions d'une équation  [/color][color=#F87171]$S = \{1 ; 5\}$[/color]'' ;

    text id 7 start 58.2s for 2.8s at (5.0, 65.0) ''[bold][color=#38BDF8]2. Notation entre crochets $[1 ; 5]$ :[/color][/bold]'' ;
    text id 8 start 64.0s for 5.4s at (7.0, 73.0) ''[color=#F8FAFC]Désigne [/color][bold][color=#38BDF8]tous les réels[/color][/bold][color=#F8FAFC] compris entre $1$ et $5$ : infinité continue ![/color]'' ;
    text id 9 start 73.0s for 4.9s at (7.0, 81.0) ''[color=#F8FAFC]Exemples :  $2{,}46$  ;  $3{,}14$  ;  $\sqrt{2}+2$  ;  $4{,}999$...[/color]'' ;
    text id 10 start 82.0s for 4.9s at (7.0, 89.0) ''[bold][color=#34D399]Un intervalle est une portion continue de la droite réelle.[/color][/bold]'' ;

    # Volet graphique comparatif à droite
    draw polygone id 502 start 22.0s for 0.5s color (56, 189, 248, 0.5) width 1.5 fillcolor (56, 189, 248, 0.06) at [(94, 17), (174, 17), (174, 91), (94, 91)] ;
    text id 11 start 24.0s for 3.8s at (96.0, 21.0) ''[bold][color=#F8FAFC]Comparaison Visuelle sur la Droite Réelle[/color][/bold]'' ;

    # Panneau Accolades (haut droite)
    text id 12 start 34.0s for 2.8s at (96.0, 29.0) ''[bold][color=#F87171]Ensemble discret :  $\{1 ; 5\}$[/color][/bold]'' ;
    draw arrow id 503 start 35.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 42), (170, 42)] ;
    draw line id 504 start 36.0s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(110, 39), (110, 45)] ;
    text id 13 start 36.5s at (109.0, 47.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw circle id 505 start 38.0s for 0.4s color (248, 113, 113, 1.0) width 2.0 fillcolor (248, 113, 113, 1.0) radius 1.6 at (124, 42) ;
    text id 14 start 38.5s at (123.0, 47.0) ''[bold][color=#F87171]$1$[/color][/bold]'' ;
    draw circle id 506 start 40.0s for 0.4s color (248, 113, 113, 1.0) width 2.0 fillcolor (248, 113, 113, 1.0) radius 1.6 at (156, 42) ;
    text id 15 start 40.5s at (155.0, 47.0) ''[bold][color=#F87171]$5$[/color][/bold]'' ;
    text id 16 start 43.0s for 2.8s at (96.0, 52.0) ''[italic][color=#F87171]Seulement 2 points isolés ![/color][/italic]'' ;

    # Panneau Crochets (bas droite)
    text id 17 start 60.0s for 2.8s at (96.0, 62.0) ''[bold][color=#38BDF8]Intervalle continu :  $[1 ; 5]$[/color][/bold]'' ;
    draw arrow id 507 start 61.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 73), (170, 73)] ;
    draw line id 508 start 62.0s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(110, 70), (110, 76)] ;
    text id 18 start 62.5s at (109.0, 77.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw line id 509 start 64.0s for 0.6s color (56, 189, 248, 1.0) width 5.0 at [(124, 73), (156, 73)] ;
    draw path id 510 start 65.0s for 0.4s color (56, 189, 248, 1.0) width 2.5 at [(127, 68), (124, 68), (124, 78), (127, 78)] ;
    text id 19 start 65.5s at (123.0, 80.0) ''[bold][color=#38BDF8]$1$[/color][/bold]'' ;
    draw path id 511 start 67.0s for 0.4s color (56, 189, 248, 1.0) width 2.5 at [(153, 68), (156, 68), (156, 78), (153, 78)] ;
    text id 20 start 67.5s at (155.0, 80.0) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 21 start 75.0s for 3.8s at (96.0, 86.0) ''[italic][color=#34D399]Infinité de points réels reliés ![/color][/italic]'' ;

    erase id 2001 start 113.0s ;

    # =========================================================================
    # SCÈNE 2 : 113.1s -> 255.4s (Demi-droites vers +infini : x >= 2 et x > -4)
    # =========================================================================
    text id 22 start 113.5s for 4.4s at (4.0, 7.0) ''[bold][color=#38BDF8]2. Demi-droites vers $+\infty$ : Inégalités Supérieures[/color][/bold]'' ;
    draw line id 512 start 113.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    # Cas 1 : x >= 2
    text id 23 start 115.6s for 3.8s at (5.0, 18.0) ''[bold][color=#FBBF24]Premier Cas :[/color][/bold]  [color=#38BDF8]$x \ge 2$[/color]  [color=#F8FAFC](supérieur ou égal à 2)[/color]'' ;
    text id 24 start 120.0s for 4.6s at (5.0, 26.5) ''[color=#F8FAFC]On part de $2$ et on prend tous les réels vers la droite.[/color]'' ;
    text id 25 start 155.0s for 4.3s at (5.0, 35.0) ''[color=#F8FAFC]Statut de la borne : [/color][bold][color=#34D399]$2$ est inclus[/color][/bold][color=#F8FAFC] car $\ge$ (ou égal).[/color]'' ;
    text id 26 start 167.0s for 3.8s at (5.0, 43.5) ''[bold][color=#34D399]Règle :[/color][/bold]  [color=#F8FAFC]Le crochet regarde la zone solution.[/color]'' ;
    text id 27 start 188.0s for 3.8s at (5.0, 52.0) ''[color=#F8FAFC]Borne en $+\infty$ : L'infini est toujours [/color][bold][color=#F87171]ouvert (exclu)[/color][/bold][color=#F8FAFC].[/color]'' ;
    text id 28 start 201.0s for 3.8s at (5.0, 60.5) ''[bold][color=#38BDF8]Conclusion Cas 1 :[/color][/bold]  [bold][color=#38BDF8]$\mathbf{x \in [2 ; +\infty[}$[/color][/bold]'' ;
    draw polygone id 513 start 202.0s for 0.4s color (56, 189, 248, 0.8) width 1.6 fillcolor (56, 189, 248, 0.1) at [(4, 57), (78, 57), (78, 67), (4, 67)] ;

    # Cas 2 : x > -4
    text id 29 start 208.5s for 4.3s at (5.0, 71.0) ''[bold][color=#FBBF24]Deuxième Cas :[/color][/bold]  [color=#34D399]$x > -4$[/color]  [color=#F8FAFC](strictement supérieur à -4)[/color]'' ;
    text id 30 start 228.0s for 4.5s at (5.0, 78.5) ''[color=#F8FAFC]Statut de la borne : [/color][bold][color=#F87171]$-4$ est exclu[/color][/bold][color=#F8FAFC] (inégalité stricte).[/color]'' ;
    text id 31 start 236.0s for 3.8s at (5.0, 85.5) ''[bold][color=#F87171]Règle :[/color][/bold]  [color=#F8FAFC]Le crochet tourne le dos aux solutions.[/color]'' ;
    text id 32 start 249.0s for 4.2s at (5.0, 92.0) ''[bold][color=#34D399]Conclusion Cas 2 :[/color][/bold]  [bold][color=#34D399]$\mathbf{x \in ]{-}4 ; +\infty[}$[/color][/bold]'' ;

    # Volet graphique à droite pour Scène 2
    draw polygone id 514 start 132.0s for 0.5s color (251, 191, 36, 0.5) width 1.5 fillcolor (251, 191, 36, 0.05) at [(94, 17), (174, 17), (174, 91), (94, 91)] ;
    text id 33 start 133.0s for 3.8s at (96.0, 21.0) ''[bold][color=#F8FAFC]Axes Gradués des Inégalités Supérieures[/color][/bold]'' ;

    # Graphique Axe 1 : x >= 2
    text id 34 start 134.5s for 2.8s at (96.0, 28.0) ''[color=#38BDF8]$x \ge 2$  $\implies$  $2$ inclus[/color]'' ;
    draw arrow id 515 start 135.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 42), (170, 42)] ;
    text id 35 start 136.0s for 1.8s at (164.0, 37.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    draw line id 516 start 138.5s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(108, 39), (108, 45)] ;
    text id 36 start 139.0s at (107.0, 48.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw line id 517 start 143.0s for 0.6s color (56, 189, 248, 1.0) width 4.5 at [(124, 42), (166, 42)] ;
    draw path id 518 start 164.5s for 0.4s color (56, 189, 248, 1.0) width 2.8 at [(127, 37), (124, 37), (124, 47), (127, 47)] ;
    text id 37 start 165.0s at (123.0, 50.0) ''[bold][color=#38BDF8]$2$[/color][/bold]'' ;
    text id 38 start 169.0s for 1.8s at (136.0, 28.0) ''[italic][color=#38BDF8]fermé $[$[/color][/italic]'' ;

    # Graphique Axe 2 : x > -4
    text id 39 start 220.0s for 2.8s at (96.0, 60.0) ''[color=#34D399]$x > -4$  $\implies$  $-4$ exclu[/color]'' ;
    draw arrow id 519 start 221.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 73), (170, 73)] ;
    text id 40 start 221.5s for 1.8s at (164.0, 68.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    draw line id 520 start 222.0s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(136, 70), (136, 76)] ;
    text id 41 start 222.5s at (135.0, 78.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw line id 521 start 223.0s for 0.6s color (52, 211, 153, 1.0) width 4.5 at [(110, 73), (166, 73)] ;
    draw path id 522 start 236.0s for 0.4s color (248, 113, 113, 1.0) width 2.8 at [(107, 68), (110, 68), (110, 78), (107, 78)] ;
    text id 42 start 237.0s at (108.0, 81.0) ''[bold][color=#F87171]$-4$[/color][/bold]'' ;
    text id 43 start 240.0s for 1.8s at (136.0, 60.0) ''[italic][color=#F87171]ouvert $]$[/color][/italic]'' ;

    erase id 2002 start 255.4s ;

    # =========================================================================
    # SCÈNE 3 : 255.5s -> 382.1s (Demi-droites vers -infini : x <= 0 et x < 7)
    # =========================================================================
    text id 44 start 256.0s for 4.4s at (4.0, 7.0) ''[bold][color=#38BDF8]3. Demi-droites vers $-\infty$ : Inégalités Inférieures[/color][/bold]'' ;
    draw line id 523 start 256.3s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    # Cas 3 : x <= 0
    text id 45 start 259.0s for 3.8s at (5.0, 18.0) ''[bold][color=#FBBF24]Troisième Cas :[/color][/bold]  [color=#38BDF8]$x \le 0$[/color]  [color=#F8FAFC](inférieur ou égal à 0)[/color]'' ;
    text id 46 start 277.0s for 4.7s at (5.0, 26.5) ''[color=#F8FAFC]« Inférieur » signifie plus petit : situé à [/color][bold][color=#38BDF8]gauche de 0[/color][/bold][color=#F8FAFC].[/color]'' ;
    text id 47 start 285.5s for 4.2s at (5.0, 35.0) ''[color=#F8FAFC]Statut de 0 : [/color][bold][color=#34D399]$0$ est inclus[/color][/bold][color=#F8FAFC] car $\le$ (crochet fermé).[/color]'' ;
    text id 48 start 298.0s for 1.4s at (5.0, 43.5) ''[bold][color=#FBBF24]RÈGLE D'OR ABSOLUE :[/color][/bold]'' ;
    text id 49 start 301.0s for 4.1s at (7.0, 50.0) ''[color=#F8FAFC]Toujours écrire dans [/color][bold][color=#34D399]l'ordre croissant[/color][/bold][color=#F8FAFC] de gauche à droite ![/color]'' ;
    text id 50 start 308.0s for 3.3s at (7.0, 58.0) ''[color=#F87171]NE JAMAIS ÉCRIRE $[0 ; -\infty[$ ![/color]  [color=#34D399]De $-\infty$ jusqu'à $0$[/color]'' ;
    text id 51 start 324.0s for 3.8s at (5.0, 68.0) ''[bold][color=#38BDF8]Conclusion Cas 3 :[/color][/bold]  [bold][color=#38BDF8]$\mathbf{x \in ]{-}\infty ; 0]}$[/color][/bold]'' ;
    draw polygone id 524 start 325.0s for 0.4s color (56, 189, 248, 0.8) width 1.6 fillcolor (56, 189, 248, 0.1) at [(4, 64), (78, 64), (78, 74), (4, 74)] ;

    # Cas 4 : x < 7
    text id 52 start 331.0s for 4.2s at (5.0, 78.0) ''[bold][color=#FBBF24]Quatrième Cas :[/color][/bold]  [color=#34D399]$x < 7$[/color]  [color=#F8FAFC](strictement inférieur à 7)[/color]'' ;
    text id 53 start 352.0s for 3.8s at (5.0, 85.5) ''[color=#F8FAFC]Statut de 7 : [/color][bold][color=#F87171]$7$ est exclu[/color][/bold][color=#F8FAFC] car $<$ (crochet ouvert).[/color]'' ;
    text id 54 start 363.0s for 3.8s at (5.0, 92.5) ''[bold][color=#34D399]Conclusion Cas 4 :[/color][/bold]  [bold][color=#34D399]$\mathbf{x \in ]{-}\infty ; 7[}$[/color][/bold]'' ;

    # Volet graphique à droite pour Scène 3
    draw polygone id 525 start 261.0s for 0.5s color (52, 211, 153, 0.5) width 1.5 fillcolor (52, 211, 153, 0.05) at [(94, 17), (174, 17), (174, 91), (94, 91)] ;
    text id 55 start 262.0s for 3.8s at (96.0, 21.0) ''[bold][color=#F8FAFC]Axes Gradués des Inégalités Inférieures[/color][/bold]'' ;

    # Graphique Axe 1 : x <= 0
    text id 56 start 263.0s for 2.8s at (96.0, 28.0) ''[color=#38BDF8]$x \le 0$  $\implies$  $0$ inclus[/color]'' ;
    draw arrow id 526 start 264.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 42), (170, 42)] ;
    text id 57 start 266.0s for 1.8s at (96.0, 48.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 58 start 266.5s for 1.8s at (164.0, 48.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    draw line id 527 start 281.0s for 0.6s color (56, 189, 248, 1.0) width 4.5 at [(98, 42), (142, 42)] ;
    draw path id 528 start 289.0s for 0.4s color (56, 189, 248, 1.0) width 2.8 at [(139, 37), (142, 37), (142, 47), (139, 47)] ;
    text id 59 start 290.0s at (141.0, 50.0) ''[bold][color=#38BDF8]$0$[/color][/bold]'' ;
    text id 60 start 293.0s for 1.8s at (136.0, 28.0) ''[italic][color=#38BDF8]fermé $]$[/color][/italic]'' ;

    # Graphique Axe 2 : x < 7
    text id 61 start 334.0s for 2.8s at (96.0, 60.0) ''[color=#34D399]$x < 7$  $\implies$  $7$ exclu[/color]'' ;
    draw arrow id 529 start 335.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 73), (170, 73)] ;
    text id 62 start 336.0s for 1.8s at (96.0, 78.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 63 start 336.5s for 1.8s at (164.0, 78.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    draw line id 530 start 337.0s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(114, 70), (114, 76)] ;
    text id 64 start 337.5s at (113.0, 78.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw line id 531 start 341.0s for 0.6s color (52, 211, 153, 1.0) width 4.5 at [(98, 73), (152, 73)] ;
    draw path id 532 start 356.5s for 0.4s color (248, 113, 113, 1.0) width 2.8 at [(155, 68), (152, 68), (152, 78), (155, 78)] ;
    text id 65 start 357.5s at (151.0, 81.0) ''[bold][color=#F87171]$7$[/color][/bold]'' ;
    text id 66 start 360.0s for 1.8s at (136.0, 60.0) ''[italic][color=#F87171]ouvert $[$[/color][/italic]'' ;

    erase id 2003 start 382.1s ;

    # =========================================================================
    # SCÈNE 4 : 382.2s -> 484.6s (Encadrements Bornés entre Deux Réels)
    # =========================================================================
    text id 67 start 382.5s for 4.6s at (4.0, 7.0) ''[bold][color=#38BDF8]4. Encadrements Bornés : Doubles Inégalités sans Infini[/color][/bold]'' ;
    draw line id 533 start 382.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    # Exemple 5 : -1 < x <= 7
    text id 68 start 386.5s for 4.7s at (5.0, 18.0) ''[bold][color=#FBBF24]Cinquième Cas :[/color][/bold]  [color=#38BDF8]$-1 < x \le 7$[/color]  [color=#F8FAFC](x compris entre -1 et 7)[/color]'' ;
    text id 69 start 405.0s for 5.2s at (5.0, 26.5) ''[color=#F8FAFC]x est pris en sandwich entre deux bornes finies : [/color][color=#38BDF8]aucun infini[/color]'' ;
    text id 70 start 420.0s for 4.2s at (5.0, 35.0) ''[color=#F8FAFC]Borne gauche $-1$ : [/color][bold][color=#F87171]strictement $< -1$[/color][/bold][color=#F8FAFC] $\implies$ ouvert.[/color]'' ;
    text id 71 start 430.0s for 3.8s at (5.0, 43.5) ''[color=#F8FAFC]Borne droite $7$ : [/color][bold][color=#34D399]large $\le 7$[/color][/bold][color=#F8FAFC] $\implies$ fermé.[/color]'' ;
    text id 72 start 444.0s for 5.0s at (5.0, 52.0) ''[bold][color=#38BDF8]Conclusion Cas 5 :[/color][/bold]  [bold][color=#38BDF8]$\mathbf{x \in ]{-}1 ; 7]}$[/color][/bold]  [italic][color=#F8FAFC](semi-ouvert)[/color][/italic]'' ;
    draw polygone id 534 start 445.0s for 0.4s color (56, 189, 248, 0.8) width 1.6 fillcolor (56, 189, 248, 0.1) at [(4, 48), (82, 48), (82, 58), (4, 58)] ;

    # Exemple 6 : 0 <= x <= 10
    text id 73 start 451.0s for 4.7s at (5.0, 64.0) ''[bold][color=#FBBF24]Sixième Cas :[/color][/bold]  [color=#34D399]$0 \le x \le 10$[/color]  [color=#F8FAFC](x compris entre 0 et 10)[/color]'' ;
    text id 74 start 468.0s for 4.5s at (5.0, 72.0) ''[color=#F8FAFC]Borne gauche $0$ : [/color][bold][color=#34D399]large $\ge 0$[/color][/bold][color=#F8FAFC] $\implies$ crochet fermé $[$.[/color]'' ;
    text id 75 start 475.0s for 4.7s at (5.0, 80.0) ''[color=#F8FAFC]Borne droite $10$ : [/color][bold][color=#34D399]large $\le 10$[/color][/bold][color=#F8FAFC] $\implies$ crochet fermé $]$.[/color]'' ;
    text id 76 start 481.0s for 3.4s at (5.0, 90.0) ''[bold][color=#34D399]Conclusion Cas 6 :[/color][/bold]  [bold][color=#34D399]$\mathbf{x \in [0 ; 10]}$[/color][/bold]  [italic][color=#F8FAFC](intervalle fermé)[/color][/italic]'' ;

    # Volet graphique à droite pour Scène 4
    draw polygone id 535 start 408.0s for 0.5s color (192, 132, 252, 0.5) width 1.5 fillcolor (192, 132, 252, 0.05) at [(94, 17), (174, 17), (174, 91), (94, 91)] ;
    text id 77 start 409.0s for 3.8s at (96.0, 21.0) ''[bold][color=#F8FAFC]Représentation des Segments Bornés[/color][/bold]'' ;

    # Graphique Encadrement 1 : -1 < x <= 7
    text id 78 start 410.0s for 3.8s at (96.0, 28.0) ''[color=#38BDF8]$-1 < x \le 7$  $\implies$  Segment $]{-}1 ; 7]$[/color]'' ;
    draw arrow id 536 start 411.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 42), (170, 42)] ;
    draw line id 537 start 411.5s for 0.3s color (248, 250, 252, 0.6) width 1.5 at [(120, 39), (120, 45)] ;
    text id 79 start 412.0s at (119.0, 50.0) ''[color=#F8FAFC]$0$[/color]'' ;
    draw line id 538 start 413.0s for 0.6s color (56, 189, 248, 1.0) width 4.5 at [(113, 42), (155, 42)] ;
    draw path id 539 start 425.0s for 0.4s color (248, 113, 113, 1.0) width 2.8 at [(110, 37), (113, 37), (113, 47), (110, 47)] ;
    text id 80 start 426.0s at (110.0, 50.0) ''[bold][color=#F87171]$-1$[/color][/bold]'' ;
    draw path id 540 start 435.0s for 0.4s color (52, 211, 153, 1.0) width 2.8 at [(152, 37), (155, 37), (155, 47), (152, 47)] ;
    text id 81 start 436.0s at (154.0, 50.0) ''[bold][color=#34D399]$7$[/color][/bold]'' ;

    # Graphique Encadrement 2 : 0 <= x <= 10
    text id 82 start 454.0s for 3.8s at (96.0, 60.0) ''[color=#34D399]$0 \le x \le 10$  $\implies$  Segment $[0 ; 10]$[/color]'' ;
    draw arrow id 541 start 455.0s for 0.5s color (248, 250, 252, 0.8) width 1.8 at [(96, 73), (170, 73)] ;
    draw line id 542 start 458.0s for 0.6s color (52, 211, 153, 1.0) width 4.5 at [(114, 73), (162, 73)] ;
    draw path id 543 start 468.5s for 0.4s color (52, 211, 153, 1.0) width 2.8 at [(117, 68), (114, 68), (114, 78), (117, 78)] ;
    text id 83 start 469.5s at (113.0, 81.0) ''[bold][color=#34D399]$0$[/color][/bold]'' ;
    draw path id 544 start 475.5s for 0.4s color (52, 211, 153, 1.0) width 2.8 at [(159, 68), (162, 68), (162, 78), (159, 78)] ;
    text id 84 start 476.5s at (160.0, 81.0) ''[bold][color=#34D399]$10$[/color][/bold]'' ;

    erase id 2004 start 484.6s ;

    # =========================================================================
    # SCÈNE 5 : 484.7s -> 521.1s (Les 3 Erreurs Fréquentes d'Examen)
    # =========================================================================
    text id 85 start 485.0s for 2.2s at (4.0, 7.0) ''[bold][color=#F87171]5. Les Trois Pièges d'Examen à Absolument Bannir[/color][/bold]'' ;
    draw line id 545 start 485.3s for 0.4s color (248, 113, 113, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    # Piège 1 : crochet fermé sur infini
    draw polygone id 546 start 487.0s for 0.4s color (248, 113, 113, 0.6) width 1.4 fillcolor (248, 113, 113, 0.06) at [(5, 17), (173, 17), (173, 38), (5, 38)] ;
    text id 86 start 488.0s for 3.8s at (8.0, 19.5) ''[bold][color=#F87171]Piège 1 : Fermer un crochet sur un symbole infini[/color][/bold]'' ;
    text id 87 start 491.0s for 4.6s at (10.0, 26.0) ''[bold][color=#F87171]FAUX :[/color][/bold]  $[2 ; +\infty]$  ou  $[-\infty ; 0]$  [italic][color=#F8FAFC](l'infini n'est pas un nombre réel)[/color][/italic]'' ;
    text id 88 start 496.0s for 4.3s at (10.0, 32.5) ''[bold][color=#34D399]CORRECT :[/color][/bold]  $[2 ; +\infty[$  et  $]{-}\infty ; 0]$  [italic][color=#F8FAFC](l'infini est TOUJOURS ouvert)[/color][/italic]'' ;

    # Piège 2 : ordre décroissant
    draw polygone id 547 start 499.0s for 0.4s color (251, 191, 36, 0.6) width 1.4 fillcolor (251, 191, 36, 0.06) at [(5, 41), (173, 41), (173, 62), (5, 62)] ;
    text id 89 start 500.5s for 3.8s at (8.0, 43.5) ''[bold][color=#FBBF24]Piège 2 : Inverser le sens croissant des bornes[/color][/bold]'' ;
    text id 90 start 503.0s for 3.8s at (10.0, 50.0) ''[bold][color=#F87171]FAUX :[/color][/bold]  $[7 ; -1]$  ou  $[0 ; -\infty[$  [italic][color=#F8FAFC](sens décroissant interdit !)[/color][/italic]'' ;
    text id 91 start 508.0s for 5.5s at (10.0, 56.5) ''[bold][color=#34D399]CORRECT :[/color][/bold]  $]{-}1 ; 7]$  et  $]{-}\infty ; 0]$  [italic][color=#F8FAFC](ordre croissant obligatoire)[/color][/italic]'' ;

    # Piège 3 : confusion accolades crochets
    draw polygone id 548 start 510.5s for 0.4s color (56, 189, 248, 0.6) width 1.4 fillcolor (56, 189, 248, 0.06) at [(5, 65), (173, 65), (173, 86), (5, 86)] ;
    text id 92 start 511.5s for 4.8s at (8.0, 67.5) ''[bold][color=#38BDF8]Piège 3 : Confondre les accolades $\{\}$ et les crochets $[ ]$[/color][/bold]'' ;
    text id 93 start 515.0s for 5.4s at (10.0, 74.0) ''[bold][color=#F87171]Accolades $\{1 ; 5\}$ :[/color][/bold]  [color=#F8FAFC]seulement deux solutions discrètes isolées[/color]'' ;
    text id 94 start 519.0s for 1.9s at (10.0, 80.5) ''[bold][color=#34D399]Crochets $[1 ; 5]$ :[/color][/bold]  [color=#F8FAFC]infinité continue de réels entre deux bornes[/color]'' ;

    erase id 2005 start 521.1s ;

    # =========================================================================
    # SCÈNE 6 : 521.2s -> 541.28s (Synthèse Réflexe & Tableau Méthodologique)
    # =========================================================================
    text id 95 start 521.5s for 4.4s at (4.0, 7.0) ''[bold][color=#38BDF8]6. Synthèse Réflexe : Méthode Infaillible en 3 Étapes[/color][/bold]'' ;
    draw line id 549 start 521.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    # Colonne gauche : La règle en 3 étapes
    draw polygone id 550 start 523.0s for 0.5s color (56, 189, 248, 0.5) width 1.5 fillcolor (56, 189, 248, 0.06) at [(4, 17), (92, 17), (92, 91), (4, 91)] ;
    text id 96 start 524.0s for 1.8s at (6.0, 21.0) ''[bold][color=#FBBF24]L'Algorithme Mental au Brouillon[/color][/bold]'' ;

    text id 97 start 528.0s for 1.9s at (6.0, 30.0) ''[bold][color=#38BDF8]Étape 1 : Tracer l'axe réel[/color][/bold]'' ;
    text id 98 start 531.0s for 3.8s at (8.0, 37.0) ''[color=#F8FAFC]Placer $-\infty$ à gauche et $+\infty$ à droite.[/color]'' ;

    text id 99 start 536.0s for 3.8s at (6.0, 46.0) ''[bold][color=#38BDF8]Étape 2 : Colorier la zone solution[/color][/bold]'' ;
    text id 100 start 538.0s for 3.0s at (8.0, 53.0) ''[color=#F8FAFC]Repérer les bornes et surligner la région.[/color]'' ;

    text id 101 start 541.0s at (6.0, 62.0) ''[bold][color=#38BDF8]Étape 3 : Orienter chaque crochet[/color][/bold]'' ;
    text id 102 start 544.0s at (8.0, 69.0) ''[color=#34D399]• Borne incluse $(\le, \ge)$ :[/color]  [color=#F8FAFC]regarde la zone[/color]'' ;
    text id 103 start 548.0s at (8.0, 76.0) ''[color=#F87171]• Borne exclue $(<, >)$ :[/color]  [color=#F8FAFC]tourne le dos[/color]'' ;
    text id 104 start 551.0s at (8.0, 83.0) ''[color=#FBBF24]• Infini $\pm\infty$ :[/color]  [color=#F8FAFC]toujours ouvert (tourne le dos)[/color]'' ;

    # Colonne droite : Tableau Méthodologique Récapitulatif
    draw polygone id 551 start 525.0s for 0.5s color (52, 211, 153, 0.5) width 1.5 fillcolor (52, 211, 153, 0.06) at [(96, 17), (174, 17), (174, 91), (96, 91)] ;
    text id 105 start 526.0s for 0.8s at (98.0, 21.0) ''[bold][color=#34D399]Tableau Récapitulatif d'Examen[/color][/bold]'' ;

    # Entête de tableau
    text id 106 start 527.0s for 1.8s at (98.0, 29.0) ''[bold][color=#FBBF24]Inégalité[/color][/bold]'' ;
    text id 107 start 527.0s for 1.8s at (124.0, 29.0) ''[bold][color=#FBBF24]Allure Axe[/color][/bold]'' ;
    text id 108 start 527.0s for 1.8s at (150.0, 29.0) ''[bold][color=#FBBF24]Intervalle[/color][/bold]'' ;
    draw line id 552 start 527.5s for 0.3s color (248, 250, 252, 0.5) width 1.2 at [(98, 35), (172, 35)] ;

    # Lignes du tableau
    text id 109 start 555.0s at (98.0, 39.0) ''[color=#F8FAFC]$x \ge 2$[/color]'' ;
    text id 110 start 555.2s at (124.0, 39.0) ''[color=#38BDF8]$\mathbf{[} \longrightarrow +\infty$[/color]'' ;
    text id 111 start 555.4s at (150.0, 39.0) ''[bold][color=#38BDF8]$[2 ; +\infty[$[/color][/bold]'' ;

    text id 112 start 556.0s at (98.0, 48.0) ''[color=#F8FAFC]$x > -4$[/color]'' ;
    text id 113 start 556.2s at (124.0, 48.0) ''[color=#34D399]$\mathbf{]} \longrightarrow +\infty$[/color]'' ;
    text id 114 start 556.4s at (150.0, 48.0) ''[bold][color=#34D399]$]{-}4 ; +\infty[$[/color][/bold]'' ;

    text id 115 start 557.0s at (98.0, 57.0) ''[color=#F8FAFC]$x \le 0$[/color]'' ;
    text id 116 start 557.2s at (124.0, 57.0) ''[color=#38BDF8]$-\infty \longleftarrow \mathbf{]}$[/color]'' ;
    text id 117 start 557.4s at (150.0, 57.0) ''[bold][color=#38BDF8]$]{-}\infty ; 0]$[/color][/bold]'' ;

    text id 118 start 558.0s at (98.0, 66.0) ''[color=#F8FAFC]$x < 7$[/color]'' ;
    text id 119 start 558.2s at (124.0, 66.0) ''[color=#34D399]$-\infty \longleftarrow \mathbf{[}$[/color]'' ;
    text id 120 start 558.4s at (150.0, 66.0) ''[bold][color=#34D399]$]{-}\infty ; 7[$[/color][/bold]'' ;

    text id 121 start 559.0s at (98.0, 75.0) ''[color=#F8FAFC]$-1 < x \le 7$[/color]'' ;
    text id 122 start 559.2s at (124.0, 75.0) ''[color=#C084FC]$\mathbf{]} \longleftrightarrow \mathbf{]}$[/color]'' ;
    text id 123 start 559.4s at (150.0, 75.0) ''[bold][color=#C084FC]$]{-}1 ; 7]$[/color][/bold]'' ;

    text id 124 start 560.0s at (98.0, 84.0) ''[color=#F8FAFC]$0 \le x \le 10$[/color]'' ;
    text id 125 start 560.2s at (124.0, 84.0) ''[color=#FBBF24]$\mathbf{[} \longleftrightarrow \mathbf{]}$[/color]'' ;
    text id 126 start 560.4s at (150.0, 84.0) ''[bold][color=#FBBF24]$[0 ; 10]$[/color][/bold]'' ;
}
