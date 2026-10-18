course "Méthode pas à pas : Comment résoudre un problème de Intervalles et encadrements de réels" id 002 idgap 100 for 113s audio "MATH_002.wav" {

    # ========================================================
    # SCÈNE 1 : 1. Accroche & Problématique Concrète (0.0s - 22.6s)
    # ========================================================
    text id 1 start 0.3s for 22.1s at (6.0, 8.5)
         ''[bold][color=#38BDF8]1. Accroche & Problématique Concrète[/color][/bold]'' ;
    draw line id 101 start 0.5s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 2 start 0.8s at (4, 28) ''[bold][color=#38BDF8]Méthode : Graduer l'Axe des Réels[/color][/bold]'' ;
    text id 3 start 2.5s at (4, 42) ''Soient les intervalles à étudier :'' ;
    text id 4 start 4.0s at (4, 56) ''[bold][color=#60A5FA]I = [-1 ; 3][/color][/bold] et [bold][color=#F87171]J = [0 ; 4][/color][/bold]'' ;
    text id 5 start 6.5s at (4, 74) ''Étape 1 : Placer une échelle régulière sur l'axe.'' ;
    draw arrow id 102 start 1.5s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 103 start 2.5s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(110, 53), (110, 59)] ;
    text id 6 start 2.7s at (108.0, 62) ''-1'' ;
    draw line id 104 start 3.0s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(122, 53), (122, 59)] ;
    text id 7 start 3.2s at (120.5, 62) ''0'' ;
    draw line id 105 start 3.5s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(158, 53), (158, 59)] ;
    text id 8 start 3.7s at (156.5, 62) ''3'' ;
    draw line id 106 start 4.0s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(166, 53), (166, 59)] ;
    text id 9 start 4.2s at (164.5, 62) ''4'' ;

    # ========================================================
    # SCÈNE 2 : 2. Définition Formelle & Propriété Clé (22.6s - 45.2s)
    # ========================================================
    erase id 401 start 22.6s ;

    text id 6 start 22.9s for 22.1s at (6.0, 8.5)
         ''[bold][color=#38BDF8]2. Définition Formelle & Propriété Clé[/color][/bold]'' ;
    draw line id 111 start 23.1s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 7 start 23.4s at (4, 28) ''[bold][color=#34D399]Étape 2 : Deux Couleurs Distinctes[/color][/bold]'' ;
    text id 8 start 25.1s at (4, 42) ''Colorer I en [bold][color=#60A5FA]Bleu[/color][/bold] au-dessus de l'axe.'' ;
    text id 9 start 27.1s at (4, 58) ''Colorer J en [bold][color=#F87171]Rouge[/color][/bold] en-dessous de l'axe.'' ;
    text id 10 start 29.6s at (4, 74) ''Visualisation immédiate sans risque de confusion !'' ;
    draw arrow id 112 start 24.1s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 113 start 25.4s for 1.0s color (56, 189, 248, 1) width 4.0 at [(110, 48), (158, 48)] ;
    text id 11 start 26.1s at (107.0, 42) ''[bold][color=#60A5FA][-1[/color][/bold]'' ;
    text id 12 start 26.4s at (158.0, 42) ''[bold][color=#60A5FA]3][/color][/bold]'' ;
    draw line id 114 start 27.6s for 1.0s color (248, 113, 113, 1) width 4.0 at [(122, 64), (166, 64)] ;
    text id 13 start 28.2s at (119.0, 70) ''[bold][color=#F87171][0[/color][/bold]'' ;
    text id 14 start 28.6s at (166.0, 70) ''[bold][color=#F87171]4][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : 3. Décomposition du Raisonnement Pas à Pas (45.2s - 67.9s)
    # ========================================================
    erase id 402 start 45.2s ;

    text id 11 start 45.5s for 22.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]3. Décomposition du Raisonnement Pas à Pas[/color][/bold]'' ;
    draw line id 119 start 45.7s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 12 start 46.0s at (4, 28) ''[bold][color=#34D399]Étape 3 : Intersection des Deux Intervalles[/color][/bold]'' ;
    text id 13 start 47.7s at (4, 42) ''Repérer la zone de [bold]double coloration[/bold].'' ;
    text id 14 start 49.7s at (4, 58) ''Zone commune entre 0 et 3 :'' ;
    text id 15 start 52.2s at (4, 74) ''$$I \cap J = [0 ; 3]$$ (0 et 3 sont dans les deux)'' ;
    draw arrow id 120 start 46.7s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 121 start 47.7s for 0.5s color (37, 99, 235, 0.4) width 3.0 at [(110, 48), (158, 48)] ;
    draw line id 122 start 48.2s for 0.5s color (220, 38, 38, 0.4) width 3.0 at [(122, 64), (166, 64)] ;
    draw polygone id 123 start 49.2s for 0.8s color (5, 150, 105, 0.8) fillcolor (52, 211, 153, 0.20) width 1.5 at [(122, 44), (158, 44), (158, 68), (122, 68)] ;
    draw line id 124 start 50.2s for 0.8s color (5, 150, 105, 1) width 5.0 at [(122, 56), (158, 56)] ;
    text id 16 start 51.2s at (126.0, 34) ''$$I \cap J = [0 ; 3]$$'' ;

    # ========================================================
    # SCÈNE 4 : 4. Exemple d'Application Concrète Type Bac (67.9s - 90.5s)
    # ========================================================
    erase id 403 start 67.9s ;

    text id 16 start 68.2s for 22.1s at (6.0, 8.5)
         ''[bold][color=#38BDF8]4. Exemple d'Application Concrète Type Bac[/color][/bold]'' ;
    draw line id 126 start 68.4s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 17 start 68.7s at (4, 28) ''[bold][color=#C084FC]Étape 4 : Réunion des Deux Intervalles[/color][/bold]'' ;
    text id 18 start 70.4s at (4, 42) ''Prendre toute la zone ayant [bold]au moins une couleur[/bold].'' ;
    text id 19 start 72.4s at (4, 58) ''Couverture totale de -1 jusqu'à 4 :'' ;
    text id 20 start 74.9s at (4, 74) ''$$I \cup J = [-1 ; 4]$$'' ;
    draw arrow id 127 start 69.4s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 128 start 70.7s for 1.2s color (192, 132, 252, 1) width 5.5 at [(110, 56), (166, 56)] ;
    text id 21 start 71.7s at (107.0, 48) ''[bold][color=#C084FC][-1[/color][/bold]'' ;
    text id 22 start 72.1s at (166.0, 48) ''[bold][color=#C084FC]4][/color][/bold]'' ;
    text id 23 start 73.4s at (122.0, 36) ''$$I \cup J = [-1 ; 4]$$'' ;

    # ========================================================
    # SCÈNE 5 : 5. Erreurs Fréquentes & Réflexe de Synthèse (90.5s - 113.1s)
    # ========================================================
    erase id 404 start 90.5s ;

    text id 21 start 90.8s for 22.1s at (6.0, 8.5)
         ''[bold][color=#38BDF8]5. Erreurs Fréquentes & Réflexe de Synthèse[/color][/bold]'' ;
    draw line id 132 start 91.0s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 22 start 91.3s at (4, 28) ''[bold][color=#38BDF8]Récapitulatif de la Méthode :[/color][/bold]'' ;
    text id 23 start 93.0s at (4, 44) ''1. Tracer la droite graduée'' ;
    text id 24 start 95.0s at (4, 60) ''2. Colorer les deux intervalles (2 niveaux)'' ;
    text id 25 start 97.0s at (4, 76) ''3. Intersection = commune | Réunion = totale'' ;
    draw circle id 133 start 92.3s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;
    text id 26 start 93.5s at (118.0, 48) ''[bold][color=#38BDF8]Méthode Clé[/color][/bold]'' ;
    text id 27 start 95.0s at (118.0, 58) ''2 Couleurs ⟹ Succès'' ;

}