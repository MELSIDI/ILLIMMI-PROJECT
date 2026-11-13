course "Variations de fonctions et extrema en pratique" id 39 idgap 200 for 452.0s audio "narration.wav" {

    # ==================== SCENE 1 : Accroche & Forme Canonique ====================
    text id 1 start 0.2s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]1. Extremum et Forme Canonique[/bold][/color]'' ;
    draw line id 201 start 2.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 8.3s for 2.8s at (4.0, 20.0) ''[color=#F8FAFC]Extremum : [/color][color=#34D399]minimum[/color][color=#F8FAFC] ou [/color][color=#FBBF24]maximum[/color][color=#F8FAFC] d'une fonction.[/color]'' ;
    text id 3 start 19.1s for 3.2s at (4.0, 32.0) ''[color=#F8FAFC]Énoncé : [/color][color=#38BDF8]$f(x) = 2x^2 + 4x + 5$[/color]'' ;
    text id 4 start 26.3s for 3.0s at (4.0, 44.0) ''[color=#FBBF24][bold]Question 1 :[/bold][/color][color=#F8FAFC] Prouver que $f(x) = 2(x + 1)^2 + 3$.[/color]'' ;
    text id 5 start 39.9s for 3.5s at (4.0, 58.0) ''[color=#34D399]Forme canonique : [/color][color=#F8FAFC]$a(x - \alpha)^2 + \beta$[/color]'' ;

    draw polygone id 202 start 45.2s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.14) width 2.0 at [(95, 22), (171, 22), (171, 42), (95, 42)] ;
    text id 7 start 46.3s for 2.2s at (99.0, 26.5) ''[color=#34D399]Forme canonique : [/color][color=#F8FAFC]$2(x + 1)^2 + 3$[/color]'' ;
    text id 8 start 51.5s for 2.5s at (99.0, 34.0) ''[color=#FBBF24]$a = 2$[/color][color=#F8FAFC], carré $(x+1)^2$, constante $+3$[/color]'' ;

    text id 6 start 64.4s for 3.5s at (4.0, 72.0) ''[color=#F8FAFC]Méthode : développer et réduire pour retrouver [/color][color=#38BDF8]$f(x)$[/color][color=#F8FAFC].[/color]'' ;

    draw arrow id 203 start 72.1s for 1.0s color (56, 189, 248, 1) width 2.5 at [(133, 44), (133, 60)] ;
    text id 9 start 73.5s for 2.0s at (137.0, 49.5) ''[color=#38BDF8]Développer & Réduire[/color]'' ;
    draw polygone id 204 start 78.1s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.14) width 2.0 at [(95, 62), (171, 62), (171, 82), (95, 82)] ;
    text id 10 start 80.5s for 2.2s at (101.0, 69.0) ''[color=#38BDF8]Expression de $f$ : [/color][color=#F8FAFC]$2x^2 + 4x + 5$[/color]'' ;

    # ==================== SCENE 2 : Preuve par Développement ====================
    erase id 801 start 83.4s ;

    text id 11 start 83.5s for 1.7s at (4.0, 7.5) ''[color=#38BDF8][bold]2. Preuve par Développement et Réduction[/bold][/color]'' ;
    draw line id 205 start 85.5s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 12 start 86.9s for 2.2s at (4.0, 21.0) ''[color=#F8FAFC]$2(x + 1)^2 + 3$[/color]'' ;
    text id 13 start 93.3s for 2.5s at (4.0, 35.0) ''[color=#34D399]$= 2(x^2 + 2x + 1) + 3$[/color]'' ;

    draw polygone id 206 start 96.4s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.14) width 2.0 at [(95, 20), (172, 20), (172, 38), (95, 38)] ;
    text id 14 start 98.8s for 2.8s at (99.0, 24.0) ''[color=#34D399]Identité remarquable :[/color]'' ;
    text id 15 start 102.3s for 2.5s at (99.0, 30.5) ''[color=#F8FAFC]$(a + b)^2 = a^2 + 2ab + b^2$[/color]'' ;

    text id 16 start 116.9s for 1.8s at (107.0, 43.0) ''[color=#FBBF24][bold]Distributivité ($\times 2$)[/bold][/color]'' ;
    text id 17 start 119.0s for 1.8s at (104.0, 59.0) ''[color=#F8FAFC]$x^2 \quad\;\; +2x \quad\;\; +1$[/color]'' ;
    draw arrow id 207 start 121.2s for 0.6s color (251, 191, 36, 1) width 2.0 at [(115.0, 49.5), (105.5, 58.0)] ;
    draw arrow id 208 start 122.2s for 0.6s color (251, 191, 36, 1) width 2.0 at [(119.0, 49.5), (116.5, 58.0)] ;
    draw arrow id 209 start 123.2s for 0.6s color (251, 191, 36, 1) width 2.0 at [(123.0, 49.5), (127.0, 58.0)] ;

    text id 18 start 126.9s for 3.2s at (4.0, 49.0) ''[color=#FBBF24]$= 2x^2 + 4x + 2 + 3$[/color]'' ;
    text id 19 start 146.3s for 2.5s at (4.0, 63.0) ''[color=#38BDF8]$= 2x^2 + 4x + 5$[/color]'' ;

    draw polygone id 210 start 158.4s for 1.0s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.14) width 2.5 at [(2.5, 61.5), (34.0, 61.5), (34.0, 70.5), (2.5, 70.5)] ;
    draw polygone id 211 start 160.0s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.12) width 2.0 at [(95, 70), (172, 70), (172, 86), (95, 86)] ;
    text id 21 start 161.2s for 2.5s at (99.0, 75.0) ''[color=#38BDF8]Égalité : [/color][color=#F8FAFC]$2(x+1)^2 + 3 = f(x)$[/color]'' ;

    text id 20 start 166.7s for 2.8s at (4.0, 77.0) ''[color=#34D399][bold]Conclusion :[/bold][/color][color=#F8FAFC] $= f(x)$ (Forme canonique vérifiée)[/color]'' ;
    mouse move id 601 start 170.8s for 1.5s at [(34.0, 66.0), (58.0, 79.0)] ;

    # ==================== SCENE 3 : Tableau & Orientation ====================
    erase id 802 start 176.2s ;

    text id 22 start 176.4s for 1.7s at (4.0, 7.5) ''[color=#38BDF8][bold]3. Tableau de Variations et Orientation[/bold][/color]'' ;
    draw line id 212 start 178.4s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw polygone id 213 start 190.3s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(4, 24), (82, 24), (82, 60), (4, 60)] ;
    draw line id 214 start 194.2s for 0.6s color (248, 250, 252, 0.95) width 1.5 at [(4, 34), (82, 34)] ;
    draw line id 215 start 195.2s for 0.6s color (248, 250, 252, 0.95) width 1.5 at [(18, 24), (18, 60)] ;
    text id 23 start 196.1s at (9.5, 27.0) ''[color=#F8FAFC]$x$[/color]'' ;
    text id 24 start 197.4s at (20.5, 27.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 25 start 198.2s at (72.0, 27.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    text id 26 start 201.9s at (6.5, 44.5) ''[color=#38BDF8]$f(x)$[/color]'' ;

    text id 27 start 218.4s for 2.2s at (96.0, 18.0) ''[color=#34D399][bold]Cas 1 : $a > 0$[/bold][/color][color=#F8FAFC] (branches vers le haut)[/color]'' ;
    draw path id 216 start 221.0s for 1.5s color (52, 211, 153, 1) width 3.0 at [(112, 25.0), (116, 31.5), (120, 36.5), (124, 40.1), (128, 42.3), (132, 43.0), (136, 42.3), (140, 40.1), (144, 36.5), (148, 31.5), (152, 25.0)] ;
    text id 28 start 228.6s for 2.2s at (98.0, 46.5) ''[color=#34D399]Décroissante puis croissante (Minimum)[/color]'' ;

    text id 29 start 232.2s for 2.2s at (96.0, 58.0) ''[color=#F87171][bold]Cas 2 : $a < 0$[/bold][/color][color=#F8FAFC] (branches vers le bas)[/color]'' ;
    draw path id 217 start 234.8s for 1.5s color (248, 113, 113, 1) width 3.0 at [(112, 84.0), (116, 77.5), (120, 72.5), (124, 68.9), (128, 66.7), (132, 66.0), (136, 66.7), (140, 68.9), (144, 72.5), (148, 77.5), (152, 84.0)] ;
    text id 30 start 239.0s for 2.2s at (98.0, 88.0) ''[color=#F87171]Croissante puis décroissante (Maximum)[/color]'' ;

    text id 31 start 255.1s for 2.8s at (4.0, 67.0) ''[color=#FBBF24]$f(x) = 2x^2 + 4x + 5 \implies a = 2 > 0$[/color]'' ;
    text id 32 start 268.9s for 2.5s at (4.0, 77.0) ''[color=#34D399]Branches vers le haut $\implies$ Cas 1 ![/color]'' ;

    draw arrow id 218 start 282.0s for 1.0s color (52, 211, 153, 1) width 2.5 at [(24, 38), (47, 54)] ;
    draw arrow id 219 start 285.6s for 1.0s color (52, 211, 153, 1) width 2.5 at [(53, 54), (76, 38)] ;

    text id 33 start 292.4s for 2.4s at (4.0, 87.0) ''[color=#34D399][bold]La fonction admet donc un minimum.[/bold][/color]'' ;

    # ==================== SCENE 4 : Piège sur alpha et Extremum beta ====================
    erase id 803 start 301.0s ;

    text id 34 start 301.2s for 1.7s at (4.0, 7.5) ''[color=#38BDF8][bold]4. Valeurs de $\alpha$ et $\beta$ (Attention au Piège !)[/bold][/color]'' ;
    draw line id 220 start 303.2s for 0.6s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 35 start 304.0s for 3.2s at (4.0, 19.0) ''[color=#F8FAFC]Forme : [/color][color=#38BDF8]$a(x - \alpha)^2 + \beta$[/color][color=#F8FAFC] $\rightarrow$ minimum en $x = \alpha$[/color]'' ;
    text id 36 start 322.6s for 3.0s at (4.0, 31.0) ''[color=#F8FAFC]Ici : [/color][color=#34D399]$f(x) = 2(x + 1)^2 + 3$[/color]'' ;
    text id 37 start 331.2s for 3.2s at (4.0, 44.0) ''[color=#F87171][bold]PIÈGE :[/bold][/color][color=#F8FAFC] On voit $+1$, mais la formule a $-\alpha$ ![/color]'' ;
    text id 38 start 347.2s for 3.2s at (4.0, 56.0) ''[color=#FBBF24]$x + 1 = x - (-1) \implies \alpha = -1$[/color]'' ;
    text id 39 start 361.4s for 2.6s at (4.0, 68.0) ''[color=#34D399]Minimum atteint en [/color][color=#FBBF24][bold]$x = -1$[/bold][/color]'' ;

    draw polygone id 221 start 364.4s for 0.6s color (248, 250, 252, 0.95) width 2.0 at [(96, 30), (171, 30), (171, 74), (96, 74)] ;
    draw line id 222 start 365.2s for 0.4s color (248, 250, 252, 0.95) width 1.5 at [(96, 42), (171, 42)] ;
    draw line id 223 start 365.8s for 0.4s color (248, 250, 252, 0.95) width 1.5 at [(112, 30), (112, 74)] ;
    text id 41 start 366.4s at (102.5, 33.5) ''[color=#F8FAFC]$x$[/color]'' ;
    text id 42 start 366.5s at (114.5, 33.5) ''[color=#F8FAFC]$-\infty$[/color]'' ;
    text id 43 start 366.6s at (161.0, 33.5) ''[color=#F8FAFC]$+\infty$[/color]'' ;
    text id 44 start 366.7s at (99.5, 55.0) ''[color=#38BDF8]$f(x)$[/color]'' ;
    draw arrow id 224 start 366.8s color (52, 211, 153, 1) width 2.5 at [(118, 46), (138, 63)] ;
    draw arrow id 225 start 366.9s color (52, 211, 153, 1) width 2.5 at [(145, 63), (165, 46)] ;

    text id 45 start 367.0s for 1.5s at (139.0, 33.8) ''[color=#FBBF24][bold]$-1$[/bold][/color]'' ;
    draw circle id 226 start 368.8s for 0.7s color (251, 191, 36, 1) width 2.0 radius 4.2 at (141.5, 36.2) ;

    text id 40 start 382.6s for 3.0s at (4.0, 80.0) ''[color=#34D399]Valeur du minimum : [/color][color=#C084FC][bold]$\beta = 3$[/bold][/color]'' ;

    text id 46 start 398.8s for 1.5s at (140.4, 64.9) ''[color=#C084FC][bold]$3$[/bold][/color]'' ;
    draw circle id 227 start 400.6s for 0.7s color (192, 132, 252, 1) width 2.0 radius 4.2 at (141.5, 67.2) ;

    # ==================== SCENE 5 : Synthèse Graphique sur Repère ====================
    erase id 804 start 405.0s ;

    text id 47 start 405.1s at (4.0, 7.5) ''[color=#38BDF8][bold]5. Synthèse Graphique : Parabole et Sommet[/bold][/color]'' ;
    draw line id 228 start 405.3s color (56, 189, 248, 0.7) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    draw 2drep id 229 start 405.5s for 2.0s at (139.5, 81.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-5, 3] y_range = [-1, 9] ;

    text id 48 start 409.5s for 2.5s at (4.0, 20.0) ''[color=#34D399]$f(x) = 2(x + 1)^2 + 3$[/color]'' ;

    draw 2dfunc id 230 start 413.7s for 3.0s color (56, 189, 248, 1) width 3.0 at 229 y = 2*(x+1)^2+3 ;

    draw circle id 231 start 423.0s for 1.2s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.22) width 2.5 radius 2.2 at (133.0, 61.5) ;
    text id 49 start 425.2s for 2.5s at (4.0, 34.0) ''[color=#FBBF24][bold]Sommet $S(-1 ; 3)$[/bold][/color]'' ;

    text id 50 start 430.8s for 3.2s at (4.0, 48.0) ''[color=#F8FAFC]Décroissante sur $]-\infty ; -1]$[/color]'' ;
    text id 51 start 434.8s for 3.0s at (4.0, 60.0) ''[color=#F8FAFC]Croissante sur $[-1 ; +\infty[$[/color]'' ;
    text id 52 start 442.5s for 3.2s at (4.0, 74.0) ''[color=#34D399][bold]Minimum : $3$, atteint en $x = -1$[/bold][/color]'' ;

    mouse move id 602 start 446.3s for 1.8s at [(50.0, 77.0), (133.0, 61.5)] ;
}
