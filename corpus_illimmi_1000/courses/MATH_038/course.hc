course "Méthode pas à pas : Variations de fonctions et extrema" id 38 idgap 200 for 728.05s audio "narration.wav" {

    # === SCENE 1 : Objectif & Intuition du Maximum (0s -> 90.5s) ===
    text id 1 start 0.15s for 2.2s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Objectif & Intuition d'un Extremum[/color][/bold]'' ;
    draw line id 201 start 2.60s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 2 start 3.40s for 3.2s at (4.0, 22.0) ''[bold][color=#FBBF24]Objectif :[/color][/bold] [color=#F8FAFC]Démontrer qu'une fonction[/color]'' ;
    text id 3 start 6.85s for 2.4s at (4.0, 29.0) ''[color=#F8FAFC]admet un maximum ou un minimum.[/color]'' ;
    text id 4 start 11.00s for 3.0s at (4.0, 41.0) ''[color=#34D399]• Méthode rigoureuse + exercice final[/color]'' ;
    text id 5 start 24.80s for 3.2s at (4.0, 52.0) ''[color=#F8FAFC]1) Définition intuitive puis rigoureuse[/color]'' ;
    text id 6 start 32.50s for 3.2s at (4.0, 62.0) ''[color=#F8FAFC]2) Reconstitution étape par étape[/color]'' ;

    # Axe vertical gradué à droite (notes de 0 à 20)
    draw arrow id 202 start 54.12s for 1.2s color (248, 250, 252, 0.95) width 2.5 at [(125, 88), (125, 19)] ;
    draw line id 203 start 56.40s color (248, 250, 252, 0.9) width 2 at [(123, 84), (127, 84)] ;
    text id 7 start 56.60s at (117.0, 81.5) ''[color=#F8FAFC]0[/color]'' ;
    draw line id 204 start 56.80s color (248, 250, 252, 0.9) width 2 at [(123, 54), (127, 54)] ;
    text id 8 start 57.00s at (115.0, 51.5) ''[color=#F8FAFC]10[/color]'' ;
    draw line id 205 start 57.20s color (248, 250, 252, 0.9) width 2 at [(123, 24), (127, 24)] ;
    text id 9 start 57.40s at (115.0, 21.5) ''[color=#F8FAFC]20[/color]'' ;

    text id 10 start 62.80s for 2.6s at (4.0, 75.0) ''[color=#38BDF8]Exemple : note maximale = $18 / 20$[/color]'' ;
    draw line id 206 start 68.12s for 1.2s color (248, 113, 113, 1) width 3.5 at [(104, 30), (156, 30)] ;
    text id 11 start 69.80s for 2.2s at (130.0, 24.0) ''[bold][color=#F87171]18 (Plafond)[/color][/bold]'' ;
    draw polygone id 207 start 72.50s for 0.9s color (52, 211, 153, 0.8) width 1.5 fillcolor (52, 211, 153, 0.16) at [(108, 30), (148, 30), (148, 84), (108, 84)] ;
    text id 12 start 73.70s for 2.0s at (130.0, 55.0) ''[color=#34D399]Notes $\le 18$[/color]'' ;
    mouse move id 601 start 76.50s for 2.2s at [(125, 65), (125, 31), (146, 31)] ;
    text id 13 start 79.00s for 2.4s at (4.0, 86.0) ''[bold][color=#FBBF24]On ne dépasse jamais vers le haut.[/color][/bold]'' ;

    erase id 801 start 90.50s ;

    # === SCENE 2 : Définitions Rigoureuses Max & Min (91s -> 195.6s) ===
    text id 14 start 91.04s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Définitions Rigoureuses : Max & Min[/color][/bold]'' ;
    draw line id 208 start 93.30s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 15 start 94.20s for 3.6s at (4.0, 21.0) ''[bold][color=#F87171]Maximum $M$ sur $I$ :[/color][/bold]'' ;
    text id 16 start 98.20s for 4.2s at (4.0, 29.0) ''[color=#F8FAFC]Pour tout $x \in I$,  $f(x) \le M$[/color]'' ;
    mouse move id 602 start 108.40s for 2.2s at [(32, 34), (60, 34)] ;
    text id 17 start 125.00s for 2.8s at (4.0, 40.0) ''[color=#38BDF8]• Sur tout l'intervalle $I$ (jamais dépassé)[/color]'' ;

    # Repère 2D à droite [-3, 3] x [-2, 4], scale=7.5 -> width=45, height=45
    draw 2drep id 210 start 147.72s for 1.4s at (133.0, 62.5) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-2, 4] ;
    draw 2dfunc id 211 start 152.12s for 2.2s color (56, 189, 248, 1) width 2.8 at 210 y = 3 - 0.5 * x^2 ;
    draw line id 212 start 156.10s for 1.2s color (248, 113, 113, 1) width 2.5 at [(110.5, 40.0), (155.5, 40.0)] ;
    text id 18 start 157.60s for 1.4s at (157.0, 37.5) ''[bold][color=#F87171]$y = M$[/color][/bold]'' ;
    mouse move id 603 start 159.50s for 2.2s at [(116, 65), (133, 40), (150, 65)] ;

    text id 19 start 167.20s for 2.2s at (4.0, 56.0) ''[bold][color=#34D399]Minimum $m$ sur $I$ :[/color][/bold]'' ;
    text id 20 start 170.00s for 4.0s at (4.0, 64.0) ''[color=#F8FAFC]Pour tout $x \in I$,  $f(x) \ge m$[/color]'' ;
    draw 2dfunc id 213 start 181.50s for 2.0s color (52, 211, 153, 1) width 2.8 at 210 y = 0.5 * x^2 - 1 ;
    draw line id 214 start 185.00s for 1.2s color (52, 211, 153, 1) width 2.5 at [(110.5, 70.0), (155.5, 70.0)] ;
    text id 21 start 186.50s for 1.4s at (157.0, 67.5) ''[bold][color=#34D399]$y = m$[/color][/bold]'' ;
    text id 22 start 188.50s for 2.8s at (4.0, 77.0) ''[color=#FBBF24]Plancher : $f(x)$ ne descend jamais sous $m$.[/color]'' ;

    erase id 802 start 195.60s ;

    # === SCENE 3 : Cas de base x² >= 0 et g(x) = x² + 2 (196.5s -> 328.2s) ===
    text id 23 start 196.50s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Cas de base : $x^2$ et $g(x) = x^2 + 2$[/color][/bold]'' ;
    draw line id 215 start 198.80s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 24 start 204.50s for 2.4s at (4.0, 21.0) ''[bold][color=#FBBF24]Propriété clé (fonction carrée) :[/color][/bold]'' ;
    text id 25 start 221.80s for 3.8s at (4.0, 29.0) ''[color=#34D399]Pour tout $x \in \mathbb{R}$,  $x^2 \ge 0$[/color]'' ;
    text id 26 start 240.16s for 3.4s at (4.0, 42.0) ''[bold][color=#38BDF8]Exemple :[/color][/bold] [color=#F8FAFC]$g(x) = x^2 + 2$ sur $\mathbb{R}$[/color]'' ;
    text id 27 start 278.30s for 3.2s at (4.0, 54.0) ''[color=#F8FAFC]$\forall x \in \mathbb{R}, \quad x^2 \ge 0$[/color]'' ;
    text id 28 start 283.40s for 3.5s at (4.0, 64.0) ''[color=#F8FAFC]$\implies x^2 + 2 \ge 0 + 2$[/color]'' ;
    text id 29 start 289.60s for 3.4s at (4.0, 74.0) ''[bold][color=#34D399]Donc $g(x) \ge 2$ pour tout $x \in \mathbb{R}$[/color][/bold]'' ;

    # Repère [-3, 3] x [-1, 7], scale=6.5 -> width=39, height=52
    draw 2drep id 216 start 295.20s for 1.4s at (133.0, 74.5) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-1, 7] ;
    draw 2dfunc id 217 start 297.20s for 2.4s color (56, 189, 248, 1) width 2.8 at 216 y = x^2 + 2 ;
    draw line id 218 start 302.80s for 1.2s color (52, 211, 153, 1) width 2.5 at [(113.5, 61.5), (152.5, 61.5)] ;
    text id 30 start 304.20s for 1.2s at (154.5, 59.0) ''[bold][color=#34D399]$y = 2$[/color][/bold]'' ;
    draw circle id 219 start 305.80s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.2) at (133.0, 61.5) radius 1.6 ;
    mouse move id 604 start 307.00s for 2.2s at [(120, 42), (133, 61.5), (146, 42)] ;
    text id 31 start 314.00s for 3.2s at (4.0, 85.0) ''[bold][color=#FBBF24]Conclusion : min de $g$ sur $\mathbb{R}$ vaut $2$.[/color][/bold]'' ;

    erase id 803 start 328.20s ;

    # === SCENE 4 : Problème Guidé f(x) = 2 - 3(x + 5)² (329s -> 465.2s) ===
    text id 32 start 329.00s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Problème Guidé : Prise d'Initiative[/color][/bold]'' ;
    draw line id 220 start 331.20s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 33 start 332.00s for 4.0s at (4.0, 21.0) ''[bold][color=#F8FAFC]Énoncé :[/color][/bold] [color=#38BDF8]$f(x) = 2 - 3(x + 5)^2$[/color] [color=#F8FAFC]sur $\mathbb{R}$[/color]'' ;
    text id 34 start 338.36s for 3.0s at (4.0, 31.0) ''[color=#FBBF24]Question : Montrer que $f$ admet un extremum.[/color]'' ;
    text id 35 start 346.40s for 3.5s at (4.0, 42.0) ''[color=#C084FC]Extremum = Maximum OU Minimum (à trouver !)[/color]'' ;

    # Mise en évidence du bloc carré à droite + chaîne d'opérations
    text id 36 start 385.00s for 2.2s at (102.0, 24.0) ''[bold][color=#F8FAFC]$f(x) = 2 - 3$[/color] [color=#34D399]$(x + 5)^2$[/color][/bold]'' ;
    draw polygone id 221 start 388.76s for 1.2s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.16) at [(120.5, 22.5), (136.0, 22.5), (136.0, 30.0), (120.5, 30.0)] ;
    text id 37 start 398.75s for 4.0s at (4.0, 56.0) ''[bold][color=#34D399]Étape 1 (Départ) :[/color][/bold] [color=#F8FAFC]$\forall x \in \mathbb{R}, \; (x+5)^2 \ge 0$[/color]'' ;
    text id 38 start 413.00s for 3.6s at (4.0, 68.0) ''[color=#38BDF8]Objectif : $f(x) \le M$ ou $f(x) \ge m$[/color]'' ;
    text id 39 start 429.00s for 3.2s at (4.0, 79.0) ''[color=#F8FAFC]Reconstituer $f(x)$ de proche en proche.[/color]'' ;

    text id 40 start 455.80s at (110.0, 41.0) ''[color=#34D399]$(x + 5)^2$[/color]'' ;
    draw arrow id 222 start 456.20s for 0.8s color (248, 113, 113, 1) width 2.8 at [(118, 49), (118, 60)] ;
    text id 41 start 457.20s at (106.0, 62.0) ''[color=#FBBF24]$-3(x + 5)^2$[/color]'' ;
    draw arrow id 223 start 457.60s for 0.8s color (56, 189, 248, 1) width 2.8 at [(118, 69), (118, 80)] ;
    text id 42 start 458.60s at (103.0, 82.0) ''[color=#38BDF8]$2 - 3(x + 5)^2 = f(x)$[/color]'' ;
    text id 43 start 461.00s for 1.5s at (125.0, 52.0) ''[bold][color=#F87171]1) $\times (-3)$[/color][/bold]'' ;
    text id 44 start 463.30s for 1.3s at (125.0, 72.0) ''[bold][color=#38BDF8]2) $+ 2$[/color][/bold]'' ;

    erase id 804 start 465.20s ;

    # === SCENE 5 : Reconstitution & Piège du Signe Négatif (465.6s -> 596.0s) ===
    text id 45 start 465.60s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Reconstitution & Piège du Signe Négatif[/color][/bold]'' ;
    draw line id 224 start 467.60s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 46 start 469.00s for 3.5s at (4.0, 22.0) ''[color=#F8FAFC]Départ :  $(x + 5)^2 \ge 0$[/color]'' ;
    text id 47 start 473.50s for 3.0s at (4.0, 34.0) ''[color=#FBBF24]1) Multiplier par $(-3)$ :[/color]'' ;

    draw polygone id 225 start 495.92s for 1.2s color (248, 113, 113, 1) width 2.5 fillcolor (248, 113, 113, 0.14) at [(95, 22), (171, 22), (171, 52), (95, 52)] ;
    text id 48 start 497.50s for 2.6s at (99.0, 25.0) ''[bold][color=#F87171]PIÈGE CLASSIQUE :[/color][/bold]'' ;
    text id 49 start 500.40s for 2.8s at (99.0, 34.0) ''[color=#F8FAFC]Multiplier par $-3 < 0$[/color]'' ;
    text id 50 start 503.50s for 3.2s at (99.0, 42.5) ''[bold][color=#FBBF24]$\ge$  devient  $\le$  ![/color][/bold]'' ;
    draw line id 226 start 508.50s for 1.0s color (251, 191, 36, 1) width 3 at [(99, 49.5), (145, 49.5)] ;

    text id 51 start 513.52s for 3.8s at (4.0, 44.0) ''[color=#F8FAFC]$-3(x + 5)^2$ [color=#F87171]$\le$[/color] $-3 \times 0$[/color]'' ;
    text id 52 start 519.97s for 3.5s at (4.0, 54.0) ''[color=#34D399]$\implies -3(x + 5)^2 \le 0$[/color]'' ;
    text id 53 start 531.00s for 3.0s at (4.0, 66.0) ''[color=#38BDF8]2) Ajouter $+2$ (sens conservé) :[/color]'' ;

    draw polygone id 227 start 548.50s for 1.0s color (56, 189, 248, 1) width 2 fillcolor (56, 189, 248, 0.14) at [(95, 58), (171, 58), (171, 84), (95, 84)] ;
    text id 54 start 550.00s for 3.0s at (99.0, 62.0) ''[color=#F8FAFC]$2 - 3(x+5)^2 = \mathbf{+2} - 3(x+5)^2$[/color]'' ;
    text id 55 start 561.72s for 2.6s at (99.0, 72.5) ''[color=#34D399]Ajouter $+2$ ne change pas $\le$[/color]'' ;

    text id 56 start 566.44s for 4.0s at (4.0, 75.5) ''[color=#F8FAFC]$2 - 3(x + 5)^2 \le 0 + 2$[/color]'' ;
    text id 57 start 585.10s for 4.0s at (4.0, 85.5) ''[bold][color=#34D399]Donc $\forall x \in \mathbb{R}, \; f(x) \le 2$[/color][/bold]'' ;
    mouse move id 605 start 589.50s for 2.2s at [(4, 89), (56, 89)] ;

    erase id 805 start 596.00s ;

    # === SCENE 6 : Conclusion & Courbe Finale de f (596.5s -> 644.6s) ===
    text id 58 start 596.50s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Conclusion & Représentation Graphique[/color][/bold]'' ;
    draw line id 228 start 598.60s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 59 start 600.00s for 3.5s at (4.0, 22.0) ''[color=#F8FAFC]Pour tout $x \in \mathbb{R}$,  $f(x) \le 2$[/color]'' ;
    text id 60 start 614.00s for 3.8s at (4.0, 35.0) ''[bold][color=#F87171]Conclusion :[/color][/bold] [color=#F8FAFC]$f$ admet un maximum[/color]'' ;
    text id 61 start 618.00s for 2.0s at (4.0, 44.0) ''[bold][color=#FBBF24]sur $\mathbb{R}$, et ce maximum vaut $2$.[/color][/bold]'' ;
    text id 62 start 624.50s for 3.6s at (4.0, 58.0) ''[color=#38BDF8]Atteint quand $(x + 5)^2 = 0$[/color]'' ;
    text id 63 start 628.30s for 1.5s at (4.0, 67.0) ''[color=#34D399]$\iff x = -5$ (sommet $(-5 ; 2)$)[/color]'' ;

    # Repère [-8, 0] x [-6, 4], scale=6.0, origin at (157.0, 49.0) -> X in [109, 157], Y in [25, 85]
    draw 2drep id 229 start 630.00s for 1.4s at (157.0, 49.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-8, 0] y_range = [-6, 4] ;
    draw 2dfunc id 230 start 632.00s for 2.2s color (56, 189, 248, 1) width 2.8 at 229 y = 2 - 3 * (x + 5)^2 ;
    draw line id 231 start 634.50s for 1.2s color (248, 113, 113, 1) width 2.5 at [(109.0, 37.0), (157.0, 37.0)] ;
    text id 64 start 636.00s for 1.2s at (159.0, 34.5) ''[bold][color=#F87171]$y = 2$[/color][/bold]'' ;
    draw circle id 232 start 638.50s for 0.9s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.2) at (127.0, 37.0) radius 1.6 ;
    text id 65 start 639.70s for 1.4s at (116.0, 17.0) ''[bold][color=#FBBF24]Sommet $(-5 ; 2)$[/color][/bold]'' ;
    mouse move id 606 start 641.50s for 2.0s at [(117, 58), (127, 37), (137, 58)] ;

    erase id 806 start 644.60s ;

    # === SCENE 7 : Synthèse : Les 4 Réflexes (644.8s -> 685.6s) ===
    text id 66 start 644.80s for 2.0s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Synthèse : Les 4 Réflexes Méthode[/color][/bold]'' ;
    draw line id 233 start 647.10s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 67 start 649.31s for 4.0s at (4.0, 23.0) ''[bold][color=#34D399]1.[/color][/bold] [color=#F8FAFC]Repérer le carré : $(x + a)^2 \ge 0$ pour tout $x \in \mathbb{R}$.[/color]'' ;
    draw polygone id 234 start 653.60s for 0.8s color (52, 211, 153, 0.9) width 2 fillcolor (52, 211, 153, 0.14) at [(122, 22), (168, 22), (168, 32), (122, 32)] ;
    text id 71 start 654.60s for 1.2s at (126.0, 24.5) ''[color=#34D399]$(u(x))^2 \ge 0$[/color]'' ;

    text id 68 start 658.36s for 4.0s at (4.0, 39.0) ''[bold][color=#38BDF8]2.[/color][/bold] [color=#F8FAFC]Reconstituer $f(x)$ pas à pas (priorités opératoires).[/color]'' ;
    draw arrow id 235 start 662.60s for 0.6s color (56, 189, 248, 1) width 2.5 at [(145, 32), (145, 38)] ;
    draw polygone id 236 start 663.40s for 0.8s color (56, 189, 248, 0.9) width 2 fillcolor (56, 189, 248, 0.14) at [(122, 38), (168, 38), (168, 48), (122, 48)] ;
    text id 72 start 664.40s at (126.0, 40.5) ''[color=#38BDF8]Opérations ordonnées[/color]'' ;

    text id 69 start 665.24s for 4.0s at (4.0, 55.0) ''[bold][color=#F87171]3.[/color][/bold] [color=#F8FAFC]Multiplier par un négatif $\implies$ inverser $\ge$ et $\le$ ![/color]'' ;
    draw arrow id 237 start 669.50s for 0.6s color (248, 113, 113, 1) width 2.5 at [(145, 48), (145, 54)] ;
    draw polygone id 238 start 670.30s for 0.8s color (248, 113, 113, 0.9) width 2 fillcolor (248, 113, 113, 0.14) at [(122, 54), (168, 54), (168, 64), (122, 64)] ;
    text id 73 start 671.30s for 1.2s at (126.0, 56.5) ''[color=#F87171]Attention au signe $-$[/color]'' ;

    text id 70 start 672.95s for 4.0s at (4.0, 71.0) ''[bold][color=#FBBF24]4.[/color][/bold] [color=#F8FAFC]Conclure : nature (max ou min) et valeur exacte.[/color]'' ;
    draw arrow id 239 start 677.20s for 0.6s color (251, 191, 36, 1) width 2.5 at [(145, 64), (145, 70)] ;
    draw polygone id 240 start 678.00s for 0.8s color (251, 191, 36, 0.9) width 2 fillcolor (251, 191, 36, 0.14) at [(122, 70), (168, 70), (168, 80), (122, 80)] ;
    text id 74 start 679.00s for 1.4s at (126.0, 72.5) ''[color=#FBBF24]Max ou Min trouvé ![/color]'' ;

    erase id 807 start 685.60s ;

    # === SCENE 8 : Exercice d'Entraînement Final h(x) = -5 + 2(x - 1)² (686.16s -> 728.05s) ===
    text id 75 start 686.16s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. À Toi de Jouer : Exercice d'Entraînement[/color][/bold]'' ;
    draw line id 241 start 688.20s for 0.6s color (248, 250, 252, 0.6) width 1.5 at [(4, 13.5), (173, 13.5)] ;
    text id 76 start 689.28s for 4.0s at (4.0, 22.0) ''[bold][color=#FBBF24]Exercice :[/color][/bold] [color=#F8FAFC]$h(x) = -5 + 2(x - 1)^2$ sur $\mathbb{R}$[/color]'' ;
    text id 77 start 696.36s for 2.8s at (4.0, 32.0) ''[color=#38BDF8]Montrer que $h$ admet un extremum et préciser sa valeur.[/color]'' ;

    # Repère [-2, 4] x [-7, 3], scale=6.0, origin at (127.0, 43.0) -> X in [115, 151], Y in [25, 85]
    draw 2drep id 242 start 699.74s for 1.4s at (127.0, 43.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 4] y_range = [-7, 3] ;
    draw 2dfunc id 243 start 701.40s for 1.8s color (56, 189, 248, 1) width 2.8 at 242 y = -5 + 2 * (x - 1)^2 ;

    text id 78 start 703.44s for 2.8s at (4.0, 46.0) ''[color=#F8FAFC]1) $(x - 1)^2 \ge 0$[/color]'' ;
    text id 79 start 707.32s for 3.0s at (4.0, 56.0) ''[color=#F8FAFC]2) $2(x - 1)^2 \ge 0$  (car $2 > 0$)[/color]'' ;
    text id 80 start 711.60s for 3.6s at (4.0, 66.0) ''[color=#34D399]3) $-5 + 2(x - 1)^2 \ge -5 \implies h(x) \ge -5$[/color]'' ;
    text id 81 start 718.04s for 3.2s at (4.0, 78.0) ''[bold][color=#FBBF24]Réponse : minimum de $h$ sur $\mathbb{R}$ vaut $-5$.[/color][/bold]'' ;

    draw line id 244 start 721.50s for 1.0s color (52, 211, 153, 1) width 2.5 at [(115.0, 73.0), (151.0, 73.0)] ;
    draw circle id 245 start 722.70s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.2) at (133.0, 73.0) radius 1.6 ;
    mouse move id 607 start 723.80s for 2.2s at [(122, 42), (133, 73), (144, 42)] ;

}
