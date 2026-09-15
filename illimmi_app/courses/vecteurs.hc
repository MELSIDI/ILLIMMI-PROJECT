course "Construire un point avec des vecteurs" id 1000 idgap 100 for 165.3s audio "C:\Users\pc elqods\Desktop\ILLIMMI-PROJECT\services\audio_service\speaker\audios\vecteurs\vecteurs.wav" {
    # ═══════════════════════════════════════
    # SEGMENT 1 : INTRODUCTION (0.0s - 17.5s)
    # ═══════════════════════════════════════

    text id 1 start 0.5s at (2, 8)
         ''[bold][color=#3498DB]Construire un point défini par des vecteurs[/color][/bold]'' ;

    text id 2 start 1.5s at (2, 15)
         ''[italic]Égalités vectorielles & constructions géométriques[/italic]'' ;

    text id 3 start 8.0s at (2, 23)
         ''[bold]Objectif :[/bold] Construire les points $E$, $F$ et $G$'' ;

    # ═══════════════════════════════════════
    # SEGMENT 2 : FIGURE DE BASE & RAPPEL (16.0s - 51.5s)
    # ═══════════════════════════════════════

    text id 4 start 16.0s at (2, 30)
         ''[color=#BDC3C7]Donnée : ABCD est un parallélogramme[/color]'' ;

    # Tracé du parallélogramme ABCD
    draw polygone id 101 start 16.5s for 2.0s
         color (242, 246, 243, 1) width 2.5
         at [(100, 32), (136, 32), (128, 50), (92, 50)] ;

    # Étiquettes des sommets
    text id 5 start 17.0s at (98, 27) ''[bold][color=#F2F6F3]A[/color][/bold]'' ;
    text id 6 start 17.3s at (138, 27) ''[bold][color=#F2F6F3]B[/color][/bold]'' ;
    text id 7 start 17.6s at (131, 52) ''[bold][color=#F2F6F3]C[/color][/bold]'' ;
    text id 8 start 17.9s at (88, 52) ''[bold][color=#F2F6F3]D[/color][/bold]'' ;

    # Rappel : deux vecteurs égaux
    text id 9 start 22.0s at (2, 38)
         ''[bold]Rappel :[/bold] $\vec{u} = \vec{v} \iff$ même direction, même sens, même norme'' ;

    # Exemples sur la figure
    text id 10 start 40.5s at (2, 46)
         ''[color=#2ECC71]Exemples :[/color] $\vec{AB} = \vec{DC}$ et $\vec{AD} = \vec{BC}$'' ;

    mouse move id 301 start 41.0s for 2.5s
          at [(100, 32), (136, 32)] ;

    mouse move id 302 start 44.0s for 2.5s
          at [(92, 50), (128, 50)] ;

    erase id 401 start 51.0s at [9, 10] ;

    # ═══════════════════════════════════════
    # SEGMENT 3 : QUESTION 1 — POINT E (51.6s - 89.9s)
    # \vec{DE} = \vec{BC}
    # ═══════════════════════════════════════

    text id 11 start 51.6s at (2, 38)
         ''[bold][color=#E67E22]1) Construire E tel que :[/color][/bold] $\vec{DE} = \vec{BC}$'' ;

    # Vecteur BC (en vert)
    draw arrow id 102 start 61.0s for 1.5s
         color (46, 204, 113, 1) width 3
         at [(136, 32), (128, 50)] ;

    text id 12 start 62.0s at (135, 41) ''[color=#2ECC71]$\vec{BC}$[/color]'' ;

    # Origine en D, tracé du vecteur DE
    draw arrow id 103 start 74.5s for 2.0s
         color (46, 204, 113, 1) width 3
         at [(92, 50), (84, 68)] ;

    text id 13 start 76.0s at (91, 59) ''[color=#2ECC71]$\vec{DE}$[/color]'' ;

    # Point E marqué
    draw circle id 104 start 82.5s
         color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
         radius 1.5 at (84, 68) ;

    text id 14 start 82.8s at (79, 71) ''[bold][color=#E74C3C]E[/color][/bold]'' ;

    text id 15 start 87.5s at (2, 46)
         ''[color=#2ECC71]$\checkmark$ Point E déterminé : $\vec{DE} = \vec{BC}$[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 4 : QUESTION 2 — POINT F (90.0s - 120.7s)
    # \vec{CF} = \vec{DC}
    # ═══════════════════════════════════════

    text id 16 start 90.0s at (2, 54)
         ''[bold][color=#E67E22]2) Construire F tel que :[/color][/bold] $\vec{CF} = \vec{DC}$'' ;

    # Vecteur DC (en orange)
    draw arrow id 105 start 95.5s for 1.5s
         color (243, 156, 18, 1) width 3
         at [(92, 50), (128, 50)] ;

    text id 17 start 97.0s at (110, 54) ''[color=#F39C12]$\vec{DC}$[/color]'' ;

    # Origine en C, tracé du vecteur CF
    draw arrow id 106 start 106.0s for 2.0s
         color (243, 156, 18, 1) width 3
         at [(128, 50), (164, 50)] ;

    text id 18 start 108.0s at (146, 54) ''[color=#F39C12]$\vec{CF}$[/color]'' ;

    # Point F marqué
    draw circle id 107 start 113.0s
         color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
         radius 1.5 at (164, 50) ;

    text id 19 start 113.3s at (166, 48) ''[bold][color=#E74C3C]F[/color][/bold]'' ;

    text id 20 start 117.0s at (2, 62)
         ''[color=#F39C12]$\checkmark$ Point F déterminé : $\vec{CF} = \vec{DC}$[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 5 : QUESTION 3 — POINT G (120.8s - 155.3s)
    # \vec{GA} = \vec{BC}
    # ═══════════════════════════════════════

    text id 21 start 120.8s at (2, 70)
         ''[bold][color=#E67E22]3) Construire G tel que :[/color][/bold] $\vec{GA} = \vec{BC}$'' ;

    text id 22 start 128.0s at (2, 78)
         ''[italic][color=#E74C3C]Origine G inconnue, mais extrémité connue : A[/color][/italic]'' ;

    # Vecteur GA se terminant en A(100, 32)
    draw arrow id 108 start 143.0s for 2.0s
         color (52, 152, 219, 1) width 3
         at [(108, 14), (100, 32)] ;

    text id 23 start 145.0s at (107, 23) ''[color=#3498DB]$\vec{GA}$[/color]'' ;

    # Point G marqué
    draw circle id 109 start 149.0s
         color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
         radius 1.5 at (108, 14) ;

    text id 24 start 149.3s at (110, 12) ''[bold][color=#E74C3C]G[/color][/bold]'' ;

    text id 25 start 153.0s at (2, 85)
         ''[color=#3498DB]$\checkmark$ Point G déterminé : $\vec{GA} = \vec{BC}$[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 6 : BILAN ET CONCLUSION (155.4s - 165.3s)
    # ═══════════════════════════════════════

    mouse move id 303 start 156.0s for 2.0s
          at [(84, 68), (164, 50)] ;

    mouse move id 304 start 158.5s for 2.0s
          at [(164, 50), (108, 14)] ;

    text id 26 start 162.0s at (2, 92)
         ''[bold][color=#2ECC71]Bravo ! Les 3 points E, F et G sont construits.[/color][/bold]'' ;
}
