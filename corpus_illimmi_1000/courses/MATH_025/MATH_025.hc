course "Problème type Bac : Généralités sur les fonctions et lecture graphique — Raisonnement en plusieurs étapes" id 25 idgap 500 for 306s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 (0.0s - 66.5s) : Introduction & Tableau de Valeurs & Machine
    # =========================================================================

    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[bold][color=#38BDF8]1. La Fonction : Machine Mathématique & Tableau de Valeurs[/color][/bold]'' ;
    draw line id 501 start 2.6s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 2 start 10.4s for 2.2s at (5.0, 21.0) ''[color=#FBBF24]Tableau de valeurs de la fonction $f$ :[/color]'' ;

    # Grille du tableau à gauche
    draw polygone id 502 start 13.5s for 0.6s color (248, 250, 252, 0.8) width 1.5 at [(5, 27), (82, 27), (82, 51), (5, 51)] ;
    draw line id 503 start 14.2s color (248, 250, 252, 0.6) width 1.2 at [(5, 39), (82, 39)] ;
    draw line id 504 start 14.2s color (248, 250, 252, 0.6) width 1.2 at [(20, 27), (20, 51)] ;
    draw line id 505 start 14.2s color (248, 250, 252, 0.4) width 1.0 at [(35.5, 27), (35.5, 51)] ;
    draw line id 506 start 14.2s color (248, 250, 252, 0.4) width 1.0 at [(51.0, 27), (51.0, 51)] ;
    draw line id 507 start 14.2s color (248, 250, 252, 0.4) width 1.0 at [(66.5, 27), (66.5, 51)] ;

    text id 3 start 14.8s for 2.4s at (5.0, 58.0) ''[color=#38BDF8]1ère ligne :[/color] Nombres de départ (antécédents $x$)'' ;

    # Nombres du tableau
    text id 4 start 17.5s at (8.0, 32.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 5 start 17.5s at (6.5, 44.5) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 6 start 17.5s at (26.0, 32.5) ''$2$'' ;
    text id 7 start 17.5s at (26.0, 44.5) ''$5$'' ;
    text id 8 start 17.5s at (41.5, 32.5) ''$3$'' ;
    text id 9 start 17.5s at (41.5, 44.5) ''$0$'' ;
    text id 10 start 17.5s at (57.0, 32.5) ''$5$'' ;
    text id 11 start 17.5s at (57.0, 44.5) ''$-2$'' ;
    text id 12 start 17.5s at (72.5, 32.5) ''$6$'' ;
    text id 13 start 17.5s at (72.5, 44.5) ''$3$'' ;

    text id 14 start 19.9s for 2.4s at (5.0, 68.0) ''[color=#34D399]2ème ligne :[/color] Résultats obtenus (images $f(x)$)'' ;

    # Modèle de la boîte fonctionnelle à droite
    text id 15 start 27.0s for 1.8s at (105.0, 21.0) ''[bold][color=#FBBF24]Modèle de la Machine Mathématique[/color][/bold]'' ;
    draw arrow id 508 start 29.2s for 0.6s color (56, 189, 248, 1) width 2.5 at [(98, 41), (116, 41)] ;
    text id 16 start 30.3s for 1.2s at (98.0, 34.0) ''[color=#38BDF8]Entrée $x$[/color]'' ;

    draw polygone id 509 start 34.0s for 0.8s color (56, 189, 248, 0.9) width 2.0 fillcolor (56, 189, 248, 0.15) at [(118, 29), (148, 29), (148, 53), (118, 53)] ;
    text id 17 start 35.5s for 0.8s at (123.0, 37.0) ''[bold][color=#F8FAFC]Machine $f$[/color][/bold]'' ;
    text id 18 start 37.0s for 0.8s at (122.0, 45.0) ''[color=#94A3B8]Opérations[/color]'' ;

    draw arrow id 510 start 39.0s for 0.6s color (52, 211, 153, 1) width 2.5 at [(150, 41), (168, 41)] ;
    text id 19 start 40.5s for 1.2s at (152.0, 34.0) ''[color=#34D399]Sortie $f(x)$[/color]'' ;

    text id 20 start 46.5s for 2.5s at (102.0, 63.0) ''[color=#F8FAFC]Exemple de formule :[/color] [color=#38BDF8]$f(x) = x^2 + 1$[/color]'' ;
    text id 21 start 55.8s for 2.5s at (98.0, 73.0) ''[color=#FBBF24]Ici la formule est inconnue, mais le tableau[/color]'' ;
    text id 22 start 61.2s for 2.5s at (98.0, 81.0) ''[color=#FBBF24]donne directement les couples $(x ; f(x))$.[/color]'' ;

    erase id 2001 start 66.5s ;

    # =========================================================================
    # SCÈNE 2 (67.0s - 102.2s) : Question 1 : Déterminer l'Image de 3
    # =========================================================================

    text id 31 start 67.2s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Question 1 : Déterminer l'Image de 3 par la Fonction $f$[/color][/bold]'' ;
    draw line id 531 start 68.9s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 32 start 70.0s for 2.2s at (5.0, 21.0) ''[color=#FBBF24]Question 1 :[/color] Quelle est l'image de $3$ par la fonction $f$ ?'' ;

    # Tableau avec cible colonne x = 3
    draw polygone id 532 start 72.8s color (248, 250, 252, 0.8) width 1.5 at [(5, 27), (82, 27), (82, 51), (5, 51)] ;
    draw line id 533 start 72.8s color (248, 250, 252, 0.6) width 1.2 at [(5, 39), (82, 39)] ;
    draw line id 534 start 72.8s color (248, 250, 252, 0.6) width 1.2 at [(20, 27), (20, 51)] ;
    draw line id 535 start 72.8s color (248, 250, 252, 0.4) width 1.0 at [(35.5, 27), (35.5, 51)] ;
    draw line id 536 start 72.8s color (248, 250, 252, 0.4) width 1.0 at [(51.0, 27), (51.0, 51)] ;
    draw line id 537 start 72.8s color (248, 250, 252, 0.4) width 1.0 at [(66.5, 27), (66.5, 51)] ;

    text id 33 start 72.8s at (8.0, 32.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 34 start 72.8s at (6.5, 44.5) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 35 start 72.8s at (26.0, 32.5) ''$2$'' ;
    text id 36 start 72.8s at (26.0, 44.5) ''$5$'' ;
    text id 37 start 72.8s at (41.5, 32.5) ''[bold][color=#FBBF24]$3$[/color][/bold]'' ;
    text id 38 start 72.8s at (41.5, 44.5) ''[bold][color=#34D399]$0$[/color][/bold]'' ;
    text id 39 start 72.8s at (57.0, 32.5) ''$5$'' ;
    text id 40 start 72.8s at (57.0, 44.5) ''$-2$'' ;
    text id 41 start 72.8s at (72.5, 32.5) ''$6$'' ;
    text id 42 start 72.8s at (72.5, 44.5) ''$3$'' ;

    text id 43 start 73.7s for 2.2s at (5.0, 58.0) ''[bold][color=#38BDF8]Définition :[/color][/bold] L'image de $3$ est la valeur de $f(x)$ lorsque $x = 3$.'' ;

    # Droite : Méthode visuelle étape par étape
    draw polygone id 538 start 76.5s for 0.7s color (56, 189, 248, 0.9) width 1.5 fillcolor (56, 189, 248, 0.15) at [(102, 28), (166, 28), (166, 41), (102, 41)] ;
    text id 44 start 77.5s for 1.2s at (105.0, 34.0) ''[color=#38BDF8]1. Repérer $x = 3$ sur la 1ère ligne[/color]'' ;

    draw polygone id 539 start 79.2s for 0.7s color (251, 191, 36, 0.9) width 2.0 fillcolor (251, 191, 36, 0.2) at [(35.5, 27), (51.0, 27), (51.0, 51), (35.5, 51)] ;

    draw arrow id 540 start 82.0s for 0.6s color (251, 191, 36, 1) width 2.0 at [(133, 42), (133, 50)] ;
    text id 45 start 83.0s for 1.0s at (135.0, 46.0) ''[color=#FBBF24]Descente $f$[/color]'' ;

    draw polygone id 541 start 85.0s for 0.7s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(102, 51), (166, 51), (166, 64), (102, 64)] ;
    text id 46 start 86.2s for 1.2s at (105.0, 57.0) ''[color=#34D399]2. Lire la sortie sur la 2ème ligne : $0$[/color]'' ;

    # Flèche descendante sur le tableau
    draw arrow id 542 start 88.5s for 0.8s color (251, 191, 36, 1) width 2.5 at [(43.25, 36), (43.25, 43)] ;

    # Synthèse de la règle d'or à droite
    draw polygone id 543 start 90.0s for 0.6s color (251, 191, 36, 0.8) width 1.5 fillcolor (251, 191, 36, 0.12) at [(98, 71), (172, 71), (172, 87), (98, 87)] ;
    text id 49 start 91.0s for 1.4s at (101.0, 75.0) ''[bold][color=#FBBF24]Règle d'or de l'image :[/color][/bold]'' ;
    text id 50 start 92.8s for 1.8s at (101.0, 81.0) ''[color=#F8FAFC]On part de la ligne $x$ et on descend vers $f(x)$[/color]'' ;

    text id 47 start 95.8s for 2.0s at (5.0, 68.0) ''[bold][color=#34D399]Conclusion :[/color][/bold] L'image de $3$ par la fonction $f$ est [bold][color=#34D399]$0$[/color][/bold].'' ;
    text id 48 start 98.5s for 2.0s at (5.0, 77.0) ''Notation : [color=#38BDF8]$f(3) = 0$[/color] (sens direct de lecture, de haut en bas)'' ;

    erase id 2002 start 102.2s ;

    # =========================================================================
    # SCÈNE 3 (102.5s - 142.8s) : Question 2 : Déterminer un Antécédent de 3
    # =========================================================================

    text id 61 start 102.6s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Question 2 : Déterminer un Antécédent de 3 par la Fonction $f$[/color][/bold]'' ;
    draw line id 561 start 104.3s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 62 start 105.0s for 2.0s at (5.0, 21.0) ''[color=#FBBF24]Question 2 :[/color] Déterminer un antécédent de $3$ par la fonction $f$.'' ;

    # Tableau avec cible colonne x = 6
    draw polygone id 562 start 107.5s color (248, 250, 252, 0.8) width 1.5 at [(5, 27), (82, 27), (82, 51), (5, 51)] ;
    draw line id 563 start 107.5s color (248, 250, 252, 0.6) width 1.2 at [(5, 39), (82, 39)] ;
    draw line id 564 start 107.5s color (248, 250, 252, 0.6) width 1.2 at [(20, 27), (20, 51)] ;
    draw line id 565 start 107.5s color (248, 250, 252, 0.4) width 1.0 at [(35.5, 27), (35.5, 51)] ;
    draw line id 566 start 107.5s color (248, 250, 252, 0.4) width 1.0 at [(51.0, 27), (51.0, 51)] ;
    draw line id 567 start 107.5s color (248, 250, 252, 0.4) width 1.0 at [(66.5, 27), (66.5, 51)] ;

    text id 63 start 107.5s at (8.0, 32.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 64 start 107.5s at (6.5, 44.5) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 65 start 107.5s at (26.0, 32.5) ''$2$'' ;
    text id 66 start 107.5s at (26.0, 44.5) ''$5$'' ;
    text id 67 start 107.5s at (41.5, 32.5) ''$3$'' ;
    text id 68 start 107.5s at (41.5, 44.5) ''$0$'' ;
    text id 69 start 107.5s at (57.0, 32.5) ''$5$'' ;
    text id 70 start 107.5s at (57.0, 44.5) ''$-2$'' ;
    text id 71 start 107.5s at (72.5, 32.5) ''[bold][color=#34D399]$6$[/color][/bold]'' ;
    text id 72 start 107.5s at (72.5, 44.5) ''[bold][color=#F87171]$3$[/color][/bold]'' ;

    text id 73 start 109.0s for 2.2s at (5.0, 58.0) ''[bold][color=#F87171]Chemin inverse :[/color][/bold] On connaît la sortie $f(x) = 3$,'' ;
    text id 74 start 112.0s for 2.2s at (5.0, 66.0) ''on cherche la valeur de départ $x$ qui a donné ce résultat.'' ;

    # Droite : Démarche antécédent
    draw polygone id 568 start 114.8s for 0.6s color (248, 113, 113, 0.9) width 1.5 fillcolor (248, 113, 113, 0.15) at [(102, 28), (166, 28), (166, 41), (102, 41)] ;
    text id 75 start 116.0s for 1.2s at (105.0, 34.0) ''[color=#F87171]1. Repérer $f(x) = 3$ sur la 2ème ligne[/color]'' ;

    draw arrow id 569 start 117.8s for 0.6s color (248, 113, 113, 1) width 2.0 at [(133, 50), (133, 42)] ;
    text id 76 start 118.8s for 1.0s at (135.0, 46.0) ''[color=#F87171]Remontée[/color]'' ;

    draw polygone id 570 start 120.5s for 0.7s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(102, 51), (166, 51), (166, 64), (102, 64)] ;
    text id 77 start 121.8s for 1.2s at (105.0, 57.0) ''[color=#34D399]2. Lire l'antécédent en haut : $x = 6$[/color]'' ;

    # Mise en valeur colonne 4 sur tableau
    draw polygone id 571 start 125.8s for 0.7s color (248, 113, 113, 0.9) width 2.0 fillcolor (248, 113, 113, 0.2) at [(66.5, 27), (82.0, 27), (82.0, 51), (66.5, 51)] ;

    # Flèche montante sur le tableau
    draw arrow id 572 start 131.4s for 0.8s color (248, 113, 113, 1) width 2.5 at [(74.25, 43), (74.25, 36)] ;

    # Synthèse antécédent à droite
    draw polygone id 573 start 133.0s for 0.6s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.12) at [(98, 71), (172, 71), (172, 87), (98, 87)] ;
    text id 80 start 134.0s for 1.6s at (101.0, 75.0) ''[bold][color=#F87171]Règle d'or de l'antécédent :[/color][/bold]'' ;
    text id 81 start 136.0s for 1.8s at (101.0, 81.0) ''[color=#F8FAFC]On part de la ligne $f(x)$ et on remonte vers $x$[/color]'' ;

    text id 78 start 138.8s for 2.0s at (5.0, 75.0) ''[bold][color=#34D399]Conclusion :[/color][/bold] Un antécédent de $3$ par la fonction $f$ est [bold][color=#34D399]$6$[/color][/bold].'' ;
    text id 79 start 141.0s at (5.0, 84.0) ''Vérification : [color=#38BDF8]$f(6) = 3$[/color] (chemin inverse, de bas en haut)'' ;

    erase id 2003 start 142.8s ;

    # =========================================================================
    # SCÈNE 4 (143.1s - 188.8s) : Piège : 'L'Image' vs 'Un Antécédent'
    # =========================================================================

    text id 91 start 143.2s for 1.4s at (4.0, 7.5) ''[bold][color=#FBBF24]4. Piège Fréquent : 'L'Image' vs 'Un Antécédent'[/color][/bold]'' ;
    draw line id 591 start 145.0s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    # Colonne gauche : Unicité de l'image
    text id 92 start 146.8s for 2.2s at (5.0, 21.0) ''[bold][color=#38BDF8]Pourquoi dit-on L'IMAGE (au singulier) ?[/color][/bold]'' ;
    text id 93 start 153.0s for 2.5s at (5.0, 30.0) ''[bold][color=#34D399]L'image d'un nombre par une fonction est UNIQUE ![/color][/bold]'' ;
    text id 94 start 157.4s for 2.5s at (5.0, 40.0) ''Pour un nombre de départ $x$, la fonction applique sa formule'' ;
    text id 95 start 161.0s for 2.2s at (5.0, 49.0) ''et te renvoie [bold][color=#F8FAFC]un seul et unique[/color][/bold] résultat, jamais deux.'' ;

    draw circle id 592 start 163.6s color (56, 189, 248, 0.8) width 1.8 fillcolor (56, 189, 248, 0.15) radius 8.0 at (27, 67) ;
    draw circle id 593 start 163.6s color (52, 211, 153, 0.8) width 1.8 fillcolor (52, 211, 153, 0.15) radius 8.0 at (65, 67) ;
    text id 96 start 163.6s at (22.5, 65.5) ''[bold][color=#38BDF8]$x = 3$[/color][/bold]'' ;
    text id 97 start 163.6s at (62.5, 65.5) ''[bold][color=#34D399]$0$[/color][/bold]'' ;
    draw arrow id 594 start 163.8s for 0.6s color (56, 189, 248, 1) width 2.5 at [(36, 67), (56, 67)] ;
    text id 98 start 164.8s for 1.0s at (16.0, 80.0) ''[color=#34D399]Une seule flèche part de chaque entrée $x$[/color]'' ;

    # Colonne droite : Pluralité des antécédents
    text id 99 start 166.2s for 2.2s at (96.0, 21.0) ''[bold][color=#F87171]Pourquoi dit-on UN ANTÉCÉDENT (indéfini) ?[/color][/bold]'' ;
    text id 100 start 169.5s for 2.5s at (96.0, 30.0) ''[bold][color=#F87171]Plusieurs entrées peuvent donner la même sortie ![/color][/bold]'' ;
    text id 101 start 173.2s for 2.2s at (96.0, 40.0) ''Exemple : en entrant $6$, nous obtenons $3$ ;'' ;
    text id 102 start 177.0s for 2.2s at (96.0, 49.0) ''mais en entrant $122$, on pourrait aussi obtenir $3$ !'' ;

    draw circle id 595 start 179.5s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.15) radius 6.5 at (109, 62) ;
    draw circle id 596 start 179.5s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.15) radius 6.5 at (109, 76) ;
    draw circle id 597 start 179.5s color (248, 113, 113, 0.8) width 1.8 fillcolor (248, 113, 113, 0.15) radius 8.0 at (153, 69) ;
    text id 103 start 179.5s at (106.0, 60.5) ''[bold][color=#38BDF8]$6$[/color][/bold]'' ;
    text id 104 start 179.5s at (104.0, 74.5) ''[bold][color=#38BDF8]$122$[/color][/bold]'' ;
    text id 105 start 179.5s at (150.0, 67.5) ''[bold][color=#F87171]$3$[/color][/bold]'' ;

    draw arrow id 598 start 180.0s for 0.6s color (248, 113, 113, 1) width 2.2 at [(116, 63), (144, 67)] ;
    draw arrow id 599 start 181.2s for 0.6s color (248, 113, 113, 1) width 2.2 at [(116, 75), (144, 71)] ;
    text id 106 start 182.5s for 2.5s at (98.0, 84.0) ''[color=#F87171]Plusieurs entrées pour une même sortie ![/color]'' ;

    erase id 2004 start 188.8s ;

    # =========================================================================
    # SCÈNE 5 (189.0s - 223.2s) : Formulation : 'Quel Nombre a pour Image 5 ?'
    # =========================================================================

    text id 121 start 189.2s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Formulation d'Examen : 'Quel Nombre a pour Image 5 ?'[/color][/bold]'' ;
    draw line id 621 start 191.0s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    text id 122 start 191.8s for 2.0s at (5.0, 21.0) ''[color=#FBBF24]Question 3 :[/color] Quel nombre a pour image $5$ ?'' ;

    # Tableau avec cible colonne x = 2
    draw polygone id 622 start 194.0s color (248, 250, 252, 0.8) width 1.5 at [(5, 27), (82, 27), (82, 51), (5, 51)] ;
    draw line id 623 start 194.0s color (248, 250, 252, 0.6) width 1.2 at [(5, 39), (82, 39)] ;
    draw line id 624 start 194.0s color (248, 250, 252, 0.6) width 1.2 at [(20, 27), (20, 51)] ;
    draw line id 625 start 194.0s color (248, 250, 252, 0.4) width 1.0 at [(35.5, 27), (35.5, 51)] ;
    draw line id 626 start 194.0s color (248, 250, 252, 0.4) width 1.0 at [(51.0, 27), (51.0, 51)] ;
    draw line id 627 start 194.0s color (248, 250, 252, 0.4) width 1.0 at [(66.5, 27), (66.5, 51)] ;

    text id 123 start 194.0s at (8.0, 32.5) ''[bold][color=#38BDF8]$x$[/color][/bold]'' ;
    text id 124 start 194.0s at (6.5, 44.5) ''[bold][color=#34D399]$f(x)$[/color][/bold]'' ;
    text id 125 start 194.0s at (26.0, 32.5) ''[bold][color=#34D399]$2$[/color][/bold]'' ;
    text id 126 start 194.0s at (26.0, 44.5) ''[bold][color=#FBBF24]$5$[/color][/bold]'' ;
    text id 127 start 194.0s at (41.5, 32.5) ''$3$'' ;
    text id 128 start 194.0s at (41.5, 44.5) ''$0$'' ;
    text id 129 start 194.0s at (57.0, 32.5) ''$5$'' ;
    text id 130 start 194.0s at (57.0, 44.5) ''$-2$'' ;
    text id 131 start 194.0s at (72.5, 32.5) ''$6$'' ;
    text id 132 start 194.0s at (72.5, 44.5) ''$3$'' ;

    text id 133 start 198.0s for 1.5s at (5.0, 58.0) ''[bold][color=#F87171]Attention à la formulation :[/color][/bold]'' ;
    text id 134 start 199.8s for 2.5s at (5.0, 66.0) ''« Ce nombre a pour image 5 » $\iff 5$ est le RÉSULTAT d'arrivée !'' ;
    text id 135 start 203.2s for 2.5s at (5.0, 75.0) ''On cherche donc le nombre de départ : un antécédent de $5$.'' ;

    # Droite : Démarche
    draw polygone id 628 start 206.0s for 0.6s color (251, 191, 36, 0.9) width 1.5 fillcolor (251, 191, 36, 0.15) at [(102, 28), (166, 28), (166, 41), (102, 41)] ;
    text id 136 start 207.0s for 1.4s at (105.0, 34.0) ''[color=#FBBF24]1. Repérer $5$ sur la 2ème ligne ($f(x) = 5$)[/color]'' ;

    # Sur le tableau, highlight colonne 1
    draw polygone id 629 start 209.0s for 0.6s color (251, 191, 36, 0.9) width 2.0 fillcolor (251, 191, 36, 0.2) at [(20.0, 27), (35.5, 27), (35.5, 51), (20.0, 51)] ;

    draw arrow id 630 start 210.2s for 0.6s color (52, 211, 153, 1) width 2.0 at [(133, 42), (133, 50)] ;
    draw polygone id 631 start 211.5s for 0.6s color (52, 211, 153, 0.9) width 1.5 fillcolor (52, 211, 153, 0.15) at [(102, 51), (166, 51), (166, 64), (102, 64)] ;

    # Flèche montante sur tableau
    draw arrow id 632 start 212.5s for 0.7s color (52, 211, 153, 1) width 2.5 at [(27.75, 43), (27.75, 36)] ;
    text id 137 start 213.8s for 1.5s at (105.0, 57.0) ''[color=#34D399]2. Remonter vers la 1ère ligne : $x = 2$[/color]'' ;

    # Carte de réponse en bas à droite
    draw polygone id 633 start 216.5s for 0.7s color (52, 211, 153, 0.9) width 2.0 fillcolor (52, 211, 153, 0.15) at [(98, 71), (168, 71), (168, 88), (98, 88)] ;
    text id 138 start 217.8s for 1.2s at (101.0, 75.0) ''[bold][color=#34D399]Réponse rédigée :[/color][/bold]'' ;
    text id 139 start 219.5s for 2.2s at (101.0, 83.0) ''Le nombre [bold][color=#34D399]$2$[/color][/bold] a pour image $5$ (ou $f(2) = 5$).'' ;

    erase id 2005 start 223.2s ;

    # =========================================================================
    # SCÈNE 6 (223.5s - 292.0s) : Maîtriser les Notations Formelles
    # =========================================================================

    text id 151 start 223.6s for 1.4s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Maîtriser les Notations : $f(\dots) = 0$ et $f : 5 \mapsto \dots$[/color][/bold]'' ;
    draw line id 651 start 225.5s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    # Séparateur vertical central
    draw line id 652 start 226.0s color (248, 250, 252, 0.3) width 1.0 at [(90, 16), (90, 89)] ;

    # Cas A à gauche
    text id 152 start 226.5s for 1.8s at (5.0, 21.0) ''[bold][color=#FBBF24]Cas A : Résoudre $f(\dots) = 0$[/color][/bold]'' ;
    text id 153 start 231.8s for 1.4s at (5.0, 29.0) ''Écriture : [bold][color=#38BDF8]$f(?) = 0$[/color][/bold]'' ;
    text id 154 start 234.0s for 2.2s at (5.0, 36.5) ''• Dans la parenthèse : antécédent $x$ cherché'' ;
    text id 155 start 241.0s for 2.2s at (5.0, 44.5) ''• Après le signe $=$ : image $f(x) = 0$ (donnée)'' ;
    text id 156 start 246.0s for 2.0s at (5.0, 52.5) ''$\implies$ On cherche un antécédent de $0$.'' ;

    # Mini tableau à gauche
    draw polygone id 653 start 250.0s color (248, 250, 252, 0.8) width 1.2 at [(5, 60), (82, 60), (82, 78), (5, 78)] ;
    draw line id 654 start 250.0s color (248, 250, 252, 0.6) width 1.0 at [(5, 69), (82, 69)] ;
    draw line id 655 start 250.0s color (248, 250, 252, 0.6) width 1.0 at [(20, 60), (20, 78)] ;
    draw line id 656 start 250.0s color (248, 250, 252, 0.4) width 0.8 at [(35.5, 60), (35.5, 78)] ;
    draw line id 657 start 250.0s color (248, 250, 252, 0.4) width 0.8 at [(51.0, 60), (51.0, 78)] ;
    draw line id 658 start 250.0s color (248, 250, 252, 0.4) width 0.8 at [(66.5, 60), (66.5, 78)] ;

    text id 157 start 250.0s at (8.0, 64.5) ''$x$'' ;
    text id 158 start 250.0s at (6.5, 73.0) ''$f(x)$'' ;
    text id 159 start 250.0s at (26.0, 64.5) ''$2$'' ;
    text id 160 start 250.0s at (26.0, 73.0) ''$5$'' ;
    text id 161 start 250.0s at (41.5, 64.5) ''[bold][color=#34D399]$3$[/color][/bold]'' ;
    text id 162 start 250.0s at (41.5, 73.0) ''[bold][color=#FBBF24]$0$[/color][/bold]'' ;
    text id 163 start 250.0s at (57.0, 64.5) ''$5$'' ;
    text id 164 start 250.0s at (57.0, 73.0) ''$-2$'' ;
    text id 165 start 250.0s at (72.5, 64.5) ''$6$'' ;
    text id 166 start 250.0s at (72.5, 73.0) ''$3$'' ;

    draw arrow id 659 start 252.0s for 0.7s color (251, 191, 36, 1) width 2.2 at [(43.25, 72), (43.25, 66)] ;
    text id 167 start 258.0s for 2.0s at (5.0, 83.0) ''[bold][color=#34D399]Conclusion :[/color][/bold] On écrit [bold][color=#34D399]$f(3) = 0$[/color][/bold] (ou antécédent $3$).'' ;

    # Cas B à droite
    text id 168 start 263.5s for 2.0s at (96.0, 21.0) ''[bold][color=#C084FC]Cas B : Flèche d'association $f : 5 \mapsto \dots$[/color][/bold]'' ;
    text id 169 start 266.0s for 1.5s at (96.0, 29.0) ''Écriture : [bold][color=#C084FC]$f : 5 \mapsto ?$[/color][/bold]'' ;
    text id 170 start 269.0s for 2.2s at (96.0, 36.5) ''• Le nombre $5$ est l'entrée (nombre de départ)'' ;
    text id 171 start 277.0s for 2.2s at (96.0, 44.5) ''• La flèche $\mapsto$ indique : associer son image !'' ;
    text id 172 start 281.0s for 2.0s at (96.0, 52.5) ''$\implies$ Quelle est l'image de $5$ par $f$ ?'' ;

    # Mini tableau à droite
    draw polygone id 660 start 283.5s color (248, 250, 252, 0.8) width 1.2 at [(96, 60), (168, 60), (168, 78), (96, 78)] ;
    draw line id 661 start 283.5s color (248, 250, 252, 0.6) width 1.0 at [(96, 69), (168, 69)] ;
    draw line id 662 start 283.5s color (248, 250, 252, 0.6) width 1.0 at [(109, 60), (109, 78)] ;
    draw line id 663 start 283.5s color (248, 250, 252, 0.4) width 0.8 at [(123, 60), (123, 78)] ;
    draw line id 664 start 283.5s color (248, 250, 252, 0.4) width 0.8 at [(137, 60), (137, 78)] ;
    draw line id 665 start 283.5s color (248, 250, 252, 0.4) width 0.8 at [(151, 60), (151, 78)] ;

    text id 173 start 283.5s at (99.0, 64.5) ''$x$'' ;
    text id 174 start 283.5s at (97.5, 73.0) ''$f(x)$'' ;
    text id 175 start 283.5s at (115.0, 64.5) ''$2$'' ;
    text id 176 start 283.5s at (115.0, 73.0) ''$5$'' ;
    text id 177 start 283.5s at (129.0, 64.5) ''$3$'' ;
    text id 178 start 283.5s at (129.0, 73.0) ''$0$'' ;
    text id 179 start 283.5s at (143.0, 64.5) ''[bold][color=#38BDF8]$5$[/color][/bold]'' ;
    text id 180 start 283.5s at (143.0, 73.0) ''[bold][color=#34D399]$-2$[/color][/bold]'' ;
    text id 181 start 283.5s at (157.0, 64.5) ''$6$'' ;
    text id 182 start 283.5s at (157.0, 73.0) ''$3$'' ;

    draw arrow id 666 start 284.5s for 0.7s color (52, 211, 153, 1) width 2.2 at [(144.0, 66), (144.0, 72)] ;
    text id 183 start 287.5s for 2.5s at (96.0, 83.0) ''[bold][color=#34D399]Conclusion :[/color][/bold] [bold][color=#34D399]$f : 5 \mapsto -2$[/color][/bold] (ou $f(5) = -2$).'' ;

    erase id 2006 start 292.0s ;

    # =========================================================================
    # SCÈNE 7 (292.2s - 305.8s) : Synthèse & Réflexes Bac
    # =========================================================================

    text id 184 start 292.3s for 1.4s at (4.0, 7.5) ''[bold][color=#FBBF24]7. Synthèse : Réflexes Fondamentaux d'Examen[/color][/bold]'' ;
    draw line id 681 start 294.0s for 0.5s color (248, 250, 252, 0.4) width 1.2 at [(4, 13.5), (173, 13.5)] ;

    # Schéma de lecture à gauche
    text id 185 start 294.5s for 1.8s at (5.0, 21.0) ''[bold][color=#38BDF8]Sens de Lecture dans un Tableau de Valeurs[/color][/bold]'' ;

    draw polygone id 682 start 296.5s color (248, 250, 252, 0.8) width 1.5 at [(5, 27), (85, 27), (85, 61), (5, 61)] ;
    draw line id 683 start 296.5s color (248, 250, 252, 0.6) width 1.2 at [(5, 44), (85, 44)] ;
    text id 186 start 296.5s at (8.0, 34.0) ''[bold][color=#38BDF8]1ère ligne : Antécédents $x$[/color][/bold] (départ)'' ;
    text id 187 start 296.5s at (8.0, 52.0) ''[bold][color=#34D399]2ème ligne : Images $f(x)$[/color][/bold] (arrivée)'' ;

    # Cartes réflexes à droite
    text id 190 start 295.5s for 1.2s at (96.0, 21.0) ''[bold][color=#34D399]Les 3 Réflexes Incontournables[/color][/bold]'' ;

    draw polygone id 686 start 297.0s for 0.6s color (56, 189, 248, 0.8) width 1.5 fillcolor (56, 189, 248, 0.15) at [(96, 28), (172, 28), (172, 47), (96, 47)] ;
    text id 191 start 297.8s for 1.2s at (99.0, 33.0) ''[bold][color=#38BDF8]1. Unicité de l'image :[/color][/bold]'' ;
    text id 192 start 298.5s at (99.0, 40.0) ''Chaque $x$ a au maximum [bold][color=#F8FAFC]une seule image[/color][/bold].'' ;

    draw polygone id 687 start 299.2s for 0.6s color (248, 113, 113, 0.8) width 1.5 fillcolor (248, 113, 113, 0.15) at [(96, 49), (172, 49), (172, 68), (96, 68)] ;
    text id 193 start 300.0s for 1.2s at (99.0, 54.0) ''[bold][color=#F87171]2. Pluralité des antécédents :[/color][/bold]'' ;
    text id 194 start 300.5s at (99.0, 61.0) ''Une image peut avoir [bold][color=#F8FAFC]plusieurs antécédents[/color][/bold].'' ;

    draw arrow id 684 start 301.4s for 0.6s color (251, 191, 36, 1) width 2.5 at [(75, 34), (75, 54)] ;
    draw polygone id 688 start 302.2s for 0.6s color (251, 191, 36, 0.8) width 1.5 fillcolor (251, 191, 36, 0.15) at [(96, 70), (172, 70), (172, 89), (96, 89)] ;
    text id 188 start 303.0s for 1.2s at (5.0, 68.0) ''[bold][color=#FBBF24]Calculer une IMAGE :[/color][/bold] lecture [bold][color=#FBBF24]de HAUT en BAS $\downarrow$[/color][/bold]'' ;

    draw arrow id 685 start 304.4s for 0.6s color (248, 113, 113, 1) width 2.5 at [(80, 54), (80, 34)] ;
    text id 189 start 305.1s at (5.0, 78.0) ''[bold][color=#F87171]Trouver un ANTÉCÉDENT :[/color][/bold] lecture [bold][color=#F87171]de BAS en HAUT $\uparrow$[/color][/bold]'' ;
    text id 195 start 305.1s at (99.0, 75.0) ''[bold][color=#FBBF24]3. Équivalence fondamentale :[/color][/bold]'' ;
    text id 196 start 305.1s at (99.0, 82.0) ''$f(a) = b \iff b$ est l'image et $a$ est l'antécédent.'' ;
}
