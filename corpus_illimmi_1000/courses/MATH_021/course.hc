course "Généralités sur les fonctions et lecture graphique" id 1 idgap 500 for 362s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 0 : Introduction & Ensemble de définition (0.0s - 37.4s)
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold]1. Introduction & Ensemble de définition[/bold]'' ;
    draw line id 501 start 2.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 10.1s for 2.0s at (5.0, 22.0) ''[bold]Fonction étudiée :[/bold]'' ;
    text id 3 start 16.0s for 2.5s at (5.0, 31.0) ''[color=#38BDF8]$$f(x) = \frac{x}{3x - 6}$$[/color]'' ;

    text id 4 start 23.6s for 2.0s at (5.0, 47.0) ''[bold]Sens fondamental :[/bold]'' ;
    text id 5 start 27.2s for 2.0s at (5.0, 56.0) ''L'ensemble de définition [bold]$\mathcal{D}_f$[/bold] est l'ensemble'' ;
    text id 6 start 30.0s for 2.5s at (5.0, 65.0) ''des réels $x$ ayant une [color=#34D399]image $f(x)$ calculable[/color].'' ;

    text id 7 start 33.7s at (105.0, 22.0) ''[bold][color=#38BDF8]Cadre graphique de l'étude[/color][/bold]'' ;
    draw 2drep id 502 start 34.5s for 2.0s at (133, 58) color (248, 250, 252, 0.95) width 1.5 scale = 7.0 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 4] y_range = [-3, 3] ;

    # =========================================================================
    # SCÈNE 1 : Rappel sur les fonctions homographiques (37.8s - 86.8s)
    # =========================================================================
    erase id 2001 start 37.4s ;

    text id 10 start 37.8s for 1.5s at (4.0, 7.5) ''[bold]2. Rappel de cours : Fonctions homographiques[/bold]'' ;
    draw line id 505 start 40.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 11 start 44.3s for 1.8s at (5.0, 22.0) ''[bold]Définition générale :[/bold]'' ;
    text id 12 start 47.0s for 1.5s at (5.0, 29.0) ''Une fonction [color=#38BDF8]homographique[/color] est de la forme :'' ;
    text id 13 start 49.0s for 2.5s at (5.0, 39.0) ''[color=#38BDF8]$$f(x) = \frac{ax + b}{cx + d}$$[/color]'' ;
    text id 14 start 54.0s for 2.0s at (5.0, 52.0) ''avec $a, b, c, d \in \mathbb{R}$ et [color=#F87171]$c \neq 0$[/color]'' ;

    text id 15 start 59.4s for 1.5s at (5.0, 62.0) ''[bold]Identification pour notre fonction :[/bold]'' ;
    text id 16 start 61.5s for 2.5s at (5.0, 72.0) ''[color=#34D399]$$f(x) = \frac{1 \cdot x + 0}{3x - 6}$$[/color]'' ;

    text id 17 start 67.3s for 1.8s at (105.0, 25.0) ''[bold]Coefficients identifiés :[/bold]'' ;
    text id 18 start 70.0s for 2.5s at (105.0, 36.0) ''[color=#38BDF8]Numérateur : $a = 1$ et $b = 0$[/color]'' ;
    text id 19 start 77.6s for 2.5s at (105.0, 47.0) ''[color=#FBBF24]Dénominateur : $c = 3$ et $d = -6$[/color]'' ;
    text id 20 start 81.0s for 2.5s at (105.0, 59.0) ''[color=#34D399]$\implies$ Quotient de deux fonctions affines[/color]'' ;
    draw polygone id 506 start 85.0s for 1.2s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.12) width 1.5 at [(100, 20), (170, 20), (170, 70), (100, 70)] ;

    # =========================================================================
    # SCÈNE 2 : Interprétation graphique & L'hyperbole (87.2s - 174.5s)
    # =========================================================================
    erase id 2002 start 86.8s ;

    text id 30 start 87.2s for 1.8s at (4.0, 7.5) ''[bold]3. Interprétation graphique : L'hyperbole et le « trou »[/bold]'' ;
    draw line id 510 start 90.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 31 start 95.6s for 2.0s at (5.0, 22.0) ''[bold]Allure de la courbe :[/bold]'' ;
    text id 32 start 99.0s for 2.5s at (5.0, 30.0) ''La courbe représentative est une [color=#38BDF8][bold]hyperbole[/bold][/color].'' ;
    text id 33 start 103.0s for 2.0s at (5.0, 38.0) ''Elle est formée de [color=#34D399]deux branches distinctes[/color].'' ;

    text id 34 start 105.4s for 2.5s at (5.0, 48.0) ''[bold]Exemple de référence :[/bold] Fonction inverse'' ;
    text id 35 start 112.8s for 2.5s at (5.0, 58.0) ''[color=#FBBF24]$$g(x) = \frac{1}{x}$$[/color]'' ;

    draw 2drep id 511 start 119.0s for 1.5s at (133, 56) color (248, 250, 252, 0.95) width 1.5 scale = 7.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-3, 3] y_range = [-3, 3] ;
    draw 2dfunc id 512 start 121.0s for 2.5s color (56, 189, 248, 1) width 2.5 at 511 y = 1 / x ;

    text id 36 start 146.7s for 2.5s at (5.0, 70.0) ''[color=#F87171][bold]Rupture graphique :[/bold] en $x = 0$[/color]'' ;
    text id 37 start 151.0s at (5.0, 79.0) ''Aucun point sur l'axe vertical : [color=#F87171]valeur interdite ![/color]'' ;
    draw line id 513 start 152.0s for 1.5s color (248, 113, 113, 0.95) width 2.0 at [(133, 23), (133, 89)] ;
    text id 38 start 155.0s for 1.5s at (135.0, 26.0) ''[color=#F87171][bold]Asymptote : $x = 0$[/bold][/color]'' ;

    # =========================================================================
    # SCÈNE 3 : Recherche algébrique de la valeur interdite (175.4s - 241.0s)
    # =========================================================================
    erase id 2003 start 174.5s ;

    text id 50 start 175.4s for 1.8s at (4.0, 7.5) ''[bold]4. Recherche algébrique : Dénominateur nul[/bold]'' ;
    draw line id 520 start 178.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 51 start 181.7s for 2.5s at (5.0, 22.0) ''[bold]Règle fondamentale absolue :[/bold]'' ;
    text id 52 start 185.3s for 2.5s at (5.0, 31.0) ''[color=#F87171][bold]La division par zéro est INTERDITE ![/bold][/color]'' ;
    text id 53 start 190.8s for 3.0s at (5.0, 41.0) ''Le dénominateur ne doit jamais s'annuler : [color=#38BDF8]$3x - 6 \neq 0$[/color]'' ;

    text id 54 start 202.9s for 2.5s at (5.0, 52.0) ''[bold]Équation de la valeur interdite :[/bold]'' ;
    text id 55 start 207.0s for 2.5s at (5.0, 61.0) ''$$3x - 6 = 0$$'' ;
    text id 56 start 211.0s for 2.5s at (5.0, 71.0) ''Étape 1 : [color=#FBBF24]$3x = 6$[/color]'' ;
    text id 57 start 217.4s for 2.5s at (5.0, 80.0) ''Étape 2 : [color=#34D399]$x = \frac{6}{3} = 2$[/color]'' ;
    text id 58 start 228.0s for 1.5s at (5.0, 89.0) ''[color=#F87171]$\implies$ Valeur interdite : $\mathbf{x = 2}$[/color]'' ;

    draw 2drep id 521 start 230.0s for 1.2s at (120, 56) color (248, 250, 252, 0.95) width 1.5 scale = 6.5 grid = true grid_alpha = 0.7 step = 1 x_range = [-2, 6] y_range = [-3, 3] ;
    draw 2dfunc id 522 start 231.5s for 1.2s color (56, 189, 248, 1) width 2.5 at 521 y = x / (3 * x - 6) ;
    draw line id 523 start 233.0s for 1.2s color (248, 113, 113, 0.95) width 2.2 at [(133, 23), (133, 89)] ;
    text id 59 start 235.5s for 1.8s at (114.0, 20.0) ''[color=#F87171][bold]Trou / Asymptote : $x = 2$[/bold][/color]'' ;

    # =========================================================================
    # SCÈNE 4 : Vérification & Piège : Numérateur vs Dénominateur (242.0s - 303.5s)
    # =========================================================================
    erase id 2004 start 241.2s ;

    text id 70 start 242.0s for 1.8s at (4.0, 7.5) ''[bold]5. Vérification par le calcul & Piège d'examen[/bold]'' ;
    draw line id 530 start 244.5s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 71 start 247.9s for 2.5s at (5.0, 22.0) ''[bold]Calcul test pour $x = 2$ :[/bold]'' ;
    text id 72 start 254.1s for 3.5s at (5.0, 32.0) ''$$f(2) = \frac{2}{3 \times 2 - 6} = \frac{2}{6 - 6} = \frac{2}{0}$$'' ;
    text id 73 start 264.6s for 3.0s at (5.0, 48.0) ''[color=#F87171]$\frac{2}{0}$ est STRICTEMENT IMPOSSIBLE ![/color]'' ;
    text id 74 start 280.4s for 2.0s at (5.0, 58.0) ''$\implies$ 2 n'a pas d'image, 2 est exclu de $\mathcal{D}_f$.'' ;

    text id 75 start 283.3s for 1.8s at (96.0, 22.0) ''[bold][color=#F87171]Piège classique : Ne pas confondre ![/color][/bold]'' ;
    draw polygone id 531 start 285.5s for 1.0s color (251, 191, 36, 0.9) fillcolor (251, 191, 36, 0.12) width 1.5 at [(94, 28), (172, 28), (172, 85), (94, 85)] ;

    text id 76 start 287.1s at (98.0, 34.0) ''[color=#F87171][bold]Dénominateur nul (INTERDIT) :[/bold][/color]'' ;
    text id 77 start 288.0s at (98.0, 42.0) ''$3x - 6 = 0 \iff x = 2$ : division impossible'' ;
    draw line id 532 start 289.5s for 0.8s color (251, 191, 36, 0.6) width 1.0 at [(98, 52), (168, 52)] ;

    text id 78 start 290.6s at (98.0, 57.0) ''[color=#34D399][bold]Numérateur nul (AUTORISÉ) :[/bold][/color]'' ;
    text id 79 start 294.0s for 2.5s at (98.0, 66.0) ''$x = 0 \implies f(0) = \frac{0}{-6} = 0$ : calcul valide !'' ;
    text id 80 start 298.5s for 2.0s at (98.0, 75.0) ''[color=#38BDF8]Le point $(0, 0)$ appartient à la courbe.[/color]'' ;

    # =========================================================================
    # SCÈNE 5 : Notations de l'ensemble de définition & Synthèse (304.5s - 374.85s)
    # =========================================================================
    erase id 2005 start 303.8s ;

    text id 90 start 304.5s for 1.8s at (4.0, 7.5) ''[bold]6. Écriture finale de $\mathcal{D}_f$ & Synthèse[/bold]'' ;
    draw line id 540 start 307.0s for 1.0s color (56, 189, 248, 0.8) width 1.5 at [(4, 13.5), (173, 13.5)] ;

    text id 91 start 310.5s for 2.0s at (5.0, 22.0) ''[bold]Conclusion rigoureuse :[/bold]'' ;
    text id 92 start 312.0s for 2.0s at (5.0, 30.0) ''La fonction $f$ est définie pour [color=#34D399]tout réel sauf 2[/color].'' ;

    text id 98 start 314.9s for 1.0s at (100.0, 22.0) ''[bold][color=#38BDF8]Représentation sur la droite réelle[/color][/bold]'' ;
    draw arrow id 541 start 316.5s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(96, 45), (170, 45)] ;
    text id 99 start 318.2s at (96.0, 39.0) ''$-\infty$'' ;
    text id 100 start 318.6s at (164.0, 39.0) ''$+\infty$'' ;
    draw line id 542 start 319.0s for 0.4s color (248, 250, 252, 0.8) width 1.5 at [(116, 43), (116, 47)] ;
    text id 101 start 319.5s at (115.0, 50.0) ''$0$'' ;

    draw line id 544 start 320.0s for 2.5s color (56, 189, 248, 1) width 4.5 at [(98, 45), (134, 45)] ;
    draw path id 545 start 324.0s for 1.5s color (248, 113, 113, 1) width 2.5 at [(130, 41), (133, 41), (133, 49), (130, 49)] ;
    draw circle id 546 start 326.0s for 0.8s color (248, 113, 113, 1) fillcolor (15, 23, 42, 1) width 2.0 radius 1.5 at (136, 45) ;
    text id 103 start 327.0s for 2.0s at (122.0, 56.0) ''[color=#F87171][bold]Valeur 2 exclue[/bold][/color]'' ;
    draw path id 547 start 334.0s for 1.5s color (248, 113, 113, 1) width 2.5 at [(142, 41), (139, 41), (139, 49), (142, 49)] ;
    draw line id 548 start 336.0s for 1.5s color (52, 211, 153, 1) width 4.5 at [(138, 45), (167, 45)] ;

    text id 93 start 337.7s for 1.8s at (5.0, 40.0) ''[bold]Notation en réunion d'intervalles :[/bold]'' ;
    text id 94 start 340.0s for 3.5s at (5.0, 50.0) ''[color=#38BDF8]$$\mathcal{D}_f = ]-\infty ; 2[ \;\cup\; ]2 ; +\infty[$$[/color]'' ;

    text id 95 start 345.9s for 2.0s at (5.0, 63.0) ''[bold]Notation ensembliste :[/bold]'' ;
    text id 96 start 350.0s for 2.5s at (5.0, 72.0) ''[color=#FBBF24]$$\mathcal{D}_f = \mathbb{R} \setminus \{2\}$$[/color]'' ;

    draw polygone id 549 start 353.0s for 1.2s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.12) width 1.5 at [(96, 66), (170, 66), (170, 92), (96, 92)] ;
    text id 104 start 355.0s for 1.0s at (100.0, 71.0) ''[bold][color=#34D399]Bilan méthodologique :[/color][/bold]'' ;
    text id 105 start 356.5s for 1.0s at (100.0, 77.0) ''1. Repérer les fractions : $\frac{N(x)}{D(x)}$'' ;
    text id 106 start 358.0s for 1.0s at (100.0, 83.0) ''2. Poser $D(x) = 0 \implies$ Valeur interdite'' ;

    text id 97 start 359.1s for 2.4s at (5.0, 85.0) ''[color=#34D399][bold]Réflexe examen :[/bold] Fraction $\implies D(x) \neq 0$ ![/color]'' ;
}
