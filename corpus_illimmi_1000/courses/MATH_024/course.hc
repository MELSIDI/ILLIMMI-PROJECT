course "Généralités sur les fonctions et lecture graphique" id 24000 idgap 500 for 871.0s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION & LECTURE GRAPHIQUE (0.0s -> 155.0s)
    # =========================================================================

    # En-tête de scène
    text id 1 start 0.5s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]GÉNÉRALITÉS SUR LES FONCTIONS[/bold][/color] — [color=#F8FAFC]Ensemble de définition & Lecture graphique[/color]'' ;
    draw line id 501 start 2.7s for 0.8s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Colonne de gauche : Définition pédagogique
    text id 2 start 4.0s for 2.5s at (4, 22) ''[color=#FBBF24][bold]1. Qu'est-ce que l'ensemble de définition ?[/bold][/color]'' ;
    text id 3 start 8.0s for 3.5s at (4, 32) ''[color=#F8FAFC]L'ensemble de définition [color=#38BDF8]$\mathbf{D_f}$[/color] est l'ensemble de tous les [color=#FBBF24]antécédents $x$[/color][/color]'' ;
    text id 4 start 13.0s for 3.5s at (4, 42) ''[color=#F8FAFC]pour lesquels la fonction [color=#38BDF8]$f(x)$[/color] existe et peut être calculée.[/color]'' ;
    text id 5 start 28.0s for 3.0s at (4, 54) ''[color=#94A3B8]Machine mathématique :[/color] [color=#FBBF24]$x$ (entrée)[/color] [color=#38BDF8]$\mathbf{\longrightarrow f(x) = y}$ (sortie)[/color]'' ;
    text id 6 start 46.0s for 3.0s at (4, 66) ''[color=#34D399][bold]Exemple graphique :[/bold][/color] [color=#F8FAFC]Déterminer [color=#38BDF8]$\mathbf{D_f}$[/color] à partir de la courbe $\mathcal{C}_f$[/color]'' ;
    text id 7 start 78.0s for 3.0s at (4, 78) ''[color=#FBBF24][bold]Règle d'or :[/bold][/color] [color=#F8FAFC]On lit l'étendue uniquement sur [color=#FBBF24]l'axe des abscisses[/color] ($x$).[/color]'' ;

    # Colonne de droite : Repère orthogonal et tracé de la fonction 2dfunc
    # Origine at (133, 52), scale = 4.0, x_range = [-5, 8] -> bbox X: [113, 165], Y: [32, 64]
    draw 2drep id 502 start 54.5s for 1.2s at (133, 52) color (248, 250, 252, 0.95) width 1.5 scale = 4.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 8] y_range = [-3, 5] ;
    draw 2dfunc id 503 start 59.5s for 2.0s color (56, 189, 248, 1) width 3.0 at 502 y = 0.5*x + 1.5*sin(x) ;
    text id 9 start 62.0s for 1.0s at (156, 26) ''[color=#38BDF8]$\mathcal{C}_f$[/color]'' ;

    # Pointillés de projection vers l'axe des abscisses
    draw line id 504 start 86.0s for 0.8s color (251, 191, 36, 0.9) width 1.5 at [(117.0, 55.5), (117.0, 52.0)] ;
    draw line id 505 start 87.5s for 0.8s color (251, 191, 36, 0.9) width 1.5 at [(161.0, 34.1), (161.0, 52.0)] ;

    # Intervalle vert sur l'axe des abscisses entre x = -4 (117) et x = 7 (161)
    draw line id 506 start 91.0s for 1.5s color (52, 211, 153, 1) width 4.0 at [(117.0, 52.0), (161.0, 52.0)] ;
    draw path id 507 start 93.0s for 0.6s color (52, 211, 153, 1) width 2.5 at [(119.0, 49.5), (117.0, 49.5), (117.0, 54.5), (119.0, 54.5)] ;
    draw path id 508 start 94.0s for 0.6s color (52, 211, 153, 1) width 2.5 at [(159.0, 49.5), (161.0, 49.5), (161.0, 54.5), (159.0, 54.5)] ;

    # Bornes sous le repère (hors de la bbox [113, 32, 165, 64])
    text id 10 start 95.0s for 0.6s at (114, 68) ''[color=#52D399]$\mathbf{[-4}$[/color]'' ;
    text id 11 start 96.0s for 0.6s at (158, 68) ''[color=#52D399]$\mathbf{7]}$[/color]'' ;

    # Conclusion de la scène 1
    text id 8 start 134.4s for 3.0s at (4, 90) ''[color=#34D399][bold]Conclusion :[/bold][/color] [color=#38BDF8]$\mathbf{D_f = [-4 \;; 7]}$[/color] [color=#94A3B8](crochets fermés inclus)[/color]'' ;

    # Transition
    erase id 2001 start 155.0s ;

    # =========================================================================
    # SCÈNE 2 : LES CONDITIONS D'EXISTENCE (156.0s -> 263.0s)
    # =========================================================================

    text id 12 start 156.0s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]LES CONDITIONS D'EXISTENCE[/bold][/color] — [color=#F8FAFC]Les deux opérations interdites au Lycée[/color]'' ;
    draw line id 509 start 158.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 13 start 160.7s for 2.5s at (4, 22) ''[color=#FBBF24][bold]2. Exercice type :[/bold][/color] [color=#F8FAFC]Déterminer l'ensemble de définition des fonctions suivantes :[/color]'' ;
    text id 14 start 167.4s for 3.0s at (8, 32) ''[color=#38BDF8]$\mathbf{f(x) = \frac{1}{x^2 - 9}}$[/color]    [color=#F8FAFC]|[/color]    [color=#34D399]$\mathbf{g(x) = 2x^2 - x}$[/color]    [color=#F8FAFC]|[/color]    [color=#F87171]$\mathbf{h(x) = \sqrt{3 - 2x}}$[/color]'' ;
    text id 15 start 195.0s for 3.0s at (4, 42) ''[color=#F8FAFC]Une fonction peut ne pas exister à cause d'[color=#F87171][bold]opérations mathématiques interdites[/bold][/color] ![/color]'' ;

    # Encadré Cas 1 : Le quotient
    draw polygone id 510 start 217.6s for 1.0s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.12) at [(6, 48), (86, 48), (86, 92), (6, 92)] ;
    text id 16 start 221.0s for 2.0s at (10, 54) ''[color=#FBBF24][bold]CAS 1 : LE QUOTIENT (Fraction)[/bold][/color]'' ;
    text id 17 start 224.0s for 2.0s at (10, 64) ''[color=#F8FAFC]Interdit : [color=#F87171][bold]Diviser par zéro[/bold][/color] $\mathbf{\left(\frac{A}{0}\right)}$[/color]'' ;
    text id 18 start 228.0s for 2.0s at (10, 74) ''[color=#38BDF8][bold]Condition d'existence :[/bold][/color]'' ;
    text id 19 start 231.0s for 2.0s at (14, 84) ''[color=#38BDF8]$\mathbf{\text{Dénominateur} \neq 0}$[/color]'' ;

    # Encadré Cas 2 : La racine carrée
    draw polygone id 511 start 241.9s for 1.0s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.12) at [(92, 48), (172, 48), (172, 92), (92, 92)] ;
    text id 20 start 244.0s for 2.0s at (96, 54) ''[color=#38BDF8][bold]CAS 2 : LA RACINE CARRÉE[/bold][/color]'' ;
    text id 21 start 248.0s for 2.0s at (96, 64) ''[color=#F8FAFC]Interdit : [color=#F87171][bold]Nombre négatif sous le radical[/bold][/color][/color]'' ;
    text id 22 start 252.0s for 2.0s at (96, 74) ''[color=#34D399][bold]Condition d'existence :[/bold][/color]'' ;
    text id 23 start 256.0s for 2.0s at (100, 84) ''[color=#34D399]$\mathbf{\text{Radicande} \ge 0}$[/color]'' ;

    # Transition
    erase id 2002 start 263.0s ;

    # =========================================================================
    # SCÈNE 3 : FONCTION F(X) = 1/(X^2 - 9) (264.0s -> 436.0s)
    # =========================================================================

    text id 24 start 264.0s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]EXERCICE A[/bold][/color] — [color=#F8FAFC]Fonction rationnelle : Dénominateur non nul[/color]'' ;
    draw line id 512 start 266.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 25 start 267.0s for 2.5s at (4, 22) ''[color=#38BDF8][bold]Fonction étudiée :[/bold] $\mathbf{f(x) = \frac{1}{x^2 - 9}}$[/color]'' ;
    text id 26 start 279.4s for 3.0s at (4, 33) ''[color=#F8FAFC]$f(x)$ existe [color=#FBBF24][bold]si et seulement si[/bold][/color] :[/color]'' ;
    text id 27 start 284.0s for 2.5s at (8, 43) ''[color=#38BDF8]$\mathbf{x^2 - 9 \neq 0}$[/color] [color=#94A3B8](tout le dénominateur !)[/color]'' ;

    # Encadré piège classique
    draw polygone id 513 start 305.0s for 0.8s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.12) at [(4, 51), (86, 51), (86, 73), (4, 73)] ;
    text id 28 start 306.5s for 2.5s at (6, 57) ''[color=#F87171][bold]Piège classique :[/bold] Ne PAS écrire $x \neq 0$ ![/color]'' ;
    text id 29 start 315.6s for 3.0s at (6, 67) ''[color=#F8FAFC]Si $x = 0$ : $0^2 - 9 = -9 \neq 0 \implies f(0) = -\frac{1}{9}$ (valide !)[/color]'' ;

    # Résolution
    text id 30 start 346.5s for 3.0s at (4, 80) ''[color=#FBBF24][bold]Recherche des valeurs interdites :[/bold] Résolvons $x^2 - 9 = 0$[/color]'' ;
    text id 31 start 352.0s for 3.5s at (8, 91) ''[color=#F8FAFC]$x^2 = 9 \iff \mathbf{x = 3}$ ou $\mathbf{x = -3}$[/color] [color=#F87171](ne pas oublier $-3$ !)[/color]'' ;

    # Colonne droite : Axe gradué des réels et exclusion
    draw arrow id 514 start 376.7s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(94, 38), (172, 38)] ;
    text id 32 start 378.0s for 0.8s at (168, 33) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 515 start 380.0s for 0.5s color (248, 113, 113, 1) width 2.0 at [(114, 34), (114, 42)] ;
    text id 33 start 381.0s for 0.8s at (112, 47) ''[color=#F87171]$\mathbf{-3}$[/color]'' ;
    draw path id 516 start 382.5s for 0.5s color (248, 113, 113, 1) width 2.0 at [(112, 36), (116, 40)] ;
    draw path id 517 start 383.5s for 0.5s color (248, 113, 113, 1) width 2.0 at [(112, 40), (116, 36)] ;

    draw line id 518 start 385.0s for 0.5s color (248, 113, 113, 1) width 2.0 at [(150, 34), (150, 42)] ;
    text id 34 start 386.0s for 0.8s at (149, 47) ''[color=#F87171]$\mathbf{3}$[/color]'' ;
    draw path id 519 start 387.5s for 0.5s color (248, 113, 113, 1) width 2.0 at [(148, 36), (152, 40)] ;
    draw path id 520 start 388.5s for 0.5s color (248, 113, 113, 1) width 2.0 at [(148, 40), (152, 36)] ;

    draw line id 521 start 391.0s for 0.8s color (56, 189, 248, 1) width 4.0 at [(94, 38), (113, 38)] ;
    draw line id 522 start 392.5s for 0.8s color (56, 189, 248, 1) width 4.0 at [(115, 38), (149, 38)] ;
    draw line id 523 start 394.0s for 0.8s color (56, 189, 248, 1) width 4.0 at [(151, 38), (170, 38)] ;

    # Conclusion encadrée
    draw polygone id 524 start 404.3s for 1.0s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(94, 58), (172, 58), (172, 92), (94, 92)] ;
    text id 35 start 406.0s for 2.0s at (98, 64) ''[color=#34D399][bold]ENSEMBLE DE DÉFINITION :[/bold][/color]'' ;
    text id 36 start 409.0s for 3.0s at (100, 75) ''[color=#38BDF8]$\mathbf{D_f = \mathbb{R} \setminus \{-3 \;; 3\}}$[/color]'' ;
    text id 37 start 420.0s for 3.5s at (96, 85) ''[color=#F8FAFC]$]-\infty \;; -3[ \; \cup \; ]-3 \;; 3[ \; \cup \; ]3 \;; +\infty[$[/color]'' ;

    # Transition
    erase id 2003 start 436.5s ;

    # =========================================================================
    # SCÈNE 4 : FONCTION G(X) = 2X^2 - X (437.5s -> 521.0s)
    # =========================================================================

    text id 38 start 437.5s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]EXERCICE B[/bold][/color] — [color=#F8FAFC]Fonction polynomiale : Absence de contrainte[/color]'' ;
    draw line id 525 start 439.8s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 39 start 441.7s for 2.5s at (4, 24) ''[color=#34D399][bold]Fonction étudiée :[/bold] $\mathbf{g(x) = 2x^2 - x}$[/color]'' ;
    text id 40 start 452.0s for 2.5s at (4, 38) ''[color=#F8FAFC]Posons-nous les deux questions méthodiques :[/color]'' ;
    text id 41 start 462.0s for 2.0s at (8, 50) ''[color=#F8FAFC]1. Présence d'un dénominateur avec $x$ ? [color=#34D399][bold]NON[/bold][/color][/color]'' ;
    text id 42 start 474.0s for 2.0s at (8, 62) ''[color=#F8FAFC]2. Présence d'une racine carrée ? [color=#34D399][bold]NON[/bold][/color][/color]'' ;
    text id 43 start 488.0s for 2.5s at (4, 76) ''[color=#FBBF24][bold]Constat :[/bold] Aucune opération interdite n'est possible.[/color]'' ;

    # Encadré de rédaction modèle sur copie
    draw polygone id 526 start 495.0s for 1.0s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.12) at [(94, 24), (172, 24), (172, 88), (94, 88)] ;
    text id 44 start 497.0s for 2.0s at (98, 32) ''[color=#38BDF8][bold]RÉDACTION MODÈLE SUR COPIE :[/bold][/color]'' ;
    text id 45 start 501.0s for 3.0s at (98, 44) ''[color=#F8FAFC]Pour tout réel $x$, l'expression $2x^2 - x$[/color]'' ;
    text id 46 start 506.0s for 2.5s at (98, 54) ''[color=#F8FAFC]est parfaitement définie dans $\mathbb{R}$.[/color]'' ;
    text id 47 start 511.0s for 2.0s at (98, 68) ''[color=#34D399][bold]Conclusion :[/bold][/color]'' ;
    text id 48 start 514.0s for 2.5s at (104, 78) ''[color=#34D399]$\mathbf{D_g = \mathbb{R} = ]-\infty \;; +\infty[}$[/color]'' ;

    # Transition
    erase id 2004 start 521.5s ;

    # =========================================================================
    # SCÈNE 5 : FONCTION H(X) = SQRT(3 - 2X) (522.5s -> 704.5s)
    # =========================================================================

    text id 49 start 522.5s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]EXERCICE C[/bold][/color] — [color=#F8FAFC]Racine carrée & Inéquation du premier degré[/color]'' ;
    draw line id 527 start 524.8s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 50 start 526.0s for 2.5s at (4, 22) ''[color=#F87171][bold]Fonction étudiée :[/bold] $\mathbf{h(x) = \sqrt{3 - 2x}}$[/color]'' ;
    text id 51 start 539.3s for 3.0s at (4, 33) ''[color=#F8FAFC]$h(x)$ existe [color=#FBBF24][bold]si et seulement si[/bold][/color] :[/color]'' ;
    text id 52 start 544.5s for 2.5s at (8, 42) ''[color=#38BDF8]$\mathbf{3 - 2x \ge 0}$[/color] [color=#94A3B8](tout le radicande $\ge 0$ !)[/color]'' ;

    text id 53 start 583.1s for 3.0s at (4, 54) ''[color=#F8FAFC]Isolons le terme en $x$ : $\mathbf{-2x \ge -3}$[/color]'' ;
    text id 54 start 598.3s for 3.0s at (4, 66) ''[color=#F87171][bold]Règle d'or :[/bold] Division par [color=#F87171]$-2 < 0$[/color] ![/color]'' ;
    text id 55 start 605.0s for 2.5s at (4, 76) ''[color=#F87171]On [bold]change le sens[/bold] de l'inégalité : $\mathbf{\ge}$ devient $\mathbf{\le}$[/color]'' ;
    text id 56 start 625.0s for 3.0s at (8, 88) ''[color=#34D399]$\mathbf{x \le \frac{-3}{-2} \iff x \le \frac{3}{2}}$[/color] [color=#94A3B8]$(x \le 1{,}5)$[/color]'' ;

    # Colonne droite : Axe gradué et hachurage
    draw arrow id 528 start 638.5s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(94, 34), (172, 34)] ;
    text id 57 start 640.0s for 0.8s at (168, 29) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 529 start 642.0s for 0.5s color (251, 191, 36, 1) width 2.5 at [(138, 30), (138, 38)] ;
    text id 58 start 643.0s for 0.8s at (136, 43) ''[color=#FBBF24]$\mathbf{\frac{3}{2}}$[/color]'' ;

    draw line id 530 start 647.5s for 1.2s color (52, 211, 153, 1) width 4.0 at [(94, 34), (138, 34)] ;
    draw path id 531 start 650.0s for 0.6s color (52, 211, 153, 1) width 2.5 at [(135, 30), (138, 30), (138, 38), (135, 38)] ;

    # Conclusion encadrée
    draw polygone id 532 start 690.5s for 1.0s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(94, 56), (172, 56), (172, 92), (94, 92)] ;
    text id 59 start 692.0s for 2.0s at (98, 63) ''[color=#34D399][bold]ENSEMBLE DE DÉFINITION :[/bold][/color]'' ;
    text id 60 start 694.5s for 3.0s at (104, 74) ''[color=#38BDF8]$\mathbf{D_h = \left]-\infty \;; \frac{3}{2}\right]}$[/color]'' ;
    text id 61 start 698.0s for 2.5s at (98, 84) ''[color=#94A3B8]Crochet fermé en $\frac{3}{2}$ car $\sqrt{0} = 0$ existe.[/color]'' ;

    # Transition
    erase id 2005 start 705.5s ;

    # =========================================================================
    # SCÈNE 6 : APPROFONDISSEMENT — F(X) = SQRT(X^2 + 1) (706.3s -> 811.5s)
    # =========================================================================

    text id 62 start 706.3s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]APPROFONDISSEMENT[/bold][/color] — [color=#F8FAFC]Le piège déjoué : Positivité et prise de recul[/color]'' ;
    draw line id 533 start 708.5s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 63 start 710.0s for 2.0s at (4, 22) ''[color=#FBBF24][bold]3. Cas subtil : Deux cas PEUVENT poser problème[/bold][/color]'' ;
    text id 64 start 720.3s for 3.0s at (4, 32) ''[color=#38BDF8]Déterminer le domaine de : $\mathbf{f(x) = \sqrt{x^2 + 1}}$[/color]'' ;
    text id 65 start 735.0s for 2.5s at (4, 43) ''[color=#F8FAFC]Condition d'existence : $\mathbf{x^2 + 1 \ge 0}$[/color]'' ;

    text id 66 start 754.3s for 3.0s at (4, 55) ''[color=#34D399][bold]Propriété clé :[/bold] Pour tout réel $x$, $\mathbf{x^2 \ge 0}$[/color]'' ;
    text id 67 start 762.0s for 2.5s at (8, 65) ''[color=#F8FAFC]Un carré est toujours positif ou nul ![/color]'' ;
    text id 68 start 772.0s for 3.0s at (4, 77) ''[color=#38BDF8]En ajoutant 1 : $\mathbf{x^2 + 1 \ge 1 > 0}$ pour tout $x \in \mathbb{R}$.[/color]'' ;
    text id 69 start 785.0s for 2.5s at (4, 88) ''[color=#F8FAFC]La condition est [color=#34D399][bold]toujours vérifiée[/bold][/color] sans exception.[/color]'' ;

    # Colonne droite : Visualisation graphique de la parabole x^2 + 1
    # Origine at (133, 52), scale = 4.5, x_range = [-2.5, 2.5] -> X in [121.75, 144.25], Y in [29.5, 54.25]
    draw 2drep id 534 start 740.0s for 1.2s at (133, 52) color (248, 250, 252, 0.95) width 1.5 scale = 4.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2.5, 2.5] y_range = [-0.5, 4.5] ;
    draw 2dfunc id 535 start 744.0s for 2.0s color (56, 189, 248, 1) width 3.0 at 534 y = x^2 + 1 ;
    text id 70 start 748.0s for 1.2s at (148, 26) ''[color=#38BDF8]$y = x^2 + 1$[/color]'' ;
    draw circle id 536 start 752.0s for 0.8s color (251, 191, 36, 1) width 2.0 fillcolor (251, 191, 36, 0.3) radius 1.5 at (133, 47.5) ;
    text id 71 start 753.5s for 0.8s at (122, 60) ''[color=#FBBF24]$\mathbf{y \ge 1 > 0}$[/color]'' ;

    # Conclusion encadrée
    draw polygone id 537 start 790.0s for 1.0s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(94, 73), (172, 73), (172, 93), (94, 93)] ;
    text id 72 start 792.0s for 2.0s at (98, 79) ''[color=#34D399][bold]CONCLUSION :[/bold] $\mathbf{D_f = \mathbb{R}}$[/color]'' ;
    text id 73 start 796.0s for 2.5s at (96, 88) ''[color=#94A3B8]Une racine carrée n'impose pas toujours de restriction ![/color]'' ;

    # Transition
    erase id 2006 start 812.5s ;

    # =========================================================================
    # SCÈNE 7 : SYNTHÈSE MÉTHODIQUE & ARBRE DE DÉCISION (813.3s -> 871.0s)
    # =========================================================================

    text id 74 start 813.3s for 2.0s at (4, 7.5) ''[color=#38BDF8][bold]SYNTHÈSE MÉTHODIQUE[/bold][/color] — [color=#F8FAFC]L'Arbre de Décision pour l'Examen[/color]'' ;
    draw line id 538 start 815.5s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    # Boîte racine de l'arbre
    draw polygone id 539 start 817.0s for 0.8s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.15) at [(48, 17), (130, 17), (130, 27), (48, 27)] ;
    text id 75 start 818.5s for 2.0s at (52, 23) ''[color=#38BDF8][bold]EXPRESSION DE LA FONCTION : $f(x)$[/bold][/color]'' ;

    # 3 Flèches d'orientation
    draw arrow id 540 start 821.0s for 0.8s color (251, 191, 36, 1) width 2.0 at [(62, 27), (32, 36)] ;
    draw arrow id 541 start 822.5s for 0.8s color (52, 211, 153, 1) width 2.0 at [(89, 27), (89, 36)] ;
    draw arrow id 542 start 824.0s for 0.8s color (248, 113, 113, 1) width 2.0 at [(116, 27), (146, 36)] ;

    # Branche 1 : Quotient
    draw polygone id 543 start 826.0s for 0.8s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.12) at [(6, 36), (58, 36), (58, 75), (6, 75)] ;
    text id 76 start 827.5s for 1.5s at (8, 42) ''[color=#FBBF24][bold]QUOTIENT / FRACTION[/bold][/color]'' ;
    text id 77 start 830.0s for 1.5s at (8, 50) ''[color=#F8FAFC]Dénominateur $\neq 0$[/color]'' ;
    text id 78 start 832.5s for 1.5s at (8, 58) ''[color=#F8FAFC]Exclure valeurs interdites[/color]'' ;
    text id 79 start 835.0s for 2.0s at (8, 68) ''[color=#38BDF8]$\mathbf{D_f = \mathbb{R} \setminus \{x_1 \;; x_2\}}$[/color]'' ;

    # Branche 2 : Sans contrainte
    draw polygone id 544 start 838.0s for 0.8s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.12) at [(63, 36), (115, 36), (115, 75), (63, 75)] ;
    text id 80 start 839.5s for 1.5s at (65, 42) ''[color=#34D399][bold]SANS CONTRAINTE[/bold][/color]'' ;
    text id 81 start 842.0s for 1.5s at (65, 50) ''[color=#F8FAFC]Ni fraction ni racine[/color]'' ;
    text id 82 start 844.5s for 1.5s at (65, 58) ''[color=#F8FAFC]Calcul toujours possible[/color]'' ;
    text id 83 start 847.0s for 2.0s at (76, 68) ''[color=#34D399]$\mathbf{D_f = \mathbb{R}}$[/color]'' ;

    # Branche 3 : Racine carrée
    draw polygone id 545 start 850.0s for 0.8s color (248, 113, 113, 0.9) width 1.5 fillcolor (248, 113, 113, 0.12) at [(120, 36), (172, 36), (172, 75), (120, 75)] ;
    text id 84 start 851.5s for 1.5s at (123, 42) ''[color=#F87171][bold]RACINE CARRÉE[/bold][/color]'' ;
    text id 85 start 854.0s for 1.5s at (123, 50) ''[color=#F8FAFC]Radicande $\ge 0$[/color]'' ;
    text id 86 start 856.5s for 1.5s at (123, 58) ''[color=#F8FAFC]Inéquation ($<0 \implies \le$)[/color]'' ;
    text id 87 start 859.0s for 2.0s at (123, 68) ''[color=#38BDF8]$\mathbf{D_f = ]-\infty \;; a]}$[/color]'' ;

    # Bannière réflexe examen
    draw polygone id 546 start 862.0s for 0.8s color (192, 132, 252, 0.9) width 1.5 fillcolor (192, 132, 252, 0.15) at [(14, 80), (164, 80), (164, 94), (14, 94)] ;
    text id 88 start 863.5s for 3.0s at (18, 88) ''[color=#C084FC][bold]RÉFLEXE EXAMEN :[/bold] [color=#F8FAFC]Toujours poser la condition d'existence et rédiger clairement la justification ![/color][/color]'' ;

}
