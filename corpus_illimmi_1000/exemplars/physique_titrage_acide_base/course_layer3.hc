course "Titrage pH-métrique & Méthode des Tangentes" id 4 idgap 100 for 125s audio "physique_titrage_acide_base.wav" {

    # ========================================================
    # SCÈNE 1 : Dispositif expérimental (0s - 25s)
    # ========================================================
    text id 1 start 0.5s for 23s at (88.89, 12)
         ''[bold][color=#1E3A8A]Chimie : Titrage Acido-Basique pH-métrique[/color][/bold]'' ;

    # Dessin schématique de la burette et du bécher
    draw polygone id 101 start 5.0s for 1.5s
         color (100, 116, 139, 1) fillcolor (241, 245, 249, 1) width 2
         at [(85, 25), (93, 25), (93, 50), (85, 50)] ;

    text id 2 start 6.5s at (120, 37)
         ''Burette : Solution titrante ($c_B$ connue)'' ;

    draw polygone id 102 start 10.0s for 1.2s
         color (59, 130, 246, 0.8) fillcolor (219, 234, 254, 0.8) width 2
         at [(80, 58), (98, 58), (95, 75), (83, 75)] ;

    text id 3 start 11.5s at (120, 66)
         ''Bécher : Solution titrée ($c_A$ inconnue, $V_A$)'' ;

    # ========================================================
    # SCÈNE 2 : Définition de l'équivalence (25s - 50s)
    # ========================================================
    erase id 401 start 25.0s ;

    text id 4 start 25.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Définition de l'Équivalence Stœchiométrique[/color][/bold]'' ;

    draw polygone id 103 start 28.0s for 1.0s
         color (16, 185, 129, 0.6) fillcolor (236, 253, 245, 0.9) width 2
         at [(25, 25), (152.78, 25), (152.78, 65), (25, 65)] ;

    text id 5 start 30.0s at (88.89, 36)
         ''[bold][color=#047857]$$n_A(\text{initial}) = n_B(\text{versé à l'équivalence})$$[/color][/bold]'' ;

    text id 6 start 38.0s at (88.89, 50)
         ''[bold][color=#1D4ED8]$$c_A \times V_A = c_B \times V_E \quad \Longrightarrow \quad c_A = \frac{c_B \times V_E}{V_A}$$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : Courbe de titrage et Méthode des Tangentes (50s - 100s)
    # ========================================================
    erase id 402 start 50.0s ;

    # Repère pH = f(V)
    draw 2drep id 104 start 50.5s
         color (100, 116, 139, 1) width 2
         at (25, 88) ;

    text id 7 start 51.5s at (25, 12) ''pH'' ;
    text id 8 start 52.0s at (165, 92) ''$V_B$ (mL)'' ;

    # Courbe en S avec saut de pH
    draw curve id 105 start 54.0s for 2.5s
         color (37, 99, 235, 1) width 3
         at [(28, 80), (60, 75), (80, 68), (92, 50), (96, 28), (115, 22), (155, 20)] ;

    # Tangente 1 avant le saut
    draw line id 106 start 68.0s for 1.5s
         color (16, 185, 129, 1) width 2
         at [(45, 85), (95, 60)] ;

    text id 9 start 69.5s at (102, 60) ''$T_1$'' ;

    # Tangente 2 parallèle après le saut
    draw line id 107 start 74.0s for 1.5s
         color (16, 185, 129, 1) width 2
         at [(75, 38), (125, 13)] ;

    text id 10 start 75.5s at (132, 13) ''$T_2 // T_1$'' ;

    # Droite médiane équidistante
    draw line id 108 start 82.0s for 1.8s
         color (220, 38, 38, 1) width 2
         at [(60, 61), (110, 36)] ;

    # Point d'équivalence E
    draw circle id 109 start 88.0s for 0.8s
         color (220, 38, 38, 1) fillcolor (220, 38, 38, 1) width 2
         at (94, 44) with radius 2 ;

    text id 11 start 89.0s at (98, 42)
         ''[bold][color=#DC2626]Point Équivalent E ($V_E$, $\text{pH}_E$)[/color][/bold]'' ;

    # Projection vers VE
    draw line id 110 start 93.0s for 1.0s
         color (100, 116, 139, 0.8) width 2
         at [(94, 44), (94, 88)] ;

    text id 12 start 94.5s at (94, 93) ''[bold][color=#DC2626]$V_E$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 4 : Fiche synthèse & Calcul de concentration (100s - 125s)
    # ========================================================
    erase id 403 start 100.0s ;

    text id 13 start 100.5s at (88.89, 15)
         ''[bold][color=#1E3A8A]Formule Finale & Rigueur d'Examen[/color][/bold]'' ;

    draw polygone id 111 start 103.0s for 1.0s
         color (37, 99, 235, 0.5) fillcolor (239, 246, 255, 0.9) width 2
         at [(25, 30), (152.78, 30), (152.78, 70), (25, 70)] ;

    text id 14 start 105.0s at (88.89, 45)
         ''[bold][color=#1E3A8A]$$c_A = \frac{c_B \times V_E}{V_A}$$[/color][/bold]'' ;

    text id 15 start 112.0s at (88.89, 58)
         ''[italic]$V_A$ = volume prélevé au bécher $\quad$ | $\quad$ $V_E$ = volume équivalent lu à la burette[/italic]'' ;
}
