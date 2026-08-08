course "Introduction à la Géométrie" id 500 idgap 100 for 45s {

    # ═══════════════════════════════════════
    # SEGMENT 1 : BIENVENUE
    # ═══════════════════════════════════════

    text id 1 start 1s for 4s at (88.89, 10)
         ''[bold][color=#2980B9]Géométrie : Le Cercle[/color][/bold]'' ;

    draw circle id 101 start 2s for 2s
         color (41, 128, 185, 1)
         width 3
         radius 15
         at (88.89, 50) ;

    # ═══════════════════════════════════════
    # SEGMENT 2 : PROPRIÉTÉS
    # ═══════════════════════════════════════

    # Centre
    draw circle id 102 start 6.5s
         color (231, 76, 60, 1)
         fillcolor (231, 76, 60, 1)
         radius 1.5
         at (88.89, 50) ;

    # Rayon
    draw line id 103 start 7s for 1.5s
         color (46, 204, 113, 1)
         width 2.5
         at [(88.89, 50), (103.89, 50)] ;

    text id 2 start 7.5s at (96, 47) ''[color=#2ECC71]$r$[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 3 : FORMULE MATHÉMATIQUE
    # ═══════════════════════════════════════

    text id 3 start 11s for 5s at (88.89, 75)
         ''$$\mathcal{A} = \pi r^2$$'' ;

    # Curseur qui souligne la formule
    mouse move id 301 start 11.5s for 2s
          at [(75, 80), (105, 80)] ;

    # ═══════════════════════════════════════
    # SEGMENT 4 : CONCLUSION
    # ═══════════════════════════════════════

    text id 4 start 19s for 4s at (88.89, 90)
         ''[italic]Fin de la démonstration[/italic]'' ;

    draw polygone id 104 start 18.5s for 2s
         color (155, 89, 182, 1)
         width 2
         at [(20, 20), (157.78, 20), (157.78, 80), (20, 80)] ;
}
