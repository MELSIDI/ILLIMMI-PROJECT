course "Les Barycentres" id 1000 idgap 100 for 390.8s audio "C:\Users\pc elqods\Desktop\ILLIMMI-PROJECT\services\audio_service\speaker\audios\barycentres\barycentres.wav" {
    # ═══════════════════════════════════════
    # SEGMENT 1 : INTRODUCTION
    # ═══════════════════════════════════════

    text id 1 start 1.3s at (88.89, 8)
         ''[bold][color=#2980B9]Les Barycentres[/color][/bold]'' ;

    text id 2 start 1.8s at (88.89, 16)
         ''[italic]Un point d'équilibre pondéré[/italic]'' ;

    erase id 401 start 23.8s at [1, 2] ;

    # ═══════════════════════════════════════
    # SEGMENT 2 : BARYCENTRE DE DEUX POINTS
    # ═══════════════════════════════════════

    text id 3 start 24.5s at (88.89, 8)
         ''[bold][color=#2980B9]Barycentre de deux points[/color][/bold]'' ;

    draw circle id 101 start 35.6s
         color (41, 128, 185, 1) fillcolor (41, 128, 185, 1)
         radius 1.8 at (50, 50) ;

    text id 4 start 35.9s at (46, 43) ''[color=#2980B9]A[/color]'' ;

    draw circle id 102 start 37.5s
         color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
         radius 1.8 at (120, 50) ;

    text id 5 start 37.8s at (124, 43) ''[color=#E74C3C]B[/color]'' ;

    text id 6 start 48.7s at (88.89, 68)
         ''$$a\vec{GA} + b\vec{GB} = \vec{0}$$'' ;

    erase id 402 start 55.8s at [6] ;

    text id 7 start 56.5s at (88.89, 68) ''$$a + b \neq 0$$'' ;

    # ═══════════════════════════════════════
    # SEGMENT 3 : HOMOGÉNÉITÉ
    # ═══════════════════════════════════════

    erase id 403 start 77.7s at [7] ;

    text id 8 start 78.4s at (88.89, 20)
         ''[bold]Propriété d'homogénéité[/bold]'' ;

    text id 9 start 85.7s for 3s at (88.89, 68) ''$$k \neq 0$$'' ;

    # ═══════════════════════════════════════
    # SEGMENT 4 : CAS PARTICULIER (MILIEU / ISOBARYCENTRE)
    # ═══════════════════════════════════════

    erase id 404 start 112.0s at [3, 8, 9] ;

    text id 10 start 112.7s at (88.89, 8)
         ''[bold][color=#2980B9]Cas particulier : $a = b$[/color][/bold]'' ;

    draw circle id 103 start 117.5s
         color (46, 204, 113, 1) fillcolor (46, 204, 113, 1)
         radius 1.8 at (85, 50) ;

    text id 11 start 117.7s at (85, 40) ''[color=#2ECC71]G (milieu)[/color]'' ;

    mouse move id 301 start 118.0s for 2s
          at [(50, 50), (120, 50)] ;

    # ═══════════════════════════════════════
    # SEGMENT 5 : INTERPRÉTATION PHYSIQUE
    # ═══════════════════════════════════════

    erase id 405 start 134.6s at [10, 11, 103, 4, 5, 101, 102] ;

    text id 12 start 135.3s at (88.89, 8)
         ''[bold][color=#2980B9]Interprétation physique : le point d'équilibre[/color][/bold]'' ;

    draw line id 104 start 145.3s
         color (155, 89, 82, 1) width 3
         at [(40, 60), (140, 60)] ;

    draw circle id 105 start 145.3s
         fillcolor (100, 100, 100, 1)
         radius 2 at (88.89, 58) ;

    # ═══════════════════════════════════════
    # SEGMENT 6 : GÉNÉRALISATION À N POINTS ET ASSOCIATIVITÉ
    # ═══════════════════════════════════════

    erase id 406 start 165.2s at [12, 104, 105] ;

    text id 13 start 165.9s at (88.89, 8)
         ''[bold][color=#2980B9]Généralisation à n points[/color][/bold]'' ;

    text id 14 start 191.6s at (88.89, 30)
         ''[bold]Associativité (barycentre partiel)[/bold]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 7 : EXEMPLE DU TRIANGLE
    # ═══════════════════════════════════════

    erase id 407 start 225.2s at [13, 14] ;

    text id 15 start 225.9s at (88.89, 8)
         ''[bold][color=#2980B9]Exemple : le triangle[/color][/bold]'' ;

    draw polygone id 106 start 226.5s
         color (52, 152, 219, 1) width 2.5
         at [(70, 25), (120, 80), (40, 80)] ;

    text id 16 start 227.0s at (68, 19) ''A'' ;
    text id 17 start 227.3s at (122, 83) ''B'' ;
    text id 18 start 227.6s at (34, 83) ''C'' ;

    draw circle id 107 start 241.2s
         color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
         radius 1.5 at (80, 80) ;

    text id 19 start 241.4s at (80, 87) ''[color=#E74C3C]I[/color]'' ;

    draw line id 108 start 241.7s
         color (231, 76, 60, 1) width 2
         at [(70, 25), (80, 80)] ;

    draw circle id 109 start 242.4s
         color (46, 204, 113, 1) fillcolor (46, 204, 113, 1)
         radius 1.8 at (76.7, 63.3) ;

    text id 20 start 242.7s at (70, 60) ''[color=#2ECC71]G[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 8 : COORDONNÉES DU BARYCENTRE
    # ═══════════════════════════════════════

    erase id 408 start 270.4s at [15, 16, 17, 18, 19, 20, 106, 107, 108, 109] ;

    text id 21 start 271.1s at (88.89, 8)
         ''[bold][color=#2980B9]Coordonnées du barycentre[/color][/bold]'' ;

    text id 22 start 287.2s for 5s at (88.89, 45)
         ''$$x_G = \dfrac{a x_A + b x_B}{a+b}$$'' ;

    text id 23 start 294.3s for 5s at (88.89, 62)
         ''$$y_G = \dfrac{a y_A + b y_B}{a+b}$$'' ;

    # ═══════════════════════════════════════
    # SEGMENT 9 : APPLICATIONS
    # ═══════════════════════════════════════

    erase id 409 start 309.1s at [21, 22, 23] ;

    text id 24 start 309.8s at (88.89, 8)
         ''[bold][color=#2980B9]Applications : espace, physique, informatique[/color][/bold]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 10 : RÉSUMÉ ET CONCLUSION
    # ═══════════════════════════════════════

    erase id 410 start 336.6s at [24] ;

    text id 25 start 337.3s at (88.89, 8)
         ''[bold][color=#2980B9]Résumé[/color][/bold]'' ;

    text id 26 start 337.7s at (88.89, 35)
         ''[color=#2C3E50]Existence si $a+b \neq 0$ · Homogène · Milieu si $a=b$ · Centre de gravité pour un triangle[/color]'' ;

    erase id 411 start 387.1s at [25, 26] ;

    text id 27 start 387.8s for 3s at (88.89, 50)
         ''[bold]Merci de votre attention ![/bold]'' ;
}
