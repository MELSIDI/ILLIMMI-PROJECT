course "Exemple guidé et calcul détaillé : Inéquations et droite réelle" id 19 idgap 500 for 484.6s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : Introduction & Méthode de résolution des inéquations (0.0s -> 42.0s)
    # =========================================================================

    text id 1 start 0.5s for 1.5s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction & Méthode de résolution des inéquations[/color][/bold]'' ;
    draw line id 501 start 2.2s for 0.8s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 3.5s for 2.0s at (4.0, 22.0) ''[bold][color=#FBBF24]Objectif du cours :[/bold][/color]'' ;
    text id 3 start 5.8s for 2.8s at (4.0, 31.0) ''Résoudre méthodiquement une [bold]inéquation du premier degré[/bold]'' ;
    text id 4 start 8.8s for 2.2s at (4.0, 39.0) ''et représenter ses [bold]solutions sur un axe gradué[/bold].'' ;

    text id 5 start 16.8s for 2.4s at (4.0, 52.0) ''[bold][color=#34D399]Principe fondamental :[/bold][/color]'' ;
    text id 6 start 19.5s for 2.5s at (4.0, 60.0) ''Isoler l'inconnue $x$ d'un côté de l'inégalité :'' ;
    text id 7 start 23.5s for 2.8s at (8.0, 69.0) ''[bold][color=#38BDF8]$x < a$[/color][/bold]   ou   [bold][color=#38BDF8]$x \le a$[/color][/bold]   ou   [bold][color=#38BDF8]$x > a$[/color][/bold]   ou   [bold][color=#38BDF8]$x \ge a$[/color][/bold]'' ;
    text id 8 start 31.0s for 3.0s at (4.0, 81.0) ''[bold][color=#F87171]Attention :[/bold][/color] Multiplication ou division par un [bold]nombre négatif[/bold] !'' ;

    # Right column : Plan des exemples
    text id 9 start 11.5s for 1.8s at (100.0, 24.0) ''[bold][color=#FBBF24]Exemples étudiés :[/bold][/color]'' ;
    draw polygone id 502 start 13.5s for 1.0s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(98.0, 32.0), (170.0, 32.0), (170.0, 85.0), (98.0, 85.0)] ;
    text id 10 start 15.0s for 1.4s at (102.0, 42.0) ''[bold][color=#38BDF8]Exemple 1 :[/color][/bold]'' ;
    text id 11 start 17.0s at (106.0, 50.0) ''$2x + 3 < 4 - 5x$'' ;
    text id 12 start 34.5s for 1.8s at (102.0, 64.0) ''[bold][color=#F87171]Exemple 2 (avec piège) :[/color][/bold]'' ;
    text id 13 start 37.0s for 2.0s at (106.0, 74.0) ''$2(x - 4) \le 4x - 5$'' ;

    erase id 2001 start 42.5s ;

    # =========================================================================
    # SCENE 2 : Premier exemple : Regroupement et réduction (43.0s -> 125.0s)
    # =========================================================================

    text id 14 start 43.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Premier exemple : $2x + 3 < 4 - 5x$ (Résolution)[/color][/bold]'' ;
    draw line id 503 start 44.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 15 start 45.2s for 2.2s at (4.0, 24.0) ''Inéquation initiale :'' ;
    text id 16 start 47.8s for 2.2s at (14.0, 33.0) ''[bold][color=#FBBF24]$2x + 3 < 4 - 5x$[/color][/bold]'' ;

    text id 17 start 51.5s for 2.5s at (4.0, 44.0) ''[bold]Étape 1 :[/bold] Regrouper les termes en $x$ à gauche et constants à droite'' ;
    text id 18 start 66.5s for 2.5s at (4.0, 54.0) ''On ajoute $+5x$ aux deux membres pour éliminer $-5x$ à droite :'' ;
    text id 19 start 75.5s for 2.0s at (14.0, 64.0) ''$2x + 5x + 3 < 4$'' ;
    text id 20 start 87.8s for 2.2s at (4.0, 74.0) ''On soustrait $-3$ aux deux membres pour éliminer $+3$ à gauche :'' ;
    text id 21 start 94.0s for 2.0s at (14.0, 84.0) ''$2x + 5x < 4 - 3$'' ;

    # Right column : Règle de transposition & Réduction
    draw polygone id 504 start 55.0s for 1.0s color (52, 211, 153, 0.6) width 1.5 fillcolor (52, 211, 153, 0.08) at [(96.0, 24.0), (170.0, 24.0), (170.0, 88.0), (96.0, 88.0)] ;
    text id 22 start 57.0s for 1.8s at (100.0, 31.0) ''[bold][color=#34D399]Règle de transposition :[/bold][/color]'' ;
    text id 23 start 61.5s for 2.5s at (100.0, 40.0) ''Terme $-5x$ (droite) $\longrightarrow$ devient [color=#38BDF8]$+5x$[/color] (gauche)'' ;
    draw arrow id 505 start 64.5s for 0.8s color (56, 189, 248, 1) width 2.0 at [(155.0, 47.0), (110.0, 47.0)] ;

    text id 24 start 82.5s for 2.5s at (100.0, 56.0) ''Terme $+3$ (gauche) $\longrightarrow$ devient [color=#F87171]$-3$[/color] (droite)'' ;
    draw arrow id 506 start 85.5s for 0.8s color (248, 113, 113, 1) width 2.0 at [(110.0, 63.0), (155.0, 63.0)] ;

    text id 25 start 106.5s for 2.0s at (100.0, 72.0) ''[bold][color=#FBBF24]Réduction des deux membres :[/bold][/color]'' ;
    text id 26 start 110.5s for 2.5s at (106.0, 80.0) ''[bold][color=#38BDF8]$7x < 1$[/color][/bold]'' ;

    erase id 2002 start 125.5s ;

    # =========================================================================
    # SCENE 3 : Premier exemple : Division & Solution algébrique (126.0s -> 164.0s)
    # =========================================================================

    text id 27 start 126.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Premier exemple : Division & Solution algébrique[/color][/bold]'' ;
    draw line id 507 start 127.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 28 start 128.5s for 2.0s at (4.0, 24.0) ''Inéquation réduite :'' ;
    text id 29 start 131.0s for 1.8s at (16.0, 33.0) ''[bold][color=#38BDF8]$7x < 1$[/color][/bold]'' ;

    text id 30 start 133.0s for 2.5s at (4.0, 44.0) ''[bold]Étape 2 :[/bold] Isoler $x$ en divisant par le facteur $7$ :'' ;
    text id 31 start 136.0s for 1.8s at (16.0, 54.0) ''$\frac{7x}{7} < \frac{1}{7}$'' ;

    draw polygone id 508 start 138.0s for 1.0s color (251, 191, 36, 0.6) width 1.5 fillcolor (251, 191, 36, 0.08) at [(98.0, 26.0), (170.0, 26.0), (170.0, 84.0), (98.0, 84.0)] ;
    text id 34 start 140.0s for 2.0s at (102.0, 35.0) ''[bold][color=#FBBF24]Règle fondamentale :[/bold][/color]'' ;

    text id 32 start 143.0s for 1.3s at (4.0, 65.0) ''Les $7$ se simplifient à gauche ($7 > 0$) :'' ;
    text id 35 start 144.5s for 2.5s at (102.0, 46.0) ''Diviser par un nombre [bold][color=#34D399]positif ($7 > 0$)[/color][/bold]'' ;
    text id 36 start 148.0s for 2.5s at (102.0, 55.0) ''[bold]ne change pas le sens[/bold] de l'inégalité.'' ;

    text id 33 start 152.0s for 2.5s at (16.0, 76.0) ''[bold][color=#34D399]$x < \frac{1}{7}$[/color][/bold]'' ;

    text id 37 start 156.5s for 2.5s at (102.0, 68.0) ''[bold][color=#38BDF8]Ensemble des solutions :[/color][/bold]'' ;
    text id 38 start 160.0s for 2.2s at (106.0, 76.0) ''Tous les réels strictement inférieurs à $\frac{1}{7}$.'' ;

    erase id 2003 start 164.5s ;

    # =========================================================================
    # SCENE 4 : Représentation sur l'axe gradué pour x < 1/7 (165.0s -> 248.0s)
    # =========================================================================

    text id 39 start 165.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Premier exemple : Représentation sur l'axe gradué ($x < \frac{1}{7}$)[/color][/bold]'' ;
    draw line id 509 start 166.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 40 start 167.5s for 0.8s at (4.0, 24.0) ''[bold][color=#FBBF24]Lecture géométrique :[/bold][/color]'' ;
    draw arrow id 510 start 168.5s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(92.0, 50.0), (172.0, 50.0)] ;

    draw line id 511 start 174.5s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(105.0, 46.5), (105.0, 53.5)] ;
    text id 48 start 175.5s at (103.8, 57.0) ''$0$'' ;

    text id 41 start 177.0s for 2.5s at (4.0, 33.0) ''1. Placer l'origine $0$ et l'unité $1$.'' ;
    draw line id 512 start 181.0s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(161.0, 46.5), (161.0, 53.5)] ;
    text id 49 start 182.0s at (159.8, 57.0) ''$1$'' ;

    text id 42 start 187.0s for 2.0s at (4.0, 42.0) ''2. Partager le segment $[0 ; 1]$ en $7$ parts égales.'' ;
    draw line id 513 start 189.5s for 0.4s color (56, 189, 248, 0.9) width 2.0 at [(113.0, 47.0), (113.0, 53.0)] ;
    draw line id 514 start 190.2s color (248, 250, 252, 0.4) width 1.0 at [(121.0, 48.0), (121.0, 52.0)] ;
    draw line id 515 start 190.8s color (248, 250, 252, 0.4) width 1.0 at [(129.0, 48.0), (129.0, 52.0)] ;
    draw line id 516 start 191.4s color (248, 250, 252, 0.4) width 1.0 at [(137.0, 48.0), (137.0, 52.0)] ;
    draw line id 517 start 192.0s color (248, 250, 252, 0.4) width 1.0 at [(145.0, 48.0), (145.0, 52.0)] ;
    draw line id 518 start 192.6s color (248, 250, 252, 0.4) width 1.0 at [(153.0, 48.0), (153.0, 52.0)] ;

    text id 43 start 193.0s for 0.8s at (4.0, 51.0) ''3. Repérer la graduation $\frac{1}{7}$.'' ;
    text id 50 start 194.0s at (110.0, 37.0) ''[bold][color=#38BDF8]$\frac{1}{7}$[/color][/bold]'' ;

    text id 44 start 202.0s for 2.5s at (4.0, 61.0) ''4. Colorier tous les réels situés à gauche de $\frac{1}{7}$.'' ;
    draw line id 519 start 206.0s for 1.8s color (56, 189, 248, 0.85) width 5.5 at [(92.0, 50.0), (113.0, 50.0)] ;
    text id 51 start 213.0s for 1.5s at (96.0, 34.0) ''[bold][color=#38BDF8]Solutions[/color][/bold]'' ;

    text id 45 start 221.0s for 2.5s at (4.0, 72.0) ''[bold][color=#F87171]Borne $\frac{1}{7}$ exclue :[/bold][/color] L'inégalité est stricte ($<$).'' ;
    draw path id 520 start 231.5s for 0.8s color (248, 113, 113, 1) width 2.5 at [(116.0, 45.0), (113.0, 45.0), (113.0, 55.0), (116.0, 55.0)] ;
    text id 46 start 232.5s for 1.8s at (4.0, 81.0) ''Le crochet [bold]tourne le dos[/bold] aux solutions :'' ;
    draw arrow id 521 start 234.5s for 0.8s color (248, 113, 113, 0.9) width 1.5 at [(132.0, 36.0), (118.0, 46.0)] ;
    text id 52 start 236.0s for 1.5s at (126.0, 32.0) ''[color=#F87171]Borne exclue ($<$)[/color]'' ;

    text id 47 start 243.0s for 2.5s at (10.0, 90.0) ''[bold][color=#38BDF8]$S = ]-\infty ; \frac{1}{7}[$[/color][/bold]'' ;

    erase id 2004 start 248.5s ;

    # =========================================================================
    # SCENE 5 : Deuxième exemple : 2(x - 4) <= 4x - 5 (Développement) (249.0s -> 332.0s)
    # =========================================================================

    text id 53 start 249.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Deuxième exemple : $2(x - 4) \le 4x - 5$ (Développement)[/color][/bold]'' ;
    draw line id 522 start 250.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 54 start 252.0s for 2.0s at (4.0, 24.0) ''Inéquation avec parenthèses :'' ;
    text id 55 start 256.0s for 2.5s at (14.0, 33.0) ''[bold][color=#FBBF24]$2(x - 4) \le 4x - 5$[/color][/bold]'' ;

    text id 56 start 266.5s for 2.2s at (4.0, 44.0) ''[bold]Étape 1 :[/bold] Développer le membre de gauche par distributivité :'' ;
    draw polygone id 523 start 269.0s for 1.0s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(98.0, 24.0), (170.0, 24.0), (170.0, 91.0), (98.0, 91.0)] ;
    text id 62 start 271.0s for 2.0s at (102.0, 32.0) ''[bold][color=#38BDF8]Distributivité simple :[/color][/bold]'' ;
    text id 57 start 274.0s for 0.8s at (14.0, 54.0) ''$2 \times x - 2 \times 4 \le 4x - 5$'' ;
    text id 63 start 275.0s for 1.5s at (106.0, 41.0) ''$2 \times x = 2x$'' ;
    text id 64 start 277.5s for 1.2s at (106.0, 49.0) ''$2 \times (-4) = -8$'' ;
    text id 58 start 279.0s for 2.2s at (14.0, 63.0) ''[bold][color=#38BDF8]$2x - 8 \le 4x - 5$[/color][/bold]'' ;

    text id 59 start 287.5s for 1.2s at (4.0, 73.0) ''[bold]Étape 2 :[/bold] Regrouper les termes en $x$ à gauche, les constantes à droite :'' ;
    text id 65 start 289.0s for 2.0s at (102.0, 60.0) ''[bold][color=#34D399]Opérations simultanées :[/bold][/color]'' ;
    text id 66 start 293.0s for 2.5s at (106.0, 69.0) ''$\bullet$ Soustraire $4x$ de chaque côté'' ;
    text id 60 start 298.5s for 2.5s at (14.0, 82.0) ''$2x - 4x \le -5 + 8$'' ;
    text id 67 start 303.0s for 2.5s at (106.0, 77.0) ''$\bullet$ Ajouter $+8$ de chaque côté'' ;

    text id 61 start 317.5s for 1.8s at (14.0, 91.0) ''[bold][color=#FBBF24]$-2x \le 3$[/color][/bold]'' ;
    text id 68 start 319.5s for 2.5s at (106.0, 85.0) ''[bold][color=#F87171]Attention au coefficient $-2$ ![/bold][/color]'' ;

    erase id 2005 start 332.5s ;

    # =========================================================================
    # SCENE 6 : Le piège classique : Inversion du sens (333.0s -> 394.0s)
    # =========================================================================

    text id 69 start 333.0s for 1.2s at (4.0, 7.5) ''[bold][color=#F87171]6. Le piège classique : Inversion du sens d'inégalité[/color][/bold]'' ;
    draw line id 524 start 334.4s for 0.6s color (248, 113, 113, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 70 start 335.5s for 1.5s at (4.0, 24.0) ''Nous avons obtenu :'' ;
    text id 71 start 337.5s for 1.8s at (16.0, 33.0) ''[bold][color=#FBBF24]$-2x \le 3$[/color][/bold]'' ;

    text id 72 start 341.0s for 3.0s at (4.0, 44.0) ''[bold][color=#F87171]Règle d'or absolue :[/bold][/color] Diviser par [bold]$-2 < 0$[/bold] [bold]inverse le sens[/bold] !'' ;
    text id 73 start 352.0s for 2.5s at (16.0, 54.0) ''$\frac{-2x}{-2} \ge \frac{3}{-2}$'' ;
    text id 74 start 356.5s for 2.5s at (16.0, 64.0) ''[color=#F87171]Le symbole $\le$ devient $\ge$ ![/color]'' ;

    draw polygone id 525 start 361.0s for 1.0s color (248, 113, 113, 0.6) width 1.5 fillcolor (248, 113, 113, 0.08) at [(96.0, 24.0), (172.0, 24.0), (172.0, 88.0), (96.0, 88.0)] ;
    text id 76 start 363.0s for 2.2s at (100.0, 32.0) ''[bold][color=#F87171]Pourquoi le sens change-t-il ?[/bold][/color]'' ;
    text id 77 start 366.5s for 2.0s at (104.0, 42.0) ''Exemple concret évident :'' ;
    text id 78 start 369.0s for 2.0s at (114.0, 51.0) ''[bold][color=#38BDF8]$1 \le 2$[/color][/bold]'' ;
    text id 79 start 371.5s for 2.5s at (104.0, 61.0) ''Multiplions les deux membres par $-1$ :'' ;
    text id 80 start 375.0s for 2.5s at (114.0, 71.0) ''[bold][color=#F87171]$-1 \ge -2$[/color][/bold]'' ;
    text id 81 start 379.0s for 2.5s at (100.0, 81.0) ''$-1$ est à droite de $-2$, donc [bold][color=#F87171]$-1 \ge -2$[/color][/bold] !'' ;

    text id 75 start 383.0s for 2.5s at (16.0, 77.0) ''[bold][color=#34D399]$x \ge -\frac{3}{2}$[/color][/bold]   soit   [bold][color=#34D399]$x \ge -1{,}5$[/color][/bold]'' ;

    erase id 2006 start 394.5s ;

    # =========================================================================
    # SCENE 7 : Représentation sur l'axe gradué pour x >= -3/2 (395.0s -> 451.0s)
    # =========================================================================

    text id 82 start 395.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Deuxième exemple : Représentation sur l'axe gradué ($x \ge -\frac{3}{2}$)[/color][/bold]'' ;
    draw line id 526 start 396.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 83 start 397.5s for 1.2s at (4.0, 24.0) ''[bold][color=#FBBF24]Lecture géométrique :[/bold][/color]'' ;
    draw arrow id 527 start 399.0s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(92.0, 50.0), (172.0, 50.0)] ;

    text id 84 start 402.0s for 0.4s at (4.0, 34.0) ''1. Placer l'origine $0$, $-1$ et $-2$.'' ;
    draw line id 528 start 402.5s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(155.0, 46.5), (155.0, 53.5)] ;
    text id 90 start 403.5s at (154.0, 57.0) ''$0$'' ;

    draw line id 529 start 405.0s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(135.0, 46.5), (135.0, 53.5)] ;
    text id 91 start 405.8s at (133.0, 57.0) ''$-1$'' ;

    text id 85 start 407.0s for 0.4s at (4.0, 44.0) ''2. Positionner $-\frac{3}{2} = -1{,}5$ au milieu de $[-2 ; -1]$.'' ;
    draw line id 530 start 407.5s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(115.0, 46.5), (115.0, 53.5)] ;
    text id 92 start 408.5s at (113.0, 57.0) ''$-2$'' ;

    draw line id 531 start 410.0s for 0.5s color (52, 211, 153, 1) width 2.2 at [(125.0, 46.0), (125.0, 54.0)] ;
    text id 93 start 411.0s at (121.0, 64.0) ''[bold][color=#34D399]$-\frac{3}{2}$[/color][/bold]'' ;

    text id 86 start 415.0s for 2.8s at (4.0, 54.0) ''3. Colorier tous les réels à droite de $-\frac{3}{2}$ ($x \ge -\frac{3}{2}$).'' ;
    draw line id 532 start 422.0s for 1.8s color (52, 211, 153, 0.85) width 5.5 at [(125.0, 50.0), (171.0, 50.0)] ;
    text id 94 start 425.0s for 1.5s at (142.0, 34.0) ''[bold][color=#34D399]Solutions[/color][/bold]'' ;

    text id 87 start 428.5s for 2.8s at (4.0, 66.0) ''[bold][color=#34D399]Borne $-\frac{3}{2}$ incluse :[/bold][/color] L'inégalité est large ($\ge$).'' ;
    text id 88 start 437.0s for 1.2s at (4.0, 77.0) ''Le crochet [bold]tourne vers l'intérieur[/bold] (vers les solutions) :'' ;
    draw path id 533 start 438.5s for 0.8s color (52, 211, 153, 1) width 2.5 at [(128.0, 45.0), (125.0, 45.0), (125.0, 55.0), (128.0, 55.0)] ;
    draw arrow id 534 start 440.5s for 0.8s color (52, 211, 153, 0.9) width 1.5 at [(118.0, 34.0), (125.0, 43.0)] ;
    text id 95 start 442.0s for 1.8s at (102.0, 30.0) ''[color=#34D399]Borne incluse ($\ge$)[/color]'' ;

    text id 89 start 447.0s for 2.5s at (10.0, 89.0) ''[bold][color=#38BDF8]$S = [-\frac{3}{2} ; +\infty[$[/color][/bold]'' ;

    erase id 2007 start 451.5s ;

    # =========================================================================
    # SCENE 8 : Synthèse méthodique : Les 3 réflexes indispensables (452.0s -> 501.5s)
    # =========================================================================

    text id 96 start 452.0s for 1.2s at (4.0, 7.5) ''[bold][color=#38BDF8]8. Synthèse méthodique : Les 3 réflexes indispensables[/color][/bold]'' ;
    draw line id 535 start 453.4s for 0.6s color (56, 189, 248, 0.8) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw polygone id 536 start 456.0s for 1.0s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(4.0, 22.0), (87.0, 22.0), (87.0, 92.0), (4.0, 92.0)] ;
    text id 97 start 458.0s for 2.2s at (6.0, 30.0) ''[bold][color=#38BDF8]Réflexe 1 : Regroupement méthodique[/bold][/color]'' ;
    text id 98 start 461.5s for 2.5s at (8.0, 39.0) ''$\bullet$ Développer les parenthèses si nécessaire.'' ;
    text id 99 start 464.5s for 2.5s at (8.0, 47.0) ''$\bullet$ Transposer les $x$ à gauche, nombres à droite.'' ;

    text id 100 start 468.0s for 2.2s at (6.0, 58.0) ''[bold][color=#F87171]Réflexe 2 : Signe du diviseur[/bold][/color]'' ;
    text id 101 start 471.5s for 2.5s at (8.0, 67.0) ''$\bullet$ Diviser par $k > 0$ : [bold][color=#34D399]sens conservé[/color][/bold].'' ;
    text id 102 start 476.5s for 3.0s at (8.0, 76.0) ''$\bullet$ Diviser par $k < 0$ : [bold][color=#F87171]sens INVERSÉ ($\le \leftrightarrow \ge$)[/color][/bold] !'' ;

    draw polygone id 537 start 480.0s for 1.0s color (52, 211, 153, 0.6) width 1.5 fillcolor (52, 211, 153, 0.08) at [(91.0, 22.0), (173.0, 22.0), (173.0, 92.0), (91.0, 92.0)] ;
    text id 103 start 482.0s for 2.2s at (94.0, 30.0) ''[bold][color=#34D399]Réflexe 3 : Conventions des crochets[/bold][/color]'' ;
    text id 104 start 485.5s for 2.5s at (96.0, 41.0) ''$\bullet$ [bold]Inégalité stricte ($<, >$)[/bold] : Borne exclue'' ;
    text id 105 start 488.5s for 2.5s at (100.0, 50.0) ''Crochet [color=#F87171]tourne le dos[/color] aux solutions.'' ;
    text id 106 start 491.5s for 2.5s at (96.0, 61.0) ''$\bullet$ [bold]Inégalité large ($\le, \ge$)[/bold] : Borne incluse'' ;
    text id 107 start 494.5s for 2.5s at (100.0, 70.0) ''Crochet [color=#34D399]embrasse[/color] les solutions.'' ;
    text id 108 start 498.0s for 2.5s at (96.0, 82.0) ''[bold][color=#FBBF24]Rigueur + Graphique = 100% Réussite ![/bold][/color]'' ;

}
