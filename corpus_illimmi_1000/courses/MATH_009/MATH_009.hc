course "Exemple guidé et calcul détaillé : Intervalles et encadrements de réels en pratique" id 900 idgap 500 for 411.83s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 (0.0s -> 84.0s) : Introduction & Double Inégalité 1 <= x < 5
    # =========================================================================

    text id 1 start 0.5s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]1. Introduction : Des Inégalités aux Intervalles[/bold][/color]'' ;
    draw line id 501 start 2.2s for 0.8s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 27.5s for 1.2s at (5.0, 22.0) ''[color=#FBBF24][bold]Inégalité étudiée :[/bold][/color]'' ;
    text id 3 start 30.4s for 2.0s at (5.0, 31.0) ''[color=#F8FAFC]$$\mathbf{1 \leqslant x < 5}$$[/color]'' ;

    text id 4 start 35.0s for 1.5s at (5.0, 44.0) ''[color=#38BDF8]Double condition simultanée :[/color]'' ;
    text id 5 start 40.0s for 2.0s at (6.0, 52.0) ''• [color=#34D399]$x \geqslant 1$[/color] : $x$ est supérieur ou égal à $1$'' ;
    text id 6 start 44.0s for 2.0s at (6.0, 60.0) ''• [color=#F87171]$x < 5$[/color] : $x$ est strictement inférieur à $5$'' ;

    text id 7 start 50.5s for 1.5s at (96.0, 22.0) ''[color=#FBBF24][bold]Infinité de solutions réelles :[/bold][/color]'' ;
    text id 8 start 54.0s for 2.0s at (96.0, 32.0) ''[color=#F8FAFC]$x \in \{1 \;;\; 2 \;;\; 2{,}5 \;;\; \pi \;;\; 4{,}87 \dots\}$[/color]'' ;

    text id 9 start 60.0s for 2.0s at (96.0, 45.0) ''[color=#34D399][bold]Borne 1 incluse :[/bold] $x = 1$ est permis ($\leqslant$)[/color]'' ;
    text id 10 start 65.0s for 2.0s at (96.0, 56.0) ''[color=#F87171][bold]Borne 5 exclue :[/bold] $x = 5$ est interdit ($<$)[/color]'' ;

    text id 11 start 74.0s for 2.5s at (96.0, 70.0) ''[color=#C084FC]Un ensemble continu entre deux bornes = [bold]un intervalle[/bold][/color]'' ;

    erase id 2001 start 84.0s ;

    # =========================================================================
    # SCÈNE 2 (84.5s -> 176.0s) : Définition des Crochets & Axe Gradué
    # =========================================================================

    text id 21 start 85.0s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]2. Définition Formelle : La Règle d'Or des Crochets[/bold][/color]'' ;
    draw line id 511 start 86.8s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 22 start 98.0s for 1.2s at (5.0, 20.0) ''[color=#FBBF24][bold]Sens des Crochets :[/bold][/color]'' ;
    text id 23 start 115.0s for 1.6s at (5.0, 28.0) ''[color=#34D399][bold]Crochet vers l'intérieur :[/bold] $[ \dots$ ou $\dots ]$[/color]'' ;
    text id 24 start 117.0s for 1.8s at (7.0, 35.0) ''$\rightarrow$ Borne [color=#34D399][bold]incluse[/bold][/color] (inégalité large $\leqslant$ ou $\geqslant$)'' ;

    text id 25 start 128.0s for 1.6s at (5.0, 44.0) ''[color=#F87171][bold]Crochet vers l'extérieur :[/bold] $] \dots$ ou $\dots [$[/color]'' ;
    text id 26 start 130.0s for 1.8s at (7.0, 51.0) ''$\rightarrow$ Borne [color=#F87171][bold]exclue[/bold][/color] (inégalité stricte $<$ ou $>$)'' ;

    text id 27 start 137.0s for 1.2s at (5.0, 62.0) ''[color=#FBBF24][bold]Notation pour notre exemple :[/bold][/color]'' ;
    text id 28 start 140.8s for 2.0s at (5.0, 71.0) ''[color=#38BDF8]$$\mathbf{x \in [1 \;;\; 5[}$$[/color]'' ;
    text id 29 start 143.2s for 1.8s at (5.0, 81.0) ''[color=#F8FAFC]Lecture : « $x$ appartient à l'intervalle fermé $1$, ouvert $5$ »[/color]'' ;

    text id 30 start 145.5s for 1.0s at (96.0, 20.0) ''[color=#FBBF24][bold]Représentation sur la Droite Numérique :[/bold][/color]'' ;
    draw arrow id 512 start 147.0s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    draw line id 513 start 148.2s color (248, 250, 252, 0.7) width 1.5 at [(104, 50), (104, 54)] ;
    text id 31 start 148.2s at (103, 59) ''0'' ;
    draw line id 514 start 148.5s color (248, 250, 252, 0.7) width 1.5 at [(114, 50), (114, 54)] ;
    text id 32 start 148.5s at (113, 59) ''1'' ;
    draw line id 515 start 148.8s color (248, 250, 252, 0.7) width 1.5 at [(124, 50), (124, 54)] ;
    text id 33 start 148.8s at (123, 59) ''2'' ;
    draw line id 516 start 149.1s color (248, 250, 252, 0.7) width 1.5 at [(134, 50), (134, 54)] ;
    text id 34 start 149.1s at (133, 59) ''3'' ;
    draw line id 517 start 149.4s color (248, 250, 252, 0.7) width 1.5 at [(144, 50), (144, 54)] ;
    text id 35 start 149.4s at (143, 59) ''4'' ;
    draw line id 518 start 149.7s color (248, 250, 252, 0.7) width 1.5 at [(154, 50), (154, 54)] ;
    text id 36 start 149.7s at (153, 59) ''5'' ;
    draw line id 519 start 150.0s color (248, 250, 252, 0.7) width 1.5 at [(164, 50), (164, 54)] ;
    text id 37 start 150.0s at (163, 59) ''6'' ;

    draw line id 520 start 151.0s for 1.8s color (56, 189, 248, 1) width 5.5 at [(114, 52), (154, 52)] ;

    draw path id 521 start 154.8s for 1.0s color (52, 211, 153, 1) width 3.0 at [(117, 47), (114, 47), (114, 57), (117, 57)] ;
    text id 38 start 156.0s for 1.0s at (109.0, 41.0) ''[color=#34D399][bold]1 inclus[/bold][/color]'' ;

    draw path id 522 start 157.8s for 1.0s color (248, 113, 113, 1) width 3.0 at [(157, 47), (154, 47), (154, 57), (157, 57)] ;
    text id 39 start 159.2s for 1.0s at (149.0, 41.0) ''[color=#F87171][bold]5 exclu[/bold][/color]'' ;

    text id 40 start 163.0s for 2.2s at (96.0, 72.0) ''[color=#F8FAFC]La zone bleue et la borne $1$ forment l'ensemble $[1 \;;\; 5[$[/color]'' ;

    erase id 2002 start 176.0s ;

    # =========================================================================
    # SCÈNE 3 (176.5s -> 226.0s) : Exemple 1 : ]-2 ; 2]
    # =========================================================================

    text id 51 start 176.8s for 1.4s at (4.0, 7.5) ''[color=#38BDF8][bold]3. Exemple 1 : Intervalle Semi-Ouvert $]-2 \;;\; 2]$[/bold][/color]'' ;
    draw line id 531 start 178.5s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 52 start 180.0s for 1.0s at (5.0, 20.0) ''[color=#FBBF24][bold]Donnée de départ :[/bold][/color]'' ;
    text id 53 start 181.8s for 1.8s at (5.0, 29.0) ''[color=#38BDF8]$$\mathbf{x \in \; ]-2 \;;\; 2]}$$[/color]'' ;

    text id 54 start 184.5s for 1.0s at (96.0, 20.0) ''[color=#FBBF24][bold]Construction sur l'axe gradué :[/bold][/color]'' ;
    draw arrow id 532 start 186.0s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    draw line id 533 start 187.2s color (248, 250, 252, 0.7) width 1.5 at [(103, 50), (103, 54)] ;
    text id 55 start 187.2s at (101, 59) ''-3'' ;
    draw line id 534 start 187.4s color (248, 250, 252, 0.7) width 1.5 at [(113, 50), (113, 54)] ;
    text id 56 start 187.4s at (111, 59) ''-2'' ;
    draw line id 535 start 187.6s color (248, 250, 252, 0.7) width 1.5 at [(123, 50), (123, 54)] ;
    text id 57 start 187.6s at (121, 59) ''-1'' ;
    draw line id 536 start 187.8s color (248, 250, 252, 0.7) width 1.5 at [(133, 50), (133, 54)] ;
    text id 58 start 187.8s at (132, 59) ''0'' ;
    draw line id 537 start 188.0s color (248, 250, 252, 0.7) width 1.5 at [(143, 50), (143, 54)] ;
    text id 59 start 188.0s at (142, 59) ''1'' ;
    draw line id 538 start 188.2s color (248, 250, 252, 0.7) width 1.5 at [(153, 50), (153, 54)] ;
    text id 60 start 188.2s at (152, 59) ''2'' ;
    draw line id 539 start 188.4s color (248, 250, 252, 0.7) width 1.5 at [(163, 50), (163, 54)] ;
    text id 61 start 188.4s at (162, 59) ''3'' ;

    draw line id 540 start 189.8s for 1.8s color (56, 189, 248, 1) width 5.5 at [(113, 52), (153, 52)] ;

    draw path id 541 start 192.5s for 1.0s color (248, 113, 113, 1) width 3.0 at [(110, 47), (113, 47), (113, 57), (110, 57)] ;
    text id 62 start 193.8s for 1.0s at (107.0, 41.0) ''[color=#F87171][bold]-2 exclu[/bold][/color]'' ;

    draw path id 542 start 195.5s for 1.0s color (52, 211, 153, 1) width 3.0 at [(150, 47), (153, 47), (153, 57), (150, 57)] ;
    text id 63 start 196.8s for 1.0s at (147.0, 41.0) ''[color=#34D399][bold]2 inclus[/bold][/color]'' ;

    text id 64 start 198.5s for 1.2s at (5.0, 42.0) ''[color=#F8FAFC][bold]Analyse des bornes :[/bold][/color]'' ;
    text id 65 start 201.0s for 2.0s at (6.0, 50.0) ''• En $-2$ : [color=#F87171]crochet extérieur[/color] $\rightarrow x > -2$ (stricte)'' ;
    text id 66 start 205.5s for 2.0s at (6.0, 58.0) ''• En $2$ : [color=#34D399]crochet intérieur[/color] $\rightarrow x \leqslant 2$ (large)'' ;

    text id 67 start 210.0s for 1.0s at (5.0, 68.0) ''[color=#FBBF24][bold]Inégalité correspondante :[/bold][/color]'' ;
    text id 68 start 211.5s for 2.2s at (5.0, 77.0) ''[color=#34D399]$$\mathbf{-2 < x \leqslant 2}$$[/color]'' ;
    text id 69 start 217.0s for 2.2s at (5.0, 88.0) ''[color=#C084FC]Crochet intérieur = large ($\leqslant$) ; extérieur = stricte ($<$)'' ;

    erase id 2003 start 226.0s ;

    # =========================================================================
    # SCÈNE 4 (226.5s -> 286.0s) : Exemple 2 : Inégalité x <= 3 et l'Infini
    # =========================================================================

    text id 81 start 226.8s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]4. Exemple 2 : Inégalité $x \leqslant 3$ et Découverte de l'Infini[/bold][/color]'' ;
    draw line id 551 start 228.6s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 82 start 229.8s for 1.0s at (5.0, 20.0) ''[color=#FBBF24][bold]Inégalité donnée :[/bold][/color]'' ;
    text id 83 start 231.2s for 1.8s at (5.0, 29.0) ''[color=#F8FAFC]$$\mathbf{x \leqslant 3}$$[/color]'' ;

    text id 84 start 239.0s for 1.2s at (96.0, 20.0) ''[color=#FBBF24][bold]Demi-droite illimitée à gauche :[/bold][/color]'' ;
    draw arrow id 552 start 240.8s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    draw line id 553 start 242.0s color (248, 250, 252, 0.7) width 1.5 at [(110, 50), (110, 54)] ;
    text id 85 start 242.0s at (109, 59) ''0'' ;
    draw line id 554 start 242.3s color (248, 250, 252, 0.7) width 1.5 at [(122, 50), (122, 54)] ;
    text id 86 start 242.3s at (121, 59) ''1'' ;
    draw line id 555 start 242.6s color (248, 250, 252, 0.7) width 1.5 at [(134, 50), (134, 54)] ;
    text id 87 start 242.6s at (133, 59) ''2'' ;
    draw line id 556 start 242.9s color (248, 250, 252, 0.7) width 1.5 at [(146, 50), (146, 54)] ;
    text id 88 start 242.9s at (145, 59) ''3'' ;
    draw line id 557 start 243.2s color (248, 250, 252, 0.7) width 1.5 at [(158, 50), (158, 54)] ;
    text id 89 start 243.2s at (157, 59) ''4'' ;

    draw line id 558 start 244.0s for 1.8s color (56, 189, 248, 1) width 5.5 at [(96, 52), (146, 52)] ;

    draw path id 559 start 246.0s for 1.0s color (52, 211, 153, 1) width 3.0 at [(143, 47), (146, 47), (146, 57), (143, 57)] ;
    text id 90 start 247.5s for 1.0s at (140.0, 41.0) ''[color=#34D399][bold]3 inclus ($\leqslant$)[/bold][/color]'' ;

    text id 91 start 251.0s for 1.2s at (5.0, 41.0) ''[color=#FBBF24][bold]Pas de borne finie à gauche :[/bold][/color]'' ;
    text id 92 start 257.0s for 2.0s at (5.0, 49.0) ''Symbole $\infty$ (huit couché) $\rightarrow$ notion de [color=#38BDF8][bold]$-\infty$[/bold][/color]'' ;

    text id 93 start 260.0s for 1.2s at (96.0, 41.0) ''[color=#38BDF8][bold]$-\infty$ (illimité à gauche)[/bold][/color]'' ;
    draw arrow id 560 start 262.0s for 0.8s color (56, 189, 248, 1) width 2.0 at [(106, 44), (98, 49)] ;

    text id 94 start 267.0s for 1.2s at (5.0, 59.0) ''[color=#F87171][bold]RÈGLE D'OR ABSOLUE :[/bold][/color]'' ;
    text id 95 start 269.0s for 2.2s at (5.0, 67.0) ''Le crochet est [color=#F87171][bold]TOUJOURS OUVERT[/bold][/color] en $-\infty$ et $+\infty$ !'' ;
    text id 96 start 275.0s for 2.0s at (5.0, 75.0) ''[color=#F8FAFC]($\infty$ n'est pas un nombre réel, jamais inclus)[/color]'' ;

    text id 97 start 281.8s for 2.2s at (5.0, 84.0) ''[color=#34D399]$$\mathbf{x \in \; ]-\infty \;;\; 3]}$$[/color]'' ;

    erase id 2004 start 286.0s ;

    # =========================================================================
    # SCÈNE 5 (286.5s -> 324.0s) : Exemple 3 : L'Intervalle Ouvert ]0 ; +oo[
    # =========================================================================

    text id 111 start 286.8s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]5. Exemple 3 : L'Intervalle Ouvert $]0 \;;\; +\infty[$[/bold][/color]'' ;
    draw line id 571 start 288.5s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 112 start 289.5s for 1.0s at (5.0, 20.0) ''[color=#FBBF24][bold]Donnée de départ :[/bold][/color]'' ;
    text id 113 start 291.2s for 1.8s at (5.0, 29.0) ''[color=#38BDF8]$$\mathbf{x \in \; ]0 \;;\; +\infty[}$$[/color]'' ;

    text id 114 start 293.5s for 1.0s at (96.0, 20.0) ''[color=#FBBF24][bold]Demi-droite vers $+\infty$ :[/bold][/color]'' ;
    draw arrow id 572 start 294.8s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    draw line id 573 start 296.0s color (248, 250, 252, 0.7) width 1.5 at [(105, 50), (105, 54)] ;
    text id 115 start 296.0s at (103, 59) ''-1'' ;
    draw line id 574 start 296.3s color (248, 250, 252, 0.7) width 1.5 at [(117, 50), (117, 54)] ;
    text id 116 start 296.3s at (116, 59) ''0'' ;
    draw line id 575 start 296.6s color (248, 250, 252, 0.7) width 1.5 at [(129, 50), (129, 54)] ;
    text id 117 start 296.6s at (128, 59) ''1'' ;
    draw line id 576 start 296.9s color (248, 250, 252, 0.7) width 1.5 at [(141, 50), (141, 54)] ;
    text id 118 start 296.9s at (140, 59) ''2'' ;
    draw line id 577 start 297.2s color (248, 250, 252, 0.7) width 1.5 at [(153, 50), (153, 54)] ;
    text id 119 start 297.2s at (152, 59) ''3'' ;

    draw line id 578 start 298.5s for 1.8s color (56, 189, 248, 1) width 5.5 at [(117, 52), (170, 52)] ;

    draw path id 579 start 300.8s for 1.0s color (248, 113, 113, 1) width 3.0 at [(114, 47), (117, 47), (117, 57), (114, 57)] ;
    text id 120 start 302.5s for 1.0s at (111.0, 41.0) ''[color=#F87171][bold]0 exclu ($>$)[/bold][/color]'' ;

    text id 121 start 305.0s for 1.2s at (5.0, 42.0) ''[color=#F8FAFC][bold]Analyse de l'intervalle :[/bold][/color]'' ;
    text id 122 start 307.0s for 1.8s at (6.0, 50.0) ''• En $0$ : crochet [color=#F87171]extérieur[/color] $\rightarrow 0$ [color=#F87171][bold]exclu[/bold][/color]'' ;
    text id 123 start 310.0s for 1.8s at (6.0, 58.0) ''• En $+\infty$ : [color=#38BDF8]ouvert[/color] (nombres arbitrairement grands)'' ;

    text id 124 start 312.5s for 1.0s at (158.0, 41.0) ''[color=#38BDF8][bold]$+\infty$[/bold][/color]'' ;

    text id 125 start 315.0s for 1.0s at (5.0, 68.0) ''[color=#FBBF24][bold]Inégalité correspondante :[/bold][/color]'' ;
    text id 126 start 316.8s for 2.0s at (5.0, 77.0) ''[color=#34D399]$$\mathbf{x > 0}$$[/color]'' ;
    text id 127 start 319.8s for 2.0s at (5.0, 88.0) ''[color=#C084FC]Noté aussi $\mathbb{R}^{+*}$ (ensemble des réels strictement positifs)'' ;

    erase id 2005 start 324.0s ;

    # =========================================================================
    # SCÈNE 6 (324.5s -> 365.0s) : Exemple 4 : De la Droite Numérique à x < 4
    # =========================================================================

    text id 141 start 325.0s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]6. Exemple 4 : De la Droite Numérique à l'Inégalité[/bold][/color]'' ;
    draw line id 591 start 326.8s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 142 start 328.0s for 1.0s at (96.0, 20.0) ''[color=#FBBF24][bold]Figure de départ :[/bold][/color]'' ;
    draw arrow id 592 start 329.2s for 1.0s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (170, 52)] ;

    draw line id 593 start 330.4s color (248, 250, 252, 0.7) width 1.5 at [(106, 50), (106, 54)] ;
    text id 143 start 330.4s at (105, 59) ''1'' ;
    draw line id 594 start 330.7s color (248, 250, 252, 0.7) width 1.5 at [(118, 50), (118, 54)] ;
    text id 144 start 330.7s at (117, 59) ''2'' ;
    draw line id 595 start 331.0s color (248, 250, 252, 0.7) width 1.5 at [(130, 50), (130, 54)] ;
    text id 145 start 331.0s at (129, 59) ''3'' ;
    draw line id 596 start 331.3s color (248, 250, 252, 0.7) width 1.5 at [(142, 50), (142, 54)] ;
    text id 146 start 331.3s at (141, 59) ''4'' ;
    draw line id 597 start 331.6s color (248, 250, 252, 0.7) width 1.5 at [(154, 50), (154, 54)] ;
    text id 147 start 331.6s at (153, 59) ''5'' ;

    draw line id 598 start 332.0s for 1.6s color (56, 189, 248, 1) width 5.5 at [(96, 52), (142, 52)] ;

    draw path id 599 start 334.0s for 1.0s color (248, 113, 113, 1) width 3.0 at [(145, 47), (142, 47), (142, 57), (145, 57)] ;
    text id 148 start 335.5s for 1.0s at (139.0, 41.0) ''[color=#F87171][bold]4 exclu ($<$)[/bold][/color]'' ;

    text id 149 start 340.5s for 1.0s at (96.0, 41.0) ''[color=#38BDF8][bold]$-\infty$[/bold][/color]'' ;

    text id 150 start 344.5s for 1.0s at (5.0, 22.0) ''[color=#FBBF24][bold]1. Écriture en Intervalle :[/bold][/color]'' ;
    text id 151 start 346.8s for 2.0s at (5.0, 31.0) ''[color=#38BDF8]$$\mathbf{x \in \; ]-\infty \;;\; 4[}$$[/color]'' ;

    text id 152 start 350.5s for 1.6s at (6.0, 42.0) ''• Crochet [color=#F87171]ouvert[/color] en $-\infty$ (impératif)'' ;
    text id 153 start 353.5s for 1.6s at (6.0, 50.0) ''• Crochet [color=#F87171]ouvert[/color] en $4$ (borne exclue)'' ;

    text id 154 start 358.5s for 1.0s at (5.0, 62.0) ''[color=#FBBF24][bold]2. Inégalité Associée :[/bold][/color]'' ;
    text id 155 start 360.8s for 2.0s at (5.0, 72.0) ''[color=#34D399]$$\mathbf{x < 4}$$[/color]'' ;

    erase id 2006 start 365.0s ;

    # =========================================================================
    # SCÈNE 7 (365.5s -> 411.83s) : Synthèse Finale & Réflexes pour le Contrôle
    # =========================================================================

    text id 171 start 365.8s for 1.5s at (4.0, 7.5) ''[color=#38BDF8][bold]7. Synthèse Finale : La Règle Infaillible des Intervalles[/bold][/color]'' ;
    draw line id 661 start 367.6s for 0.6s color (248, 250, 252, 0.4) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 172 start 370.8s for 1.2s at (5.0, 20.0) ''[color=#FBBF24][bold]Les 3 Réflexes Fondamentaux :[/bold][/color]'' ;
    text id 173 start 373.0s for 1.2s at (96.0, 20.0) ''[color=#FBBF24][bold]Tableau des Équivalences :[/bold][/color]'' ;

    text id 174 start 377.9s for 1.4s at (5.0, 28.0) ''[color=#34D399][bold]1. Inégalité Large ($\leqslant$ ou $\geqslant$) :[/bold][/color]'' ;
    text id 175 start 379.8s for 1.8s at (7.0, 35.0) ''$\rightarrow$ Crochet [color=#34D399][bold]vers l'intérieur[/bold][/color] $[a \dots$ ou $\dots b]$ (borne [color=#34D399]incluse[/color])'' ;

    text id 176 start 382.5s for 1.8s at (96.0, 30.0) ''[color=#F8FAFC]$a \leqslant x \leqslant b \iff x \in [a \;;\; b]$ [color=#34D399](fermé)[/color][/color]'' ;

    text id 177 start 387.8s for 1.4s at (5.0, 45.0) ''[color=#F87171][bold]2. Inégalité Stricte ($<$ ou $>$) :[/bold][/color]'' ;
    text id 178 start 389.8s for 1.8s at (7.0, 52.0) ''$\rightarrow$ Crochet [color=#F87171][bold]vers l'extérieur[/bold][/color] $]a \dots$ ou $\dots b[$ (borne [color=#F87171]exclue[/color])'' ;

    text id 179 start 392.5s for 1.8s at (96.0, 42.0) ''[color=#F8FAFC]$a < x < b \iff x \in \; ]a \;;\; b[$ [color=#F87171](ouvert)[/color][/color]'' ;

    text id 180 start 397.8s for 1.4s at (5.0, 62.0) ''[color=#C084FC][bold]3. En $-\infty$ et $+\infty$ :[/bold][/color]'' ;
    text id 181 start 399.6s for 1.8s at (7.0, 69.0) ''$\rightarrow$ Crochet [color=#C084FC][bold]TOUJOURS OUVERT[/bold][/color] $]-\infty \dots$ ou $\dots +\infty[$'' ;

    text id 182 start 402.0s for 1.5s at (96.0, 54.0) ''[color=#F8FAFC]$x \geqslant a \iff x \in [a \;;\; +\infty[$[/color]'' ;
    text id 183 start 404.0s for 1.5s at (96.0, 66.0) ''[color=#F8FAFC]$x < b \iff x \in \; ]-\infty \;;\; b[$[/color]'' ;

    text id 184 start 406.0s for 2.2s at (5.0, 81.0) ''[color=#38BDF8][bold]Conseil :[/bold] Esquisse toujours un axe rapide au brouillon ![/color]'' ;
    text id 185 start 409.0s for 1.8s at (96.0, 78.0) ''[color=#34D399][bold]RÉFLEXE MAÎTRISÉ — PRÊT POUR LE CONTRÔLE[/bold][/color]'' ;

}
