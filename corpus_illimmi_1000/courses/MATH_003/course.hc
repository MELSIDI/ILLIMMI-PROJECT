course "Exemple guidé et calcul détaillé : Intervalles et encadrements de réels en pratique" id 1 idgap 500 for 395.21s audio "narration.wav" {

    # ==========================================
    # SCENE 1 : 0.0s -> 58.0s (Objectif et Démarche)
    # ==========================================
    text id 1 start 0.5s at (4.0, 7.0) ''[bold][color=#38BDF8]1. Opérations sur les Inégalités & Encadrements[/color][/bold]'' ;
    draw line id 501 start 0.8s for 0.5s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 2 start 2.5s at (5.0, 18.0) ''[color=#F8FAFC]Objectif : Déduire l'encadrement d'une expression affine[/color]'' ;
    text id 3 start 10.5s at (5.0, 27.0) ''[bold][color=#FBBF24]Hypothèse initiale :[/color][/bold]  [color=#38BDF8]$x < 3$[/color]'' ;
    text id 4 start 20.0s at (5.0, 36.0) ''[color=#F8FAFC]Problème : Que peut-on dire de l'expression [/color][color=#34D399]$3x - 4$[/color] ?'' ;

    text id 5 start 40.0s at (5.0, 48.0) ''[bold][color=#C084FC]Méthode pas à pas :[/color][/bold]'' ;
    text id 6 start 42.0s at (7.0, 56.0) ''[color=#F8FAFC]1. Respecter les priorités opératoires : multiplier avant de soustraire[/color]'' ;
    text id 7 start 51.0s at (7.0, 65.0) ''[color=#F8FAFC]2. Encadrer d'abord [/color][color=#38BDF8]$3x$[/color][color=#F8FAFC], puis retrancher [/color][color=#FBBF24]$4$[/color]'' ;

    draw polygone id 502 start 12.0s for 0.6s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 8 start 14.0s at (102.0, 25.0) ''[bold][color=#F8FAFC]Départ :[/color][/bold]  [color=#38BDF8]$x < 3$[/color]'' ;
    draw arrow id 503 start 26.0s for 0.5s color (251, 191, 36, 0.9) width 2.0 at [(132, 32), (132, 44)] ;
    text id 9 start 27.0s at (136.0, 37.0) ''[color=#FBBF24]$\times 3$[/color]'' ;

    text id 10 start 32.0s at (102.0, 48.0) ''[bold][color=#F8FAFC]Étape 1 :[/color][/bold]  [color=#38BDF8]$3x < ?$[/color]'' ;
    draw arrow id 504 start 46.0s for 0.5s color (52, 211, 153, 0.9) width 2.0 at [(132, 55), (132, 67)] ;
    text id 11 start 47.0s at (136.0, 60.0) ''[color=#34D399]$- 4$[/color]'' ;

    text id 12 start 52.0s at (102.0, 72.0) ''[bold][color=#F8FAFC]Cible :[/color][/bold]  [color=#34D399]$3x - 4 < ?$[/color]'' ;

    erase id 2001 start 58.0s ;

    # ==========================================
    # SCENE 2 : 58.5s -> 117.5s (Exemple 1 : Étape 1)
    # ==========================================
    text id 13 start 58.5s at (4.0, 7.0) ''[bold][color=#38BDF8]2. Exemple 1 — Étape 1 : Multiplication par un Positif[/color][/bold]'' ;
    draw line id 505 start 58.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 14 start 59.5s at (5.0, 18.0) ''[bold][color=#FBBF24]Hypothèse :[/color][/bold]  [color=#F8FAFC]$x < 3$[/color]'' ;
    text id 15 start 70.0s at (5.0, 28.0) ''[color=#F8FAFC]On multiplie les deux membres par [/color][color=#38BDF8]$3$[/color] :'' ;
    text id 16 start 88.5s at (8.0, 38.0) ''[color=#F8FAFC]$3 \times x < 3 \times 3$[/color]'' ;

    text id 17 start 98.0s at (5.0, 50.0) ''[bold][color=#34D399]Propriété fondamentale :[/color][/bold]'' ;
    text id 18 start 100.5s at (7.0, 58.0) ''[color=#F8FAFC]Comme [/color][color=#34D399]$3 > 0$[/color][color=#F8FAFC], le sens de l'inégalité est [/color][bold][color=#34D399]conservé[/color][/bold][color=#F8FAFC].[/color]'' ;

    text id 19 start 108.5s at (5.0, 69.0) ''[color=#F8FAFC]Calcul numérique : [/color][color=#FBBF24]$3 \times 3 = 9$[/color]'' ;
    text id 20 start 113.5s at (8.0, 79.0) ''[bold][color=#38BDF8]$\mathbf{3x < 9}$[/color][/bold]'' ;
    draw polygone id 506 start 114.0s for 0.5s color (56, 189, 248, 0.9) width 1.8 fillcolor (56, 189, 248, 0.12) at [(6, 75), (42, 75), (42, 87), (6, 87)] ;

    draw polygone id 507 start 61.0s for 0.5s color (251, 191, 36, 0.6) width 1.5 fillcolor (251, 191, 36, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 21 start 63.0s at (98.0, 25.0) ''[bold][color=#FBBF24]Transformation membre à membre :[/color][/bold]'' ;
    text id 22 start 65.0s at (105.0, 36.0) ''[color=#38BDF8]$x$[/color]'' ;
    text id 23 start 65.5s at (128.0, 36.0) ''[color=#F8FAFC]$<$[/color]'' ;
    text id 24 start 66.0s at (150.0, 36.0) ''[color=#FBBF24]$3$[/color]'' ;

    draw arrow id 508 start 67.0s for 0.5s color (52, 211, 153, 0.9) width 2.0 at [(107, 41), (107, 54)] ;
    text id 25 start 67.5s at (96.0, 47.0) ''[color=#34D399]$\times 3$[/color]'' ;
    draw arrow id 509 start 68.0s for 0.5s color (52, 211, 153, 0.9) width 2.0 at [(152, 41), (152, 54)] ;
    text id 26 start 68.5s at (156.0, 47.0) ''[color=#34D399]$\times 3$[/color]'' ;

    text id 27 start 74.0s at (103.0, 61.0) ''[color=#38BDF8]$3x$[/color]'' ;
    text id 28 start 74.5s at (128.0, 61.0) ''[bold][color=#34D399]$<$[/color][/bold]'' ;
    text id 29 start 75.0s at (150.0, 61.0) ''[color=#FBBF24]$9$[/color]'' ;

    text id 30 start 96.0s at (98.0, 74.0) ''[color=#34D399]$\checkmark$ Sens conservé car $3 > 0$[/color]'' ;

    erase id 2002 start 117.5s ;

    # ==========================================
    # SCENE 3 : 118.0s -> 190.0s (Exemple 1 : Étape 2 & Droite Réelle)
    # ==========================================
    text id 31 start 118.0s at (4.0, 7.0) ''[bold][color=#38BDF8]3. Exemple 1 — Étape 2 : Soustraction & Droite Réelle[/color][/bold]'' ;
    draw line id 510 start 118.3s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 32 start 119.5s at (5.0, 18.0) ''[bold][color=#FBBF24]Résultat intermédiaire :[/color][/bold]  [color=#F8FAFC]$3x < 9$[/color]'' ;
    text id 33 start 125.0s at (5.0, 28.0) ''[color=#F8FAFC]On retranche [/color][color=#FBBF24]$4$[/color][color=#F8FAFC] aux deux membres :[/color]'' ;
    text id 34 start 138.0s at (8.0, 38.0) ''[color=#F8FAFC]$3x - 4 < 9 - 4$[/color]'' ;

    text id 35 start 146.0s at (5.0, 49.0) ''[color=#34D399]Ajouter ou soustraire ne change jamais le sens.[/color]'' ;
    text id 36 start 153.0s at (5.0, 59.0) ''[color=#F8FAFC]Calcul numérique : [/color][color=#FBBF24]$9 - 4 = 5$[/color]'' ;
    text id 37 start 157.0s at (8.0, 69.0) ''[bold][color=#34D399]$\mathbf{3x - 4 < 5}$[/color][/bold]'' ;
    draw polygone id 511 start 158.0s for 0.5s color (52, 211, 153, 0.9) width 1.8 fillcolor (52, 211, 153, 0.12) at [(6, 65), (50, 65), (50, 77), (6, 77)] ;

    text id 38 start 174.0s at (5.0, 83.0) ''[color=#38BDF8]Notation intervalle : [/color][color=#F8FAFC]$3x - 4 \in ]-\infty ; 5[$[/color]'' ;

    draw polygone id 512 start 160.0s for 0.5s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 39 start 161.0s at (96.0, 25.0) ''[bold][color=#F8FAFC]Représentation sur l'axe des réels :[/color][/bold]'' ;

    draw arrow id 513 start 162.0s for 0.6s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (168, 52)] ;
    text id 40 start 163.0s at (168.0, 48.0) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 514 start 164.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(112, 49), (112, 55)] ;
    text id 41 start 164.5s at (111.0, 58.0) ''[color=#F8FAFC]$0$[/color]'' ;

    draw line id 515 start 165.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(130, 49), (130, 55)] ;
    text id 42 start 165.5s at (129.0, 58.0) ''[color=#F8FAFC]$3$[/color]'' ;

    draw line id 516 start 166.0s for 0.3s color (248, 250, 252, 0.7) width 1.5 at [(148, 49), (148, 55)] ;
    text id 43 start 166.5s at (147.0, 59.5) ''[bold][color=#34D399]$5$[/color][/bold]'' ;

    draw line id 517 start 169.0s for 0.8s color (52, 211, 153, 0.95) width 4.5 at [(96, 52), (148, 52)] ;
    draw path id 518 start 175.0s for 0.4s color (248, 113, 113, 1.0) width 2.8 at [(145, 46), (148, 46), (148, 56), (145, 56)] ;
    text id 44 start 176.5s at (122.0, 38.0) ''[color=#F87171]crochet ouvert (5 exclu)[/color]'' ;
    text id 45 start 178.0s at (96.0, 73.0) ''[bold][color=#34D399]$3x - 4 < 5 \iff 3x - 4 \in ]-\infty ; 5[$[/color][/bold]'' ;

    erase id 2003 start 190.0s ;

    # ==========================================
    # SCENE 4 : 190.5s -> 243.8s (Exemple 2 : Départ & Décomposition)
    # ==========================================
    text id 46 start 190.5s at (4.0, 7.0) ''[bold][color=#38BDF8]4. Exemple 2 — Départ et Priorités de Calcul[/color][/bold]'' ;
    draw line id 519 start 190.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 47 start 192.0s at (5.0, 18.0) ''[color=#F8FAFC]Nouvel énoncé avec un piège classique à déjouer.[/color]'' ;
    text id 48 start 198.0s at (5.0, 27.0) ''[bold][color=#FBBF24]Hypothèse initiale :[/color][/bold]  [color=#38BDF8]$x > 1$[/color]'' ;
    text id 49 start 208.0s at (5.0, 36.0) ''[color=#F8FAFC]Objectif : Que peut-on dire de [/color][color=#34D399]$4 - 2x$[/color] ?'' ;

    text id 50 start 214.0s at (5.0, 48.0) ''[bold][color=#C084FC]Décomposition de l'expression :[/color][/bold]'' ;
    text id 51 start 218.0s at (7.0, 56.0) ''[color=#F8FAFC]1. Multiplication de [/color][color=#38BDF8]$x$[/color][color=#F8FAFC] par [/color][color=#FBBF24]$2$[/color][color=#F8FAFC] en priorité[/color]'' ;
    text id 52 start 221.5s at (7.0, 64.0) ''[color=#F8FAFC]2. Prise de l'opposé [/color][color=#F87171]$-2x$[/color][color=#F8FAFC], puis ajout de [/color][color=#38BDF8]$4$[/color]'' ;

    text id 53 start 227.0s at (5.0, 76.0) ''[color=#F8FAFC]Partons de [/color][color=#38BDF8]$x > 1$[/color][color=#F8FAFC] et multiplions par [/color][color=#FBBF24]$2$[/color] :'' ;
    text id 54 start 233.0s at (8.0, 85.0) ''[color=#F8FAFC]$2 \times x > 2 \times 1 \implies $[/color][bold][color=#34D399]$\mathbf{2x > 2}$[/color][/bold]'' ;

    draw polygone id 520 start 193.0s for 0.5s color (192, 132, 252, 0.6) width 1.5 fillcolor (192, 132, 252, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 55 start 194.0s at (98.0, 25.0) ''[bold][color=#C084FC]Analyse de l'expression :[/color][/bold]'' ;
    text id 56 start 209.0s at (105.0, 35.0) ''[bold][color=#F8FAFC]$4 - 2x = $[/color][color=#38BDF8]$-2x$[/color][color=#F8FAFC] + [/color][color=#FBBF24]$4$[/color][/bold]'' ;

    text id 57 start 223.0s at (98.0, 47.0) ''[bold][color=#F8FAFC]Étape 1 :[/color][/bold]  [color=#38BDF8]$x \longrightarrow 2x$[/color]'' ;
    draw arrow id 521 start 224.0s for 0.4s color (52, 211, 153, 0.9) width 2.0 at [(138, 47), (150, 47)] ;
    text id 58 start 225.0s at (152.0, 45.0) ''[color=#34D399]$\times 2$[/color]'' ;

    text id 59 start 235.0s at (98.0, 59.0) ''[bold][color=#F8FAFC]Étape 2 :[/color][/bold]  [color=#F87171]$2x \longrightarrow -2x$[/color]'' ;
    draw arrow id 522 start 236.0s for 0.4s color (248, 113, 113, 0.9) width 2.0 at [(138, 59), (150, 59)] ;
    text id 60 start 237.0s at (152.0, 57.0) ''[color=#F87171]$\times (-1)$[/color]'' ;

    text id 61 start 240.0s at (98.0, 73.0) ''[bold][color=#F87171]ATTENTION : Le sens reste-t-il $> ?$[/color][/bold]'' ;

    erase id 2004 start 243.8s ;

    # ==========================================
    # SCENE 5 : 244.2s -> 316.0s (Le Piège Fondamental)
    # ==========================================
    text id 62 start 244.2s at (4.0, 7.0) ''[bold][color=#F87171]5. Le Piège Fondamental : Multiplication par un Négatif[/color][/bold]'' ;
    draw line id 523 start 244.5s for 0.4s color (248, 113, 113, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 63 start 246.0s at (5.0, 18.0) ''[bold][color=#F8FAFC]La question :[/color][/bold]  [color=#F8FAFC]Si [/color][color=#38BDF8]$2x > 2$[/color][color=#F8FAFC], a-t-on [/color][color=#F87171]$-2x > -2$[/color] ?'' ;
    text id 64 start 261.0s at (8.0, 27.0) ''[bold][color=#F87171]NON ! C'est le piège numéro 1 des inéquations ![/color][/bold]'' ;

    text id 65 start 270.0s at (5.0, 38.0) ''[bold][color=#FBBF24]Exemple 1 :[/color][/bold]'' ;
    text id 66 start 277.5s at (8.0, 46.0) ''[color=#F8FAFC]On sait que [/color][color=#34D399]$1 < 2$[/color]'' ;
    text id 67 start 287.5s at (8.0, 54.0) ''[color=#F8FAFC]Mais pour les opposés : [/color][bold][color=#F87171]$-1 > -2$[/color][/bold]'' ;
    text id 68 start 297.0s at (8.0, 62.0) ''[color=#FBBF24]L'inégalité s'est retournée ![/color]'' ;

    text id 69 start 302.0s at (5.0, 72.0) ''[bold][color=#FBBF24]Exemple 2 :[/color][/bold]'' ;
    text id 70 start 304.0s at (8.0, 80.0) ''[color=#F8FAFC]On sait que [/color][color=#34D399]$10 > 3$[/color]'' ;
    text id 71 start 308.5s at (8.0, 88.0) ''[color=#F8FAFC]Mais pour les opposés : [/color][bold][color=#F87171]$-10 < -3$[/color][/bold]'' ;

    draw polygone id 524 start 247.0s for 0.5s color (248, 113, 113, 0.6) width 1.5 fillcolor (248, 113, 113, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 72 start 272.0s at (96.0, 24.0) ''[bold][color=#F8FAFC]Visualisation géométrique sur l'axe :[/color][/bold]'' ;

    draw arrow id 525 start 273.5s for 0.5s color (248, 250, 252, 0.9) width 2.0 at [(96, 52), (168, 52)] ;

    draw line id 526 start 274.5s for 0.3s color (248, 250, 252, 0.8) width 1.5 at [(132, 49), (132, 55)] ;
    text id 73 start 275.0s at (131.0, 58.0) ''[color=#F8FAFC]$0$[/color]'' ;

    draw circle id 527 start 277.5s for 0.3s color (52, 211, 153, 1.0) width 2.0 radius 1.5 at (142, 52) ;
    text id 74 start 278.0s at (141.0, 58.0) ''[color=#34D399]$1$[/color]'' ;
    draw circle id 528 start 279.0s for 0.3s color (52, 211, 153, 1.0) width 2.0 radius 1.5 at (154, 52) ;
    text id 75 start 279.5s at (153.0, 58.0) ''[color=#34D399]$2$[/color]'' ;
    draw arrow id 529 start 280.0s for 0.4s color (52, 211, 153, 0.9) width 1.5 at [(144, 44), (152, 44)] ;
    text id 76 start 280.5s at (144.0, 36.0) ''[color=#34D399]$1 < 2$[/color]'' ;

    draw circle id 530 start 284.0s for 0.3s color (248, 113, 113, 1.0) width 2.0 radius 1.5 at (122, 52) ;
    text id 77 start 284.5s at (120.0, 58.0) ''[color=#F87171]$-1$[/color]'' ;
    draw circle id 531 start 285.0s for 0.3s color (248, 113, 113, 1.0) width 2.0 radius 1.5 at (110, 52) ;
    text id 78 start 285.5s at (108.0, 58.0) ''[color=#F87171]$-2$[/color]'' ;
    draw arrow id 532 start 290.0s for 0.4s color (248, 113, 113, 0.9) width 1.5 at [(112, 44), (120, 44)] ;
    text id 79 start 291.5s at (111.0, 36.0) ''[color=#F87171]$-2 < -1$[/color]'' ;

    text id 80 start 294.5s at (96.0, 71.0) ''[bold][color=#F8FAFC]$-1$ est à droite de $-2 \implies $[/color][color=#F87171]$-1 > -2$[/color][/bold]'' ;
    text id 81 start 298.0s at (96.0, 80.0) ''[bold][color=#FBBF24]L'ordre des nombres est inversé par symétrie ![/color][/bold]'' ;

    erase id 2005 start 316.0s ;

    # ==========================================
    # SCENE 6 : 316.5s -> 366.5s (Exemple 2 : Application du Retournement)
    # ==========================================
    text id 82 start 316.5s at (4.0, 7.0) ''[bold][color=#38BDF8]6. Exemple 2 — Application du Retournement & Conclusion[/color][/bold]'' ;
    draw line id 533 start 316.8s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    text id 83 start 317.5s at (5.0, 18.0) ''[bold][color=#FBBF24]Règle fondamentale :[/color][/bold]'' ;
    text id 84 start 320.0s at (7.0, 26.0) ''[color=#F8FAFC]Multiplier ou diviser par un négatif [/color][bold][color=#F87171]inverse[/color][/bold][color=#F8FAFC] le sens.[/color]'' ;

    text id 85 start 329.5s at (5.0, 37.0) ''[bold][color=#F8FAFC]Étape 1 : Passage à l'opposé[/color][/bold]'' ;
    text id 86 start 331.0s at (7.0, 45.0) ''[color=#38BDF8]$2x > 2$[/color][color=#F8FAFC]  et on multiplie par  [/color][color=#F87171]$-1$[/color]'' ;
    text id 87 start 334.5s at (9.0, 53.0) ''[bold][color=#F87171]$\mathbf{-2x < -2}$[/color][/bold]  [color=#FBBF24](sens inversé : $>$ devient $<$) [/color]'' ;

    text id 88 start 338.0s at (5.0, 64.0) ''[bold][color=#F8FAFC]Étape 2 : Ajout de 4 des deux côtés[/color][/bold]'' ;
    text id 89 start 344.0s at (7.0, 72.0) ''[color=#F8FAFC]On ajoute [/color][color=#34D399]$4$[/color][color=#F8FAFC] (le sens ne change pas) :[/color]'' ;
    text id 90 start 354.5s at (9.0, 80.0) ''[color=#F8FAFC]$4 - 2x < 4 - 2$[/color]'' ;
    text id 91 start 363.0s at (9.0, 89.0) ''[bold][color=#34D399]$\mathbf{4 - 2x < 2}$[/color][/bold]'' ;
    draw polygone id 534 start 364.0s for 0.5s color (52, 211, 153, 0.9) width 1.8 fillcolor (52, 211, 153, 0.12) at [(7, 85), (48, 85), (48, 96), (7, 96)] ;

    draw polygone id 535 start 318.0s for 0.5s color (56, 189, 248, 0.6) width 1.5 fillcolor (56, 189, 248, 0.08) at [(92, 18), (172, 18), (172, 88), (92, 88)] ;
    text id 92 start 319.0s at (98.0, 24.0) ''[bold][color=#38BDF8]Chaîne d'implications :[/color][/bold]'' ;

    text id 93 start 321.0s at (102.0, 32.0) ''[color=#F8FAFC]Hypothèse :[/color]  [color=#38BDF8]$x > 1$[/color]'' ;
    draw arrow id 536 start 323.0s for 0.4s color (52, 211, 153, 0.9) width 2.0 at [(130, 37), (130, 44)] ;
    text id 94 start 324.0s at (134.0, 41.0) ''[color=#34D399]$\times 2 > 0$[/color]'' ;

    text id 95 start 326.0s at (102.0, 48.0) ''[color=#F8FAFC]Produit :[/color]  [color=#38BDF8]$2x > 2$[/color]'' ;
    draw arrow id 537 start 332.0s for 0.4s color (248, 113, 113, 0.9) width 2.0 at [(130, 53), (130, 60)] ;
    text id 96 start 333.0s at (134.0, 57.0) ''[bold][color=#F87171]$\times (-1) < 0$[/color][/bold]'' ;

    text id 97 start 336.0s at (102.0, 64.0) ''[bold][color=#F87171]Retournement :  $-2x < -2$[/color][/bold]'' ;
    draw arrow id 538 start 348.0s for 0.4s color (52, 211, 153, 0.9) width 2.0 at [(130, 69), (130, 76)] ;
    text id 98 start 349.0s at (134.0, 73.0) ''[color=#34D399]$+ 4$[/color]'' ;

    text id 99 start 358.0s at (102.0, 81.0) ''[bold][color=#34D399]Résultat :  $4 - 2x < 2$[/color][/bold]'' ;

    erase id 2006 start 366.5s ;

    # ==========================================
    # SCENE 7 : 367.0s -> 395.21s (Synthèse des Règles d'Or)
    # ==========================================
    text id 100 start 367.0s at (4.0, 7.0) ''[bold][color=#38BDF8]7. Synthèse : Les Règles d'Or des Inégalités[/color][/bold]'' ;
    draw line id 539 start 367.3s for 0.4s color (56, 189, 248, 0.7) width 1.5 at [(4, 12.5), (173, 12.5)] ;

    draw polygone id 540 start 368.0s for 0.5s color (52, 211, 153, 0.8) width 1.8 fillcolor (52, 211, 153, 0.08) at [(5, 18), (88, 18), (88, 52), (5, 52)] ;
    text id 101 start 371.0s at (8.0, 24.0) ''[bold][color=#34D399]Règle 1 : Addition & Soustraction[/color][/bold]'' ;
    text id 102 start 372.5s at (8.0, 31.0) ''[color=#F8FAFC]On peut [/color][bold][color=#34D399]ajouter[/color][/bold][color=#F8FAFC] ou [/color][bold][color=#34D399]soustraire[/color][/bold][color=#F8FAFC] un même nombre[/color]'' ;
    text id 103 start 374.5s at (8.0, 38.0) ''[color=#F8FAFC]sans jamais changer le sens de l'inégalité :[/color]'' ;
    text id 104 start 376.0s at (12.0, 46.0) ''[bold][color=#F8FAFC]$a < b \iff a + c < b + c$[/color][/bold]'' ;

    draw polygone id 541 start 377.0s for 0.5s color (251, 191, 36, 0.8) width 1.8 fillcolor (251, 191, 36, 0.08) at [(5, 56), (88, 56), (88, 94), (5, 94)] ;
    text id 105 start 377.5s at (8.0, 62.0) ''[bold][color=#FBBF24]Règle 2 : Multiplication & Division[/color][/bold]'' ;
    text id 106 start 379.5s at (8.0, 70.0) ''[color=#34D399]$\bullet$ Si $c > 0$ : on conserve le sens[/color]'' ;
    text id 107 start 381.5s at (12.0, 76.0) ''[color=#F8FAFC]$a < b \implies a \times c < b \times c$[/color]'' ;
    text id 108 start 383.5s at (8.0, 83.0) ''[bold][color=#F87171]$\bullet$ Si $c < 0$ : on INVERSE le sens ![/color][/bold]'' ;
    text id 109 start 385.5s at (12.0, 89.0) ''[bold][color=#F87171]$a < b \implies a \times c > b \times c$[/color][/bold]'' ;

    draw polygone id 542 start 387.0s for 0.5s color (192, 132, 252, 0.8) width 1.8 fillcolor (192, 132, 252, 0.08) at [(92, 18), (172, 18), (172, 94), (92, 94)] ;
    text id 110 start 387.5s at (96.0, 24.0) ''[bold][color=#C084FC]Réflexes pour Contrôles & Exercices[/color][/bold]'' ;

    text id 111 start 388.5s at (96.0, 34.0) ''[color=#38BDF8]1. Identifier l'ordre des opérations :[/color]'' ;
    text id 112 start 389.5s at (100.0, 42.0) ''[color=#F8FAFC]Multiplication/Division d'abord, puis Addition[/color]'' ;

    text id 113 start 390.5s at (96.0, 52.0) ''[color=#FBBF24]2. Alerte signe du coefficient :[/color]'' ;
    text id 114 start 391.5s at (100.0, 60.0) ''[color=#F8FAFC]Dès qu'un signe $-$ apparaît devant $x$,[/color]'' ;
    text id 115 start 392.5s at (100.0, 68.0) ''[bold][color=#F87171]retourner immédiatement le sens ($< \leftrightarrow >$) ![/color][/bold]'' ;

    text id 116 start 393.5s at (96.0, 78.0) ''[color=#34D399]3. Vérification par un test numérique :[/color]'' ;
    text id 117 start 394.2s at (100.0, 86.0) ''[color=#F8FAFC]Tester une valeur particulière pour valider l'inégalité.[/color]'' ;

}
