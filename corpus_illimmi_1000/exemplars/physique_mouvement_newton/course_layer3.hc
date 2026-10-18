course "Deuxième Loi de Newton & Trajectoire Parabolique" id 3 idgap 100 for 130s audio "physique_mouvement_newton.wav" {

    # ========================================================
    # SCÈNE 1 : Titre et situation physique (0s - 22s)
    # ========================================================
    text id 1 start 0.5s for 20s at (88.89, 12)
         ''[bold][color=#1E3A8A]Mécanique : 2ème Loi de Newton[/color][/bold]'' ;

    text id 2 start 4.0s for 17s at (88.89, 25)
         ''[italic]Mouvement d'un projectile dans un champ de pesanteur uniforme[/italic]'' ;

    draw 2drep id 101 start 7.0s for 1.5s
         color (100, 116, 139, 1) width 2
         at (20, 85) ;

    # Vecteur vitesse initiale v0
    draw arrow id 102 start 12.0s for 1.2s
         color (16, 185, 129, 1) width 3
         at [(20, 85), (45, 60)] ;

    text id 3 start 13.0s at (48, 58)
         ''[bold][color=#10B981]$$\vec{v}_0$$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 2 : Bilan méthodique des forces (22s - 45s)
    # ========================================================
    erase id 401 start 22.0s ;

    text id 4 start 22.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Méthode Officielle du Baccalauréat[/color][/bold]'' ;

    text id 5 start 24.0s at (45, 25)
         ''1) Système : { projectile de masse $m$ }'' ;

    text id 6 start 28.0s at (45, 36)
         ''2) Référentiel : Terrestre supposé galiléen'' ;

    text id 7 start 33.0s at (45, 47)
         ''3) Bilan des forces : Poids $\vec{P}$ uniquement (frottements négligés)'' ;

    # Schéma de la balle et du vecteur Poids
    draw circle id 103 start 38.0s for 0.8s
         color (30, 41, 59, 1) fillcolor (203, 213, 225, 1) width 2
         at (120, 50) with radius 4 ;

    draw arrow id 104 start 40.0s for 1.2s
         color (220, 38, 38, 1) width 3
         at [(120, 50), (120, 75)] ;

    text id 8 start 41.0s at (126, 65)
         ''[bold][color=#DC2626]$$\vec{P} = m \vec{g}$$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : 2ème Loi de Newton et indépendance de la masse (45s - 78s)
    # ========================================================
    erase id 402 start 45.0s ;

    text id 9 start 45.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Application du Principe Fondamental[/color][/bold]'' ;

    text id 10 start 48.0s at (88.89, 28)
         ''$$\sum \vec{F}_{\text{ext}} = m \vec{a}_G$$'' ;

    text id 11 start 52.0s at (88.89, 42)
         ''$$\vec{P} = m \vec{a}_G \quad \Longleftrightarrow \quad m \vec{g} = m \vec{a}_G$$'' ;

    draw polygone id 105 start 60.0s for 1.0s
         color (16, 185, 129, 0.6) fillcolor (236, 253, 245, 0.9) width 2
         at [(25, 55), (152.78, 55), (152.78, 85), (25, 85)] ;

    text id 12 start 62.0s at (88.89, 65)
         ''[bold][color=#10B981]$$\vec{a}_G = \vec{g}$$[/color][/bold]'' ;

    text id 13 start 68.0s at (88.89, 76)
         ''[italic]L'accélération en chute libre est strictement indépendante de la masse ![/italic]'' ;

    # ========================================================
    # SCÈNE 4 : Trajectoire parabolique & Synthèse (78s - 130s)
    # ========================================================
    erase id 403 start 78.0s ;

    text id 14 start 78.5s at (88.89, 10)
         ''[bold][color=#1E3A8A]Équations Horaires & Trajectoire[/color][/bold]'' ;

    text id 15 start 82.0s at (50, 24)
         ''$$\text{Accélération : } \begin{cases} a_x = 0 \\ a_y = -g \end{cases} \quad \Longrightarrow \quad \text{Vitesse : } \begin{cases} v_x = v_0 \cos(\alpha) \\ v_y = -gt + v_0 \sin(\alpha) \end{cases}$$'' ;

    text id 16 start 94.0s at (88.89, 42)
         ''[bold][color=#2563EB]$$y(x) = -\frac{g}{2 v_0^2 \cos^2(\alpha)} x^2 + \tan(\alpha) x$$[/color][/bold]'' ;

    # Tracé de la parabole finale
    draw 2drep id 106 start 98.0s
         color (100, 116, 139, 1) width 2
         at (20, 92) ;

    draw curve id 107 start 100.0s for 2.5s
         color (37, 99, 235, 1) width 3
         at [(20, 92), (50, 68), (85, 56), (120, 68), (150, 92)] ;

    text id 17 start 112.0s at (88.89, 94)
         ''[bold][color=#1E3A8A]Méthode en 4 étapes validée : Système $\rightarrow$ Référentiel $\rightarrow$ Bilan $\rightarrow$ 2ème Loi[/color][/bold]'' ;
}
