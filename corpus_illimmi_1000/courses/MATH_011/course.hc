course "Valeur absolue et distance sur la droite réelle" id 1 idgap 500 for 886.3s audio "narration.wav" {

    # =========================================================================
    # SCENE 1 : INTRODUCTION & PLAN DU COURS (0.0s -> 58.8s)
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]VALEUR ABSOLUE & DISTANCE SUR LA DROITE RÉELLE[/color][/bold]'' ;
    draw line id 501 start 2.5s for 1.2s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 4.5s for 2.2s at (4.0, 20.0) ''[bold][color=#FBBF24]Objectifs d'apprentissage du chapitre (Seconde) :[/color][/bold]'' ;
    text id 3 start 10.0s for 2.2s at (6.0, 32.0) ''[color=#F8FAFC]1. Définition algébrique et notation $|a|$[/color]'' ;
    text id 4 start 18.0s for 2.2s at (6.0, 44.0) ''[color=#F8FAFC]2. Expression avec inconnue : $|x - 5|$[/color]'' ;
    text id 5 start 26.0s for 2.2s at (6.0, 56.0) ''[color=#F8FAFC]3. Propriétés clés & Piège $\sqrt{x^2} = |x|$[/color]'' ;
    text id 6 start 34.0s for 2.2s at (6.0, 68.0) ''[color=#F8FAFC]4. Distance géométrique : $AB = |a - b|$[/color]'' ;
    text id 7 start 42.0s for 2.2s at (6.0, 80.0) ''[color=#F8FAFC]5. Encadrements & Intervalles centrés $[a-r \,;\, a+r]$[/color]'' ;

    # Aperçu visuel à droite (Axe géométrique)
    draw line id 502 start 47.0s for 1.5s color (248, 250, 252, 0.8) width 2.0 at [(96, 52), (168, 52)] ;
    draw arrow id 503 start 49.0s for 0.8s color (248, 250, 252, 0.8) width 2.0 at [(166, 52), (171, 52)] ;
    draw line id 504 start 50.5s color (56, 189, 248, 1) width 2.5 at [(114, 49), (114, 55)] ;
    text id 8 start 51.0s at (112.0, 58.0) ''[color=#38BDF8]$A(a)$[/color]'' ;
    draw line id 505 start 52.5s color (52, 211, 153, 1) width 2.5 at [(150, 49), (150, 55)] ;
    text id 9 start 53.0s at (148.0, 58.0) ''[color=#34D399]$B(b)$[/color]'' ;
    draw path id 506 start 54.5s for 1.5s color (251, 191, 36, 1) width 2.0 at [(114, 44), (114, 40), (150, 40), (150, 44)] ;
    text id 10 start 56.5s at (122.0, 32.0) ''[color=#FBBF24]$d(A, B) = |b - a|$[/color]'' ;

    erase id 2001 start 58.8s ;

    # =========================================================================
    # SCENE 2 : PREMIÈRES OBSERVATIONS NUMÉRIQUES (59.0s -> 165.2s)
    # =========================================================================
    text id 11 start 59.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. APPROCHE INTUITIVE : LE NOMBRE SANS SON SIGNE[/color][/bold]'' ;
    draw line id 507 start 61.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 12 start 63.5s for 2.2s at (4.0, 20.0) ''[bold][color=#FBBF24]Observations sur quelques exemples concrets :[/color][/bold]'' ;
    text id 13 start 70.5s for 2.2s at (6.0, 32.0) ''[color=#F8FAFC]Nombre de départ :[/color]  [color=#F87171]$-5$[/color]   $\longrightarrow$   [color=#34D399]$5$[/color]'' ;
    text id 14 start 79.5s for 2.2s at (6.0, 44.0) ''[color=#F8FAFC]Nombre de départ :[/color]  [color=#F87171]$-9$[/color]   $\longrightarrow$   [color=#34D399]$9$[/color]'' ;
    text id 15 start 92.0s for 2.2s at (6.0, 56.0) ''[color=#F8FAFC]Nombre de départ :[/color]  [color=#38BDF8]$+7$[/color]   $\longrightarrow$   [color=#34D399]$7$[/color]'' ;
    text id 16 start 101.5s for 2.2s at (6.0, 68.0) ''[color=#F8FAFC]Nombre de départ :[/color]  [color=#38BDF8]$+9$[/color]   $\longrightarrow$   [color=#34D399]$9$[/color]'' ;
    text id 17 start 110.5s for 2.2s at (6.0, 80.0) ''[color=#F8FAFC]Nombre décimal :[/color]   [color=#F87171]$-0{,}1$[/color] $\longrightarrow$   [color=#34D399]$0{,}1$[/color]'' ;

    # Tableau comparatif à droite
    draw polygone id 508 start 120.0s for 1.5s color (56, 189, 248, 0.7) fillcolor (56, 189, 248, 0.08) width 1.8 at [(94, 20), (170, 20), (170, 88), (94, 88)] ;
    draw line id 509 start 122.0s for 1.0s color (56, 189, 248, 0.5) width 1.5 at [(94, 32), (170, 32)] ;
    draw line id 510 start 123.5s for 1.0s color (56, 189, 248, 0.5) width 1.5 at [(132, 20), (132, 88)] ;
    text id 18 start 125.0s at (98.0, 24.0) ''[bold][color=#F8FAFC]Nombre initial $x$[/color][/bold]'' ;
    text id 19 start 126.5s at (136.0, 24.0) ''[bold][color=#34D399]Valeur absolue[/color][/bold]'' ;
    text id 20 start 128.5s at (104.0, 38.0) ''[color=#F87171]$-5$[/color]'' ;
    text id 21 start 129.5s at (146.0, 38.0) ''[bold][color=#34D399]$5$[/color][/bold]'' ;
    text id 22 start 131.0s at (104.0, 50.0) ''[color=#38BDF8]$+7$[/color]'' ;
    text id 23 start 132.0s at (146.0, 50.0) ''[bold][color=#34D399]$7$[/color][/bold]'' ;
    text id 24 start 133.5s at (102.0, 62.0) ''[color=#F87171]$-0{,}1$[/color]'' ;
    text id 25 start 134.5s at (144.0, 62.0) ''[bold][color=#34D399]$0{,}1$[/color][/bold]'' ;
    text id 26 start 145.0s for 2.5s at (96.0, 74.0) ''[bold][color=#FBBF24]Règle intuitive :[/color][/bold]'' ;
    text id 27 start 149.0s for 3.0s at (96.0, 81.0) ''[color=#F8FAFC]On conserve la grandeur :[/color] [bold][color=#34D399]$|x| \ge 0$[/color][/bold]'' ;

    erase id 2002 start 165.2s ;

    # =========================================================================
    # SCENE 3 : DÉFINITION ALGÉBRIQUE FORMELLE & NOTATION |a| (165.5s -> 277.2s)
    # =========================================================================
    text id 28 start 166.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]2. DÉFINITION ALGÉBRIQUE FORMELLE & NOTATION $|a|$[/color][/bold]'' ;
    draw line id 511 start 168.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 29 start 171.0s for 2.2s at (4.0, 20.0) ''[bold][color=#FBBF24]Définition mathématique rigoureuse :[/color][/bold]'' ;
    draw polygone id 512 start 174.5s for 1.5s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.1) width 1.8 at [(4, 27), (88, 27), (88, 54), (4, 54)] ;
    text id 30 start 177.0s for 2.5s at (6.0, 30.5) ''[color=#F8FAFC]Soit $a \in \mathbb{R}$. La valeur absolue de $a$ est définie par :[/color]'' ;
    text id 31 start 181.0s for 3.0s at (10.0, 39.0) ''[bold][color=#34D399]$$|a| = \begin{cases} a & \text{si } a \ge 0 \\ -a & \text{si } a < 0 \end{cases}$$[/color][/bold]'' ;

    text id 32 start 192.0s for 2.5s at (4.0, 58.0) ''[bold][color=#F87171]Attention au piège de l'écriture $-a$ :[/color][/bold]'' ;
    text id 33 start 196.0s for 3.0s at (6.0, 66.0) ''[color=#F8FAFC]Le signe $-$ indique [bold]l'opposé[/bold], et non un nombre négatif ![/color]'' ;
    text id 34 start 208.0s for 2.8s at (6.0, 75.0) ''[color=#F8FAFC]Si $a = -5 < 0$, alors :[/color] [color=#34D399]$-a = -(-5) = +5 > 0$[/color]'' ;
    text id 35 start 222.0s for 2.5s at (6.0, 84.0) ''[bold][color=#38BDF8]Conclusion : L'opposé d'un négatif est toujours positif ![/color][/bold]'' ;

    # Notation entre deux barres à droite
    draw polygone id 513 start 240.0s for 1.5s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.08) width 1.8 at [(94, 20), (170, 20), (170, 88), (94, 88)] ;
    text id 36 start 242.0s for 2.2s at (98.0, 24.0) ''[bold][color=#38BDF8]Notation universelle : Deux barres verticales[/color][/bold]'' ;
    draw line id 514 start 245.0s for 1.0s color (56, 189, 248, 0.4) width 1.5 at [(94, 32), (170, 32)] ;
    text id 37 start 247.0s for 2.5s at (98.0, 36.0) ''[color=#F8FAFC]L'écriture [bold]$|a|$[/bold] se lit : [italic]« valeur absolue de a »[/italic][/color]'' ;
    text id 38 start 254.0s for 2.2s at (104.0, 48.0) ''[color=#F8FAFC]$|-5| = -(-5) =$[/color] [bold][color=#34D399]$5$[/color][/bold]'' ;
    text id 39 start 261.0s for 2.2s at (104.0, 60.0) ''[color=#F8FAFC]$|-9| = -(-9) =$[/color] [bold][color=#34D399]$9$[/color][/bold]'' ;
    text id 40 start 268.0s for 2.2s at (104.0, 72.0) ''[color=#F8FAFC]$|+9| = 9$[/color]    [color=#FBBF24]et[/color]    [color=#F8FAFC]$|0| = 0$[/color]'' ;
    text id 41 start 272.0s for 2.2s at (98.0, 82.0) ''[color=#38BDF8]Écriture concise, claire et universelle.[/color]'' ;

    erase id 2003 start 277.2s ;

    # =========================================================================
    # SCENE 4 : EXPRESSION AVEC INCONNUE : CAS DE |x - 5| (277.5s -> 399.2s)
    # =========================================================================
    text id 42 start 278.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]3. CALCUL ALGÉBRIQUE AVEC INCONNUE : CAS DE $|x - 5|$[/color][/bold]'' ;
    draw line id 515 start 280.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 43 start 283.0s for 2.2s at (4.0, 20.0) ''[bold][color=#FBBF24]Comment expliciter $|x - 5|$ sans les barres ?[/color][/bold]'' ;
    text id 44 start 306.0s for 2.5s at (4.0, 30.0) ''[bold][color=#34D399]Cas 1 : Si l'intérieur est positif ou nul $(x - 5 \ge 0)$[/color][/bold]'' ;
    text id 45 start 312.0s for 2.5s at (8.0, 38.0) ''[color=#F8FAFC]$x - 5 \ge 0 \iff x \ge 5$[/color]'' ;
    text id 46 start 320.0s for 2.5s at (8.0, 46.0) ''[color=#F8FAFC]Alors :[/color] [bold][color=#34D399]$|x - 5| = x - 5$[/color][/bold]'' ;

    text id 47 start 332.0s for 2.5s at (4.0, 58.0) ''[bold][color=#F87171]Cas 2 : Si l'intérieur est strictement négatif $(x - 5 < 0)$[/color][/bold]'' ;
    text id 48 start 338.0s for 2.5s at (8.0, 66.0) ''[color=#F8FAFC]$x - 5 < 0 \iff x < 5$[/color]'' ;
    text id 49 start 346.0s for 2.8s at (8.0, 75.0) ''[color=#F8FAFC]Alors :[/color] [bold][color=#F87171]$|x - 5| = -(x - 5) = 5 - x$[/color][/bold]'' ;

    # Synthèse à droite (Double information)
    draw polygone id 516 start 367.5s for 1.5s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.08) width 1.8 at [(94, 20), (170, 20), (170, 88), (94, 88)] ;
    text id 50 start 369.5s for 2.2s at (98.0, 24.0) ''[bold][color=#FBBF24]Synthèse : Une double information condensée[/color][/bold]'' ;
    draw line id 517 start 372.5s for 1.0s color (251, 191, 36, 0.4) width 1.5 at [(94, 32), (170, 32)] ;
    text id 51 start 375.0s for 3.2s at (100.0, 41.0) ''[bold][color=#F8FAFC]$$|x - 5| = \begin{cases} x - 5 & \text{si } x \ge 5 \\ 5 - x & \text{si } x < 5 \end{cases}$$[/color][/bold]'' ;
    text id 52 start 385.0s for 2.5s at (98.0, 62.0) ''[color=#38BDF8]Au lieu d'écrire deux formules séparées,[/color]'' ;
    text id 53 start 389.0s for 2.5s at (98.0, 70.0) ''[color=#F8FAFC]l'écriture [bold]$|x - 5|$[/bold] résume les deux branches ![/color]'' ;
    text id 54 start 393.5s for 2.5s at (96.0, 80.0) ''[color=#34D399]Indispensable pour l'étude des fonctions.[/color]'' ;

    erase id 2004 start 399.2s ;

    # =========================================================================
    # SCENE 5 : PROPRIÉTÉS ÉLÉMENTAIRES FONDAMENTALES (399.5s -> 539.2s)
    # =========================================================================
    text id 55 start 400.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]4. PROPRIÉTÉS ÉLÉMENTAIRES FONDAMENTALES[/color][/bold]'' ;
    draw line id 518 start 402.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    # Colonne de gauche
    text id 56 start 410.5s for 2.5s at (4.0, 20.0) ''[bold][color=#34D399]Propriété 1 (Positivité absolue) :[/color][/bold]'' ;
    text id 57 start 414.0s for 2.2s at (8.0, 28.0) ''[bold][color=#F8FAFC]$\forall x \in \mathbb{R}, \quad |x| \ge 0$[/color][/bold]'' ;

    text id 58 start 433.5s for 2.5s at (4.0, 40.0) ''[bold][color=#38BDF8]Propriété 2 (Symétrie des opposés) :[/color][/bold]'' ;
    text id 59 start 437.0s for 2.2s at (8.0, 48.0) ''[bold][color=#F8FAFC]$\forall x \in \mathbb{R}, \quad |-x| = |x|$[/color][/bold]'' ;
    text id 60 start 450.0s for 2.5s at (8.0, 56.0) ''[color=#FBBF24]Exemple :[/color] [color=#F8FAFC]$|-3| = 3$[/color] [color=#FBBF24]et[/color] [color=#F8FAFC]$|3| = 3 \implies |-3| = |3|$[/color]'' ;

    text id 61 start 469.0s for 2.5s at (4.0, 68.0) ''[bold][color=#C084FC]Propriété 3 (Annulation stricte) :[/color][/bold]'' ;
    text id 62 start 473.0s for 2.2s at (8.0, 76.0) ''[bold][color=#F8FAFC]$|x| = 0 \iff x = 0$[/color][/bold]'' ;

    # Colonne de droite
    text id 63 start 491.0s for 2.5s at (96.0, 20.0) ''[bold][color=#FBBF24]Propriété 4 (Égalité des valeurs absolues) :[/color][/bold]'' ;
    text id 64 start 495.0s for 2.5s at (98.0, 28.0) ''[bold][color=#F8FAFC]$|x| = |y| \iff (x = y \quad \text{ou} \quad x = -y)$[/color][/bold]'' ;

    text id 65 start 512.0s for 2.5s at (96.0, 42.0) ''[bold][color=#34D399]Propriété 5 (Multiplication) :[/color][/bold]'' ;
    text id 66 start 516.0s for 2.2s at (98.0, 50.0) ''[bold][color=#F8FAFC]$|x \times y| = |x| \times |y|$[/color][/bold]'' ;

    text id 67 start 525.0s for 2.5s at (96.0, 64.0) ''[bold][color=#38BDF8]Propriété 6 (Division avec $y \ne 0$) :[/color][/bold]'' ;
    text id 68 start 529.0s for 2.5s at (98.0, 73.0) ''[bold][color=#F8FAFC]$$\left| \frac{x}{y} \right| = \frac{|x|}{|y|}$$[/color][/bold]'' ;

    erase id 2005 start 539.2s ;

    # =========================================================================
    # SCENE 6 : PIÈGE D'EXAMEN : RACINE CARRÉE DE x^2 (540.0s -> 644.2s)
    # =========================================================================
    text id 69 start 541.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]5. PIÈGE D'EXAMEN : LA RACINE CARRÉE DE $x^2$[/color][/bold]'' ;
    draw line id 519 start 543.0s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 70 start 546.0s for 2.5s at (4.0, 20.0) ''[bold][color=#F87171]FAUX en général :[/color][/bold] [color=#F8FAFC]$\sqrt{x^2} = x$[/color]  [color=#F87171](vrai SEULEMENT si $x \ge 0$ !)[/color]'' ;
    draw polygone id 520 start 555.0s for 1.5s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.1) width 2.0 at [(4, 28), (88, 28), (88, 48), (4, 48)] ;
    text id 71 start 558.0s for 2.5s at (6.0, 32.5) ''[bold][color=#34D399]RÈGLE UNIVERSELLE VRAIE POUR TOUT $x \in \mathbb{R}$ :[/color][/bold]'' ;
    text id 72 start 563.0s for 2.5s at (24.0, 40.0) ''[bold][color=#F8FAFC]$$\mathbf{\sqrt{x^2} = |x|}$$[/color][/bold]'' ;

    text id 73 start 582.0s for 2.5s at (4.0, 54.0) ''[bold][color=#FBBF24]Démonstration pas à pas avec $x = -5$ :[/color][/bold]'' ;
    text id 74 start 590.0s for 2.5s at (6.0, 63.0) ''[color=#F8FAFC]1) Calcul de $\sqrt{(-5)^2}$ :[/color]  [color=#38BDF8]$(-5)^2 = 25 \implies \sqrt{25} = 5$[/color]'' ;
    text id 75 start 605.0s for 2.5s at (6.0, 73.0) ''[color=#F8FAFC]2) Calcul de $|-5|$ :[/color]           [color=#34D399]$|-5| = 5$[/color]'' ;
    text id 76 start 618.0s for 2.5s at (6.0, 83.0) ''[bold][color=#34D399]On a bien : $\sqrt{(-5)^2} = |-5| = 5$[/color][/bold]'' ;

    # Contre-exemple et explication à droite
    draw polygone id 521 start 624.0s for 1.5s color (248, 113, 113, 0.8) fillcolor (248, 113, 113, 0.08) width 1.8 at [(94, 20), (170, 20), (170, 88), (94, 88)] ;
    text id 77 start 626.5s for 2.2s at (98.0, 24.0) ''[bold][color=#F87171]Pourquoi écrire $x$ mène à une absurdité ?[/color][/bold]'' ;
    draw line id 522 start 629.5s for 1.0s color (248, 113, 113, 0.4) width 1.5 at [(94, 32), (170, 32)] ;
    text id 78 start 631.5s for 2.2s at (98.0, 38.0) ''[color=#F8FAFC]Si l'on appliquait naïvement $\sqrt{x^2} = x$ :[/color]'' ;
    text id 79 start 634.5s for 2.5s at (100.0, 50.0) ''[color=#F87171]$$\sqrt{(-5)^2} = -5 \implies 5 = -5 \quad \text{(FAUX !)}$$[/color]'' ;
    text id 80 start 638.0s for 2.5s at (98.0, 66.0) ''[color=#F8FAFC]Une racine carrée est TOUJOURS positive :[/color]'' ;
    text id 81 start 641.0s for 2.5s at (104.0, 76.0) ''[bold][color=#34D399]$$\sqrt{A} \ge 0 \implies \sqrt{x^2} = |x| \ge 0$$[/color][/bold]'' ;

    erase id 2006 start 644.2s ;

    # =========================================================================
    # SCENE 7 : DISTANCE SUR LA DROITE RÉELLE (644.5s -> 772.2s)
    # =========================================================================
    text id 82 start 645.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]6. DISTANCE SUR LA DROITE RÉELLE GRADUÉE[/color][/bold]'' ;
    draw line id 523 start 647.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 83 start 650.0s for 2.2s at (4.0, 20.0) ''[bold][color=#FBBF24]Théorème fondamental de distance :[/color][/bold]'' ;
    draw polygone id 524 start 653.0s for 1.5s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.08) width 1.8 at [(4, 27), (88, 27), (88, 48), (4, 48)] ;
    text id 84 start 656.0s for 2.5s at (6.0, 31.0) ''[color=#F8FAFC]Soient deux points $A(a)$ et $B(b)$ d'un axe gradué :[/color]'' ;
    text id 85 start 662.0s for 2.8s at (14.0, 38.5) ''[bold][color=#38BDF8]$$AB = |a - b| = |b - a|$$[/color][/bold]'' ;

    text id 86 start 681.0s for 2.5s at (4.0, 53.0) ''[bold][color=#34D399]Exemple numérique concret : $A(1{,}5)$ et $B(4)$[/color][/bold]'' ;
    text id 87 start 695.0s for 2.5s at (6.0, 62.0) ''[color=#F8FAFC]Sens classique $(B > A)$ :[/color]  $4 - 1{,}5 = 2{,}5$'' ;
    text id 88 start 719.0s for 2.5s at (6.0, 72.0) ''[color=#F8FAFC]Autre sens $(A - B)$ :[/color]     $1{,}5 - 4 = -2{,}5 < 0$  [color=#F87171](invalide)[/color]'' ;
    text id 89 start 738.0s for 2.5s at (6.0, 82.0) ''[bold][color=#34D399]Avec valeur absolue :[/color][/bold]  [color=#F8FAFC]$|1{,}5 - 4| = |-2{,}5| =$[/color] [bold][color=#34D399]$2{,}5$[/color][/bold]'' ;

    # Droite graduée à droite
    draw line id 525 start 654.0s for 1.5s color (248, 250, 252, 0.9) width 2.2 at [(94, 52), (168, 52)] ;
    draw arrow id 526 start 656.0s for 0.8s color (248, 250, 252, 0.9) width 2.2 at [(166, 52), (172, 52)] ;
    draw line id 527 start 658.0s color (248, 250, 252, 0.4) width 1.5 at [(100, 49), (100, 55)] ;
    text id 90 start 659.0s at (98.5, 57.0) ''[color=#F8FAFC]$0$[/color]'' ;

    draw line id 528 start 684.0s color (56, 189, 248, 1) width 3.0 at [(118, 48), (118, 56)] ;
    text id 91 start 686.0s at (113.0, 58.0) ''[bold][color=#38BDF8]$A(1{,}5)$[/color][/bold]'' ;
    draw line id 529 start 689.0s color (52, 211, 153, 1) width 3.0 at [(148, 48), (148, 56)] ;
    text id 92 start 691.0s at (145.0, 58.0) ''[bold][color=#34D399]$B(4)$[/color][/bold]'' ;

    draw line id 530 start 698.0s for 1.2s color (251, 191, 36, 1) width 3.5 at [(118, 52), (148, 52)] ;
    draw path id 531 start 702.0s for 1.2s color (251, 191, 36, 1) width 2.0 at [(118, 45), (118, 41), (148, 41), (148, 45)] ;
    text id 93 start 705.0s for 2.2s at (122.0, 32.0) ''[bold][color=#FBBF24]$d = |4 - 1{,}5| = 2{,}5$[/color][/bold]'' ;

    text id 94 start 755.0s for 2.5s at (96.0, 74.0) ''[bold][color=#38BDF8]Avantage capital :[/color][/bold] [color=#F8FAFC]Indépendant de l'ordre des points ![/color]'' ;
    text id 95 start 760.0s for 2.5s at (100.0, 82.0) ''[bold][color=#34D399]$$|a - b| = |b - a| \ge 0$$[/color][/bold]'' ;

    erase id 2007 start 772.2s ;

    # =========================================================================
    # SCENE 8 : INÉGALITÉS & INTERVALLES CENTRÉS (773.0s -> 855.2s)
    # =========================================================================
    text id 96 start 774.0s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]7. INÉGALITÉS & INTERVALLES CENTRÉS SUR L'AXE RÉEL[/color][/bold]'' ;
    draw line id 532 start 776.0s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    text id 97 start 778.0s for 2.5s at (4.0, 20.0) ''[bold][color=#FBBF24]Interprétation de l'inégalité $|x - a| \le r$ $(r > 0)$ :[/color][/bold]'' ;
    text id 98 start 791.0s for 2.8s at (6.0, 29.0) ''[color=#F8FAFC]$|x - a|$ représente la [bold]distance entre $x$ et le centre $a$[/bold].[/color]'' ;
    text id 99 start 802.0s for 2.5s at (6.0, 38.0) ''[color=#F8FAFC]Dire que $|x - a| \le r$ signifie que :[/color]'' ;
    text id 100 start 807.0s for 2.5s at (8.0, 46.0) ''[color=#38BDF8]« Le réel $x$ est situé à une distance au plus $r$ de $a$ »[/color]'' ;

    draw polygone id 533 start 832.0s for 1.5s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.1) width 2.0 at [(4, 56), (88, 56), (88, 86), (4, 86)] ;
    text id 101 start 834.0s for 2.5s at (6.0, 60.0) ''[bold][color=#34D399]Équivalence fondamentale de lycée :[/color][/bold]'' ;
    text id 102 start 838.0s for 3.0s at (10.0, 67.5) ''[bold][color=#F8FAFC]$$\mathbf{|x - a| \le r \iff x \in [a - r \,;\, a + r]}$$[/color][/bold]'' ;
    text id 103 start 846.0s for 2.5s at (8.0, 78.0) ''[color=#FBBF24]Intervalle fermé centré en $a$ et de rayon $r$.[/color]'' ;

    # Droite graduée et schéma à droite
    draw line id 534 start 792.0s for 1.5s color (248, 250, 252, 0.9) width 2.2 at [(94, 52), (168, 52)] ;
    draw arrow id 535 start 794.0s for 0.8s color (248, 250, 252, 0.9) width 2.2 at [(166, 52), (172, 52)] ;

    draw line id 536 start 796.0s color (251, 191, 36, 1) width 3.0 at [(131, 48), (131, 56)] ;
    text id 104 start 798.0s at (127.0, 59.0) ''[bold][color=#FBBF24]Centre $a$[/color][/bold]'' ;

    draw line id 537 start 812.0s color (56, 189, 248, 1) width 2.5 at [(106, 48), (106, 56)] ;
    text id 105 start 814.0s at (100.0, 59.0) ''[color=#38BDF8]$a - r$[/color]'' ;
    draw line id 538 start 818.0s color (56, 189, 248, 1) width 2.5 at [(156, 48), (156, 56)] ;
    text id 106 start 820.0s at (152.0, 59.0) ''[color=#38BDF8]$a + r$[/color]'' ;

    draw line id 539 start 824.0s for 1.2s color (52, 211, 153, 0.9) width 4.5 at [(106, 52), (156, 52)] ;
    draw arrow id 540 start 826.5s for 0.8s color (251, 191, 36, 1) width 1.8 at [(131, 42), (106, 42)] ;
    text id 107 start 828.0s at (116.0, 34.0) ''[color=#FBBF24]$-r$[/color]'' ;
    draw arrow id 541 start 829.5s for 0.8s color (251, 191, 36, 1) width 1.8 at [(131, 42), (156, 42)] ;
    text id 108 start 831.0s at (141.0, 34.0) ''[color=#FBBF24]$+r$[/color]'' ;

    draw path id 542 start 840.0s for 0.8s color (52, 211, 153, 1) width 2.5 at [(108, 48), (106, 48), (106, 56), (108, 56)] ;
    draw path id 543 start 841.5s for 0.8s color (52, 211, 153, 1) width 2.5 at [(154, 48), (156, 48), (156, 56), (154, 56)] ;
    text id 109 start 848.0s for 2.2s at (110.0, 76.0) ''[bold][color=#34D399]$x \in [a - r \,;\, a + r]$[/color][/bold]'' ;

    erase id 2008 start 855.2s ;

    # =========================================================================
    # SCENE 9 : SYNTHÈSE MÉTHODOLOGIQUE & RÉFLEXES LYCÉE (856.0s -> 886.3s)
    # =========================================================================
    text id 110 start 856.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]8. SYNTHÈSE MÉTHODOLOGIQUE & RÉFLEXES LYCÉE[/color][/bold]'' ;
    draw line id 544 start 858.5s for 1.0s color (56, 189, 248, 0.9) width 2.0 at [(4, 13.5), (173, 13.5)] ;

    # 4 Cartes de synthèse
    draw polygone id 545 start 860.0s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.08) width 1.8 at [(4, 20), (86, 20), (86, 50), (4, 50)] ;
    text id 111 start 861.5s for 2.0s at (6.0, 23.5) ''[bold][color=#38BDF8]1. Définition algébrique formelle[/color][/bold]'' ;
    text id 112 start 864.0s for 2.2s at (8.0, 31.5) ''[color=#F8FAFC]$|a| = a$ si $a \ge 0$, et $|a| = -a$ si $a < 0$[/color]'' ;
    text id 113 start 867.0s at (8.0, 41.0) ''[color=#34D399]Toujours $|a| \ge 0$ (grandeur positive).[/color]'' ;

    draw polygone id 546 start 868.5s for 1.0s color (248, 113, 113, 0.8) fillcolor (248, 113, 113, 0.08) width 1.8 at [(92, 20), (173, 20), (173, 50), (92, 50)] ;
    text id 114 start 870.0s for 2.0s at (96.0, 23.5) ''[bold][color=#F87171]2. Réflexe d'examen capital[/color][/bold]'' ;
    text id 115 start 872.5s for 2.0s at (96.0, 32.5) ''[bold][color=#FBBF24]$$\mathbf{\sqrt{x^2} = |x| \ne x} \quad (\text{si } x < 0)$$[/color][/bold]'' ;

    draw polygone id 547 start 875.0s for 1.0s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.08) width 1.8 at [(4, 56), (86, 56), (86, 88), (4, 88)] ;
    text id 116 start 876.5s for 2.0s at (6.0, 59.5) ''[bold][color=#34D399]3. Distance sur la droite réelle[/color][/bold]'' ;
    text id 117 start 879.0s for 2.2s at (8.0, 68.0) ''[bold][color=#F8FAFC]$$AB = |a - b| = |b - a|$$[/color][/bold]'' ;
    text id 118 start 881.8s at (8.0, 79.0) ''[color=#38BDF8]Indépendant du sens de parcours.[/color]'' ;

    draw polygone id 548 start 882.5s for 1.0s color (192, 132, 252, 0.8) fillcolor (192, 132, 252, 0.08) width 1.8 at [(92, 56), (173, 56), (173, 88), (92, 88)] ;
    text id 119 start 883.8s at (96.0, 59.5) ''[bold][color=#C084FC]4. Intervalles centrés[/color][/bold]'' ;
    text id 120 start 884.8s at (96.0, 70.0) ''[bold][color=#F8FAFC]$$|x - a| \le r \iff x \in [a - r \,;\, a + r]$$[/color][/bold]'' ;

}
