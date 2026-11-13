course "Fonctions affines et droites du plan — Cours fondamental et définitions" id 41 idgap 500 for 1217.5s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Accroche & Plan du chapitre (0.0s -> 54.4s)
    # =========================================================================
    text id 1 start 0.2s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]1. Fonctions affines et droites du plan[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.8s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 7.2s for 1.6s at (4.0, 19.0) ''[bold][color=#FBBF24]Objectif du cours :[/color][/bold]'' ;
    text id 3 start 16.0s for 2.2s at (5.5, 28.0) ''[color=#F8FAFC]• Différents types de fonctions affines[/color]'' ;
    text id 4 start 18.6s for 2.2s at (5.5, 37.0) ''[color=#38BDF8]• Représentation graphique : droite du plan[/color]'' ;
    text id 5 start 21.7s for 2.0s at (5.5, 46.0) ''[color=#34D399]• Coefficient directeur ($a$)[/color]'' ;
    text id 6 start 24.0s for 1.8s at (5.5, 55.0) ''[color=#FBBF24]• Ordonnée à l'origine ($b$)[/color]'' ;
    text id 7 start 26.2s for 2.0s at (5.5, 64.0) ''[color=#C084FC]• Propriété des accroissements[/color]'' ;

    draw 2drep id 502 start 29.0s for 1.5s at (133.0, 56.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 3] ;
    draw 2dfunc id 503 start 31.0s for 1.5s color (56, 189, 248, 1) width 3.0 at 502 y = x + 1 ;
    text id 8 start 33.0s for 1.8s at (114.0, 22.0) ''[bold][color=#38BDF8]Aperçu : droite $y = ax + b$[/color][/bold]'' ;

    text id 9 start 37.0s for 2.4s at (4.0, 76.0) ''[color=#CBD5E1]Prérequis : calcul d'image et lecture graphique[/color]'' ;

    erase id 2001 start 54.4s ;

    # =========================================================================
    # SCENE 2 : Définition formelle f(x) = ax + b & Exemples (54.4s -> 145.5s)
    # =========================================================================
    text id 10 start 54.6s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]2. Définition d'une fonction affine[/color][/bold]'' ;
    draw line id 504 start 56.6s for 0.6s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 11 start 63.0s for 2.2s at (4.0, 19.5) ''[bold][color=#FBBF24]Définition :[/color][/bold]'' ;
    text id 12 start 67.5s for 2.5s at (6.0, 28.5) ''[bold][color=#38BDF8]$f(x) = ax + b$[/color][/bold]   ($a, b \in \mathbb{R}$)'' ;

    text id 13 start 79.0s for 2.2s at (4.0, 41.0) ''[color=#F8FAFC]Exemple 1 : $f(x) = 2x - 1$[/color]'' ;
    draw polygone id 505 start 84.2s for 1.0s color (56, 189, 248, 0.85) fillcolor (56, 189, 248, 0.14) width 1.8 at [(96.0, 22.0), (170.0, 22.0), (170.0, 56.0), (96.0, 56.0)] ;
    text id 14 start 85.5s for 1.4s at (114.0, 26.0) ''[bold][color=#F8FAFC]$f(x) = 2x - 1$[/color][/bold]'' ;
    draw arrow id 506 start 87.2s for 0.8s color (52, 211, 153, 1) width 2.5 at [(112.0, 43.0), (125.0, 34.0)] ;
    text id 15 start 88.5s at (101.0, 45.0) ''[bold][color=#34D399]$a = 2$[/color][/bold]'' ;
    draw arrow id 507 start 90.0s for 0.8s color (251, 191, 36, 1) width 2.5 at [(150.0, 43.0), (139.0, 34.0)] ;
    text id 16 start 91.2s at (142.0, 45.0) ''[bold][color=#FBBF24]$b = -1$[/color][/bold]'' ;

    text id 17 start 104.3s for 2.4s at (4.0, 52.5) ''[color=#34D399]Exemple 2 : $f(x) = 2x - \frac{4}{5}$[/color]'' ;
    text id 18 start 111.5s for 2.0s at (6.0, 62.0) ''[color=#CBD5E1]$a = 2$   et   $b = -\frac{4}{5}$[/color]'' ;

    draw polygone id 508 start 115.0s for 1.0s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.14) width 2.0 at [(96.0, 62.0), (170.0, 62.0), (170.0, 89.0), (96.0, 89.0)] ;
    text id 19 start 128.5s for 2.4s at (4.0, 75.5) ''[color=#F87171]Piège : $g(x) = 2x^2 - 1$[/color]'' ;
    text id 20 start 131.5s for 2.0s at (100.0, 66.0) ''[bold][color=#F87171]Attention : $x^2 \neq$ affine ![/color][/bold]'' ;
    text id 21 start 134.5s for 2.2s at (100.0, 76.5) ''[color=#F8FAFC]Puissance $1$ uniquement : $ax + b$[/color]'' ;

    erase id 2002 start 145.5s ;

    # =========================================================================
    # SCENE 3 : Cas particuliers — Linéaire & Constante (145.5s -> 266.8s)
    # =========================================================================
    text id 22 start 145.7s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]3. Cas particuliers : linéaire et constante[/color][/bold]'' ;
    draw line id 509 start 147.7s for 0.6s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 23 start 150.7s for 2.0s at (4.0, 19.0) ''[bold][color=#34D399]Cas 1 : Fonction linéaire ($b = 0$)[/color][/bold]'' ;
    text id 24 start 157.5s for 2.2s at (6.0, 27.5) ''[color=#F8FAFC]$g(x) = ax$  (pas de terme constant)[/color]'' ;
    text id 25 start 168.0s for 1.8s at (6.0, 36.0) ''[color=#34D399]Exemple : $g(x) = 3x$  ($a=3, b=0$)[/color]'' ;
    text id 26 start 176.2s for 2.4s at (4.0, 45.5) ''[color=#CBD5E1]Toute linéaire est affine (réciproque fausse)[/color]'' ;

    draw polygone id 510 start 182.0s for 1.0s color (56, 189, 248, 0.85) fillcolor (56, 189, 248, 0.14) width 1.8 at [(96.0, 20.0), (170.0, 20.0), (170.0, 46.0), (96.0, 46.0)] ;
    text id 27 start 183.5s for 1.6s at (104.0, 23.0) ''[bold][color=#38BDF8]Affines : $f(x) = ax + b$[/color][/bold]'' ;
    text id 28 start 186.0s at (99.5, 34.0) ''[color=#34D399]• Linéaire ($b=0$)[/color]'' ;
    text id 29 start 188.0s at (135.5, 34.0) ''[color=#FBBF24]• Constante ($a=0$)[/color]'' ;

    text id 30 start 199.0s for 2.2s at (4.0, 57.5) ''[bold][color=#FBBF24]Cas 2 : Fonction constante ($a = 0$)[/color][/bold]'' ;
    text id 31 start 212.0s for 2.2s at (6.0, 66.0) ''[color=#F8FAFC]$h(x) = b$  (aucune variable $x$)[/color]'' ;
    text id 32 start 226.5s for 1.8s at (6.0, 74.5) ''[color=#FBBF24]Exemple : $h(x) = 4$[/color]'' ;

    draw polygone id 511 start 231.5s for 1.0s color (251, 191, 36, 0.85) fillcolor (251, 191, 36, 0.14) width 1.8 at [(96.0, 52.0), (170.0, 52.0), (170.0, 88.0), (96.0, 88.0)] ;
    text id 33 start 233.2s at (102.0, 56.0) ''[color=#F8FAFC]$x = 10 \implies h(10) = 4$[/color]'' ;
    text id 34 start 236.0s at (102.0, 66.0) ''[color=#F8FAFC]$x = 1 \implies h(1) = 4$[/color]'' ;
    text id 35 start 238.8s at (102.0, 76.0) ''[color=#FBBF24]$x = 10^9 \implies h(10^9) = 4$[/color]'' ;

    text id 36 start 249.0s for 2.5s at (4.0, 85.0) ''[bold][color=#38BDF8]Bilan : $ax+b$ | $b=0 \to ax$ | $a=0 \to b$[/color][/bold]'' ;

    erase id 2003 start 266.8s ;

    # =========================================================================
    # SCENE 4 : Représentations graphiques des trois cas (266.8s -> 389.5s)
    # =========================================================================
    text id 37 start 267.0s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]4. Représentations graphiques : des droites[/color][/bold]'' ;
    draw line id 512 start 269.0s for 0.6s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 513 start 271.5s for 1.8s at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 5] ;

    text id 38 start 281.3s for 2.5s at (4.0, 19.5) ''[bold][color=#FBBF24]Propriété :[/color][/bold] toute affine est une [bold]droite[/bold] (règle).'' ;

    text id 39 start 303.5s for 2.4s at (4.0, 31.0) ''[color=#38BDF8]1) Cas général : $f(x) = x + 1$[/color]'' ;
    text id 40 start 307.0s for 2.0s at (6.0, 38.5) ''[color=#CBD5E1]Droite oblique coupant les 2 axes[/color]'' ;
    draw 2dfunc id 514 start 312.5s for 1.8s color (56, 189, 248, 1) width 3.0 at 513 y = x + 1 ;
    text id 41 start 317.5s for 1.4s at (6.0, 46.0) ''[bold][color=#38BDF8]Tracé : droite oblique $y = x + 1$[/color][/bold]'' ;

    text id 42 start 321.5s for 2.4s at (4.0, 54.0) ''[color=#34D399]2) Fonction linéaire : $g(x) = 2x$[/color]'' ;
    text id 43 start 337.0s for 2.4s at (6.0, 61.5) ''[color=#CBD5E1]Passe par l'origine $O(0 ; 0)$[/color]'' ;
    draw 2dfunc id 515 start 344.2s for 1.6s color (52, 211, 153, 1) width 3.0 at 513 y = 2 * x ;
    draw circle id 516 start 347.2s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.22) radius 1.4 at (133.0, 55.0) ;
    text id 44 start 348.5s for 1.0s at (6.0, 69.0) ''[bold][color=#FBBF24]Origine du repère : point $O(0 ; 0)$[/color][/bold]'' ;
    text id 45 start 350.0s for 1.2s at (6.0, 75.5) ''[bold][color=#34D399]Tracé : droite verte passant par $O$[/color][/bold]'' ;

    text id 46 start 355.5s for 2.4s at (4.0, 83.0) ''[color=#FBBF24]3) Fonction constante : $h(x) = 3$[/color]'' ;
    text id 47 start 362.5s for 2.2s at (6.0, 89.5) ''[color=#CBD5E1]Parallèle à l'axe des abscisses[/color]'' ;
    draw 2dfunc id 517 start 365.8s for 1.5s color (251, 191, 36, 1) width 3.0 at 513 y = 3 ;
    text id 48 start 368.5s for 1.5s at (105.0, 83.0) ''[bold][color=#FBBF24]Droite horizontale : $y = 3$[/color][/bold]'' ;

    erase id 2004 start 389.5s ;

    # =========================================================================
    # SCENE 5 : De la fonction affine à l'équation de droite (389.5s -> 575.8s)
    # =========================================================================
    text id 49 start 389.7s for 1.6s at (4.0, 6.5) ''[bold][color=#38BDF8]5. De la fonction à l'équation de droite[/color][/bold]'' ;
    draw line id 518 start 391.5s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 519 start 391.8s for 1.5s at (122.0, 59.0) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 5] y_range = [-3, 4] ;

    text id 50 start 395.5s for 2.2s at (4.0, 19.0) ''[color=#38BDF8]Droite $(d)$ : $f(x) = x - 1$[/color]'' ;
    text id 51 start 406.8s for 1.8s at (6.0, 26.5) ''[color=#CBD5E1]$a = 1$   et   $b = -1$[/color]'' ;
    draw 2dfunc id 520 start 416.8s for 1.6s color (56, 189, 248, 1) width 3.0 at 519 y = x - 1 ;
    text id 52 start 418.7s for 1.5s at (115.0, 20.0) ''[bold][color=#38BDF8]Droite $(d) : y = x - 1$[/color][/bold]'' ;

    text id 53 start 428.5s for 2.0s at (4.0, 35.5) ''[color=#F8FAFC]Pour $x = 3$ :[/color]'' ;
    text id 54 start 437.8s for 2.0s at (6.0, 43.0) ''[bold][color=#34D399]$f(3) = 3 - 1 = 2$[/color][/bold]'' ;

    draw circle id 521 start 455.0s for 0.8s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.24) radius 1.2 at (144.5, 44.0) ;
    text id 55 start 457.5s for 1.5s at (6.0, 50.5) ''[bold][color=#34D399]Point sur $(d)$ : $A(3 ; 2)$[/color][/bold]'' ;
    draw line id 522 start 465.5s for 0.8s color (52, 211, 153, 0.7) width 1.5 at [(144.5, 44.0), (144.5, 59.0)] ;
    draw line id 523 start 469.5s for 0.8s color (52, 211, 153, 0.7) width 1.5 at [(144.5, 44.0), (122.0, 44.0)] ;

    draw circle id 524 start 482.0s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.24) radius 1.2 at (152.0, 36.5) ;
    text id 56 start 483.2s for 1.5s at (6.0, 58.0) ''[bold][color=#FBBF24]Point quelconque : $M(x ; y) \in (d)$[/color][/bold]'' ;

    text id 57 start 501.5s for 1.8s at (6.0, 65.5) ''[color=#F8FAFC]$3 - 1 = 2$[/color]'' ;
    text id 58 start 518.5s for 1.8s at (6.0, 72.5) ''[color=#F8FAFC]$x - 1 = y$[/color]'' ;
    text id 59 start 536.8s for 1.8s at (6.0, 79.5) ''[bold][color=#FBBF24]$y = x - 1$[/color][/bold]  (équation de $(d)$)'' ;

    text id 60 start 555.8s for 2.8s at (4.0, 88.0) ''[bold][color=#38BDF8]Général : $M(x;y) \in (d) \iff y = ax + b$[/color][/bold]'' ;

    erase id 2005 start 575.8s ;

    # =========================================================================
    # SCENE 6 : Vocabulaire a et b (575.8s -> 622.5s)
    # =========================================================================
    text id 61 start 576.0s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]6. Coefficient directeur et ordonnée à l'origine[/color][/bold]'' ;
    draw line id 525 start 578.0s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 62 start 580.8s for 2.2s at (4.0, 20.0) ''[bold][color=#F8FAFC]Soit $(d)$ représentant $f(x) = ax + b$ :[/color][/bold]'' ;
    draw polygone id 526 start 594.5s for 1.0s color (56, 189, 248, 0.85) fillcolor (56, 189, 248, 0.14) width 1.8 at [(96.0, 24.0), (170.0, 24.0), (170.0, 74.0), (96.0, 74.0)] ;
    text id 63 start 596.0s for 1.6s at (116.0, 30.0) ''[bold][color=#F8FAFC]$$f(x) = a x + b$$[/color][/bold]'' ;

    text id 64 start 599.0s for 2.4s at (5.5, 34.0) ''[color=#34D399]• $a$ : coefficient directeur (pente)[/color]'' ;
    draw arrow id 527 start 602.5s for 0.8s color (52, 211, 153, 1) width 2.5 at [(115.0, 56.0), (128.0, 42.0)] ;
    text id 65 start 603.8s at (101.0, 58.0) ''[bold][color=#34D399]$a$ = pente[/color][/bold]'' ;

    text id 66 start 605.5s for 2.4s at (5.5, 48.0) ''[color=#FBBF24]• $b$ : ordonnée à l'origine[/color]'' ;
    draw arrow id 528 start 608.5s for 0.8s color (251, 191, 36, 1) width 2.5 at [(150.0, 56.0), (141.0, 42.0)] ;
    text id 67 start 609.6s at (135.0, 58.0) ''[bold][color=#FBBF24]$b$ = hauteur en $0$[/color][/bold]'' ;

    text id 68 start 613.0s for 2.4s at (4.0, 64.0) ''[color=#CBD5E1]Comment lire $a$ et $b$ sur un graphique ?[/color]'' ;

    erase id 2006 start 622.5s ;

    # =========================================================================
    # SCENE 7 : Exemple graphique 1 — f(x) = 2x - 2 (622.5s -> 824.2s)
    # =========================================================================
    text id 69 start 622.7s for 1.6s at (4.0, 6.5) ''[bold][color=#38BDF8]7. Exemple graphique 1 : lire b puis a[/color][/bold]'' ;
    draw line id 529 start 624.4s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 530 start 624.8s for 1.5s at (125.0, 59.0) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-3, 4] ;
    draw 2dfunc id 531 start 627.2s for 1.6s color (52, 211, 153, 1) width 3.0 at 530 y = 2 * x - 2 ;
    text id 70 start 629.0s for 1.5s at (115.0, 19.0) ''[bold][color=#34D399]Courbe $(d) : f(x) = ax + b$[/color][/bold]'' ;

    text id 71 start 631.5s for 2.2s at (4.0, 18.0) ''[color=#F8FAFC]Objectif : trouver $f(x) = ax + b$[/color]'' ;
    text id 72 start 645.5s for 2.2s at (4.0, 25.5) ''[bold][color=#FBBF24]1) Ordonnée à l'origine $b$ :[/color][/bold]'' ;

    draw circle id 532 start 661.5s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.24) radius 1.3 at (125.0, 75.0) ;
    text id 73 start 663.5s for 1.5s at (6.0, 33.0) ''[bold][color=#FBBF24]Coupe l'axe $Oy$ en $-2 \implies b = -2$[/color][/bold]'' ;
    text id 74 start 666.2s for 2.0s at (6.0, 40.5) ''[color=#CBD5E1]Car $f(0) = b = -2$[/color]'' ;
    text id 75 start 687.8s for 2.0s at (6.0, 47.5) ''[color=#F8FAFC]Donc $f(x) = a x - 2$[/color]'' ;

    draw line id 533 start 710.0s for 0.6s color (148, 163, 184, 0.45) width 1.2 at [(121.0, 91.0), (137.0, 27.0)] ;
    draw line id 534 start 712.7s for 0.6s color (148, 163, 184, 0.45) width 1.2 at [(109.0, 83.0), (157.0, 59.0)] ;

    text id 76 start 730.5s for 2.2s at (4.0, 56.0) ''[bold][color=#38BDF8]2) Coefficient directeur $a$ (pente) :[/color][/bold]'' ;
    draw circle id 535 start 742.0s for 0.6s color (56, 189, 248, 1) width 2.2 fillcolor (56, 189, 248, 0.25) radius 1.1 at (133.0, 59.0) ;
    text id 77 start 743.0s for 1.2s at (6.0, 63.5) ''[color=#38BDF8]Point $A(1 ; 0)$ sur la droite[/color]'' ;
    draw circle id 536 start 744.8s for 0.6s color (56, 189, 248, 1) width 2.2 fillcolor (56, 189, 248, 0.25) radius 1.1 at (141.0, 43.0) ;
    text id 78 start 746.0s for 1.2s at (6.0, 70.5) ''[color=#38BDF8]Point $B(2 ; 2)$ sur la droite[/color]'' ;

    draw arrow id 537 start 758.5s for 0.9s color (251, 191, 36, 1) width 2.8 at [(133.0, 59.0), (141.0, 59.0)] ;
    text id 79 start 760.0s for 1.2s at (6.0, 77.5) ''[bold][color=#FBBF24]Avance horizontale : $\Delta x = +1$[/color][/bold]'' ;
    draw arrow id 538 start 772.0s for 0.9s color (56, 189, 248, 1) width 2.8 at [(141.0, 59.0), (141.0, 43.0)] ;
    text id 80 start 773.2s for 1.2s at (6.0, 84.5) ''[bold][color=#38BDF8]Montée verticale : $\Delta y = +2$[/color][/bold]'' ;

    text id 81 start 794.0s for 2.2s at (6.0, 91.5) ''[bold][color=#34D399]$a = \frac{+2}{+1} = 2$[/color][/bold]'' ;
    text id 82 start 803.0s for 2.2s at (108.0, 86.5) ''[bold][color=#34D399]Résultat : $f(x) = 2x - 2$[/color][/bold]'' ;

    erase id 2007 start 824.2s ;

    # =========================================================================
    # SCENE 8 : Exemple graphique 2 — Pente négative (824.2s -> 923.1s)
    # =========================================================================
    text id 83 start 824.4s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]8. Exemple graphique 2 : pente négative[/color][/bold]'' ;
    draw line id 539 start 826.3s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 540 start 833.0s for 1.5s at (125.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-3, 3] ;
    draw 2dfunc id 541 start 835.2s for 1.6s color (192, 132, 252, 1) width 3.0 at 540 y = -0.5 * x - 1 ;
    text id 84 start 837.0s for 1.5s at (115.0, 22.0) ''[bold][color=#C084FC]Droite $(d') : g(x) = ax + b$[/color][/bold]'' ;

    text id 85 start 840.4s for 2.2s at (4.0, 19.5) ''[color=#C084FC]Droite $(d')$ : pente négative[/color]'' ;

    draw circle id 542 start 853.5s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.24) radius 1.2 at (125.0, 63.0) ;
    text id 86 start 855.3s for 1.5s at (4.0, 28.5) ''[bold][color=#FBBF24]1) Ordonnée à l'origine : $b = -1$[/color][/bold]'' ;
    text id 87 start 856.2s for 2.2s at (6.0, 36.5) ''[color=#CBD5E1]Coupe l'axe $Oy$ en $-1$[/color]'' ;

    text id 88 start 866.0s for 1.5s at (4.0, 46.0) ''[bold][color=#38BDF8]2) Coefficient directeur $a$ :[/color][/bold]'' ;
    draw arrow id 543 start 874.6s for 1.0s color (251, 191, 36, 1) width 2.8 at [(125.0, 63.0), (133.0, 63.0)] ;
    text id 89 start 876.5s for 1.5s at (6.0, 54.0) ''[color=#FBBF24]On avance de $+1$ en abscisse[/color]'' ;

    draw arrow id 544 start 884.5s for 1.0s color (56, 189, 248, 1) width 2.8 at [(133.0, 63.0), (133.0, 67.0)] ;
    text id 90 start 893.0s for 1.5s at (6.0, 62.0) ''[color=#38BDF8]On descend de $0{,}5$ en ordonnée[/color]'' ;

    text id 91 start 896.5s for 2.4s at (6.0, 70.0) ''[color=#F87171]Descente $\implies \Delta y = -0{,}5$[/color]'' ;
    text id 92 start 905.5s for 2.2s at (6.0, 78.0) ''[bold][color=#F87171]$a = \frac{-0{,}5}{+1} = -0{,}5$[/color][/bold]'' ;
    text id 93 start 916.0s for 2.4s at (108.0, 84.0) ''[bold][color=#C084FC]Résultat : $g(x) = -0{,}5x - 1$[/color][/bold]'' ;

    erase id 2008 start 923.1s ;

    # =========================================================================
    # SCENE 9 : Variation de b — Droites parallèles (923.1s -> 999.0s)
    # =========================================================================
    text id 94 start 923.3s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]9. Influence de b : droites parallèles[/color][/bold]'' ;
    draw line id 545 start 925.2s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 546 start 933.5s for 1.5s at (133.0, 63.0) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 5] ;

    draw 2dfunc id 547 start 935.5s for 1.4s color (52, 211, 153, 1) width 2.8 at 546 y = 2 * x - 2 ;
    text id 95 start 937.5s for 2.0s at (4.0, 20.0) ''[color=#34D399]• $b = -2 \implies y = 2x - 2$[/color]'' ;

    draw 2dfunc id 548 start 952.0s for 1.4s color (56, 189, 248, 1) width 2.8 at 546 y = 2 * x + 1 ;
    text id 96 start 959.0s for 2.0s at (4.0, 32.0) ''[color=#38BDF8]• $b = +1 \implies y = 2x + 1$[/color]'' ;

    draw 2dfunc id 549 start 968.0s for 1.4s color (251, 191, 36, 1) width 2.8 at 546 y = 2 * x + 3 ;
    text id 97 start 974.0s for 2.0s at (4.0, 44.0) ''[color=#FBBF24]• $b = +3 \implies y = 2x + 3$[/color]'' ;

    text id 98 start 980.8s for 2.4s at (4.0, 58.0) ''[bold][color=#F8FAFC]Observation : droites parallèles ![/color][/bold]'' ;
    text id 99 start 988.0s for 2.4s at (4.0, 70.0) ''[color=#CBD5E1]Même coefficient directeur $a = 2$[/color]'' ;
    text id 100 start 995.0s for 2.0s at (4.0, 80.0) ''[color=#CBD5E1]$\implies$ même direction (glissement vertical)[/color]'' ;

    erase id 2009 start 999.0s ;

    # =========================================================================
    # SCENE 10 : Variation de a — Pente & Sens de variation (999.0s -> 1106.95s)
    # =========================================================================
    text id 101 start 999.2s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]10. Influence de a : pente et sens de variation[/color][/bold]'' ;
    draw line id 550 start 1001.1s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw 2drep id 551 start 1002.0s for 1.5s at (133.0, 55.0) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-4, 4] ;
    draw circle id 552 start 1003.8s for 0.6s color (251, 191, 36, 1) width 2.2 fillcolor (251, 191, 36, 0.25) radius 1.2 at (133.0, 71.0) ;

    draw 2dfunc id 553 start 1010.0s for 1.2s color (52, 211, 153, 1) width 2.8 at 551 y = 2 * x - 2 ;
    text id 102 start 1011.5s for 1.0s at (4.0, 19.0) ''[color=#34D399]• $a = 2 \implies y = 2x - 2$[/color]'' ;

    draw 2dfunc id 554 start 1016.0s for 1.2s color (56, 189, 248, 1) width 2.5 at 551 y = 3 * x - 2 ;
    draw 2dfunc id 555 start 1026.2s for 1.2s color (56, 189, 248, 0.85) width 2.2 at 551 y = 4 * x - 2 ;
    text id 103 start 1028.0s for 1.8s at (4.0, 28.0) ''[color=#38BDF8]• $a = 3, 4$ : pente plus forte[/color]'' ;

    draw 2dfunc id 556 start 1039.5s for 1.2s color (251, 191, 36, 1) width 2.8 at 551 y = -2 ;
    text id 104 start 1043.0s for 1.8s at (4.0, 37.0) ''[color=#FBBF24]• $a = 0 \implies y = -2$ (constante)[/color]'' ;

    draw 2dfunc id 557 start 1054.5s for 1.2s color (248, 113, 113, 1) width 2.8 at 551 y = -x - 2 ;
    draw 2dfunc id 558 start 1061.0s for 1.2s color (248, 113, 113, 0.85) width 2.4 at 551 y = -2 * x - 2 ;
    text id 105 start 1063.0s for 1.8s at (4.0, 46.0) ''[color=#F87171]• $a = -1, -2, -3$ : la droite descend[/color]'' ;

    text id 106 start 1074.0s for 2.6s at (4.0, 58.0) ''[bold][color=#F87171]• Si $a < 0 \implies f$ est décroissante[/color][/bold]'' ;
    text id 107 start 1087.0s for 2.6s at (4.0, 69.0) ''[bold][color=#34D399]• Si $a > 0 \implies f$ est croissante[/color][/bold]'' ;
    text id 108 start 1096.0s for 2.2s at (4.0, 80.0) ''[bold][color=#FBBF24]• Si $a = 0 \implies f$ est constante[/color][/bold]'' ;

    erase id 2010 start 1106.95s ;

    # =========================================================================
    # SCENE 11 : Propriété des accroissements & Synthèse (1106.95s -> 1218.5s)
    # =========================================================================
    text id 109 start 1107.1s for 1.8s at (4.0, 6.5) ''[bold][color=#38BDF8]11. Propriété des accroissements & Synthèse[/color][/bold]'' ;
    draw line id 559 start 1109.1s color (56, 189, 248, 0.75) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 110 start 1110.5s for 2.2s at (4.0, 18.5) ''[bold][color=#FBBF24]Propriété des accroissements :[/color][/bold]'' ;
    text id 111 start 1127.0s for 2.4s at (4.0, 25.5) ''[color=#F8FAFC]$A(x_A ; y_A)$ et $B(x_B ; y_B)$ sur $(d)$ ($x_B \neq x_A$)[/color]'' ;

    draw 2drep id 560 start 1141.8s for 1.2s at (133.0, 44.0) color (248, 250, 252, 0.95) width 1.5 scale = 5.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 5] y_range = [-1, 5] ;
    draw 2dfunc id 561 start 1143.5s for 1.2s color (56, 189, 248, 1) width 3.0 at 560 y = (2 / 3) * x + (1 / 3) ;
    draw circle id 562 start 1145.0s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.25) radius 1.2 at (138.0, 39.0) ;
    text id 112 start 1145.3s for 1.0s at (6.0, 32.5) ''[color=#34D399]Point $A(x_A ; y_A)$ sur la droite[/color]'' ;
    draw circle id 563 start 1145.6s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.25) radius 1.2 at (153.0, 29.0) ;
    text id 113 start 1145.9s for 1.0s at (6.0, 39.0) ''[color=#34D399]Point $B(x_B ; y_B)$ sur la droite[/color]'' ;
    draw arrow id 564 start 1146.3s for 0.7s color (52, 211, 153, 1) width 2.6 at [(153.0, 39.0), (153.0, 29.0)] ;
    text id 114 start 1147.3s for 1.0s at (6.0, 45.5) ''[color=#38BDF8]Accroissement vertical : $y_B - y_A$[/color]'' ;
    draw arrow id 565 start 1147.8s for 0.8s color (251, 191, 36, 1) width 2.6 at [(138.0, 39.0), (153.0, 39.0)] ;
    text id 115 start 1148.8s for 1.0s at (6.0, 52.0) ''[color=#FBBF24]Accroissement horizontal : $x_B - x_A$[/color]'' ;

    text id 116 start 1151.6s for 2.6s at (6.0, 60.0) ''[bold][color=#34D399]$$a = \frac{y_B - y_A}{x_B - x_A}$$[/color][/bold]'' ;

    text id 117 start 1188.0s for 2.0s at (4.0, 71.0) ''[bold][color=#38BDF8]Synthèse — 4 réflexes clés :[/color][/bold]'' ;
    text id 118 start 1191.0s for 2.2s at (5.5, 77.0) ''[color=#F8FAFC]1) $f(x)=ax+b$ (linéaire si $b=0$, constante si $a=0$)[/color]'' ;
    text id 119 start 1197.0s for 2.2s at (5.5, 83.0) ''[color=#CBD5E1]2) Représentation = droite d'équation $y = ax + b$[/color]'' ;
    text id 120 start 1201.5s for 2.2s at (5.5, 89.0) ''[color=#FBBF24]3) $b$ = ordonnée en $0$ ; $a$ = pente et sens de variation[/color]'' ;
    text id 121 start 1206.0s for 2.2s at (5.5, 95.0) ''[color=#34D399]4) Accroissements : $a = \frac{y_B - y_A}{x_B - x_A}$[/color]'' ;

}
