course "Révision express & Fiche de synthèse : Tout retenir sur Valeur absolue et distance sur la droite réelle" id 1 idgap 500 for 682.2s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : Définition Algébrique & Sens Géométrique sur la Droite Réelle
    # =========================================================================

    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Définition et Interprétation Géométrique de la Valeur Absolue[/color][/bold]'' ;
    draw line id 501 start 2.5s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 18.0s for 2.8s at (4.0, 22.0) ''[bold][color=#F8FAFC]Définition algébrique :[/color][/bold]'' ;
    text id 3 start 22.0s for 3.2s at (6.0, 31.0) ''Pour tout réel $x \in \mathbb{R}$ :  [color=#34D399]$|x| \ge 0$[/color]'' ;
    text id 4 start 27.5s for 3.0s at (6.0, 42.0) ''Exemples fondamentaux :  $|-3| = 3$   et   $|3| = 3$'' ;
    text id 5 start 34.0s for 3.5s at (6.0, 53.0) ''[color=#FBBF24]Règle :[/color]  $|x| = x$ si $x \ge 0$,  et  $|x| = -x$ si $x < 0$'' ;
    text id 6 start 48.5s for 0.8s at (4.0, 67.0) ''[bold][color=#38BDF8]Sens géométrique sur la droite réelle :[/color][/bold]'' ;
    text id 7 start 53.0s for 0.8s at (6.0, 78.0) ''[color=#F8FAFC]$|x - a| = \text{distance}(x, a) = d(x, a)$[/color]'' ;
    text id 8 start 58.0s for 2.5s at (6.0, 88.0) ''[italic][color=#34D399]Une distance physique est toujours positive ou nulle ![/color][/italic]'' ;

    # Droite réelle à droite
    draw line id 502 start 42.5s for 1.0s color (248, 250, 252, 0.95) width 2.2 at [(95, 52), (168, 52)] ;
    draw arrow id 503 start 43.8s for 0.6s color (248, 250, 252, 0.95) width 2.2 at [(166, 52), (171, 52)] ;
    text id 9 start 44.6s at (168.0, 47.0) ''[color=#F8FAFC]$x$[/color]'' ;

    # Pivot a
    draw line id 504 start 46.0s for 0.5s color (251, 191, 36, 1) width 2.8 at [(128, 48), (128, 56)] ;
    text id 10 start 46.8s at (126.5, 60.0) ''[bold][color=#FBBF24]Pivot $a$[/color][/bold]'' ;

    # Point x
    draw line id 505 start 49.5s for 0.5s color (56, 189, 248, 1) width 2.8 at [(154, 48), (154, 56)] ;
    text id 11 start 50.2s at (152.5, 60.0) ''[bold][color=#38BDF8]Point $x$[/color][/bold]'' ;

    # Flèche bilatérale de distance
    draw arrow id 506 start 51.5s for 0.8s color (52, 211, 153, 1) width 2.0 at [(129, 44), (153, 44)] ;
    draw arrow id 507 start 52.5s for 0.4s color (52, 211, 153, 1) width 2.0 at [(153, 44), (129, 44)] ;
    text id 12 start 54.0s for 1.8s at (130.0, 38.0) ''[bold][color=#34D399]$d(x, a) = |x - a|$[/color][/bold]'' ;

    erase id 2001 start 70.0s ;

    # =========================================================================
    # SCÈNE 2 : Méthode 1 — Résolution de |x - 3| = 6 (Algèbre & Droite Réelle)
    # =========================================================================

    text id 31 start 70.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Méthode 1 : Résolution de $|x - 3| = 6$ (Algèbre & Géométrie)[/color][/bold]'' ;
    draw line id 531 start 72.5s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 32 start 73.5s for 2.5s at (4.0, 22.0) ''[bold][color=#FBBF24]Équation initiale :[/color][/bold]  [color=#F8FAFC]$|x - 3| = 6$[/color]'' ;
    text id 33 start 83.5s for 3.2s at (4.0, 32.0) ''La quantité intérieure $x - 3$ peut valoir $6$ ou $-6$ :'' ;
    text id 34 start 98.5s for 3.0s at (6.0, 42.0) ''[color=#38BDF8]$x - 3 = 6$[/color]   [color=#F8FAFC]ou[/color]   [color=#38BDF8]$x - 3 = -6$[/color]'' ;

    # Droite graduée à droite
    text id 38 start 105.5s for 2.0s at (96.0, 22.0) ''[bold][color=#38BDF8]Sens géométrique : $d(x, 3) = 6$[/color][/bold]'' ;
    draw line id 532 start 107.8s for 0.8s color (248, 250, 252, 0.95) width 2.2 at [(95, 52), (170, 52)] ;
    draw arrow id 533 start 108.8s for 0.5s color (248, 250, 252, 0.95) width 2.2 at [(168, 52), (172, 52)] ;

    # Pivot 3
    draw line id 534 start 109.5s for 0.5s color (251, 191, 36, 1) width 3.0 at [(132, 48), (132, 56)] ;
    text id 39 start 110.2s at (129.5, 60.0) ''[bold][color=#FBBF24]Pivot $3$[/color][/bold]'' ;

    # Flèche vers la droite +6 -> 9
    draw arrow id 535 start 125.0s for 1.2s color (52, 211, 153, 1) width 2.2 at [(132, 42), (158, 42)] ;
    text id 40 start 126.5s for 1.5s at (142.0, 35.0) ''[bold][color=#34D399]$+ 6$[/color][/bold]'' ;
    draw line id 536 start 128.5s for 0.5s color (52, 211, 153, 1) width 3.0 at [(158, 48), (158, 56)] ;
    text id 41 start 129.2s at (156.5, 60.0) ''[bold][color=#34D399]$9$[/color][/bold]'' ;

    # Flèche vers la gauche -6 -> -3
    draw arrow id 537 start 132.0s for 1.2s color (248, 113, 113, 1) width 2.2 at [(132, 42), (106, 42)] ;
    text id 42 start 133.5s for 1.5s at (116.0, 35.0) ''[bold][color=#F87171]$- 6$[/color][/bold]'' ;
    draw line id 538 start 135.5s for 0.5s color (248, 113, 113, 1) width 3.0 at [(106, 48), (106, 56)] ;
    text id 43 start 136.2s at (103.5, 60.0) ''[bold][color=#F87171]$-3$[/color][/bold]'' ;

    text id 44 start 138.0s for 1.8s at (104.0, 75.0) ''[italic][color=#F8FAFC]Distance bilatérale : $3 - 6 = -3$ et $3 + 6 = 9$[/color][/italic]'' ;

    # Résolution algébrique à gauche
    text id 35 start 140.0s for 2.8s at (4.0, 54.0) ''[bold][color=#34D399]Branche 1 :[/color][/bold] $x = 6 + 3 \implies$ [color=#34D399]$\mathbf{x = 9}$[/color]'' ;
    text id 36 start 153.0s for 2.8s at (4.0, 66.0) ''[bold][color=#34D399]Branche 2 :[/color][/bold] $x = -6 + 3 \implies$ [color=#34D399]$\mathbf{x = -3}$[/color]'' ;
    text id 37 start 162.5s for 2.5s at (4.0, 80.0) ''[bold][color=#FBBF24]Deux solutions trouvées :[/color][/bold]  $-3$ et $9$'' ;

    erase id 2002 start 166.5s ;

    # =========================================================================
    # SCÈNE 3 : Vérification Rigoureuse & Fiche Type 1
    # =========================================================================

    text id 66 start 167.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Contrôle Rigoureux et Ensemble Solution de $|x - 3| = 6$[/color][/bold]'' ;
    draw line id 571 start 169.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 67 start 170.0s for 0.8s at (4.0, 24.0) ''[bold][color=#FBBF24]Vérification pour $x = -3$ :[/color][/bold]'' ;
    draw polygone id 572 start 171.0s for 1.2s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 2.0 at [(96, 24), (170, 24), (170, 84), (96, 84)] ;
    text id 72 start 172.5s for 0.3s at (100.0, 30.0) ''[bold][color=#38BDF8]FICHE TYPE 1 : $|x - a| = r$[/color][/bold]'' ;
    text id 68 start 173.0s for 2.5s at (6.0, 36.0) ''$|-3 - 3| = |-6| = 6$   [color=#34D399][bold](Vérifié !)[/bold][/color]'' ;
    text id 73 start 176.0s for 2.5s at (100.0, 42.0) ''Si $r > 0$, l'équation admet exactement'' ;
    text id 69 start 179.0s for 2.5s at (4.0, 52.0) ''[bold][color=#FBBF24]Vérification pour $x = 9$ :[/color][/bold]'' ;
    text id 74 start 182.0s for 0.8s at (100.0, 50.0) ''[color=#FBBF24]deux solutions réelles :[/color]'' ;
    text id 75 start 183.0s for 2.0s at (108.0, 60.0) ''[color=#34D399]$\mathbf{x = a - r}$   ou   $\mathbf{x = a + r}$[/color]'' ;
    text id 70 start 188.0s for 1.5s at (6.0, 64.0) ''$|9 - 3| = |6| = 6$   [color=#34D399][bold](Vérifié !)[/bold][/color]'' ;
    text id 71 start 190.0s for 3.0s at (4.0, 80.0) ''[bold][color=#38BDF8]Conclusion :[/color][/bold]  [color=#34D399]$\mathbf{S = \{-3 \;;\; 9\}}$[/color]'' ;
    text id 76 start 195.0s for 2.5s at (100.0, 72.0) ''[color=#F8FAFC]$S = \{a - r \;;\; a + r\}$[/color]'' ;

    erase id 2003 start 202.5s ;

    # =========================================================================
    # SCÈNE 4 : Méthode 2 — Égalité de Deux Valeurs Absolues |2x - 5| = |x + 7|
    # =========================================================================

    text id 91 start 203.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Méthode 2 : Égalité $|2x - 5| = |x + 7|$ par Différence de Deux Carrés[/color][/bold]'' ;
    draw line id 601 start 205.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 92 start 206.0s for 2.8s at (4.0, 22.0) ''[bold][color=#FBBF24]Équation :[/color][/bold]  [color=#F8FAFC]$|2x - 5| = |x + 7|$[/color]'' ;
    text id 93 start 221.5s for 3.5s at (4.0, 32.0) ''[color=#34D399]Propriété :[/color]  $|A| = |B| \iff A^2 = B^2 \iff A^2 - B^2 = 0$'' ;
    text id 94 start 235.5s for 3.0s at (4.0, 43.0) ''$(2x - 5)^2 = (x + 7)^2 \iff (2x - 5)^2 - (x + 7)^2 = 0$'' ;
    text id 95 start 259.5s for 3.5s at (4.0, 55.0) ''[bold][color=#38BDF8]Identité remarquable :[/color][/bold]  $A^2 - B^2 = (A - B)(A + B)$'' ;
    text id 96 start 270.0s for 3.0s at (6.0, 65.0) ''Ici :  [color=#FBBF24]$A = 2x - 5$[/color]   et   [color=#38BDF8]$B = x + 7$[/color]'' ;
    text id 97 start 279.5s for 2.3s at (4.0, 77.0) ''$[(2x - 5) - (x + 7)] \times [(2x - 5) + (x + 7)] = 0$'' ;

    # Encadré de réduction à droite
    draw polygone id 602 start 282.0s for 1.5s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.12) width 2.0 at [(95, 24), (171, 24), (171, 88), (95, 88)] ;
    text id 99 start 284.0s for 2.5s at (99.0, 30.0) ''[bold][color=#34D399]Réduction des deux facteurs :[/color][/bold]'' ;
    text id 98 start 308.0s for 3.2s at (4.0, 89.0) ''$(2x - 5 - x - 7)(2x - 5 + x + 7) = 0$'' ;
    text id 100 start 318.5s for 2.8s at (99.0, 42.0) ''[bold][color=#FBBF24]Premier facteur :[/color][/bold]'' ;
    text id 101 start 322.0s for 2.5s at (103.0, 50.0) ''$2x - x - 5 - 7 =$ [color=#34D399]$\mathbf{x - 12}$[/color]'' ;
    text id 102 start 327.5s for 2.5s at (99.0, 62.0) ''[bold][color=#38BDF8]Second facteur :[/color][/bold]'' ;
    text id 103 start 330.5s for 2.5s at (103.0, 70.0) ''$2x + x - 5 + 7 =$ [color=#34D399]$\mathbf{3x + 2}$[/color]'' ;
    text id 104 start 337.5s for 3.0s at (99.0, 80.0) ''[bold][color=#F8FAFC]Forme factorisée :[/color][/bold]  [color=#38BDF8]$\mathbf{(x - 12)(3x + 2) = 0}$[/color]'' ;

    erase id 2004 start 341.5s ;

    # =========================================================================
    # SCÈNE 5 : Équation Produit Nul & Solutions de la Méthode 2
    # =========================================================================

    text id 131 start 342.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Résolution de l'Équation Produit Nul $(x - 12)(3x + 2) = 0$[/color][/bold]'' ;
    draw line id 641 start 344.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 132 start 345.0s for 1.0s at (4.0, 24.0) ''[color=#FBBF24]Règle :[/color] $A \times B = 0 \iff A = 0 \text{ ou } B = 0$'' ;
    draw polygone id 642 start 346.5s for 1.2s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 2.0 at [(96, 24), (170, 24), (170, 84), (96, 84)] ;
    text id 137 start 348.0s for 2.0s at (100.0, 30.0) ''[bold][color=#FBBF24]POURQUOI LA MÉTHODE FONCTIONNE ?[/color][/bold]'' ;
    text id 133 start 352.0s for 1.8s at (4.0, 36.0) ''[color=#38BDF8]$x - 12 = 0$[/color]   [color=#F8FAFC]ou[/color]   [color=#38BDF8]$3x + 2 = 0$[/color]'' ;
    text id 138 start 354.0s for 2.5s at (100.0, 42.0) ''$|A| = |B|$ signifie que $A$ et $B$ ont la'' ;
    text id 134 start 357.0s for 2.5s at (4.0, 48.0) ''[bold][color=#34D399]Cas 1 :[/color][/bold]  $x - 12 = 0 \implies$ [color=#34D399]$\mathbf{x = 12}$[/color]'' ;
    text id 139 start 360.0s for 2.5s at (100.0, 50.0) ''même distance à l'origine $0$.'' ;
    text id 135 start 363.0s for 2.8s at (4.0, 60.0) ''[bold][color=#34D399]Cas 2 :[/color][/bold]  $3x + 2 = 0 \implies 3x = -2 \implies$ [color=#34D399]$\mathbf{x = -\frac{2}{3}}$[/color]'' ;
    text id 140 start 366.5s for 2.5s at (100.0, 60.0) ''[color=#38BDF8]Donc soit $A = B$, soit $A = -B$.[/color]'' ;
    text id 136 start 371.5s for 3.0s at (4.0, 76.0) ''[bold][color=#FBBF24]Ensemble des solutions :[/color][/bold]  [color=#34D399]$\mathbf{S = \left\{-\frac{2}{3} \;;\; 12\right\}}$[/color]'' ;
    text id 141 start 375.5s for 2.5s at (100.0, 70.0) ''[color=#34D399]Toutes les solutions réelles sont[/color]'' ;
    text id 142 start 378.5s for 2.5s at (100.0, 77.0) ''[color=#34D399]obtenues sans ambiguïté de signe ![/color]'' ;

    erase id 2005 start 386.3s ;

    # =========================================================================
    # SCÈNE 6 : Méthode 3 — Équation Mixte |5x - 6| - 3x = 2 & Tableau de Signes
    # =========================================================================

    text id 161 start 387.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Méthode 3 : Équation Mixte $|5x - 6| - 3x = 2$ & Tableau de Signes[/color][/bold]'' ;
    draw line id 671 start 389.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 162 start 390.0s for 2.8s at (4.0, 22.0) ''[bold][color=#FBBF24]Équation mixte :[/color][/bold]  [color=#F8FAFC]$|5x - 6| - 3x = 2$[/color]'' ;
    text id 163 start 403.0s for 3.5s at (4.0, 32.0) ''Le terme externe $-3x$ impose d'étudier le signe de $5x - 6$.'' ;
    text id 164 start 411.0s for 2.5s at (4.0, 44.0) ''[bold][color=#38BDF8]Recherche de la racine pivot :[/color][/bold]'' ;
    text id 165 start 416.0s for 3.2s at (6.0, 54.0) ''$5x - 6 = 0 \iff 5x = 6 \iff$ [color=#34D399]$\mathbf{x = \frac{6}{5} = 1{,}2}$[/color]'' ;

    # Tableau de signes à droite
    text id 169 start 424.5s for 2.0s at (96.0, 24.0) ''[bold][color=#38BDF8]Tableau de signes de $5x - 6$ :[/color][/bold]'' ;
    draw line id 672 start 427.0s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(95, 34), (170, 34)] ;
    draw line id 673 start 428.2s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(95, 48), (170, 48)] ;
    draw line id 674 start 429.5s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(95, 64), (170, 64)] ;
    draw line id 675 start 430.8s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(122, 34), (122, 64)] ;

    text id 170 start 432.0s at (105.0, 40.0) ''[bold][color=#F8FAFC]$x$[/color][/bold]'' ;
    text id 171 start 433.0s at (126.0, 40.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 172 start 434.0s at (145.0, 40.0) ''[bold][color=#FBBF24]$\frac{6}{5}$[/color][/bold]'' ;
    text id 173 start 435.0s at (162.0, 40.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;

    text id 174 start 437.0s at (98.0, 54.0) ''[bold][color=#F8FAFC]$5x - 6$[/color][/bold]'' ;
    text id 166 start 439.5s for 3.0s at (4.0, 68.0) ''[color=#FBBF24]Coefficient de $x$ :[/color] $a = 5 > 0$ (droite affine croissante)'' ;
    text id 175 start 446.0s for 1.2s at (133.0, 54.0) ''[bold][color=#F87171]$-$[/color][/bold]'' ;
    draw line id 676 start 447.8s for 0.5s color (251, 191, 36, 1) width 1.8 at [(147, 48), (147, 64)] ;
    draw circle id 677 start 448.5s for 0.5s color (251, 191, 36, 1) radius 1.5 at (147, 56) ;
    text id 176 start 450.0s for 1.2s at (156.0, 54.0) ''[bold][color=#34D399]$+$[/color][/bold]'' ;

    text id 167 start 453.5s for 3.5s at (4.0, 80.0) ''[color=#F87171]Sur $]-\infty \;;\; \frac{6}{5}]$ :[/color] $5x - 6 \le 0 \implies |5x - 6| = -(5x - 6)$'' ;
    text id 168 start 460.0s for 1.8s at (4.0, 90.0) ''[color=#34D399]Sur $[\frac{6}{5} \;;\; +\infty[$ :[/color] $5x - 6 \ge 0 \implies |5x - 6| = 5x - 6$'' ;

    draw polygone id 678 start 462.0s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.8 at [(95, 70), (170, 70), (170, 88), (95, 88)] ;
    text id 177 start 464.0s for 2.0s at (98.0, 75.0) ''[bold][color=#38BDF8]Plan d'attaque :[/color][/bold] Résoudre l'équation'' ;
    text id 178 start 466.5s at (98.0, 82.0) ''séparément sur chacun des deux intervalles !'' ;

    erase id 2006 start 468.5s ;

    # =========================================================================
    # SCÈNE 7 : Disjonction de Cas sur Intervalles & Solutions Finales
    # =========================================================================

    text id 201 start 469.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Disjonction de Cas sur Intervalles & Validation des Solutions[/color][/bold]'' ;
    draw line id 721 start 471.0s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    text id 202 start 472.0s for 2.5s at (4.0, 22.0) ''[bold][color=#F87171]CAS 1 : Pour $x \in ]-\infty \;;\; \frac{6}{5}]$  ($5x - 6 \le 0$)[/color][/bold]'' ;

    # Axe de validation des domaines à droite
    draw line id 722 start 476.0s for 0.8s color (248, 250, 252, 0.95) width 2.2 at [(95, 36), (170, 36)] ;
    draw arrow id 723 start 477.2s for 0.5s color (248, 250, 252, 0.95) width 2.2 at [(168, 36), (172, 36)] ;
    draw line id 724 start 478.0s for 0.5s color (251, 191, 36, 1) width 3.0 at [(130, 32), (130, 40)] ;
    text id 211 start 479.0s at (126.5, 43.0) ''[bold][color=#FBBF24]$\frac{6}{5} = 1{,}2$[/color][/bold]'' ;

    draw line id 725 start 481.0s for 1.0s color (248, 113, 113, 0.8) width 5.0 at [(96, 36), (130, 36)] ;
    text id 212 start 482.5s for 1.8s at (98.0, 28.0) ''[color=#F87171]Zone 1 : $]-\infty \;;\; 1{,}2]$[/color]'' ;

    text id 203 start 489.0s for 3.0s at (6.0, 31.0) ''$|5x - 6| = -(5x - 6) =$ [color=#FBBF24]$-5x + 6$[/color]'' ;
    text id 204 start 499.0s for 3.2s at (6.0, 40.0) ''$-5x + 6 - 3x = 2 \iff -8x + 6 = 2$'' ;
    text id 205 start 513.5s for 3.2s at (6.0, 49.0) ''$-8x = 2 - 6 = -4 \iff x = \frac{-4}{-8} \implies$ [color=#34D399]$\mathbf{x = \frac{1}{2} = 0{,}5}$[/color]'' ;

    # Solution 1/2 sur l'axe
    draw circle id 726 start 524.0s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.25) radius 2.0 at (112, 36) ;
    text id 213 start 525.0s for 1.5s at (107.0, 48.0) ''[bold][color=#34D399]$x_1 = \frac{1}{2}$[/color][/bold]'' ;

    text id 206 start 532.0s for 3.5s at (6.0, 58.0) ''[bold][color=#FBBF24]Vérification :[/color][/bold] $0{,}5 \le 1{,}2 \iff \frac{1}{2} \in ]-\infty \;;\; \frac{6}{5}]$  [color=#34D399][bold](Admis !)[/bold][/color]'' ;

    text id 207 start 557.0s for 2.5s at (4.0, 69.0) ''[bold][color=#34D399]CAS 2 : Pour $x \in [\frac{6}{5} \;;\; +\infty[$  ($5x - 6 \ge 0$)[/color][/bold]'' ;

    draw line id 727 start 562.0s for 1.0s color (52, 211, 153, 0.8) width 5.0 at [(130, 36), (168, 36)] ;
    text id 214 start 564.0s for 1.8s at (136.0, 28.0) ''[color=#34D399]Zone 2 : $[1{,}2 \;;\; +\infty[$[/color]'' ;

    text id 208 start 572.0s for 2.8s at (6.0, 77.0) ''$|5x - 6| = 5x - 6 \implies 5x - 6 - 3x = 2$'' ;
    text id 209 start 587.0s for 3.0s at (6.0, 85.0) ''$2x - 6 = 2 \iff 2x = 8 \implies$ [color=#34D399]$\mathbf{x = 4}$[/color]'' ;

    # Solution 4 sur l'axe
    draw circle id 728 start 604.0s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.25) radius 2.0 at (158, 36) ;
    text id 215 start 605.0s for 1.5s at (155.0, 48.0) ''[bold][color=#34D399]$x_2 = 4$[/color][/bold]'' ;

    text id 210 start 612.0s for 3.2s at (6.0, 93.0) ''[bold][color=#FBBF24]Vérification :[/color][/bold] $4 \ge 1{,}2 \iff 4 \in [\frac{6}{5} \;;\; +\infty[$  [color=#34D399][bold](Admis !)[/bold][/color]'' ;

    # Boîte récapitulative
    draw polygone id 729 start 618.0s for 1.0s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.15) width 2.2 at [(96, 62), (170, 62), (170, 90), (96, 90)] ;
    text id 216 start 620.0s for 2.2s at (100.0, 68.0) ''[bold][color=#38BDF8]ENSEMBLE DES SOLUTIONS :[/color][/bold]'' ;
    text id 217 start 623.0s for 2.5s at (114.0, 79.0) ''[color=#34D399]$\mathbf{S = \left\{\frac{1}{2} \;;\; 4\right\}}$[/color]'' ;

    erase id 2007 start 626.8s ;

    # =========================================================================
    # SCÈNE 8 : Fiche de Synthèse Express & Pièges d'Examen
    # =========================================================================

    text id 251 start 627.2s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. Fiche de Synthèse Express : Les 4 Réflexes Infaillibles[/color][/bold]'' ;
    draw line id 771 start 629.5s for 0.8s color (56, 189, 248, 1) width 1.8 at [(4, 13.5), (173, 13.5)] ;

    # Carte 1 : Piège du second membre négatif
    draw polygone id 772 start 630.5s for 0.8s color (248, 113, 113, 0.8) fillcolor (248, 113, 113, 0.12) width 1.8 at [(4, 18), (85, 18), (85, 52), (4, 52)] ;
    text id 252 start 631.5s for 2.2s at (6.0, 23.0) ''[bold][color=#F87171]RÉFLEXE 1 : Attention au signe du second membre ![/color][/bold]'' ;
    text id 253 start 637.5s for 3.0s at (6.0, 32.0) ''$|x - a| = r$ avec [color=#F87171]$r < 0 \implies \mathbf{S = \emptyset}$[/color] (Impossible !)'' ;
    text id 254 start 646.0s for 3.0s at (6.0, 42.0) ''[italic]Une distance géométrique ne peut JAMAIS être négative ![/italic]'' ;

    # Carte 2 : Équation type |x - a| = r
    draw polygone id 773 start 651.0s for 1.0s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.12) width 1.8 at [(4, 58), (85, 58), (85, 92), (4, 92)] ;
    text id 255 start 652.5s for 2.5s at (6.0, 63.0) ''[bold][color=#34D399]RÉFLEXE 2 : Équation type $|x - a| = r$ ($r > 0$)[/color][/bold]'' ;
    text id 256 start 656.0s for 3.0s at (6.0, 72.0) ''Deux solutions bilatérales :  [color=#34D399]$\mathbf{x = a - r}$  ou  $\mathbf{x = a + r}$[/color]'' ;
    text id 257 start 662.0s for 2.5s at (6.0, 82.0) ''Géométrie : Déplacement de rayon $r$ autour du centre $a$.'' ;

    # Carte 3 : Égalité |A| = |B|
    draw polygone id 774 start 666.0s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.12) width 1.8 at [(92, 18), (173, 18), (173, 52), (92, 52)] ;
    text id 258 start 667.5s for 2.5s at (96.0, 23.0) ''[bold][color=#38BDF8]RÉFLEXE 3 : Égalité $|A| = |B|$[/color][/bold]'' ;
    text id 259 start 672.0s for 3.0s at (96.0, 32.0) ''Passage aux carrés : $A^2 - B^2 = 0$'' ;
    text id 260 start 677.0s for 3.0s at (96.0, 42.0) ''Factorisation : [color=#38BDF8]$\mathbf{(A - B)(A + B) = 0}$[/color] (Produit nul)'' ;

    # Carte 4 : Équations mixtes
    draw polygone id 775 start 680.5s for 1.0s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.12) width 1.8 at [(92, 58), (173, 58), (173, 92), (92, 92)] ;
    text id 261 start 682.0s for 2.8s at (96.0, 63.0) ''[bold][color=#FBBF24]RÉFLEXE 4 : Équations mixtes[/color][/bold]'' ;
    text id 262 start 686.5s for 3.0s at (96.0, 72.0) ''1. Trouver la racine de l'expression sous la barre.'' ;
    text id 263 start 691.0s for 3.0s at (96.0, 79.0) ''2. Dresser le tableau de signes et séparer les cas.'' ;
    text id 264 start 695.5s for 3.0s at (96.0, 86.0) ''[bold][color=#34D399]3. CONTRÔLER l'appartenance à chaque intervalle ![/color][/bold]'' ;

}
