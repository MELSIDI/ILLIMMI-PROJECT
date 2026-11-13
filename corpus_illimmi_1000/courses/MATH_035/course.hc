course "Problème type Bac : Variations de fonctions et extrema — Raisonnement en plusieurs étapes" id 35 idgap 200 for 346.5s audio "narration.wav" {

# ==========================================================
# SCENE 1 : 1. Accroche & Fonction du Second Degré (0s - 41.5s)
# ==========================================================
text id 1 start 0.20s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Accroche & Fonction du Second Degré[/color][/bold]'' ;
draw line id 201 start 2.00s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

text id 2 start 3.00s for 3.0s at (4.0, 22.0) ''[color=#F8FAFC]Objectif : variations et [color=#FBBF24]extremum[/color] d'une fonction du $2^{\text{nd}}$ degré.[/color]'' ;
text id 3 start 9.00s for 3.2s at (4.0, 36.0) ''[color=#F8FAFC]Soit $f$ définie sur $\mathbb{R}$ par :[/color]'' ;
text id 4 start 13.50s for 2.6s at (6.0, 48.0) ''[color=#38BDF8]$$f(x) = -x^2 + 4x$$[/color]'' ;
text id 5 start 19.20s for 3.2s at (4.0, 65.0) ''[color=#34D399]Polynôme du $2^{\text{nd}}$ degré (exposant max $= 2$).[/color]'' ;
text id 6 start 26.60s for 2.8s at (4.0, 77.0) ''[color=#FBBF24]Sa représentation graphique est une parabole.[/color]'' ;

draw 2drep id 202 start 30.60s for 1.2s at (118, 66.25) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 5] y_range = [-2, 5] ;
draw 2dfunc id 203 start 32.30s for 1.8s color (251, 191, 36, 1) width 2.8 at 202 y = 4*x - x^2 ;

text id 7 start 34.80s for 3.2s at (4.0, 89.0) ''[color=#F87171]Son sens dépend du signe de $a$ (devant $x^2$).[/color]'' ;
mouse move id 601 start 38.50s for 1.2s at [(118, 66.25), (133, 39.0)] ;

erase id 801 start 41.50s ;

# ==========================================================
# SCENE 2 : 2. Allure de la Parabole : Minimum ou Maximum (41.6s - 95.0s)
# ==========================================================
text id 8 start 41.62s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Allure de la Parabole : Minimum ou Maximum[/color][/bold]'' ;
draw line id 204 start 43.40s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

text id 9 start 46.00s for 3.0s at (4.0, 22.0) ''[bold][color=#34D399]Cas 1 : $a > 0$[/color][/bold] [color=#F8FAFC](branches vers le haut)[/color]'' ;
draw path id 205 start 49.60s for 1.5s color (52, 211, 153, 1) width 3 at [(98.5, 28.6), (100.75, 35.75), (103.0, 41.6), (105.25, 46.15), (107.5, 49.4), (109.75, 51.35), (112.0, 52.0), (114.25, 51.35), (116.5, 49.4), (118.75, 46.15), (121.0, 41.6), (123.25, 35.75), (125.5, 28.6)] ;
text id 10 start 51.50s for 1.5s at (99.0, 17.5) ''[color=#34D399]$a > 0$ : cuvette[/color]'' ;
draw circle id 206 start 53.70s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) radius 2.0 at (112, 52) ;
text id 11 start 55.20s for 1.8s at (101.0, 58.0) ''[color=#FBBF24]Minimum[/color]'' ;

text id 12 start 58.60s for 3.2s at (4.0, 38.0) ''[bold][color=#F87171]Cas 2 : $a < 0$[/color][/bold] [color=#F8FAFC](branches vers le bas)[/color]'' ;
draw path id 207 start 67.40s for 1.5s color (248, 113, 113, 1) width 3 at [(140.5, 51.4), (142.75, 44.25), (145.0, 38.4), (147.25, 33.85), (149.5, 30.6), (151.75, 28.65), (154.0, 28.0), (156.25, 28.65), (158.5, 30.6), (160.75, 33.85), (163.0, 38.4), (165.25, 44.25), (167.5, 51.4)] ;
text id 13 start 69.50s for 1.5s at (141.0, 58.0) ''[color=#F87171]$a < 0$ : colline[/color]'' ;
draw circle id 208 start 71.40s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.25) radius 2.0 at (154, 28) ;
text id 14 start 72.60s for 1.8s at (143.0, 17.5) ''[color=#FBBF24]Maximum[/color]'' ;

text id 15 start 78.38s for 3.0s at (4.0, 56.0) ''[color=#F8FAFC]Ici : $f(x) = -1x^2 + 4x \implies$ [color=#F87171]$a = -1 < 0$[/color][/color]'' ;
text id 16 start 83.50s for 3.0s at (4.0, 72.0) ''[color=#F8FAFC]Donc l'extremum de $f$ est un [bold][color=#FBBF24]maximum[/color][/bold].[/color]'' ;

draw polygone id 209 start 87.40s for 1.2s color (251, 191, 36, 0.95) width 2 fillcolor (251, 191, 36, 0.14) at [(96, 70), (171, 70), (171, 88), (96, 88)] ;
text id 17 start 89.00s for 2.5s at (100.0, 75.5) ''[color=#FBBF24]Objectif : trouver $(\alpha ; \beta)$ du maximum[/color]'' ;

erase id 802 start 95.00s ;

# ==========================================================
# SCENE 3 : 3. Mise sous Forme Canonique : Étape par Étape (95.1s - 200.0s)
# ==========================================================
text id 18 start 95.10s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Mise sous Forme Canonique : Étape par Étape[/color][/bold]'' ;
draw line id 210 start 96.80s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

text id 19 start 100.56s for 3.5s at (4.0, 21.0) ''[color=#38BDF8]Départ : $f(x) = -x^2 + 4x$[/color]'' ;
text id 20 start 106.14s for 2.5s at (96.0, 19.0) ''[color=#FBBF24]Étape 1 :[/color] [color=#F8FAFC]factoriser par $-1$[/color]'' ;
text id 21 start 112.66s for 3.8s at (4.0, 34.0) ''[color=#F8FAFC]1) $f(x) = -\big[x^2 - 4x\big]$[/color]'' ;
text id 22 start 119.30s for 2.8s at (96.0, 31.0) ''[color=#34D399]Vérif : $-(-4x) = +4x$[/color]'' ;

text id 23 start 123.66s for 3.2s at (96.0, 44.0) ''[color=#FBBF24]Étape 2 :[/color] [color=#F8FAFC]$(x - 2)^2 = x^2 - 4x + 4$[/color]'' ;
text id 24 start 131.98s for 3.5s at (4.0, 47.0) ''[color=#F8FAFC]2) $f(x) = -\big[x^2 - 4x + 4 - 4\big]$[/color]'' ;
text id 25 start 140.96s for 2.5s at (96.0, 56.0) ''[color=#38BDF8]Équilibre : $+4 - 4 = 0$[/color]'' ;

text id 26 start 151.86s for 3.2s at (4.0, 60.0) ''[color=#F8FAFC]3) $f(x) = -\big[(x - 2)^2 - 4\big]$[/color]'' ;
draw arrow id 211 start 160.24s for 1.2s color (52, 211, 153, 1) width 2.5 at [(94, 48), (64, 62)] ;
mouse move id 602 start 162.50s for 1.5s at [(30, 52), (44, 67)] ;

text id 27 start 172.20s for 2.8s at (96.0, 68.0) ''[color=#FBBF24]Étape 4 :[/color] [color=#F8FAFC]distribuer le signe $-$[/color]'' ;
text id 28 start 179.70s for 3.2s at (4.0, 74.0) ''[color=#34D399]4) $f(x) = -(x - 2)^2 + 4$[/color]'' ;

draw polygone id 212 start 188.01s for 1.0s color (56, 189, 248, 0.95) width 2 fillcolor (56, 189, 248, 0.14) at [(95, 77), (173, 77), (173, 96), (95, 96)] ;
text id 29 start 189.30s for 3.2s at (98.0, 78.5) ''[color=#38BDF8]Forme canonique : $a(x - \alpha)^2 + \beta$[/color]'' ;
text id 30 start 194.50s for 3.0s at (98.0, 87.5) ''[color=#FBBF24]$a = -1 \quad ; \quad \alpha = 2 \quad ; \quad \beta = 4$[/color]'' ;

erase id 803 start 200.00s ;

# ==========================================================
# SCENE 4 : 4. Lecture de l'Extremum & Piège à Éviter (200.1s - 251.4s)
# ==========================================================
text id 31 start 200.26s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Lecture de l'Extremum & Piège à Éviter[/color][/bold]'' ;
draw line id 213 start 202.00s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

text id 32 start 205.70s for 2.5s at (4.0, 21.0) ''[bold][color=#34D399]Propriété Fondamentale :[/color][/bold]'' ;
text id 33 start 208.90s for 3.8s at (4.0, 32.0) ''[color=#F8FAFC]Si $f(x) = a(x - \alpha)^2 + \beta$ :[/color]'' ;
text id 34 start 216.14s for 3.8s at (4.0, 44.0) ''[color=#F8FAFC]Extremum atteint en $x = \alpha$, valeur $= \beta$.[/color]'' ;

draw polygone id 214 start 221.96s for 1.0s color (248, 113, 113, 0.95) width 2 fillcolor (248, 113, 113, 0.14) at [(4, 58), (85, 58), (85, 86), (4, 86)] ;
text id 35 start 223.20s for 3.0s at (6.0, 60.0) ''[bold][color=#F87171]PIÈGE FRÉQUENT :[/color][/bold]'' ;
text id 36 start 227.80s for 3.8s at (6.0, 72.0) ''[color=#F8FAFC]Dans $(x - 2)^2$, on a $\alpha = +2$ (et non $-2$ !)[/color]'' ;

text id 37 start 233.70s for 3.0s at (96.0, 22.0) ''[color=#F8FAFC]Pour $f(x) = -(x - 2)^2 + 4$ :[/color]'' ;
text id 38 start 237.00s for 3.0s at (96.0, 35.0) ''[color=#F87171]$a = -1 < 0 \implies$ Maximum[/color]'' ;
text id 39 start 241.30s for 2.8s at (96.0, 48.0) ''[color=#38BDF8]Atteint en $x = \alpha = \mathbf{2}$[/color]'' ;
text id 40 start 245.34s for 2.6s at (96.0, 60.0) ''[color=#34D399]Valeur du maximum : $\beta = \mathbf{4}$[/color]'' ;

draw polygone id 215 start 248.88s for 1.2s color (251, 191, 36, 0.95) width 2.5 fillcolor (251, 191, 36, 0.15) at [(95, 72), (172, 72), (172, 90), (95, 90)] ;
text id 41 start 250.15s for 0.8s at (98.0, 77.5) ''[bold][color=#FBBF24]Maximum $= 4$, atteint en $x = 2$.[/color][/bold]'' ;

erase id 804 start 251.40s ;

# ==========================================================
# SCENE 5 : 5. Tableau de Variations de f sur R (251.5s - 307.9s)
# ==========================================================
text id 42 start 251.50s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Tableau de Variations de $f$ sur $\mathbb{R}$[/color][/bold]'' ;
draw line id 216 start 253.25s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

text id 43 start 258.36s for 2.2s at (4.0, 22.0) ''[bold][color=#F8FAFC]Deux profils possibles :[/color][/bold]'' ;
text id 44 start 261.00s for 3.2s at (4.0, 34.0) ''[color=#34D399]• $a > 0$ : décroissante, min, croissante[/color]'' ;
text id 45 start 265.76s for 3.2s at (4.0, 48.0) ''[color=#F87171]• $a < 0$ : croissante, max, décroissante[/color]'' ;
text id 46 start 270.06s for 1.8s at (4.0, 64.0) ''[color=#FBBF24]Ici $a = -1 < 0 \implies$ 2ème cas ![/color]'' ;

draw polygone id 217 start 272.10s for 1.0s color (248, 250, 252, 0.95) width 2 at [(94, 24), (172, 24), (172, 80), (94, 80)] ;
draw line id 218 start 273.30s for 0.7s color (248, 250, 252, 0.95) width 2 at [(94, 38), (172, 38)] ;
draw line id 219 start 274.20s for 0.7s color (248, 250, 252, 0.95) width 2 at [(110, 24), (110, 80)] ;

text id 47 start 277.16s at (100.0, 28.0) ''[color=#F8FAFC]$x$[/color]'' ;
text id 48 start 278.53s at (113.0, 28.0) ''[color=#F8FAFC]$-\infty$[/color]'' ;
text id 49 start 279.60s at (159.0, 28.0) ''[color=#F8FAFC]$+\infty$[/color]'' ;
text id 50 start 286.17s for 1.0s at (139.0, 28.0) ''[color=#FBBF24]$\mathbf{2}$[/color]'' ;

text id 51 start 293.29s at (96.0, 56.0) ''[color=#F8FAFC]$f(x)$[/color]'' ;
draw arrow id 220 start 296.60s for 1.8s color (52, 211, 153, 1) width 3 at [(116, 72), (136, 48)] ;
draw arrow id 221 start 300.70s for 1.8s color (248, 113, 113, 1) width 3 at [(146, 48), (166, 72)] ;
text id 52 start 305.03s for 1.2s at (139.0, 42.0) ''[color=#FBBF24]$\mathbf{4}$[/color]'' ;

erase id 805 start 307.90s ;

# ==========================================================
# SCENE 6 : 6. Représentation Graphique & Synthèse (308.0s - 346.5s)
# ==========================================================
text id 53 start 308.00s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Représentation Graphique & Synthèse[/color][/bold]'' ;
draw line id 222 start 309.75s for 0.8s color (248, 250, 252, 0.5) width 1.5 at [(4, 13.5), (173, 13.5)] ;

draw 2drep id 223 start 311.30s for 1.5s at (117, 67) color (248, 250, 252, 0.95) width 1.5 scale = 8.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-1, 5] y_range = [-2, 5] ;

draw circle id 224 start 317.00s for 0.8s color (251, 191, 36, 1) width 2.5 fillcolor (251, 191, 36, 0.35) radius 1.5 at (133, 35) ;
text id 54 start 318.20s for 1.5s at (124.0, 18.0) ''[color=#FBBF24]Sommet $S(2 ; 4)$[/color]'' ;
draw 2dfunc id 225 start 320.60s for 2.2s color (56, 189, 248, 1) width 3.0 at 223 y = 4*x - x^2 ;

text id 55 start 326.04s for 2.8s at (4.0, 21.0) ''[bold][color=#38BDF8]Synthèse en 4 étapes :[/color][/bold]'' ;
text id 56 start 329.20s for 2.2s at (4.0, 34.0) ''[color=#F8FAFC]1. Signe de $a$ ($a=-1<0 \implies$ maximum)[/color]'' ;
draw circle id 226 start 332.15s for 0.6s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.25) radius 1.4 at (117, 67) ;
draw circle id 227 start 333.13s for 0.6s color (52, 211, 153, 1) width 2 fillcolor (52, 211, 153, 0.25) radius 1.4 at (149, 67) ;
text id 57 start 334.86s for 2.2s at (4.0, 48.0) ''[color=#F8FAFC]2. Forme canonique : $-(x-2)^2 + 4$[/color]'' ;
text id 58 start 337.46s for 2.2s at (4.0, 62.0) ''[color=#F8FAFC]3. Sommet $S(2 ; 4)$ et variations[/color]'' ;
text id 59 start 340.56s for 2.5s at (4.0, 76.0) ''[color=#34D399]4. Courbe passant par $(0;0)$ et $(4;0)$[/color]'' ;
mouse move id 603 start 343.50s for 1.8s at [(117, 67), (133, 35), (153, 71)] ;

}
