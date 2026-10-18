course "Le Nombre Dérivé et la Tangente" id 1 idgap 100 for 120s audio "math_derivation_tangente.wav" {

    # ========================================================
    # SCÈNE 1 : Titre et accroche (0s - 12s)
    # ========================================================
    text id 1 start 0.5s for 11s at (88.89, 15)
         ''[bold][color=#1E3A8A]Le Nombre Dérivé & La Tangente[/color][/bold]'' ;

    text id 2 start 4.8s for 7s at (88.89, 45)
         ''[italic]De la sécante moyenne à la vitesse instantanée[/italic]'' ;

    # ========================================================
    # SCÈNE 2 : Construction géométrique de la sécante (12s - 31s)
    # ========================================================
    erase id 401 start 12.0s ;

    # Repère et axes
    draw 2drep id 101 start 12.2s for 1.5s
         color (100, 116, 139, 1) width 2
         at (20, 85) ;

    # Tracé de la courbe f(x)
    draw curve id 102 start 14.5s for 2.0s
         color (37, 99, 235, 1) width 3
         at [(30, 80), (55, 68), (85, 48), (120, 20), (150, 8)] ;

    text id 3 start 15.2s at (154, 8)
         ''[color=#2563EB]$$\mathcal{C}_f$$[/color]'' ;

    # Point fixe A(a, f(a))
    draw circle id 103 start 17.2s for 0.8s
         color (220, 38, 38, 1) fillcolor (220, 38, 38, 1) width 2
         at (60, 64) with radius 1.5 ;

    text id 4 start 17.5s at (58, 70)
         ''[bold][color=#DC2626]A (a, f(a))[/color][/bold]'' ;

    # Point mobile M(a+h, f(a+h))
    draw circle id 104 start 20.7s for 0.8s
         color (234, 88, 12, 1) fillcolor (234, 88, 12, 1) width 2
         at (105, 33) with radius 1.5 ;

    text id 5 start 21.0s at (108, 30)
         ''[bold][color=#EA580C]M (a+h, f(a+h))[/color][/bold]'' ;

    # Droite sécante (AM)
    draw line id 105 start 22.7s for 1.8s
         color (220, 38, 38, 0.8) width 2
         at [(35, 82), (135, 12)] ;

    text id 6 start 24.5s at (120, 65)
         ''[color=#DC2626]$$\text{Pente de la sécante} = \frac{f(a+h)-f(a)}{h}$$[/color]'' ;

    # ========================================================
    # SCÈNE 3 : Mouvement limite et naissance de la tangente (31s - 54s)
    # ========================================================
    erase id 402 start 31.5s ;

    # Courbe maintenue
    draw curve id 106 start 32.0s
         color (37, 99, 235, 1) width 3
         at [(30, 80), (55, 68), (85, 48), (120, 20), (150, 8)] ;

    # Point de contact A
    draw circle id 107 start 32.0s
         color (220, 38, 38, 1) fillcolor (220, 38, 38, 1) width 2
         at (60, 64) with radius 1.5 ;

    # Tangente en vert émeraude
    draw line id 108 start 43.5s for 2.0s
         color (16, 185, 129, 1) width 3
         at [(25, 95), (115, 15)] ;

    text id 7 start 44.0s at (120, 18)
         ''[bold][color=#10B981]Tangente $T_A$[/color][/bold]'' ;

    # Définition formelle du nombre dérivé
    text id 8 start 46.5s at (88.89, 78)
         ''[bold][color=#10B981]$$f'(a) = \lim_{h \to 0} \frac{f(a+h) - f(a)}{h}$$[/color][/bold]'' ;

    text id 9 start 50.0s at (88.89, 90)
         ''$$\text{Équation : } y = f'(a)(x-a) + f(a)$$'' ;

    # ========================================================
    # SCÈNE 4 : Calcul pratique sur la fonction carré (54s - 80s)
    # ========================================================
    erase id 403 start 54.0s ;

    text id 10 start 54.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Exemple résolu : $f(x) = x^2$ en $x = 2$[/color][/bold]'' ;

    text id 11 start 56.5s at (45, 30)
         ''$$1) \quad f(2+h) = (2+h)^2 = 4 + 4h + h^2$$'' ;

    text id 12 start 61.0s at (45, 45)
         ''$$2) \quad \frac{f(2+h)-f(2)}{h} = \frac{4 + 4h + h^2 - 4}{h} = 4 + h$$'' ;

    text id 13 start 68.0s at (45, 62)
         ''$$3) \quad \lim_{h \to 0} (4 + h) = 4$$'' ;

    text id 14 start 72.0s at (88.89, 82)
         ''[bold][color=#10B981]$$f'(2) = 4 \quad \Longrightarrow \quad \text{La pente de la tangente vaut } 4$$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 5 : Piège classique & Synthèse finale (80s - 120s)
    # ========================================================
    erase id 404 start 80.0s ;

    text id 15 start 81.0s at (88.89, 15)
         ''[bold][color=#DC2626]ATTENTION AU PIÈGE CLASSIQUE ![/color][/bold]'' ;

    draw polygone id 109 start 83.0s for 1.0s
         color (239, 68, 68, 0.4) fillcolor (254, 242, 242, 0.8) width 2
         at [(20, 25), (157.78, 25), (157.78, 55), (20, 55)] ;

    text id 16 start 84.0s at (88.89, 35)
         ''[color=#DC2626]$$f(a) \neq f'(a)$$[/color]'' ;

    text id 17 start 87.0s at (88.89, 45)
         ''[italic]$f(a)$ donne la position / hauteur $\quad$ vs $\quad$ $f'(a)$ donne la pente / vitesse instantanée[/italic]'' ;

    text id 18 start 105.0s at (88.89, 70)
         ''[bold][color=#1E3A8A]À retenir :[/color][/bold]'' ;

    text id 19 start 108.0s at (88.89, 82)
         ''$$\text{Sécante } \xrightarrow{h \to 0} \text{ Tangente } \quad \Longleftrightarrow \quad \text{Taux } \xrightarrow{h \to 0} \text{ Nombre dérivé } f'(a)$$'' ;
}
