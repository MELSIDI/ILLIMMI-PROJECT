course "Exemple guidé et calcul détaillé : Fonctions affines et droites du plan en pratique" id 43 idgap 500 for 208.0s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction & Objectif : Représentation d'une Fonction Affine
    # Timeline : 0.0s -> 40.3s
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction : Objectif & Représentation Graphique[/color][/bold]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 9.6s for 2.8s at (5.0, 22.0) ''[bold]Problème :[/bold] Représenter la fonction affine :'' ;
    text id 3 start 14.8s for 2.2s at (8.0, 33.0) ''[color=#FBBF24]$\mathbf{f(x) = 2x + 1}$[/color]'' ;

    text id 4 start 17.6s for 3.2s at (5.0, 46.0) ''[bold]Propriété fondamentale :[/bold]'' ;
    text id 5 start 21.0s for 2.8s at (8.0, 56.0) ''La représentation graphique de $f$ est une [color=#38BDF8][bold]droite $(d)$[/bold][/color].'' ;

    text id 6 start 24.5s for 3.2s at (5.0, 70.0) ''[bold]Règle géométrique d'unicité :[/bold]'' ;
    text id 7 start 28.0s for 3.5s at (8.0, 80.0) ''Par [color=#34D399][bold]deux points distincts[/bold][/color], il passe [color=#F8FAFC]une seule et unique droite[/color].'' ;

    draw line id 502 start 33.0s for 1.5s color (56, 189, 248, 0.9) width 2.5 at [(105, 75), (165, 35)] ;
    draw circle id 503 start 35.0s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.5) radius 1.8 at (120, 65) ;
    text id 8 start 35.8s at (114, 58) ''[color=#34D399]Point 1[/color]'' ;
    draw circle id 504 start 37.0s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.5) radius 1.8 at (150, 45) ;
    text id 9 start 37.8s at (144, 38) ''[color=#34D399]Point 2[/color]'' ;
    text id 10 start 38.6s at (156, 28) ''[color=#38BDF8]Droite $(d)$[/color]'' ;

    erase id 2001 start 40.3s ;

    # =========================================================================
    # SCENE 2 : Rappel Théorique : Forme f(x) = ax + b
    # Timeline : 40.5s -> 70.4s
    # =========================================================================
    text id 11 start 40.6s for 1.6s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Rappel Théorique : Forme f(x) = ax + b[/color][/bold]'' ;
    draw line id 505 start 42.5s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 12 start 44.3s at (5.0, 22.0) ''[bold]Forme générale :[/bold]'' ;
    text id 13 start 44.8s for 2.2s at (8.0, 32.0) ''[bold]$\mathbf{f(x) = ax + b}$[/bold]'' ;

    text id 14 start 48.4s for 2.4s at (5.0, 44.0) ''[color=#F87171]$\mathbf{a}$[/color] : [bold]Coefficient directeur[/bold] (pente de la droite)'' ;
    text id 15 start 51.5s for 1.2s at (10.0, 52.0) ''Dans notre exemple : [color=#F87171]$\mathbf{a = 2}$[/color]'' ;

    text id 16 start 53.5s for 2.2s at (5.0, 62.0) ''[color=#34D399]$\mathbf{b}$[/color] : [bold]Ordonnée à l'origine[/bold]'' ;
    text id 17 start 56.5s for 1.2s at (10.0, 70.0) ''Dans notre exemple : [color=#34D399]$\mathbf{b = 1}$[/color]'' ;

    draw polygone id 506 start 58.2s for 1.0s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.12) at [(95, 25), (170, 25), (170, 75), (95, 75)] ;
    text id 20 start 59.5s at (100, 32) ''[bold][color=#38BDF8]Identification des paramètres :[/color][/bold]'' ;
    text id 21 start 60.2s at (102, 44) ''Fonction : [color=#FBBF24]$\mathbf{f(x) = 2x + 1}$[/color]'' ;

    text id 18 start 61.2s for 2.4s at (5.0, 80.0) ''[bold]Propriété :[/bold] Lorsque $x = 0$, $f(0) = a \times 0 + b =$ [color=#34D399]$\mathbf{b}$[/color]'' ;
    text id 19 start 64.5s for 2.5s at (5.0, 90.0) ''La droite passe par le point [color=#34D399]$\mathbf{(0 \; ; \; b)}$[/color] sur l'axe des ordonnées.'' ;

    text id 22 start 67.5s at (102, 54) ''Pente : [color=#F87171]$\mathbf{a = 2 > 0}$[/color] (droite croissante)'' ;
    text id 23 start 68.2s at (102, 64) ''Point de départ : [color=#34D399]$\mathbf{(0 \; ; \; 1)}$[/color] sur $(Oy)$'' ;

    erase id 2002 start 70.4s ;

    # =========================================================================
    # SCENE 3 : Premier Point : Ordonnée à l'Origine b = 1
    # Timeline : 70.6s -> 95.3s
    # =========================================================================
    text id 24 start 70.7s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Premier Point : Ordonnée à l'Origine b = 1[/color][/bold]'' ;
    draw line id 507 start 72.7s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 508 start 73.8s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 5] ;

    text id 25 start 75.5s for 2.4s at (5.0, 24.0) ''[bold]Lecture sur l'axe vertical $(Oy)$ :[/bold]'' ;
    text id 26 start 78.2s for 2.5s at (5.0, 36.0) ''L'ordonnée à l'origine vaut [color=#34D399]$\mathbf{b = 1}$[/color].'' ;

    draw circle id 509 start 81.0s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.5) radius 1.8 at (133, 50.5) ;
    draw arrow id 510 start 82.2s for 0.8s color (52, 211, 153, 1) width 2.0 at [(115, 50.5), (130, 50.5)] ;
    text id 27 start 83.2s at (5.0, 48.0) ''[bold]Repérage :[/bold] Graduation [color=#34D399]$\mathbf{b = 1}$[/color] sur l'axe $(Oy)$'' ;

    text id 28 start 84.5s for 3.0s at (5.0, 60.0) ''[bold]Premier point de la droite :[/bold]'' ;
    text id 29 start 88.0s for 2.8s at (8.0, 70.0) ''[color=#34D399]$\mathbf{A(0 \; ; \; 1)}$[/color] appartient à la droite $(d)$'' ;
    text id 30 start 91.5s for 3.0s at (5.0, 84.0) ''Il suffit maintenant d'un [color=#38BDF8][bold]deuxième point[/bold][/color] pour tracer la droite.'' ;

    erase id 2003 start 95.3s ;

    # =========================================================================
    # SCENE 4 : Deuxième Point : Rôle du Coefficient Directeur a = 2
    # Timeline : 95.4s -> 122.9s
    # =========================================================================
    text id 31 start 95.6s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Rôle du Coefficient Directeur a = 2[/color][/bold]'' ;
    draw line id 511 start 97.6s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 32 start 98.6s for 2.0s at (5.0, 22.0) ''[bold]Le coefficient directeur :[/bold] [color=#F87171]$\mathbf{a = 2}$[/color]'' ;
    text id 33 start 101.0s for 1.2s at (5.0, 33.0) ''[bold]Signification géométrique :[/bold]'' ;

    draw polygone id 512 start 102.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.12) at [(95, 25), (170, 25), (170, 85), (95, 85)] ;
    text id 38 start 104.0s at (100, 32) ''[bold][color=#38BDF8]Principe de la pente (marche d'escalier) :[/color][/bold]'' ;

    text id 34 start 104.5s for 3.5s at (8.0, 43.0) ''Lorsque $x$ augmente de [color=#38BDF8][bold]$+1$ unité[/bold][/color] :'' ;
    text id 35 start 108.5s for 3.5s at (8.0, 53.0) ''$y = f(x)$ augmente de [color=#F87171][bold]$+2$ unités[/bold][/color] (deux fois plus vite).'' ;

    text id 36 start 114.2s at (5.0, 68.0) ''[bold]Règle des déplacements :[/bold]'' ;
    draw arrow id 513 start 115.0s for 1.0s color (56, 189, 248, 1) width 2.5 at [(110, 70), (140, 70)] ;
    text id 39 start 116.2s at (118, 64) ''[color=#38BDF8]$\Delta x = +1$[/color]'' ;

    text id 37 start 118.2s at (8.0, 78.0) ''[color=#38BDF8]$\Delta x = +1$[/color] (à droite) $\implies$ [color=#F87171]$\Delta y = +2$[/color] (vers le haut)'' ;
    draw arrow id 514 start 119.0s for 1.0s color (248, 113, 113, 1) width 2.5 at [(140, 70), (140, 42)] ;
    text id 40 start 120.2s at (143, 56) ''[color=#F87171]$\Delta y = +2$[/color]'' ;

    draw circle id 515 start 121.5s for 0.4s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.6) radius 1.8 at (110, 70) ;
    draw circle id 516 start 122.1s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.6) radius 1.8 at (140, 42) ;

    erase id 2004 start 122.9s ;

    # =========================================================================
    # SCENE 5 : Construction Pas à Pas et Tracé de la Droite
    # Timeline : 123.0s -> 169.7s
    # =========================================================================
    text id 41 start 123.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Construction Pas à Pas et Tracé de la Droite[/color][/bold]'' ;
    draw line id 517 start 125.2s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 518 start 126.5s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 5] ;

    text id 42 start 128.5s at (5.0, 22.0) ''[bold]Étape 1 :[/bold] Point d'ancrage $b = 1$'' ;
    draw circle id 519 start 129.5s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.5) radius 1.8 at (133, 50.5) ;
    text id 43 start 130.5s at (8.0, 28.0) ''[color=#34D399]$\mathbf{A(0 \; ; \; 1)}$[/color] sur l'axe vertical $(Oy)$'' ;
    text id 44 start 131.5s at (8.0, 34.0) ''(Ordonnée à l'origine $b = 1$)'' ;

    text id 45 start 132.3s at (5.0, 41.5) ''[bold]Étape 2 :[/bold] Pas horizontal vers la droite'' ;
    draw arrow id 520 start 134.8s for 1.0s color (56, 189, 248, 1) width 2.2 at [(133, 50.5), (140.5, 50.5)] ;
    text id 46 start 136.2s at (8.0, 47.5) ''Déplacement horizontal : [color=#38BDF8]$\mathbf{\Delta x = +1}$[/color]'' ;
    text id 47 start 137.0s at (8.0, 53.5) ''Abscisse atteinte : $x = 1$'' ;

    text id 48 start 138.8s at (5.0, 61.0) ''[bold]Étape 3 :[/bold] Pas vertical vers le haut'' ;
    draw arrow id 521 start 141.2s for 1.2s color (248, 113, 113, 1) width 2.2 at [(140.5, 50.5), (140.5, 35.5)] ;
    text id 49 start 142.8s at (8.0, 67.0) ''Déplacement vertical : [color=#F87171]$\mathbf{\Delta y = a = +2}$[/color]'' ;
    text id 50 start 144.2s for 2.0s at (8.0, 73.0) ''Ordonnée atteinte : $y = 3$'' ;

    draw circle id 522 start 147.5s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.5) radius 1.8 at (140.5, 35.5) ;
    text id 51 start 148.6s at (5.0, 80.5) ''[bold]Second point :[/bold] [color=#FBBF24]$\mathbf{B(1 \; ; \; 3)}$[/color]'' ;

    text id 52 start 151.4s for 2.5s at (5.0, 86.5) ''Les points $A$ et $B$ appartiennent à $(d)$.'' ;
    text id 53 start 155.0s for 2.0s at (5.0, 93.0) ''Tracé de la droite :'' ;

    draw 2dfunc id 523 start 158.6s for 3.0s color (56, 189, 248, 1) width 2.5 at 518 y = 2 * x + 1 ;
    text id 54 start 164.2s for 2.0s at (35.0, 93.0) ''[bold][color=#38BDF8]$\mathbf{(d) : y = 2x + 1}$[/color][/bold]'' ;

    erase id 2005 start 169.7s ;

    # =========================================================================
    # SCENE 6 : Erreur Fréquente : Inverser les Rôles de a et b
    # Timeline : 169.9s -> 195.6s
    # =========================================================================
    text id 55 start 170.0s for 1.8s at (4.0, 7.5) ''[bold][color=#F87171]6. Erreur Fréquente : Confondre a et b[/color][/bold]'' ;
    draw line id 524 start 172.0s for 0.8s color (248, 113, 113, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 56 start 173.7s at (5.0, 24.0) ''[bold][color=#F87171]PIÈGE N°1 : Placer la pente sur l'axe vertical[/color][/bold]'' ;
    draw polygone id 525 start 174.5s for 1.0s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.12) at [(95, 25), (170, 25), (170, 85), (95, 85)] ;
    text id 61 start 176.0s at (100, 32) ''[bold][color=#F87171]RAPPEL DES RÔLES :[/color][/bold]'' ;

    text id 57 start 177.8s for 3.5s at (8.0, 36.0) ''[color=#F87171]$\mathbf{\times}$ FAUX :[/color] Ne pas placer $y = 2$ comme premier point !'' ;
    text id 58 start 182.3s at (8.0, 48.0) ''[color=#34D399]$\mathbf{\checkmark}$ VRAI :[/color] Le point sur l'axe vertical est [color=#34D399]$\mathbf{b = 1}$[/color] car $f(0) = 1$.'' ;

    text id 62 start 183.0s at (102, 44) ''[color=#34D399]$\mathbf{b}$ : POINT D'ANCRAGE[/color]'' ;
    text id 63 start 184.5s at (105, 52) ''Sur l'axe vertical $(Oy)$ à $x = 0$'' ;

    text id 59 start 186.4s at (5.0, 64.0) ''[bold][color=#F87171]PIÈGE N°2 : Inverser les déplacements[/color][/bold]'' ;
    text id 64 start 188.0s at (102, 64) ''[color=#F87171]$\mathbf{a}$ : DÉPLACEMENT[/color]'' ;
    text id 65 start 189.5s at (105, 72) ''Pente : $\Delta x = 1 \implies \Delta y = a$'' ;

    text id 60 start 190.2s for 3.8s at (8.0, 76.0) ''Règle immuable : [color=#38BDF8]$\mathbf{\Delta x = +1}$[/color] (horizontal) $\rightarrow$ [color=#F87171]$\mathbf{\Delta y = a}$[/color] (vertical).'' ;

    erase id 2006 start 195.6s ;

    # =========================================================================
    # SCENE 7 : Synthèse Méthodique & Réflexe Examen
    # Timeline : 195.8s -> 208.0s
    # =========================================================================
    text id 66 start 195.9s for 1.4s at (4.0, 7.5) ''[bold][color=#34D399]7. Synthèse Méthodique & Réflexe Examen[/color][/bold]'' ;
    draw line id 526 start 197.5s for 0.6s color (52, 211, 153, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 527 start 198.4s for 1.5s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 5] ;
    draw 2dfunc id 528 start 200.2s for 1.2s color (56, 189, 248, 1) width 2.5 at 527 y = 2 * x + 1 ;

    text id 67 start 201.8s at (5.0, 22.0) ''[bold]Algorithme de tracé pour [color=#FBBF24]$y = ax + b$[/color] :[/bold]'' ;
    text id 68 start 202.2s for 2.5s at (5.0, 36.0) ''[bold]1.[/bold] Placer [color=#34D399]$\mathbf{A(0 \; ; \; b)}$[/color] sur l'axe vertical $(Oy)$ (ici $b = 1$).'' ;

    draw circle id 529 start 205.0s for 0.5s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.6) radius 1.8 at (133, 50.5) ;

    text id 70 start 205.8s for 2.5s at (5.0, 52.0) ''[bold]2.[/bold] Avancer de [color=#38BDF8]$\mathbf{\Delta x = +1}$[/color] vers la droite'' ;
    draw arrow id 530 start 208.6s for 0.8s color (56, 189, 248, 1) width 2.2 at [(133, 50.5), (140.5, 50.5)] ;
    draw arrow id 531 start 209.8s for 0.8s color (248, 113, 113, 1) width 2.2 at [(140.5, 50.5), (140.5, 35.5)] ;
    draw circle id 532 start 211.0s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.6) radius 1.8 at (140.5, 35.5) ;

    text id 71 start 211.8s at (9.0, 62.0) ''et monter de [color=#F87171]$\mathbf{\Delta y = a = +2}$[/color] pour [color=#FBBF24]$\mathbf{B(1 \; ; \; 3)}$[/color].'' ;
    text id 72 start 212.8s for 2.0s at (5.0, 76.0) ''[bold]3.[/bold] Relier $A$ et $B$ pour tracer la droite :'' ;

    text id 73 start 215.0s at (5.0, 88.0) ''[bold][color=#38BDF8]$\mathbf{(d) : y = 2x + 1}$[/color][/bold]'' ;
}
