course "Exemple guidé et calcul détaillé : Intervalles et encadrements de réels en pratique" id 003 idgap 100 for 115s audio "MATH_003.wav" {

    # ========================================================
    # SCÈNE 1 : 1. Accroche & Problématique Concrète (0.0s - 23.1s)
    # ========================================================
    text id 1 start 0.3s for 22.6s at (6.0, 8.5)
         ''[bold][color=#38BDF8]1. Accroche & Problématique Concrète[/color][/bold]'' ;
    draw line id 101 start 0.5s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 2 start 0.8s at (4, 28) ''[bold][color=#38BDF8]Exemple Guidé : Calcul d'Amplitude[/color][/bold]'' ;
    text id 3 start 2.5s at (4, 42) ''Soit l'intervalle : [bold]I = [-2 ; 6][/bold]'' ;
    text id 4 start 4.5s at (4, 58) ''Amplitude (longueur) : $$L = b - a$$'' ;
    text id 5 start 7.0s at (4, 74) ''$$L = 6 - (-2) = 6 + 2 = 8$$'' ;
    draw arrow id 102 start 1.5s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 103 start 3.0s for 0.8s color (56, 189, 248, 1) width 4.5 at [(112, 56), (156, 56)] ;
    text id 6 start 3.8s at (109.0, 63) ''-2'' ;
    text id 7 start 4.2s at (154.0, 63) ''6'' ;
    draw arrow id 104 start 5.0s for 0.8s color (251, 191, 36, 1) width 2.0 at [(112, 46), (156, 46)] ;
    text id 8 start 5.8s at (126.0, 36) ''[bold][color=#FBBF24]Longueur L = 8[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 2 : 2. Définition Formelle & Propriété Clé (23.1s - 46.3s)
    # ========================================================
    erase id 401 start 23.1s ;

    text id 6 start 23.4s for 22.7s at (6.0, 8.5)
         ''[bold][color=#38BDF8]2. Définition Formelle & Propriété Clé[/color][/bold]'' ;
    draw line id 108 start 23.6s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 7 start 23.9s at (4, 28) ''[bold][color=#34D399]Centre et Rayon de l'Intervalle[/color][/bold]'' ;
    text id 8 start 25.6s at (4, 42) ''Centre c : $$c = \frac{a + b}{2} = \frac{-2 + 6}{2} = 2$$'' ;
    text id 9 start 28.1s at (4, 58) ''Rayon r : $$r = \frac{b - a}{2} = \frac{8}{2} = 4$$'' ;
    text id 10 start 30.6s at (4, 74) ''$$I = [c - r ; c + r] = [2 - 4 ; 2 + 4]$$'' ;
    draw arrow id 109 start 24.6s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 110 start 25.9s for 0.8s color (52, 211, 153, 1) width 4.5 at [(112, 56), (156, 56)] ;
    draw circle id 111 start 26.9s for 0.4s color (248, 250, 252, 1) fillcolor (248, 250, 252, 1) width 1.0 at (134, 56) radius 2.5 ;
    text id 11 start 27.3s at (131.0, 63) ''[bold]c = 2[/bold]'' ;
    draw arrow id 112 start 28.1s for 0.6s color (251, 191, 36, 1) width 1.8 at [(134, 46), (112, 46)] ;
    text id 12 start 28.5s at (120.0, 38) ''r = 4'' ;
    draw arrow id 113 start 28.9s for 0.6s color (251, 191, 36, 1) width 1.8 at [(134, 46), (156, 46)] ;
    text id 13 start 29.3s at (142.0, 38) ''r = 4'' ;

    # ========================================================
    # SCÈNE 3 : 3. Décomposition du Raisonnement Pas à Pas (46.3s - 69.4s)
    # ========================================================
    erase id 402 start 46.3s ;

    text id 11 start 46.6s for 22.6s at (6.0, 8.5)
         ''[bold][color=#38BDF8]3. Décomposition du Raisonnement Pas à Pas[/color][/bold]'' ;
    draw line id 117 start 46.8s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 12 start 47.1s at (4, 28) ''[bold][color=#FBBF24]Lien avec la Valeur Absolue[/color][/bold]'' ;
    text id 13 start 48.8s at (4, 42) ''$$x \in [c - r ; c + r] \iff |x - c| \le r$$'' ;
    text id 14 start 51.3s at (4, 58) ''Pour notre exemple (c=2, r=4) :'' ;
    text id 15 start 53.8s at (4, 74) ''$$x \in [-2 ; 6] \iff |x - 2| \le 4$$'' ;
    draw arrow id 118 start 47.8s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 119 start 49.3s for 0.8s color (251, 191, 36, 1) width 4.5 at [(112, 56), (156, 56)] ;
    text id 16 start 50.3s at (109.0, 50) ''[bold][color=#FBBF24][[/color][/bold]'' ;
    text id 17 start 50.7s at (155.0, 50) ''[bold][color=#FBBF24]][/color][/bold]'' ;
    text id 18 start 51.8s at (122.0, 36) ''[bold][color=#FBBF24]|x - 2| \le 4[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 4 : 4. Exemple d'Application Concrète Type Bac (69.4s - 92.6s)
    # ========================================================
    erase id 403 start 69.4s ;

    text id 16 start 69.7s for 22.7s at (6.0, 8.5)
         ''[bold][color=#38BDF8]4. Exemple d'Application Concrète Type Bac[/color][/bold]'' ;
    draw line id 123 start 69.9s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 17 start 70.2s at (4, 28) ''[bold][color=#C084FC]Calcul d'Intersection Associé[/color][/bold]'' ;
    text id 18 start 71.9s at (4, 42) ''Soit J = ]1 ; 8]. Calculons I ∩ J :'' ;
    text id 19 start 73.9s at (4, 58) ''$$-2 \le x \le 6 \quad \text{et} \quad 1 < x \le 8$$'' ;
    text id 20 start 76.4s at (4, 74) ''$$I \cap J = ]1 ; 6]$$'' ;
    draw arrow id 124 start 70.9s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 125 start 72.4s for 1.0s color (192, 132, 252, 1) width 5.0 at [(128, 56), (156, 56)] ;
    text id 21 start 73.2s at (124.0, 50) ''[bold][color=#C084FC]][/color][/bold]'' ;
    text id 22 start 73.6s at (126.0, 63) ''1'' ;
    text id 23 start 74.0s at (155.0, 50) ''[bold][color=#C084FC]][/color][/bold]'' ;
    text id 24 start 74.4s at (154.0, 63) ''6'' ;
    text id 25 start 75.4s at (124.0, 36) ''[bold][color=#C084FC]I ∩ J = ]1 ; 6][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 5 : 5. Erreurs Fréquentes & Réflexe de Synthèse (92.6s - 115.7s)
    # ========================================================
    erase id 404 start 92.6s ;

    text id 21 start 92.9s for 22.6s at (6.0, 8.5)
         ''[bold][color=#38BDF8]5. Erreurs Fréquentes & Réflexe de Synthèse[/color][/bold]'' ;
    draw line id 131 start 93.1s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 22 start 93.4s at (4, 28) ''[bold][color=#38BDF8]Bilan des Formules Clés :[/color][/bold]'' ;
    text id 23 start 95.1s at (4, 44) ''(+) Longueur L = b - a (toujours > 0)'' ;
    text id 24 start 97.6s at (4, 60) ''(+) Centre c = (a+b)/2 (milieu)'' ;
    text id 25 start 100.1s at (4, 76) ''(+) Rayon r = (b-a)/2 = L/2'' ;
    draw circle id 132 start 94.4s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;
    text id 26 start 95.6s at (118.0, 48) ''[bold][color=#38BDF8]Bilan Calculs[/color][/bold]'' ;
    text id 27 start 97.1s at (118.0, 58) ''$$L = b - a$$'' ;

}