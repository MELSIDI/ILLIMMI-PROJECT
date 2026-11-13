course "Démontrer qu'une fonction est croissante : f(x) = x^2 + 1" id 34 idgap 200 for 440.82s audio "narration.wav" {

    # ==========================================================
    # SCENE 1 : Objectif et Rappel Graphique sur la Croissance
    # ==========================================================
    text id 1 start 0.15s for 2.1s at (4.0, 5.5) ''[bold][color=#38BDF8]Démontrer qu'une fonction est croissante[/color][/bold]'' ;
    draw line id 201 start 2.60s for 0.6s color (248, 250, 252, 0.5) width 1.5 at [(4.0, 12.5), (173.0, 12.5)] ;

    text id 2 start 8.90s for 2.8s at (4.0, 17.5) ''[color=#F8FAFC][bold]Exercice :[/bold] Étude sur $[0 ; +\infty[$[/color]'' ;
    text id 3 start 14.60s for 3.2s at (4.0, 28.5) ''[color=#34D399]$$f(x) = x^2 + 1$$[/color]'' ;
    text id 4 start 21.70s for 3.2s at (4.0, 44.0) ''[color=#FBBF24][bold]Objectif :[/bold] Prouver algébriquement que $f$ est croissante sur $[0 ; +\infty[$.[/color]'' ;

    draw 2drep id 202 start 36.80s for 1.5s at (133.0, 58.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-4, 4] y_range = [-3, 4] ;
    draw 2dfunc id 203 start 39.10s for 2.2s color (56, 189, 248, 1) width 2.8 at 202 y = 0.45*x + 0.02*x^3 ;

    text id 5 start 46.10s for 3.2s at (4.0, 61.0) ''[color=#38BDF8]Lecture toujours de [bold]gauche à droite[/bold][/color]'' ;
    draw arrow id 204 start 52.30s for 1.2s color (251, 191, 36, 1) width 2.8 at [(108.0, 82.0), (158.0, 82.0)] ;
    text id 6 start 54.50s for 1.2s at (119.0, 84.5) ''[color=#FBBF24]Sens croissant ($x$)[/color]'' ;

    mouse move id 601 start 61.20s for 3.5s at [(113.5, 70.3), (152.5, 45.7)] ;
    text id 7 start 68.70s for 2.5s at (4.0, 73.0) ''[color=#34D399][bold]La courbe monte[/bold] $\Rightarrow$ fonction croissante[/color]'' ;

    erase id 801 start 75.10s ;

    # ==========================================================
    # SCENE 2 : Définition Algébrique et Vérification Graphique
    # ==========================================================
    text id 8 start 75.20s for 2.2s at (4.0, 5.5) ''[bold][color=#38BDF8]Définition Algébrique d'une Fonction Croissante[/color][/bold]'' ;
    draw line id 205 start 77.80s for 0.6s color (248, 250, 252, 0.5) width 1.5 at [(4.0, 12.5), (173.0, 12.5)] ;

    text id 9 start 83.40s for 2.6s at (4.0, 17.5) ''[color=#FBBF24][bold]Propriété sur un intervalle $I$ :[/bold][/color]'' ;
    text id 10 start 89.70s for 4.0s at (4.0, 26.5) ''[color=#F8FAFC]Pour tous réels $a, b \in I$ :[/color]'' ;
    text id 11 start 95.80s for 3.6s at (4.0, 35.0) ''[color=#34D399]$$a < b \implies f(a) < f(b)$$[/color]'' ;
    text id 12 start 99.90s for 3.2s at (4.0, 51.0) ''[color=#38BDF8]Une fonction croissante [bold]conserve l'ordre[/bold].[/color]'' ;

    draw 2drep id 206 start 115.30s for 1.4s at (106.0, 80.0) color (248, 250, 252, 0.95) width 1.5 scale = 9.0 grid = true grid_alpha = 0.7 step = 1 x_range = [0, 6] y_range = [0, 6] ;
    draw 2dfunc id 207 start 117.00s for 1.0s color (56, 189, 248, 1) width 2.8 at 206 y = 0.6 + 0.3*x + 0.08*x^2 ;

    draw circle id 208 start 118.30s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.25) width 2.2 at (124.0, 80.0) radius 0.9 ;
    text id 13 start 118.60s at (122.8, 81.5) ''[color=#FBBF24]$a$[/color]'' ;
    draw circle id 209 start 119.20s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.25) width 2.2 at (151.0, 80.0) radius 0.9 ;
    text id 14 start 119.50s at (149.8, 81.5) ''[color=#34D399]$b$[/color]'' ;

    text id 15 start 125.30s for 2.5s at (4.0, 62.0) ''[color=#FBBF24]$a < b$ ($a$ à gauche de $b$)[/color]'' ;

    draw line id 210 start 131.40s for 1.0s color (251, 191, 36, 0.85) width 1.8 at [(124.0, 80.0), (124.0, 66.32)] ;
    draw line id 211 start 133.40s for 1.0s color (251, 191, 36, 0.85) width 1.8 at [(124.0, 66.32), (106.0, 66.32)] ;
    draw circle id 212 start 137.50s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.3) width 2.0 at (124.0, 66.32) radius 0.9 ;
    text id 16 start 138.30s for 1.2s at (91.5, 64.0) ''[color=#FBBF24]$f(a)$[/color]'' ;

    draw line id 213 start 140.40s for 1.0s color (52, 211, 153, 0.85) width 1.8 at [(151.0, 80.0), (151.0, 43.10)] ;
    draw line id 214 start 141.60s for 1.0s color (52, 211, 153, 0.85) width 1.8 at [(151.0, 43.10), (106.0, 43.10)] ;
    draw circle id 215 start 142.80s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.3) width 2.0 at (151.0, 43.10) radius 0.9 ;
    text id 17 start 143.10s for 1.2s at (91.5, 40.8) ''[color=#34D399]$f(b)$[/color]'' ;

    draw arrow id 216 start 147.80s for 1.2s color (52, 211, 153, 1) width 2.2 at [(104.5, 65.0), (104.5, 44.5)] ;
    text id 18 start 162.00s for 3.2s at (4.0, 72.5) ''[color=#34D399]$f(b) > f(a) \iff f(a) < f(b)$[/color]'' ;
    text id 19 start 168.20s for 3.2s at (4.0, 83.0) ''[color=#C084FC]Pour $f(x) = x^2 + 1$ : prouver $a < b \implies f(a) < f(b)$[/color]'' ;

    erase id 802 start 185.15s ;

    # ==========================================================
    # SCENE 3 : Stratégie et Calcul de f(a) - f(b)
    # ==========================================================
    text id 20 start 185.20s for 2.2s at (4.0, 5.5) ''[bold][color=#38BDF8]Étape 1 & 2 : Stratégie et Calcul de $f(a) - f(b)$[/color][/bold]'' ;
    draw line id 217 start 187.80s for 0.6s color (248, 250, 252, 0.5) width 1.5 at [(4.0, 12.5), (173.0, 12.5)] ;

    text id 21 start 189.70s for 3.5s at (4.0, 17.5) ''[color=#F8FAFC]Soient $a, b \in [0 ; +\infty[$ tels que [color=#FBBF24]$a < b$[/color].[/color]'' ;

    draw polygone id 218 start 196.60s for 1.0s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.14) width 2.0 at [(96.0, 19.0), (172.0, 19.0), (172.0, 42.0), (96.0, 42.0)] ;
    text id 22 start 198.00s for 3.2s at (99.0, 22.0) ''[color=#F87171][bold]Piège n°1 :[/bold] Ne pas tester sur $2$ et $3$ ![/color]'' ;
    text id 23 start 202.00s for 2.8s at (99.0, 31.0) ''[color=#F8FAFC]Un exemple ne prouve rien : garder $a$ et $b$.[/color]'' ;

    text id 24 start 213.00s for 3.2s at (4.0, 27.5) ''[color=#38BDF8][bold]Astuce :[/bold] Calculer la différence $f(a) - f(b)$[/color]'' ;
    text id 25 start 220.00s for 3.6s at (4.0, 37.0) ''[color=#34D399]Montrer $f(a) - f(b) < 0 \iff f(a) < f(b)$[/color]'' ;
    text id 26 start 246.60s for 2.6s at (4.0, 48.0) ''[color=#F8FAFC]$f(a) = a^2 + 1$  et  $f(b) = b^2 + 1$[/color]'' ;

    draw polygone id 219 start 256.00s for 1.0s color (251, 191, 36, 0.9) fillcolor (251, 191, 36, 0.14) width 2.0 at [(96.0, 48.0), (172.0, 48.0), (172.0, 74.0), (96.0, 74.0)] ;
    text id 27 start 257.20s for 3.0s at (99.0, 51.0) ''[color=#FBBF24][bold]Piège n°2 : Priorités opératoires[/bold][/color]'' ;
    text id 28 start 260.70s for 3.2s at (99.0, 60.5) ''[color=#F8FAFC]Parenthèses obligatoires : $-(b^2 + 1)$ ![/color]'' ;

    text id 29 start 267.50s for 3.8s at (4.0, 58.0) ''[color=#FBBF24]$$f(a) - f(b) = (a^2 + 1) - (b^2 + 1)$$[/color]'' ;
    text id 30 start 278.00s for 3.6s at (4.0, 72.5) ''[color=#F8FAFC]$$f(a) - f(b) = a^2 + 1 - b^2 - 1$$[/color]'' ;
    text id 31 start 286.00s for 2.2s at (99.0, 78.5) ''[color=#34D399]$+1$ et $-1$ s'annulent ![/color]'' ;
    text id 32 start 290.40s for 2.6s at (4.0, 85.5) ''[color=#34D399]$$f(a) - f(b) = a^2 - b^2$$[/color]'' ;

    erase id 803 start 293.45s ;

    # ==========================================================
    # SCENE 4 : Factorisation et Étude du Signe du Produit
    # ==========================================================
    text id 33 start 293.50s for 2.2s at (4.0, 5.5) ''[bold][color=#38BDF8]Étape 3 : Factorisation et Étude du Signe[/color][/bold]'' ;
    draw line id 220 start 296.00s for 0.6s color (248, 250, 252, 0.5) width 1.5 at [(4.0, 12.5), (173.0, 12.5)] ;

    text id 34 start 298.20s for 3.2s at (4.0, 17.5) ''[color=#F8FAFC]Objectif : prouver que $a^2 - b^2 < 0$[/color]'' ;

    draw polygone id 221 start 311.00s for 1.0s color (192, 132, 252, 0.9) fillcolor (192, 132, 252, 0.14) width 2.0 at [(96.0, 19.0), (172.0, 19.0), (172.0, 42.0), (96.0, 42.0)] ;
    text id 35 start 312.20s for 2.8s at (99.0, 22.0) ''[color=#C084FC][bold]3e Identité Remarquable :[/bold][/color]'' ;
    text id 36 start 315.20s for 2.2s at (104.0, 30.5) ''[color=#F8FAFC]$$a^2 - b^2 = (a - b)(a + b)$$[/color]'' ;

    text id 37 start 317.60s for 3.0s at (4.0, 28.0) ''[color=#38BDF8]$$f(a) - f(b) = (a - b)(a + b)$$[/color]'' ;

    text id 38 start 329.90s for 2.6s at (4.0, 43.0) ''[color=#34D399][bold]1) Signe de $a + b$ :[/bold][/color]'' ;
    text id 39 start 333.50s for 3.5s at (4.0, 51.0) ''[color=#F8FAFC]$a, b \in [0 ; +\infty[$ avec $0 \le a < b$[/color]'' ;
    text id 40 start 346.00s for 3.4s at (4.0, 59.0) ''[color=#34D399]Somme de positifs ($b > 0$) $\implies a + b > 0$[/color]'' ;

    text id 41 start 353.90s for 2.6s at (4.0, 70.0) ''[color=#FBBF24][bold]2) Signe de $a - b$ :[/bold][/color]'' ;
    text id 42 start 360.70s for 3.2s at (4.0, 78.0) ''[color=#F8FAFC]Hypothèse : $a < b \implies a - b < 0$[/color]'' ;
    text id 43 start 366.00s for 2.5s at (4.0, 86.0) ''[color=#F87171]Donc $(a - b)$ est strictement négatif.[/color]'' ;

    draw polygone id 222 start 370.30s for 1.0s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.14) width 2.0 at [(96.0, 48.0), (172.0, 48.0), (172.0, 88.0), (96.0, 88.0)] ;
    text id 44 start 371.50s for 2.6s at (99.0, 51.0) ''[color=#34D399][bold]Règle des signes du produit :[/bold][/color]'' ;
    text id 45 start 375.30s for 3.5s at (99.0, 60.5) ''[color=#F8FAFC]$(a - b)$ [color=#F87171]($-$)[/color] $\times$ $(a + b)$ [color=#34D399]($+$)[/color][/color]'' ;
    text id 46 start 379.40s for 2.8s at (99.0, 69.0) ''[color=#F87171]$$(-) \times (+) = (-)$$[/color]'' ;
    text id 47 start 382.50s for 2.8s at (99.0, 80.5) ''[color=#F87171]Donc $(a - b)(a + b) < 0$[/color]'' ;

    erase id 804 start 387.80s ;

    # ==========================================================
    # SCENE 5 : Conclusion, Courbe Exacte et Synthèse
    # ==========================================================
    text id 48 start 387.90s for 2.2s at (4.0, 5.5) ''[bold][color=#34D399]Étape 4 : Conclusion et Synthèse[/color][/bold]'' ;
    draw line id 223 start 390.30s for 0.6s color (248, 250, 252, 0.5) width 1.5 at [(4.0, 12.5), (173.0, 12.5)] ;

    text id 49 start 395.10s for 3.0s at (4.0, 17.5) ''[color=#F8FAFC]$$f(a) - f(b) = (a - b)(a + b) < 0$$[/color]'' ;
    text id 50 start 400.50s for 3.0s at (4.0, 32.0) ''[color=#38BDF8]$$\implies f(a) < f(b)$$[/color]'' ;
    text id 51 start 414.50s for 3.8s at (4.0, 47.0) ''[color=#34D399][bold]Conclusion :[/bold] $f$ est croissante sur $[0 ; +\infty[$.[/color]'' ;

    draw 2drep id 224 start 422.80s for 1.4s at (122.0, 84.0) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [0, 5] y_range = [0, 10] ;
    draw 2dfunc id 225 start 425.50s for 2.2s color (52, 211, 153, 1) width 3.0 at 224 y = x^2 + 1 ;
    draw circle id 226 start 431.90s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.35) width 2.5 at (122.0, 77.5) radius 1.1 ;
    text id 52 start 434.40s for 2.0s at (98.0, 75.0) ''[color=#FBBF24]Min $(0 ; 1)$[/color]'' ;
    draw arrow id 227 start 436.60s for 0.8s color (251, 191, 36, 1) width 2.2 at [(112.0, 77.5), (120.2, 77.5)] ;

    text id 53 start 437.80s at (4.0, 60.0) ''[color=#FBBF24][bold]Méthode en 4 étapes :[/bold][/color]'' ;
    text id 54 start 438.50s at (4.0, 68.0) ''[color=#F8FAFC]1. Poser $a < b$ dans $I$[/color]'' ;
    text id 55 start 439.00s at (4.0, 75.0) ''[color=#F8FAFC]2. Calculer $f(a) - f(b)$ (parenthèses !)[/color]'' ;
    text id 56 start 439.50s at (4.0, 82.0) ''[color=#F8FAFC]3. Factoriser en produit[/color]'' ;
    text id 57 start 440.00s at (4.0, 89.0) ''[color=#34D399]4. Conclure par règle des signes[/color]'' ;

}
