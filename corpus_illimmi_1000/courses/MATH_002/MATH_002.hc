course "Méthode pas à pas : Comment résoudre un problème de Intervalles et encadrements de réels" id 2 idgap 100 for 97.3s audio "narration.wav" {

    # ========================================================
    # SCÈNE 1 : 1. Accroche & Problématique Concrète (0.0s - 32.4s)
    # ========================================================
    text id 1 start 0.3s for 31.9s at (6.0, 8.5)
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
    # SCÈNE 2 : 2. Définition Formelle & Propriété Clé (32.4s - 64.9s)
    # ========================================================
    erase id 401 start 32.4s ;

    text id 6 start 32.7s for 32.0s at (6.0, 8.5)
         ''[bold][color=#38BDF8]2. Définition Formelle & Propriété Clé[/color][/bold]'' ;
    draw line id 111 start 32.9s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 7 start 33.2s at (4, 28) ''[bold][color=#34D399]Étape 2 : Deux Couleurs Distinctes[/color][/bold]'' ;
    text id 8 start 34.9s at (4, 42) ''Colorer I en [bold][color=#60A5FA]Bleu[/color][/bold] au-dessus de l'axe.'' ;
    text id 9 start 36.9s at (4, 58) ''Colorer J en [bold][color=#F87171]Rouge[/color][/bold] en-dessous de l'axe.'' ;
    text id 10 start 39.4s at (4, 74) ''Visualisation immédiate sans risque de confusion !'' ;
    draw arrow id 112 start 33.9s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 113 start 35.2s for 1.0s color (56, 189, 248, 1) width 4.0 at [(110, 48), (158, 48)] ;
    text id 11 start 35.9s at (107.0, 42) ''[bold][color=#60A5FA][-1[/color][/bold]'' ;
    text id 12 start 36.2s at (158.0, 42) ''[bold][color=#60A5FA]3][/color][/bold]'' ;
    draw line id 114 start 37.4s for 1.0s color (248, 113, 113, 1) width 4.0 at [(122, 64), (166, 64)] ;
    text id 13 start 38.0s at (119.0, 70) ''[bold][color=#F87171][0[/color][/bold]'' ;
    text id 14 start 38.4s at (166.0, 70) ''[bold][color=#F87171]4][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : 3. Décomposition du Raisonnement Pas à Pas (64.9s - 97.3s)
    # ========================================================
    erase id 402 start 64.9s ;

    text id 11 start 65.2s for 31.9s at (6.0, 8.5)
         ''[bold][color=#38BDF8]3. Décomposition du Raisonnement Pas à Pas[/color][/bold]'' ;
    draw line id 119 start 65.4s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 12 start 65.7s at (4, 28) ''[bold][color=#34D399]Étape 3 : Intersection des Deux Intervalles[/color][/bold]'' ;
    text id 13 start 67.4s at (4, 42) ''Repérer la zone de [bold]double coloration[/bold].'' ;
    text id 14 start 69.4s at (4, 58) ''Zone commune entre 0 et 3 :'' ;
    text id 15 start 71.9s at (4, 74) ''$$I \cap J = [0 ; 3]$$ (0 et 3 sont dans les deux)'' ;
    draw arrow id 120 start 66.4s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 121 start 67.4s for 0.5s color (37, 99, 235, 0.4) width 3.0 at [(110, 48), (158, 48)] ;
    draw line id 122 start 67.9s for 0.5s color (220, 38, 38, 0.4) width 3.0 at [(122, 64), (166, 64)] ;
    draw polygone id 123 start 68.9s for 0.8s color (5, 150, 105, 0.8) fillcolor (52, 211, 153, 0.20) width 1.5 at [(122, 44), (158, 44), (158, 68), (122, 68)] ;
    draw line id 124 start 69.9s for 0.8s color (5, 150, 105, 1) width 5.0 at [(122, 56), (158, 56)] ;
    text id 16 start 70.9s at (126.0, 34) ''$$I \cap J = [0 ; 3]$$'' ;

}