course "Correction d'exercice classique : Valeur absolue et distance sur la droite réelle (Entraînement Lycée)" id 20 idgap 500 for 681.96s audio "narration.wav" {

    # =========================================================================
    # SCENE 1: Introduction & Méthode générale en trois étapes (0.0s -> 96.5s)
    # =========================================================================

    # En-tête de scène
    text id 1 start 0.500s at (4.0, 7.5) ''[color=#38BDF8][bold]1. Introduction : Valeur absolue & Distance sur la droite réelle[/bold][/color]'' ;
    draw line id 501 start 0.600s for 1.200s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Contexte & Définition fondamentale
    text id 2 start 3.500s for 2.800s at (4.0, 19.0) ''[color=#F8FAFC]Exercice classique : Transformer un intervalle en inéquation.[/color]'' ;
    text id 3 start 23.500s at (4.0, 27.0) ''[color=#FBBF24][bold]Interprétation géométrique fondamentale :[/bold][/color]'' ;
    text id 4 start 25.000s for 3.200s at (4.0, 34.0) ''[color=#38BDF8]$\mathbf{|x - c|}$[/color] [color=#F8FAFC]mesure la distance entre le nombre [/color][color=#34D399]$\mathbf{x}$[/color] [color=#F8FAFC]et le centre [/color][color=#FBBF24]$\mathbf{c}$[/color]'' ;

    # Colonne droite : Axe réel gradué & Représentation du segment [a ; b]
    draw arrow id 502 start 31.500s for 1.200s color (248, 250, 252, 0.85) width 1.8 at [(96.0, 48.0), (168.0, 48.0)] ;
    text id 5 start 33.200s at (170.0, 47.0) ''[color=#94A3B8]$\mathbb{R}$[/color]'' ;

    # Bornes a et b
    draw line id 503 start 37.500s color (248, 250, 252, 0.85) width 2.0 at [(106.0, 45.0), (106.0, 51.0)] ;
    text id 6 start 37.800s at (104.5, 54.0) ''[color=#F8FAFC]$\mathbf{a}$[/color]'' ;
    draw line id 504 start 39.000s color (248, 250, 252, 0.85) width 2.0 at [(154.0, 45.0), (154.0, 51.0)] ;
    text id 7 start 39.300s at (152.5, 54.0) ''[color=#F8FAFC]$\mathbf{b}$[/color]'' ;
    draw line id 505 start 41.500s for 1.200s color (52, 211, 153, 0.95) width 4.5 at [(106.0, 48.0), (154.0, 48.0)] ;

    # Colonne gauche : La méthode en 3 étapes
    text id 8 start 48.000s at (4.0, 44.0) ''[color=#34D399][bold]Méthode en 3 étapes pour un intervalle $[a ; b]$ :[/bold][/color]'' ;
    text id 9 start 50.500s for 3.000s at (4.0, 53.0) ''[color=#F8FAFC]Étape 1 : Calculer le milieu [/color][color=#FBBF24]$\mathbf{c = \frac{a + b}{2}}$[/color]'' ;

    # Centre c sur l'axe à droite
    draw line id 506 start 55.500s color (56, 189, 248, 1.0) width 2.5 at [(130.0, 44.0), (130.0, 52.0)] ;
    draw circle id 507 start 55.800s color (56, 189, 248, 1.0) fillcolor (56, 189, 248, 0.9) radius 1.2 at (130.0, 48.0) ;
    text id 10 start 56.200s at (123.0, 54.0) ''[color=#38BDF8]$\mathbf{c}$ (milieu)[/color]'' ;

    # Colonne gauche : Étape 2 (Rayon)
    text id 11 start 62.500s for 3.200s at (4.0, 65.0) ''[color=#F8FAFC]Étape 2 : Calculer le rayon [/color][color=#38BDF8]$\mathbf{r = b - c = \frac{b - a}{2}}$[/color]'' ;

    # Flèches de rayon sur l'axe
    draw arrow id 508 start 67.500s for 1.000s color (56, 189, 248, 0.95) width 1.5 at [(130.0, 39.0), (154.0, 39.0)] ;
    text id 12 start 69.000s at (140.0, 34.0) ''[color=#38BDF8]$\mathbf{r}$[/color]'' ;
    draw arrow id 509 start 70.000s for 1.000s color (56, 189, 248, 0.95) width 1.5 at [(130.0, 39.0), (106.0, 39.0)] ;
    text id 13 start 71.500s at (116.0, 34.0) ''[color=#38BDF8]$\mathbf{r}$[/color]'' ;

    # Colonne gauche : Étape 3 (Inéquation)
    text id 14 start 76.500s for 3.200s at (4.0, 77.0) ''[color=#F8FAFC]Étape 3 : Écrire [/color][color=#34D399]$\mathbf{|x - c| \le r}$[/color] [color=#94A3B8](si intérieur)[/color] [color=#F8FAFC]ou [/color][color=#F87171]$\mathbf{|x - c| \ge r}$[/color] [color=#94A3B8](si extérieur)[/color]'' ;

    # Point x à l'intérieur sur l'axe
    draw circle id 510 start 81.000s color (251, 191, 36, 1.0) fillcolor (251, 191, 36, 0.9) radius 1.4 at (141.0, 48.0) ;
    text id 15 start 81.400s at (140.0, 54.0) ''[color=#FBBF24]$\mathbf{x}$[/color]'' ;
    draw arrow id 511 start 83.000s for 1.000s color (251, 191, 36, 0.95) width 1.5 at [(130.0, 64.0), (141.0, 64.0)] ;
    text id 16 start 84.500s at (122.0, 70.0) ''[color=#FBBF24]Distance au centre $\le r$[/color]'' ;

    # Effacement avant l'exercice 1
    erase id 2001 start 96.500s ;

    # =========================================================================
    # SCENE 2: Exercice 1 : L'intervalle fermé [-5 ; 3] (96.5s -> 287.0s)
    # =========================================================================

    text id 41 start 97.500s at (4.0, 7.5) ''[color=#38BDF8][bold]2. Exercice 1 : Intervalle $[-5 ; 3]$ vers Inéquation[/bold][/color]'' ;
    draw line id 551 start 97.600s for 1.000s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Énoncé
    text id 42 start 101.000s for 3.000s at (4.0, 19.0) ''[color=#FBBF24][bold]Énoncé :[/bold][/color] [color=#F8FAFC]Écrire l'intervalle [/color][color=#34D399]$\mathbf{I = [-5 ; 3]}$[/color] [color=#F8FAFC]avec une valeur absolue.[/color]'' ;

    # Représentation sur l'axe
    draw arrow id 552 start 107.000s for 1.000s color (248, 250, 252, 0.85) width 1.8 at [(96.0, 45.0), (168.0, 45.0)] ;
    text id 43 start 108.500s at (170.0, 44.0) ''[color=#94A3B8]$\mathbb{R}$[/color]'' ;

    # Bornes -5 et 3
    draw line id 553 start 111.500s color (248, 250, 252, 0.85) width 2.0 at [(106.0, 42.0), (106.0, 48.0)] ;
    text id 44 start 111.800s at (103.5, 51.0) ''[color=#F8FAFC]$\mathbf{-5}$[/color]'' ;
    draw line id 554 start 112.800s color (248, 250, 252, 0.85) width 2.0 at [(154.0, 42.0), (154.0, 48.0)] ;
    text id 45 start 113.100s at (152.5, 51.0) ''[color=#F8FAFC]$\mathbf{3}$[/color]'' ;
    draw line id 555 start 114.200s for 1.200s color (52, 211, 153, 0.95) width 4.5 at [(106.0, 45.0), (154.0, 45.0)] ;

    # Crochets géométriques fermés à -5 et 3
    draw path id 556 start 116.000s color (52, 211, 153, 1.0) width 2.2 at [(108.0, 41.5), (106.0, 41.5), (106.0, 48.5), (108.0, 48.5)] ;
    draw path id 557 start 116.300s color (52, 211, 153, 1.0) width 2.2 at [(152.0, 41.5), (154.0, 41.5), (154.0, 48.5), (152.0, 48.5)] ;

    # Étape 1 : Milieu
    text id 46 start 119.500s for 2.200s at (4.0, 27.0) ''[color=#34D399][bold]Étape 1 : Calcul du milieu (centre $c$)[/bold][/color]'' ;
    text id 47 start 124.000s for 2.800s at (4.0, 34.0) ''[color=#F8FAFC]$\mathbf{c = \frac{a + b}{2} = \frac{-5 + 3}{2} = \frac{-2}{2}}$[/color]'' ;
    text id 48 start 134.500s for 2.000s at (4.0, 41.0) ''[color=#38BDF8][bold]Donc le milieu est $c = -1$[/bold][/color]'' ;

    # Centre c sur l'axe
    draw line id 558 start 140.200s color (56, 189, 248, 1.0) width 2.5 at [(130.0, 41.0), (130.0, 49.0)] ;
    draw circle id 559 start 140.500s color (56, 189, 248, 1.0) fillcolor (56, 189, 248, 0.9) radius 1.3 at (130.0, 45.0) ;
    text id 49 start 140.900s at (124.0, 51.0) ''[color=#38BDF8]$\mathbf{c = -1}$[/color]'' ;

    # Forme distance au centre
    text id 50 start 150.000s for 3.000s at (4.0, 48.0) ''[color=#FBBF24]Distance au centre : [/color][color=#38BDF8]$\mathbf{|x - (-1)| = |x + 1|}$[/color]'' ;

    # Étape 2 : Distance au milieu (rayon)
    text id 51 start 162.500s for 2.200s at (4.0, 56.0) ''[color=#34D399][bold]Étape 2 : Calcul du rayon $r$[/bold][/color]'' ;
    text id 52 start 167.000s for 2.500s at (4.0, 63.0) ''[color=#F8FAFC]$\mathbf{r = 3 - (-1) = 3 + 1 = 4}$[/color]'' ;
    text id 53 start 180.000s for 2.500s at (4.0, 70.0) ''[color=#94A3B8]Vérification : $-1 - (-5) = -1 + 5 = 4$[/color]'' ;

    # Double flèche du rayon r sur l'axe
    draw arrow id 560 start 206.800s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(130.0, 36.0), (154.0, 36.0)] ;
    text id 54 start 208.200s at (140.0, 31.0) ''[color=#38BDF8]$\mathbf{r = 4}$[/color]'' ;
    draw arrow id 561 start 209.500s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(130.0, 36.0), (106.0, 36.0)] ;
    text id 55 start 211.000s at (116.0, 31.0) ''[color=#38BDF8]$\mathbf{r = 4}$[/color]'' ;

    # Étape 3 : Inéquation
    text id 56 start 215.000s for 2.200s at (4.0, 77.0) ''[color=#34D399][bold]Étape 3 : Déduction de l'inéquation[/bold][/color]'' ;
    text id 57 start 223.0s for 2.500s at (4.0, 83.5) ''[color=#F8FAFC]Zone intérieure et crochets fermés [/color][color=#34D399]$\mathbf{\implies |x + 1| \le 4}$[/color]'' ;

    # Encadré conclusion à droite en bas
    draw polygone id 562 start 270.000s for 1.200s color (52, 211, 153, 0.95) width 1.8 fillcolor (52, 211, 153, 0.15) at [(100.0, 66.0), (164.0, 66.0), (164.0, 88.0), (100.0, 88.0)] ;
    text id 58 start 272.000s for 2.500s at (104.0, 72.0) ''[color=#FBBF24][bold]Résultat validé :[/bold][/color]'' ;
    text id 59 start 275.000s for 2.500s at (104.0, 80.0) ''[color=#38BDF8]$\mathbf{x \in [-5 ; 3] \iff |x + 1| \le 4}$[/color]'' ;

    erase id 2002 start 287.000s ;

    # =========================================================================
    # SCENE 3: Exercice 2 : Intervalle [-7 ; -4] avec fractions (287.0s -> 438.5s)
    # =========================================================================

    text id 101 start 288.000s at (4.0, 7.5) ''[color=#38BDF8][bold]3. Exercice 2 : Intervalle $[-7 ; -4]$ & Nombres Négatifs[/bold][/color]'' ;
    draw line id 621 start 288.200s for 1.000s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Énoncé
    text id 102 start 291.500s for 3.000s at (4.0, 19.0) ''[color=#FBBF24][bold]Énoncé :[/bold][/color] [color=#F8FAFC]Transformer [/color][color=#34D399]$\mathbf{I = [-7 ; -4]}$[/color] [color=#F8FAFC]en inéquation avec valeur absolue.[/color]'' ;

    # Représentation sur l'axe
    draw arrow id 622 start 302.800s for 1.000s color (248, 250, 252, 0.85) width 1.8 at [(96.0, 45.0), (168.0, 45.0)] ;
    text id 103 start 304.200s at (170.0, 44.0) ''[color=#94A3B8]$\mathbb{R}$[/color]'' ;

    # Bornes -7 et -4
    draw line id 623 start 306.000s color (248, 250, 252, 0.85) width 2.0 at [(106.0, 42.0), (106.0, 48.0)] ;
    text id 104 start 306.300s at (103.5, 51.0) ''[color=#F8FAFC]$\mathbf{-7}$[/color]'' ;
    draw line id 624 start 307.200s color (248, 250, 252, 0.85) width 2.0 at [(154.0, 42.0), (154.0, 48.0)] ;
    text id 105 start 307.500s at (152.5, 51.0) ''[color=#F8FAFC]$\mathbf{-4}$[/color]'' ;
    draw line id 625 start 308.800s for 1.200s color (52, 211, 153, 0.95) width 4.5 at [(106.0, 45.0), (154.0, 45.0)] ;
    draw path id 626 start 310.200s color (52, 211, 153, 1.0) width 2.2 at [(108.0, 41.5), (106.0, 41.5), (106.0, 48.5), (108.0, 48.5)] ;
    draw path id 627 start 310.500s color (52, 211, 153, 1.0) width 2.2 at [(152.0, 41.5), (154.0, 41.5), (154.0, 48.5), (152.0, 48.5)] ;

    # Étape 1 : Milieu
    text id 106 start 313.500s for 2.200s at (4.0, 27.0) ''[color=#34D399][bold]Étape 1 : Calcul du milieu (fraction)[/bold][/color]'' ;
    text id 107 start 318.000s for 3.000s at (4.0, 34.0) ''[color=#F8FAFC]$\mathbf{c = \frac{-7 + (-4)}{2} = \frac{-11}{2} = -5{,}5}$[/color]'' ;

    # Milieu sur l'axe
    draw line id 628 start 337.800s color (56, 189, 248, 1.0) width 2.5 at [(130.0, 41.0), (130.0, 49.0)] ;
    draw circle id 629 start 338.100s color (56, 189, 248, 1.0) fillcolor (56, 189, 248, 0.9) radius 1.3 at (130.0, 45.0) ;
    text id 108 start 338.500s at (122.0, 52.0) ''[color=#38BDF8]$\mathbf{c = -\frac{11}{2}}$[/color]'' ;

    # Distance au centre
    text id 109 start 343.500s for 3.000s at (4.0, 42.0) ''[color=#FBBF24]Distance : [/color][color=#38BDF8]$\mathbf{|x - (-\frac{11}{2})| = |x + \frac{11}{2}|}$[/color]'' ;

    # Étape 2 : Rayon r
    text id 110 start 352.500s for 2.200s at (4.0, 50.0) ''[color=#34D399][bold]Étape 2 : Calcul du rayon $r$[/bold][/color]'' ;
    text id 111 start 357.000s for 2.800s at (4.0, 57.0) ''[color=#F8FAFC]$\mathbf{r = -4 - (-\frac{11}{2}) = -4 + \frac{11}{2}}$[/color]'' ;
    text id 112 start 366.500s for 2.500s at (4.0, 64.0) ''[color=#F8FAFC]Mise au dénominateur : $\mathbf{-4 = -\frac{8}{2}}$[/color]'' ;
    text id 113 start 373.000s for 2.500s at (4.0, 71.0) ''[color=#38BDF8]$\mathbf{r = -\frac{8}{2} + \frac{11}{2} = \frac{3}{2} = 1{,}5}$[/color]'' ;

    # Flèches de rayon sur l'axe
    draw arrow id 630 start 386.300s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(130.0, 36.0), (154.0, 36.0)] ;
    text id 114 start 387.800s at (139.0, 31.0) ''[color=#38BDF8]$\mathbf{r = \frac{3}{2}}$[/color]'' ;
    draw arrow id 631 start 389.000s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(130.0, 36.0), (106.0, 36.0)] ;
    text id 115 start 390.500s at (115.0, 31.0) ''[color=#38BDF8]$\mathbf{r = \frac{3}{2}}$[/color]'' ;

    # Étape 3 : Inéquation
    text id 116 start 398.000s for 2.200s at (4.0, 78.0) ''[color=#34D399][bold]Étape 3 : Inéquation finale[/bold][/color]'' ;
    text id 117 start 404.000s for 2.500s at (4.0, 84.5) ''[color=#F8FAFC]Intervalle en un seul bloc fermé [/color][color=#34D399]$\mathbf{\implies \le}$[/color]'' ;

    # Encadré de conclusion
    draw polygone id 632 start 419.000s for 1.200s color (52, 211, 153, 0.95) width 1.8 fillcolor (52, 211, 153, 0.15) at [(100.0, 66.0), (164.0, 66.0), (164.0, 88.0), (100.0, 88.0)] ;
    text id 118 start 421.000s for 2.500s at (104.0, 72.0) ''[color=#FBBF24][bold]Résultat validé :[/bold][/color]'' ;
    text id 119 start 424.000s for 2.500s at (103.0, 80.0) ''[color=#38BDF8]$\mathbf{x \in [-7 ; -4] \iff |x + \frac{11}{2}| \le \frac{3}{2}}$[/color]'' ;

    erase id 2003 start 438.500s ;

    # =========================================================================
    # SCENE 4: Exercice 3 : Union d'intervalles extérieurs (438.5s -> 577.5s)
    # =========================================================================

    text id 161 start 439.500s at (4.0, 7.5) ''[color=#38BDF8][bold]4. Exercice 3 : Union d'Intervalles Extérieurs $]-\infty ; 0] \cup [10 ; +\infty[$[/bold][/color]'' ;
    draw line id 701 start 439.700s for 1.000s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Énoncé
    text id 162 start 444.000s for 3.200s at (4.0, 19.0) ''[color=#FBBF24][bold]Énoncé :[/bold][/color] [color=#F8FAFC]Transformer [/color][color=#34D399]$\mathbf{I = ]-\infty ; 0] \cup [10 ; +\infty[}$[/color] [color=#F8FAFC]en inéquation.[/color]'' ;

    # Représentation sur l'axe
    draw arrow id 702 start 457.500s for 1.000s color (248, 250, 252, 0.85) width 1.8 at [(96.0, 45.0), (168.0, 45.0)] ;
    text id 163 start 459.000s at (170.0, 44.0) ''[color=#94A3B8]$\mathbb{R}$[/color]'' ;

    # Bornes 0 et 10
    draw line id 703 start 461.000s color (248, 250, 252, 0.85) width 2.0 at [(115.0, 42.0), (115.0, 48.0)] ;
    text id 164 start 461.300s at (113.5, 51.0) ''[color=#F8FAFC]$\mathbf{0}$[/color]'' ;
    draw line id 704 start 462.200s color (248, 250, 252, 0.85) width 2.0 at [(155.0, 42.0), (155.0, 48.0)] ;
    text id 165 start 462.500s at (153.5, 51.0) ''[color=#F8FAFC]$\mathbf{10}$[/color]'' ;

    # Deux zones extérieures surlignées en émeraude
    draw line id 705 start 464.000s for 1.000s color (52, 211, 153, 0.95) width 4.5 at [(96.0, 45.0), (115.0, 45.0)] ;
    draw line id 706 start 465.500s for 1.000s color (52, 211, 153, 0.95) width 4.5 at [(155.0, 45.0), (168.0, 45.0)] ;
    draw path id 707 start 467.000s color (52, 211, 153, 1.0) width 2.2 at [(113.0, 41.5), (115.0, 41.5), (115.0, 48.5), (113.0, 48.5)] ;
    draw path id 708 start 467.500s color (52, 211, 153, 1.0) width 2.2 at [(157.0, 41.5), (155.0, 41.5), (155.0, 48.5), (157.0, 48.5)] ;

    # Colonne gauche : Règle union extérieure
    text id 166 start 475.500s for 2.500s at (4.0, 27.0) ''[color=#FBBF24][bold]Règle essentielle pour une union extérieure :[/bold][/color]'' ;
    text id 167 start 480.000s for 3.000s at (4.0, 34.0) ''[color=#F8FAFC]Points extérieurs [/color][color=#F87171]$\implies$ distance au centre supérieure au rayon $\mathbf{\ge r}$[/color]'' ;

    # Étape 1 : Milieu
    text id 168 start 489.500s for 2.000s at (4.0, 42.0) ''[color=#34D399][bold]Étape 1 : Milieu entre $0$ et $10$[/bold][/color]'' ;
    text id 169 start 494.000s for 2.500s at (4.0, 49.0) ''[color=#F8FAFC]$\mathbf{c = \frac{0 + 10}{2} = \frac{10}{2} = 5}$[/color]'' ;

    # Centre 5 sur l'axe
    draw line id 709 start 501.500s color (56, 189, 248, 1.0) width 2.5 at [(135.0, 41.0), (135.0, 49.0)] ;
    draw circle id 710 start 501.800s color (56, 189, 248, 1.0) fillcolor (56, 189, 248, 0.9) radius 1.3 at (135.0, 45.0) ;
    text id 170 start 502.200s at (133.0, 51.0) ''[color=#38BDF8]$\mathbf{c = 5}$[/color]'' ;

    # Expression distance
    text id 171 start 507.000s for 2.500s at (4.0, 56.0) ''[color=#FBBF24]Distance au centre : [/color][color=#38BDF8]$\mathbf{|x - 5|}$[/color]'' ;

    # Étape 2 : Rayon r
    text id 172 start 514.000s for 2.000s at (4.0, 63.0) ''[color=#34D399][bold]Étape 2 : Calcul du rayon $r$[/bold][/color]'' ;
    text id 173 start 518.500s for 2.500s at (4.0, 70.0) ''[color=#F8FAFC]$\mathbf{r = 10 - 5 = 5}$[/color] [color=#94A3B8](ou $5 - 0 = 5$)[/color]'' ;

    # Flèches de rayon sur l'axe
    draw arrow id 711 start 527.500s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(135.0, 36.0), (155.0, 36.0)] ;
    text id 174 start 529.000s at (143.0, 31.0) ''[color=#38BDF8]$\mathbf{r = 5}$[/color]'' ;
    draw arrow id 712 start 530.000s for 1.000s color (56, 189, 248, 0.95) width 1.6 at [(135.0, 36.0), (115.0, 36.0)] ;
    text id 175 start 531.500s at (123.0, 31.0) ''[color=#38BDF8]$\mathbf{r = 5}$[/color]'' ;

    # Étape 3 : Inégalité
    text id 176 start 537.000s for 2.200s at (4.0, 77.0) ''[color=#34D399][bold]Étape 3 : Écriture de l'inégalité supérieure[/bold][/color]'' ;
    text id 177 start 543.500s for 2.500s at (4.0, 83.5) ''[color=#F8FAFC]Extérieur et bornes incluses [/color][color=#F87171]$\mathbf{\implies |x - 5| \ge 5}$[/color]'' ;

    # Encadré conclusion à droite
    draw polygone id 713 start 561.000s for 1.200s color (248, 113, 113, 0.95) width 1.8 fillcolor (248, 113, 113, 0.15) at [(98.0, 66.0), (166.0, 66.0), (166.0, 88.0), (98.0, 88.0)] ;
    text id 178 start 563.000s for 2.500s at (102.0, 72.0) ''[color=#FBBF24][bold]Résultat validé :[/bold][/color]'' ;
    text id 179 start 566.000s for 2.500s at (101.0, 80.0) ''[color=#F87171]$\mathbf{x \in ]-\infty ; 0] \cup [10 ; +\infty[ \iff |x - 5| \ge 5}$[/color]'' ;

    erase id 2004 start 577.500s ;

    # =========================================================================
    # SCENE 5: Erreur fréquente : Intervalle non borné sans milieu (577.5s -> 643.5s)
    # =========================================================================

    text id 221 start 578.500s at (4.0, 7.5) ''[color=#F87171][bold]5. Piège d'Examen : L'Intervalle non borné $[3 ; +\infty[$[/bold][/color]'' ;
    draw line id 781 start 578.700s for 1.000s color (248, 113, 113, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Question piège
    text id 222 start 582.000s for 3.000s at (4.0, 19.0) ''[color=#FBBF24][bold]Question piège :[/bold][/color] [color=#F8FAFC]Peut-on écrire [/color][color=#F87171]$\mathbf{[3 ; +\infty[}$[/color] [color=#F8FAFC]avec une valeur absolue ?[/color]'' ;

    # Représentation sur l'axe
    draw arrow id 782 start 589.500s for 1.000s color (248, 250, 252, 0.85) width 1.8 at [(96.0, 48.0), (168.0, 48.0)] ;
    text id 223 start 591.000s at (170.0, 47.0) ''[color=#94A3B8]$\mathbb{R}$[/color]'' ;

    # Borne 3 et demi-droite vers +infini
    draw line id 783 start 593.000s color (248, 250, 252, 0.85) width 2.0 at [(115.0, 45.0), (115.0, 51.0)] ;
    text id 224 start 593.300s at (113.5, 54.0) ''[color=#F8FAFC]$\mathbf{3}$[/color]'' ;
    draw line id 784 start 594.800s for 1.200s color (251, 191, 36, 0.95) width 4.5 at [(115.0, 48.0), (168.0, 48.0)] ;
    draw path id 785 start 596.500s color (251, 191, 36, 1.0) width 2.2 at [(117.0, 44.5), (115.0, 44.5), (115.0, 51.5), (117.0, 51.5)] ;
    text id 225 start 597.500s at (163.0, 54.0) ''[color=#FBBF24]$\mathbf{+\infty}$[/color]'' ;

    # Explication du piège
    text id 226 start 601.000s for 2.200s at (4.0, 27.0) ''[color=#F87171][bold]Tentative erronée : Calculer le milieu[/bold][/color]'' ;
    text id 227 start 605.000s for 2.500s at (4.0, 35.0) ''[color=#F8FAFC]Quel est le milieu entre $3$ et $+\infty$ ?[/color]'' ;
    text id 228 start 612.000s for 3.000s at (4.0, 43.0) ''[color=#F87171]$\mathbf{+\infty}$[/color] [color=#F8FAFC]n'est pas un nombre réel, mais une notion d'infini ![/color]'' ;
    text id 229 start 617.000s for 3.200s at (4.0, 51.0) ''[color=#F8FAFC]Il est [/color][color=#F87171][bold]impossible[/bold][/color] [color=#F8FAFC]de définir un centre fini [/color][color=#FBBF24]$\mathbf{c}$[/color] [color=#F8FAFC]et un rayon [/color][color=#38BDF8]$\mathbf{r}$[/color].'' ;
    text id 230 start 624.000s for 3.000s at (4.0, 60.0) ''[color=#F8FAFC]Une inéquation [/color][color=#94A3B8]$|x - c| \le r$[/color] [color=#F8FAFC]est donc [/color][color=#F87171][bold]totalement exclue[/bold][/color].'' ;

    # Réflexe lycée
    draw polygone id 786 start 631.000s for 1.200s color (52, 211, 153, 0.95) width 1.8 fillcolor (52, 211, 153, 0.15) at [(4.0, 70.0), (84.0, 70.0), (84.0, 88.0), (4.0, 88.0)] ;
    text id 231 start 633.000s for 2.200s at (7.0, 75.0) ''[color=#34D399][bold]Réflexe de contrôle :[/bold][/color]'' ;
    text id 232 start 636.000s for 2.500s at (7.0, 82.0) ''[color=#38BDF8]$\mathbf{x \in [3 ; +\infty[ \iff x \ge 3}$[/color] [color=#94A3B8](sans valeur absolue)[/color]'' ;

    erase id 2005 start 643.500s ;

    # =========================================================================
    # SCENE 6: Synthèse méthodologique et réflexes contrôle (643.5s -> 681.96s)
    # =========================================================================

    text id 261 start 644.500s at (4.0, 7.5) ''[color=#38BDF8][bold]6. Synthèse Méthodologique & Réflexes pour le Contrôle[/bold][/color]'' ;
    draw line id 841 start 644.700s for 1.000s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Colonne gauche : Formules clés
    text id 262 start 649.000s for 2.000s at (4.0, 19.0) ''[color=#34D399][bold]1. Formules fondamentales ($a < b$) :[/bold][/color]'' ;
    text id 263 start 653.000s for 2.000s at (4.0, 27.0) ''[color=#F8FAFC]Centre (milieu) : [/color][color=#FBBF24]$\mathbf{c = \frac{a + b}{2}}$[/color]'' ;
    text id 264 start 657.000s for 2.500s at (4.0, 35.0) ''[color=#F8FAFC]Rayon : [/color][color=#38BDF8]$\mathbf{r = \frac{b - a}{2} = b - c}$[/color]'' ;

    text id 265 start 662.000s at (4.0, 44.0) ''[color=#34D399][bold]2. Sens de l'inégalité :[/bold][/color]'' ;
    text id 266 start 664.000s for 2.500s at (4.0, 52.0) ''[color=#F8FAFC]Bloc fermé $[a ; b]$ [/color][color=#34D399]$\mathbf{\implies |x - c| \le r}$[/color]'' ;
    text id 267 start 668.000s for 2.500s at (4.0, 60.0) ''[color=#F8FAFC]Union extérieure [/color][color=#F87171]$\mathbf{\implies |x - c| \ge r}$[/color]'' ;
    text id 268 start 672.000s for 2.500s at (4.0, 69.0) ''[color=#FBBF24][bold]3. Crochets :[/bold][/color] [color=#F8FAFC]Fermé $\implies \mathbf{\le}$ ou $\mathbf{\ge}$ ; Ouvert $\implies \mathbf{<}$ ou $\mathbf{>}$[/color]'' ;

    # Colonne droite : Tableau récapitulatif
    draw polygone id 842 start 650.000s for 1.200s color (56, 189, 248, 0.7) width 1.5 fillcolor (15, 23, 42, 0.4) at [(95.0, 20.0), (170.0, 20.0), (170.0, 85.0), (95.0, 85.0)] ;
    draw line id 843 start 652.000s color (56, 189, 248, 0.6) width 1.2 at [(95.0, 30.0), (170.0, 30.0)] ;
    text id 269 start 652.300s at (98.0, 25.0) ''[color=#38BDF8][bold]Type d'intervalle[/bold][/color]'' ;
    text id 270 start 652.600s at (134.0, 25.0) ''[color=#FBBF24][bold]Inéquation[/bold][/color]'' ;

    text id 271 start 655.000s at (98.0, 38.0) ''[color=#F8FAFC]$[a ; b]$[/color]'' ;
    text id 272 start 655.500s at (134.0, 38.0) ''[color=#34D399]$\mathbf{|x - c| \le r}$[/color]'' ;

    text id 273 start 661.000s at (98.0, 49.0) ''[color=#F8FAFC]$]a ; b[$[/color]'' ;
    text id 274 start 661.500s at (134.0, 49.0) ''[color=#34D399]$\mathbf{|x - c| < r}$[/color]'' ;

    text id 275 start 667.000s at (98.0, 60.0) ''[color=#F8FAFC]$]-\infty ; a] \cup [b ; +\infty[$[/color]'' ;
    text id 276 start 667.500s at (134.0, 60.0) ''[color=#F87171]$\mathbf{|x - c| \ge r}$[/color]'' ;

    text id 277 start 673.000s at (98.0, 71.0) ''[color=#F8FAFC]$]-\infty ; a[$ $\cup$ $]b ; +\infty[$[/color]'' ;
    text id 278 start 673.500s at (134.0, 71.0) ''[color=#F87171]$\mathbf{|x - c| > r}$[/color]'' ;

    text id 279 start 677.000s at (102.0, 80.0) ''[color=#FBBF24][bold]Méthode maîtrisée pour le lycée ![/bold][/color]'' ;
}
