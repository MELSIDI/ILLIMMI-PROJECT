course "Correction d'exercice classique : Fonctions affines et droites du plan (Entraînement Lycée)" id 44 idgap 500 for 281.4s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction & Notion de Coefficient Directeur
    # Timeline : 0.0s -> 96.0s
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Définition & Rôle du Coefficient Directeur[/color][/bold]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 4.8s for 2.2s at (5.0, 20.0) ''[bold]Objectif Lycée :[/bold] Déterminer le [color=#38BDF8][bold]coefficient directeur[/bold][/color] d'une droite.'' ;

    text id 3 start 22.8s for 2.2s at (5.0, 31.0) ''[bold]Fonction affine :[/bold]'' ;
    text id 4 start 25.5s for 2.8s at (8.0, 39.0) ''[color=#FBBF24]$\mathbf{f(x) = ax + b}$[/color] $\iff$ droite non verticale $(d)$'' ;

    text id 5 start 33.4s for 2.5s at (5.0, 50.0) ''[bold]Paramètres clés :[/bold]'' ;
    text id 6 start 36.2s for 2.8s at (8.0, 58.0) ''[color=#F87171]$\mathbf{a}$[/color] : [bold]Coefficient directeur[/bold] (pente de la droite)'' ;

    text id 7 start 45.0s for 2.4s at (10.0, 66.0) ''$\bullet$ Si [color=#34D399]$\mathbf{a > 0}$[/color] : la droite [color=#34D399][bold]monte[/bold][/color] (croissante)'' ;
    text id 8 start 48.0s for 2.2s at (10.0, 73.0) ''$\bullet$ Si [color=#F87171]$\mathbf{a < 0}$[/color] : la droite [color=#F87171][bold]descend[/bold][/color] (décroissante)'' ;

    text id 9 start 62.8s for 3.0s at (8.0, 81.0) ''[color=#38BDF8]$\mathbf{b}$[/color] : [bold]Ordonnée à l'origine[/bold] (intersection avec $(Oy)$ en $(0 \; ; \; b)$)'' ;

    draw 2drep id 502 start 70.6s for 1.8s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-3, 5] ;
    draw 2dfunc id 503 start 75.5s for 2.5s color (56, 189, 248, 1) width 2.5 at 502 y = 2 * x - 1 ;
    draw circle id 504 start 78.5s for 0.6s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.5) radius 1.8 at (133, 65.5) ;

    text id 10 start 79.5s for 1.5s at (12.0, 87.0) ''[color=#F87171]$\mathbf{\implies b = -1}$[/color] (intersection avec $(Oy)$)'' ;
    text id 11 start 82.0s for 1.8s at (5.0, 93.0) ''[bold][color=#38BDF8]Droite $(d) : y = 2x - 1$[/color][/bold]'' ;
    text id 12 start 86.0s for 3.0s at (55.0, 93.0) ''[bold]Défi :[/bold] Pente [color=#FBBF24]$\mathbf{a}$[/color] ?'' ;

    erase id 2001 start 96.0s ;

    # =========================================================================
    # SCENE 2 : Méthode Graphique : Choix et Lecture des Points A et B
    # Timeline : 96.5s -> 156.0s
    # =========================================================================
    text id 13 start 96.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Méthode Graphique : Choix & Coordonnées de A et B[/color][/bold]'' ;
    draw line id 505 start 98.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 506 start 99.5s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-3, 5] ;
    draw 2dfunc id 507 start 101.2s for 1.5s color (56, 189, 248, 1) width 2.5 at 506 y = 2 * x - 1 ;

    text id 14 start 103.0s for 2.8s at (5.0, 20.0) ''[bold][color=#38BDF8]Étape 1 :[/color] Choisir 2 points distincts[/bold]'' ;
    text id 15 start 106.0s for 2.5s at (8.0, 27.5) ''Privilégier des [color=#FBBF24][bold]nœuds du quadrillage[/bold][/color] pour une lecture aisée.'' ;

    draw circle id 508 start 109.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.6) radius 1.8 at (140.5, 50.5) ;
    text id 16 start 110.0s for 1.0s at (10.0, 34.0) ''$\bullet$ Premier point sélectionné : [bold][color=#34D399]$\mathbf{A}$[/color][/bold]'' ;

    draw circle id 509 start 111.5s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.6) radius 1.8 at (148.0, 35.5) ;
    text id 17 start 112.5s for 1.0s at (10.0, 40.5) ''$\bullet$ Second point sélectionné : [bold][color=#FBBF24]$\mathbf{B}$[/color][/bold]'' ;

    text id 18 start 114.6s for 2.5s at (5.0, 48.0) ''[bold][color=#38BDF8]Étape 2 :[/color] Relever les coordonnées[/bold]'' ;
    text id 19 start 117.5s for 2.8s at (8.0, 54.5) ''Projections orthogonales sur les axes :'' ;

    draw line id 510 start 121.2s for 0.8s color (52, 211, 153, 0.8) width 1.5 at [(140.5, 50.5), (140.5, 58.0)] ;
    text id 20 start 126.9s for 2.2s at (10.0, 61.5) ''Abscisse de $A$ : [color=#34D399]$\mathbf{x_A = 1}$[/color]'' ;

    draw line id 511 start 129.8s for 0.8s color (52, 211, 153, 0.8) width 1.5 at [(140.5, 50.5), (133.0, 50.5)] ;
    text id 21 start 132.7s for 2.2s at (10.0, 68.5) ''Ordonnée de $A$ : [color=#34D399]$\mathbf{y_A = 1}$[/color]'' ;
    text id 22 start 135.5s for 2.2s at (12.0, 75.0) ''$\implies$ [color=#34D399][bold]$\mathbf{A(1 \; ; \; 1)}$[/bold][/color]'' ;

    draw line id 512 start 142.0s for 0.8s color (251, 191, 36, 0.8) width 1.5 at [(148.0, 35.5), (148.0, 58.0)] ;
    text id 23 start 146.3s for 2.2s at (10.0, 81.5) ''Abscisse de $B$ : [color=#FBBF24]$\mathbf{x_B = 2}$[/color]'' ;

    draw line id 513 start 149.0s for 0.8s color (251, 191, 36, 0.8) width 1.5 at [(148.0, 35.5), (133.0, 35.5)] ;
    text id 24 start 151.7s for 2.0s at (10.0, 88.0) ''Ordonnée de $B$ : [color=#FBBF24]$\mathbf{y_B = 3}$[/color]'' ;
    text id 25 start 154.0s for 1.8s at (12.0, 94.0) ''$\implies$ [color=#FBBF24][bold]$\mathbf{B(2 \; ; \; 3)}$[/bold][/color]'' ;

    erase id 2002 start 156.0s ;

    # =========================================================================
    # SCENE 3 : Formule Fondamentale & Piège Classique
    # Timeline : 156.5s -> 216.5s
    # =========================================================================
    text id 26 start 156.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Formule Fondamentale & Piège Classique[/color][/bold]'' ;
    draw line id 514 start 158.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 27 start 160.0s for 2.5s at (5.0, 20.0) ''[bold][color=#38BDF8]Étape 3 :[/color] Calcul du coefficient directeur[/bold]'' ;
    text id 28 start 164.0s for 3.2s at (8.0, 30.0) ''[bold]Formule fondamentale de la pente :[/bold]'' ;
    text id 29 start 168.0s for 3.0s at (12.0, 42.0) ''[color=#FBBF24]$\mathbf{a = \dfrac{y_B - y_A}{x_B - x_A}}$[/color]'' ;

    text id 30 start 173.5s for 3.0s at (8.0, 56.0) ''[bold]Interprétation :[/bold]'' ;
    text id 31 start 177.0s for 2.8s at (10.0, 64.0) ''$\mathbf{a = \dfrac{\text{Différence des ordonnées}}{\text{Différence des abscisses}}}$'' ;

    text id 32 start 183.0s for 2.5s at (8.0, 76.0) ''[bold]Notation scientifique / Physique-Chimie :[/bold]'' ;
    text id 33 start 186.0s for 3.0s at (12.0, 86.0) ''[color=#38BDF8]$\mathbf{a = \dfrac{\Delta y}{\Delta x}}$[/color] $\quad$ ($\Delta$ = variation)'' ;

    draw polygone id 515 start 193.0s for 1.0s color (248, 113, 113, 0.9) width 2.0 fillcolor (248, 113, 113, 0.12) at [(95, 20), (172, 20), (172, 92), (95, 92)] ;
    text id 34 start 194.5s for 2.0s at (100.0, 26.0) ''[bold][color=#F87171]PIÈGE CLASSIQUE D'EXAMEN[/color][/bold]'' ;
    draw line id 516 start 196.8s for 0.6s color (248, 113, 113, 0.8) width 1.2 at [(97, 31), (170, 31)] ;

    text id 35 start 198.0s for 3.0s at (98.0, 36.0) ''[color=#34D399][bold]$\checkmark$ VRAI :[/bold][/color] Les [color=#34D399][bold]ordonnées $y$[/bold][/color] au [bold]numérateur[/bold] (en haut)'' ;
    text id 36 start 202.5s for 3.0s at (98.0, 47.0) ''[color=#34D399][bold]$\checkmark$ VRAI :[/bold][/color] Les [color=#34D399][bold]abscisses $x$[/bold][/color] au [bold]dénominateur[/bold] (en bas)'' ;
    text id 37 start 207.5s for 3.0s at (98.0, 59.0) ''[color=#F87171][bold]$\times$ FAUX :[/bold][/color] $\mathbf{\dfrac{x_B - x_A}{y_B - y_A}}$ (Inversion interdite !)'' ;

    draw line id 517 start 211.0s for 0.6s color (248, 113, 113, 0.8) width 1.2 at [(97, 68), (170, 68)] ;
    text id 38 start 212.0s for 1.4s at (98.0, 74.0) ''[bold][color=#FBBF24]Moyen mnémotechnique :[/color][/bold]'' ;
    text id 39 start 213.5s for 1.4s at (100.0, 83.0) ''« Les [color=#38BDF8][bold]ordonnées montent au ciel[/bold][/color],'' ;
    text id 40 start 215.0s for 1.2s at (102.0, 88.0) ''elles vont donc [color=#FBBF24][bold]en haut[/bold][/color] ! »'' ;

    erase id 2003 start 216.5s ;

    # =========================================================================
    # SCENE 4 : Application Numérique & Interprétation Géométrique
    # Timeline : 216.8s -> 249.6s
    # =========================================================================
    text id 41 start 216.8s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Application Numérique & Interprétation Géométrique[/color][/bold]'' ;
    draw line id 518 start 218.8s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 42 start 220.0s for 2.2s at (5.0, 20.0) ''[bold]Données :[/bold] [color=#34D399]$\mathbf{A(1 \; ; \; 1)}$[/color] et [color=#FBBF24]$\mathbf{B(2 \; ; \; 3)}$[/color]'' ;
    text id 43 start 222.6s for 2.8s at (5.0, 28.5) ''[bold]Numérateur :[/bold] $y_B - y_A = 3 - 1 =$ [color=#34D399]$\mathbf{2}$[/color]'' ;
    text id 44 start 227.0s for 2.8s at (5.0, 37.0) ''[bold]Dénominateur :[/bold] $x_B - x_A = 2 - 1 =$ [color=#38BDF8]$\mathbf{1}$[/color]'' ;

    text id 45 start 232.1s for 1.6s at (5.0, 46.5) ''[bold]Calcul final de la pente :[/bold]'' ;
    text id 46 start 234.0s for 2.2s at (10.0, 54.5) ''[color=#FBBF24]$\mathbf{a = \dfrac{2}{1} = 2}$[/color]'' ;
    text id 47 start 236.5s for 0.8s at (5.0, 64.0) ''[bold]Conclusion :[/bold] Le coefficient directeur vaut [color=#34D399][bold]$\mathbf{a = 2}$[/bold][/color].'' ;

    draw 2drep id 519 start 237.5s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-3, 5] ;
    draw 2dfunc id 520 start 239.2s for 1.5s color (56, 189, 248, 1) width 2.5 at 519 y = 2 * x - 1 ;

    draw circle id 521 start 241.0s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.6) radius 1.8 at (140.5, 50.5) ;
    text id 48 start 241.8s for 0.8s at (5.0, 72.0) ''[bold]Sens géométrique (triangle de pente) :[/bold]'' ;

    draw arrow id 522 start 243.0s for 1.0s color (56, 189, 248, 1) width 2.5 at [(140.5, 50.5), (148.0, 50.5)] ;
    text id 49 start 244.2s for 1.2s at (8.0, 79.5) ''$\bullet$ Avance horizontale : [color=#38BDF8]$\mathbf{\Delta x = +1}$[/color] (vers la droite)'' ;

    draw arrow id 523 start 245.8s for 1.2s color (248, 113, 113, 1) width 2.5 at [(148.0, 50.5), (148.0, 35.5)] ;
    text id 50 start 247.2s for 1.0s at (8.0, 86.5) ''$\bullet$ Montée verticale : [color=#F87171]$\mathbf{\Delta y = +2}$[/color] (vers le haut)'' ;

    draw circle id 524 start 248.4s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.6) radius 1.8 at (148.0, 35.5) ;
    text id 51 start 249.0s at (8.0, 93.5) ''$\implies$ Pente : [color=#FBBF24]$\mathbf{\dfrac{\Delta y}{\Delta x} = \dfrac{2}{1} = 2}$[/color]'' ;

    erase id 2004 start 249.6s ;

    # =========================================================================
    # SCENE 5 : Synthèse Méthodique & Réflexe Examen
    # Timeline : 250.0s -> 281.4s
    # =========================================================================
    text id 52 start 250.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Synthèse Méthodique & Réflexe Examen[/color][/bold]'' ;
    draw line id 525 start 252.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 526 start 254.0s for 0.8s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.12) at [(5, 20), (86, 20), (86, 38), (5, 38)] ;
    text id 53 start 256.4s for 1.4s at (7.0, 26.0) ''[bold][color=#38BDF8]1. Choix des points :[/color][/bold]'' ;
    text id 54 start 258.0s for 2.2s at (9.0, 33.0) ''Prendre 2 points distincts $A$ et $B$ sur le quadrillage.'' ;

    draw polygone id 527 start 260.5s for 0.8s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.12) at [(5, 43), (86, 43), (86, 61), (5, 61)] ;
    text id 55 start 261.8s for 1.5s at (7.0, 49.0) ''[bold][color=#34D399]2. Lecture graphique :[/color][/bold]'' ;
    text id 56 start 263.5s for 2.5s at (9.0, 56.0) ''Projeter pour lire $(x_A, y_A)$ et $(x_B, y_B)$.'' ;

    draw polygone id 528 start 266.5s for 0.8s color (251, 191, 36, 0.8) width 1.5 fillcolor (251, 191, 36, 0.12) at [(5, 66), (86, 66), (86, 88), (5, 88)] ;
    text id 57 start 267.5s for 1.8s at (7.0, 72.0) ''[bold][color=#FBBF24]3. Formule de pente :[/color][/bold]'' ;
    text id 58 start 269.5s for 2.0s at (9.0, 81.0) ''[color=#FBBF24]$\mathbf{a = \dfrac{y_B - y_A}{x_B - x_A} = \dfrac{\Delta y}{\Delta x}}$[/color]'' ;

    draw polygone id 529 start 272.0s for 1.0s color (192, 132, 252, 0.9) width 2.0 fillcolor (192, 132, 252, 0.12) at [(95, 20), (172, 20), (172, 88), (95, 88)] ;
    text id 59 start 273.5s for 2.0s at (102.0, 27.0) ''[bold][color=#C084FC]LE RÉFLEXE EXAMEN LYCÉE[/color][/bold]'' ;
    draw line id 530 start 275.8s for 0.6s color (192, 132, 252, 0.8) width 1.2 at [(98, 33), (169, 33)] ;

    text id 60 start 276.5s for 0.8s at (99.0, 42.0) ''[color=#38BDF8]$\bullet$ Vérification du signe immédiate :[/color]'' ;
    text id 61 start 277.5s for 0.8s at (102.0, 50.0) ''La droite [color=#34D399][bold]monte[/bold][/color] $\implies a > 0$ (ici $+2 > 0$).'' ;

    text id 62 start 278.5s for 0.8s at (99.0, 62.0) ''[color=#F87171]$\bullet$ Vigilance fraction :[/color]'' ;
    text id 63 start 279.5s for 0.8s at (102.0, 70.0) ''Toujours les [color=#34D399][bold]ordonnées $y$ en haut[/bold][/color] !'' ;

    text id 64 start 280.5s for 1.2s at (102.0, 80.0) ''[color=#FBBF24][bold]Méthode maîtrisée à 100% ![/bold][/color]'' ;

}
