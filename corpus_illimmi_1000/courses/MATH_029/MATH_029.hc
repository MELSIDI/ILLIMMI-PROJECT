course "Généralités sur les fonctions et lecture graphique" id 29 idgap 500 for 502s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : Introduction et Formulation du Problème (0.0s - 58.5s)
    # =========================================================================
    text id 1 start 0.2s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction & Énoncé du Problème[/color][/bold]'' ;
    draw line id 501 start 1.8s for 0.8s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 3.5s for 2.2s at (4.0, 19.0) ''[color=#F8FAFC]Résoudre graphiquement une équation et une inéquation[/color]'' ;
    text id 3 start 10.3s for 2.5s at (4.0, 27.0) ''[color=#94A3B8]Objectif Seconde : lecture graphique directe sans calcul[/color]'' ;

    text id 4 start 27.5s for 1.8s at (4.0, 36.0) ''[bold][color=#FBBF24]Deux fonctions du second degré données :[/color][/bold]'' ;
    draw polygone id 502 start 29.5s for 0.8s color (56, 189, 248, 0.4) fillcolor (30, 41, 59, 0.4) width 1.5 at [(98, 22), (170, 22), (170, 86), (98, 86)] ;
    text id 5 start 30.5s for 1.5s at (102.0, 28.0) ''[bold][color=#38BDF8]MÉTHODE DE RÉSOLUTION GRAPHIQUE[/color][/bold]'' ;
    text id 6 start 32.2s for 1.2s at (102.0, 38.0) ''[color=#34D399]$\bullet$[/color] [color=#F8FAFC]Équation :[/color] [color=#FBBF24]$f(x) = g(x)$[/color]'' ;

    text id 7 start 34.8s for 2.0s at (8.0, 44.0) ''[color=#34D399]$\mathbf{f(x) = x^2 + 2}$[/color]  [color=#94A3B8](parabole tournée vers le haut)[/color]'' ;
    text id 8 start 37.0s for 1.5s at (106.0, 45.0) ''[color=#94A3B8]$\rightarrow$ Abscisses des points d'intersection[/color]'' ;
    text id 9 start 38.8s for 1.2s at (102.0, 56.0) ''[color=#34D399]$\bullet$[/color] [color=#F8FAFC]Inéquation :[/color] [color=#FBBF24]$f(x) < g(x)$[/color]'' ;

    text id 10 start 40.8s for 2.2s at (8.0, 52.0) ''[color=#38BDF8]$\mathbf{g(x) = -x^2 + 3x + 2}$[/color]  [color=#94A3B8](parabole tournée vers le bas)[/color]'' ;
    text id 11 start 43.2s for 1.5s at (106.0, 63.0) ''[color=#94A3B8]$\rightarrow$ Courbe de $f$ sous la courbe de $g$[/color]'' ;
    text id 12 start 45.0s for 1.5s at (102.0, 74.0) ''[color=#C084FC]$\bullet$ Solutions :[/color] [color=#F8FAFC]intervalles de réels[/color]'' ;

    text id 13 start 47.6s for 1.5s at (4.0, 62.0) ''[bold][color=#F8FAFC]Deux questions fondamentales à traiter :[/color][/bold]'' ;
    text id 14 start 51.0s for 1.8s at (8.0, 70.0) ''[color=#FBBF24]Étape 1 :[/color] Résoudre graphiquement [color=#38BDF8]$\mathbf{f(x) = g(x)}$[/color]'' ;
    text id 15 start 55.2s for 1.8s at (8.0, 78.0) ''[color=#FBBF24]Étape 2 :[/color] Résoudre graphiquement [color=#F87171]$\mathbf{f(x) < g(x)}$[/color]'' ;

    erase id 2001 start 58.5s ;

    # =========================================================================
    # SCÈNE 2 : Principe Théorique : Sens Géométrique de f(x) = g(x) (59.0s - 198.0s)
    # =========================================================================
    text id 16 start 59.0s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Principe Théorique : Sens Géométrique de $f(x) = g(x)$[/color][/bold]'' ;
    draw line id 503 start 60.8s for 0.6s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 504 start 61.8s for 1.0s at (133, 56) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3.5, 3.5] y_range = [-2, 5] ;
    text id 17 start 64.5s for 2.0s at (4.0, 19.0) ''[bold][color=#FBBF24]Que signifie $f(x) = g(x)$ sur un graphique ?[/color][/bold]'' ;

    draw 2dfunc id 505 start 78.2s for 1.2s color (52, 211, 153, 1) width 2.5 at 504 y = 0.3*x^2 + 1 ;
    draw 2dfunc id 506 start 80.2s for 1.2s color (248, 113, 113, 1) width 2.5 at 504 y = 3 - 0.2*x^2 ;

    draw circle id 507 start 84.0s for 0.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (126.5, 56) ;
    draw line id 508 start 104.2s for 0.8s color (52, 211, 153, 0.8) width 1.5 at [(126.5, 56), (126.5, 47.55)] ;
    draw circle id 509 start 105.2s color (52, 211, 153, 1) fillcolor (52, 211, 153, 1) radius 1.0 at (126.5, 47.55) ;
    draw line id 510 start 107.5s for 0.8s color (52, 211, 153, 0.8) width 1.5 at [(126.5, 47.55), (133, 47.55)] ;
    text id 18 start 111.0s for 1.2s at (4.0, 26.0) ''[color=#34D399]$\bullet$ Image $f(x)$ sur l'axe $(Oy)$[/color]'' ;

    draw line id 511 start 118.5s for 0.8s color (248, 113, 113, 0.8) width 1.5 at [(126.5, 37.8), (133, 37.8)] ;
    text id 19 start 123.5s for 1.2s at (4.0, 33.0) ''[color=#F87171]$\bullet$ Image $g(x)$ sur l'axe $(Oy)$[/color]'' ;

    text id 20 start 127.5s for 2.2s at (4.0, 42.0) ''[color=#F87171]$\mathbf{f(x) \neq g(x)}$[/color] : deux hauteurs différentes !'' ;
    text id 21 start 140.0s for 2.0s at (4.0, 50.0) ''[color=#94A3B8]Ce $x$ au hasard n'est donc pas solution.[/color]'' ;

    draw circle id 512 start 158.5s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) radius 2.2 at (146, 41.7) ;
    draw circle id 513 start 159.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (146, 41.7) ;

    draw line id 514 start 171.0s for 0.8s color (251, 191, 36, 0.8) width 1.5 at [(146, 41.7), (133, 41.7)] ;
    draw line id 515 start 172.5s for 0.8s color (251, 191, 36, 0.8) width 1.5 at [(146, 41.7), (146, 56)] ;

    text id 22 start 182.8s for 1.5s at (4.0, 58.0) ''[bold][color=#34D399]Au point d'intersection :[/color][/bold]'' ;
    text id 23 start 184.8s for 2.0s at (4.0, 65.0) ''$\mathbf{f(x_{sol}) = g(x_{sol})}$ [color=#94A3B8](hauteurs confondues)[/color]'' ;

    draw polygone id 516 start 190.0s for 0.8s color (56, 189, 248, 0.6) fillcolor (30, 41, 59, 0.45) width 1.5 at [(4, 73), (88, 73), (88, 92), (4, 92)] ;
    text id 24 start 191.0s for 1.5s at (6.0, 77.0) ''[bold][color=#38BDF8]RÈGLE FONDAMENTALE D'EXAMEN[/color][/bold]'' ;
    text id 25 start 193.0s for 2.2s at (6.0, 85.0) ''[color=#FBBF24]$\mathbf{f(x) = g(x)}$[/color] [color=#F8FAFC]$\Longleftrightarrow$ [bold]Abscisses[/bold] des intersections[/color]'' ;

    erase id 2002 start 198.0s ;

    # =========================================================================
    # SCÈNE 3 : Résolution Graphique : Paraboles de f et g (198.5s - 305.5s)
    # =========================================================================
    text id 26 start 198.5s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Résolution de $f(x) = g(x)$ : Tracé des Paraboles[/color][/bold]'' ;
    draw line id 517 start 200.3s for 0.6s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 518 start 201.5s for 1.0s at (133, 76) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2.5, 3.5] y_range = [-1, 6.5] ;
    draw 2dfunc id 519 start 204.8s for 2.0s color (52, 211, 153, 1) width 2.5 at 518 y = x^2 + 2 ;
    draw 2dfunc id 520 start 209.0s for 2.0s color (56, 189, 248, 1) width 2.5 at 518 y = 2 + 3*x - x^2 ;

    text id 27 start 217.5s for 1.8s at (4.0, 19.0) ''[bold][color=#FBBF24]Recherche des points d'intersection :[/color][/bold]'' ;
    text id 28 start 220.0s for 2.0s at (4.0, 26.0) ''On observe [bold][color=#F8FAFC]2 points d'intersection[/color][/bold] entre $\mathcal{C}_f$ et $\mathcal{C}_g$.'' ;

    draw circle id 521 start 222.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (133, 62) ;
    draw circle id 522 start 226.0s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (143.5, 46.25) ;

    text id 29 start 229.0s for 1.8s at (4.0, 36.0) ''[bold][color=#38BDF8]1. Premier point $B$ (à droite) :[/color][/bold]'' ;
    text id 30 start 238.5s for 1.8s at (8.0, 43.0) ''Ordonnée commune : $y \approx 4{,}25$ [color=#94A3B8](hauteur)[/color]'' ;
    text id 31 start 246.0s for 2.0s at (8.0, 50.0) ''[color=#FBBF24]$\rightarrow$ Projection perpendiculaire sur $(Ox)$ :[/color]'' ;

    draw line id 523 start 254.8s for 1.0s color (251, 191, 36, 0.9) width 1.8 at [(143.5, 46.25), (143.5, 76)] ;
    draw circle id 524 start 256.0s color (56, 189, 248, 1) fillcolor (56, 189, 248, 1) radius 1.0 at (143.5, 76) ;

    text id 32 start 266.5s for 1.8s at (8.0, 57.0) ''Première solution lue : [bold][color=#38BDF8]$\mathbf{x_1 = 1{,}5}$[/color][/bold]'' ;
    text id 33 start 269.5s for 1.8s at (4.0, 66.0) ''[bold][color=#34D399]2. Second point $A$ (sur l'axe vertical) :[/color][/bold]'' ;
    text id 34 start 284.0s for 2.2s at (8.0, 73.0) ''Ordonnée $y = 2$. Situé sur l'axe $(Oy) \Rightarrow$ [bold][color=#34D399]$\mathbf{x_2 = 0}$[/color][/bold]'' ;

    text id 35 start 301.5s for 2.2s at (4.0, 83.0) ''[bold][color=#FBBF24]Conclusion :[/color][/bold] [color=#F8FAFC]$\mathbf{S = \{0 \;;\; 1{,}5\}}$[/color]'' ;

    erase id 2003 start 305.5s ;

    # =========================================================================
    # SCÈNE 4 : Piège Fréquent & Statut de la Lecture Graphique (306.0s - 342.5s)
    # =========================================================================
    text id 36 start 306.0s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Piège Fréquent & Statut de la Lecture Graphique[/color][/bold]'' ;
    draw line id 525 start 307.8s for 0.6s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 526 start 309.0s for 0.8s color (248, 113, 113, 0.6) fillcolor (30, 41, 59, 0.5) width 1.5 at [(4, 18), (86, 18), (86, 88), (4, 88)] ;
    text id 37 start 310.0s for 1.8s at (6.0, 24.0) ''[bold][color=#F87171]PIÈGE N°1 : ABSCISSE VS ORDONNÉE[/color][/bold]'' ;
    text id 38 start 312.2s for 2.2s at (6.0, 34.0) ''[color=#F87171]$\times$ ERREUR :[/color] [color=#F8FAFC]Donner l'ordonnée $y = 2$ ou $y \approx 4{,}25$[/color]'' ;
    text id 39 start 315.0s for 2.0s at (6.0, 42.0) ''[color=#94A3B8]Ce sont les images $f(x)$ et $g(x)$, pas la solution ![/color]'' ;
    text id 40 start 318.0s for 1.8s at (6.0, 52.0) ''[color=#34D399]$\checkmark$ BON RÉFLEXE :[/color] [bold][color=#FBBF24]L'inconnue est $x$ ![/color][/bold]'' ;
    text id 41 start 320.5s for 2.0s at (6.0, 60.0) ''[color=#F8FAFC]On projette toujours sur l'axe des [bold]abscisses[/bold] :[/color]'' ;
    text id 42 start 323.0s for 1.5s at (10.0, 68.0) ''$\mathbf{x = 0}$  [color=#94A3B8]et[/color]  $\mathbf{x = 1{,}5}$'' ;
    text id 43 start 325.5s for 1.8s at (6.0, 78.0) ''[color=#38BDF8]$\bullet$ Les solutions s'écrivent :[/color] [color=#FBBF24]$\mathbf{S = \{0 \;;\; 1{,}5\}}$[/color]'' ;

    draw polygone id 527 start 328.0s for 0.8s color (56, 189, 248, 0.6) fillcolor (30, 41, 59, 0.5) width 1.5 at [(96, 18), (173, 18), (173, 88), (96, 88)] ;
    text id 44 start 329.0s for 2.0s at (98.0, 24.0) ''[bold][color=#38BDF8]STATUT : VALEUR EXACTE OU APPROCHÉE ?[/color][/bold]'' ;
    text id 45 start 331.5s for 1.8s at (98.0, 34.0) ''[bold][color=#FBBF24]1. Cas de $x = 0$ (valeur exacte) :[/color][/bold]'' ;
    text id 46 start 334.0s for 1.5s at (101.0, 42.0) ''Le point est posé sur l'axe $(Oy)$, et :'' ;
    text id 47 start 336.0s for 1.8s at (101.0, 49.0) ''$f(0) = 0^2+2 = \mathbf{2}$  [color=#94A3B8]et[/color]  $g(0) = -0^2+0+2 = \mathbf{2}$'' ;
    text id 48 start 338.5s for 1.8s at (98.0, 60.0) ''[bold][color=#FBBF24]2. Cas de $x \approx 1{,}5$ (lecture graphique) :[/color][/bold]'' ;
    text id 49 start 340.6s at (101.0, 68.0) ''Lecture visuelle précise à l'œil nu.'' ;
    text id 50 start 341.5s at (101.0, 76.0) ''Vérification : $f(1{,}5) = 1{,}5^2+2 = \mathbf{4{,}25}$'' ;

    erase id 2004 start 342.5s ;

    # =========================================================================
    # SCÈNE 5 : Inéquation f(x) < g(x) : Courbe en Dessous (343.0s - 426.5s)
    # =========================================================================
    text id 51 start 343.0s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Inéquation $f(x) < g(x)$ : Interprétation Géométrique[/color][/bold]'' ;
    draw line id 528 start 344.8s for 0.6s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 529 start 345.8s for 0.8s at (133, 76) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2.5, 3.5] y_range = [-1, 6.5] ;
    draw 2dfunc id 530 start 347.0s for 1.5s color (52, 211, 153, 1) width 2.5 at 529 y = x^2 + 2 ;
    draw 2dfunc id 531 start 348.8s for 1.5s color (56, 189, 248, 1) width 2.5 at 529 y = 2 + 3*x - x^2 ;

    draw circle id 532 start 351.5s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (133, 62) ;
    draw circle id 533 start 352.0s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) radius 1.2 at (143.5, 46.25) ;

    text id 52 start 353.0s for 1.8s at (4.0, 19.0) ''[bold][color=#FBBF24]Rôle clé des solutions de l'équation :[/color][/bold]'' ;
    text id 53 start 361.5s for 2.0s at (4.0, 26.0) ''Les points d'intersection fournissent les [bold][color=#38BDF8]frontières[/color][/bold]'' ;
    text id 54 start 364.0s for 1.8s at (4.0, 33.0) ''de l'ensemble des solutions de l'inéquation !'' ;

    text id 55 start 376.0s for 2.0s at (4.0, 42.0) ''[bold][color=#F8FAFC]Traduction géométrique de $f(x) < g(x)$ :[/color][/bold]'' ;
    text id 56 start 382.0s for 2.5s at (4.0, 50.0) ''L'image de $f$ est [bold][color=#F87171]strictement en dessous[/color][/bold] de l'image de $g$.'' ;
    text id 57 start 392.0s for 2.5s at (4.0, 58.0) ''$\Longleftrightarrow$ La courbe [color=#34D399]$\mathcal{C}_f$[/color] est [bold][color=#FBBF24]en dessous[/color][/bold] de la courbe [color=#38BDF8]$\mathcal{C}_g$[/color].'' ;

    draw arrow id 534 start 398.2s for 1.0s color (251, 191, 36, 0.8) width 2.0 at [(115, 88), (155, 88)] ;

    text id 58 start 402.5s for 2.2s at (4.0, 68.0) ''[color=#F87171]1. Pour $x < 0$ :[/color] $\mathcal{C}_f$ est au-dessus de $\mathcal{C}_g$ [color=#F87171]$\rightarrow$ Non ![/color]'' ;

    draw line id 535 start 414.0s for 0.8s color (251, 191, 36, 0.7) width 1.5 at [(133, 24), (133, 86)] ;
    draw line id 536 start 415.0s for 0.8s color (251, 191, 36, 0.7) width 1.5 at [(143.5, 24), (143.5, 86)] ;
    text id 59 start 416.2s for 2.2s at (4.0, 76.0) ''[bold][color=#34D399]2. Pour $0 < x < 1{,}5$ :[/color][/bold] [color=#F8FAFC]$\mathcal{C}_f$ est [bold]en dessous[/bold] de $\mathcal{C}_g$ ![/color]'' ;
    text id 60 start 423.0s for 2.0s at (4.0, 84.0) ''[color=#F87171]3. Pour $x > 1{,}5$ :[/color] $\mathcal{C}_f$ repasse au-dessus [color=#F87171]$\rightarrow$ Non ![/color]'' ;

    erase id 2005 start 426.5s ;

    # =========================================================================
    # SCÈNE 6 : Zone Solution et Rigueur des Crochets d'Intervalles (427.0s - 502.0s)
    # =========================================================================
    text id 61 start 427.0s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Ensemble Solution & Rigueur des Crochets d'Intervalles[/color][/bold]'' ;
    draw line id 537 start 428.8s for 0.6s color (56, 189, 248, 0.8) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 538 start 429.8s for 0.8s at (133, 76) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2.5, 3.5] y_range = [-1, 6.5] ;
    draw 2dfunc id 539 start 431.0s for 1.2s color (52, 211, 153, 1) width 2.5 at 538 y = x^2 + 2 ;
    draw 2dfunc id 540 start 432.6s for 1.2s color (56, 189, 248, 1) width 2.5 at 538 y = 2 + 3*x - x^2 ;

    draw polygone id 541 start 434.5s for 1.0s color (192, 132, 252, 0.8) fillcolor (192, 132, 252, 0.22) width 1.5 at [(133, 62), (136.5, 53.25), (140, 48), (143.5, 46.25), (140, 55), (136.5, 60.25)] ;
    draw line id 542 start 436.0s for 0.8s color (248, 113, 113, 1) width 4.0 at [(133, 76), (143.5, 76)] ;

    text id 62 start 454.0s for 2.0s at (4.0, 19.0) ''[bold][color=#FBBF24]Pourquoi des crochets ouverts aux bornes ?[/color][/bold]'' ;
    text id 63 start 460.0s for 2.2s at (4.0, 28.0) ''[color=#F87171]$\bullet$ Inégalité stricte :[/color] $f(x) < g(x)$ [color=#94A3B8](égalité refusée)[/color]'' ;
    text id 64 start 466.0s for 1.8s at (4.0, 36.0) ''[color=#F8FAFC]$\bullet$ Or, $f(x) = g(x)$ exactement pour :[/color]'' ;
    text id 65 start 473.0s for 1.5s at (8.0, 43.0) ''[bold][color=#38BDF8]$x = 0$[/color][/bold]  [color=#94A3B8]et[/color]  [bold][color=#38BDF8]$x = 1{,}5$[/color][/bold]'' ;
    text id 66 start 477.0s for 2.2s at (4.0, 52.0) ''[color=#FBBF24]$\Rightarrow$ Il faut EXCLURE $0$ et $1{,}5$ de l'ensemble ![/color]'' ;
    text id 67 start 483.0s for 2.0s at (4.0, 60.0) ''Les crochets sont donc tournés vers l'[bold][color=#F87171]extérieur[/color][/bold].'' ;

    draw path id 543 start 485.5s for 0.5s color (248, 113, 113, 1) width 2.5 at [(131.8, 73.5), (133, 73.5), (133, 78.5), (131.8, 78.5)] ;
    draw path id 544 start 486.8s for 0.5s color (248, 113, 113, 1) width 2.5 at [(144.7, 73.5), (143.5, 73.5), (143.5, 78.5), (144.7, 78.5)] ;

    draw polygone id 545 start 489.5s for 0.8s color (52, 211, 153, 0.8) fillcolor (30, 41, 59, 0.5) width 2.0 at [(4, 68), (88, 68), (88, 92), (4, 92)] ;
    text id 68 start 491.0s for 1.8s at (6.0, 73.0) ''[bold][color=#34D399]ENSEMBLE DES SOLUTIONS :[/color][/bold]'' ;
    text id 69 start 493.5s for 2.2s at (6.0, 80.0) ''[bold][color=#FBBF24]$\mathbf{S = ]0 \;;\; 1{,}5[}$[/color][/bold]  [color=#94A3B8](intervalle ouvert)[/color]'' ;
    text id 70 start 501.5s for 2.0s at (6.0, 87.0) ''[color=#38BDF8]$\checkmark$ Réflexe :[/color] [color=#F8FAFC]points d'intersection = bornes de l'inéquation[/color]'' ;

}
