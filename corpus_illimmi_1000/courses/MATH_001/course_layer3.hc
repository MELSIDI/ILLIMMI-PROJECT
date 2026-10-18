course "Intervalles et encadrements de réels — Cours fondamental et définitions" id 001 idgap 100 for 123s audio "MATH_001.wav" {

    # ========================================================
    # SCÈNE 1 : 1. Accroche & Problématique Concrète (0.0s - 24.7s)
    # ========================================================
    text id 1 start 0.3s for 24.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]1. Accroche & Problématique Concrète[/color][/bold]'' ;
    draw line id 101 start 0.5s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 2 start 0.8s at (4, 28) ''[bold][color=#38BDF8]Définition fondamentale :[/color][/bold]'' ;
    text id 3 start 2.2s at (4, 42) ''Soient a et b deux réels avec [bold]a < b[/bold].'' ;
    text id 4 start 4.0s at (4, 56) ''$$\mathcal{I} = [a ; b] = \{ x \in \mathbb{R} \mid a \le x \le b \}$$'' ;
    text id 5 start 6.5s at (4, 74) ''Exemple : [bold][color=#60A5FA]x compris entre 2 et 4[/color][/bold]'' ;
    draw arrow id 102 start 1.5s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    text id 6 start 2.0s at (164, 48) ''[bold]+\infty[/bold]'' ;
    text id 7 start 2.0s at (96, 48) ''[bold]-\infty[/bold]'' ;
    draw line id 103 start 2.5s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(110, 53), (110, 59)] ;
    text id 8 start 2.7s at (108.5, 62) ''0'' ;
    draw line id 104 start 3.0s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(134, 53), (134, 59)] ;
    text id 9 start 3.2s at (132.5, 62) ''[bold][color=#60A5FA]2[/color][/bold]'' ;
    draw line id 105 start 3.5s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(158, 53), (158, 59)] ;
    text id 10 start 3.7s at (156.5, 62) ''[bold][color=#60A5FA]4[/color][/bold]'' ;
    draw line id 106 start 5.0s for 1.2s color (56, 189, 248, 1) width 5.0 at [(134, 56), (158, 56)] ;
    text id 11 start 5.8s at (131.0, 50) ''[bold][color=#60A5FA][[/color][/bold]'' ;
    text id 12 start 6.2s at (157.0, 50) ''[bold][color=#60A5FA]][/color][/bold]'' ;
    text id 13 start 7.0s at (138.0, 36) ''[bold][color=#38BDF8]I = [2 ; 4][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 2 : 2. Définition Formelle & Propriété Clé (24.7s - 49.4s)
    # ========================================================
    erase id 401 start 24.7s ;

    text id 6 start 25.0s for 24.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]2. Définition Formelle & Propriété Clé[/color][/bold]'' ;
    draw line id 115 start 25.2s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 7 start 25.5s at (4, 28) ''[bold][color=#34D399]Règle des Crochets :[/color][/bold]'' ;
    text id 8 start 27.2s at (4, 42) ''[bold][color=#34D399]Crochet fermé (inclus) :[/color][/bold] Borne incluse ($\le$ ou $\ge$)'' ;
    text id 9 start 29.2s at (4, 58) ''[bold][color=#F87171]Crochet ouvert (exclu) :[/color][/bold] Borne exclue (< ou >)'' ;
    text id 10 start 31.7s at (4, 74) ''$$x \in ]2 ; 4] \iff 2 < x \le 4$$'' ;
    draw arrow id 116 start 26.2s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 50), (170, 50)] ;
    draw line id 117 start 27.7s for 0.8s color (52, 211, 153, 1) width 4.5 at [(120, 50), (155, 50)] ;
    text id 11 start 28.5s at (116.0, 44) ''[bold][color=#F87171]][/color][/bold]'' ;
    text id 12 start 28.9s at (154.0, 44) ''[bold][color=#34D399]][/color][/bold]'' ;
    text id 13 start 29.5s at (118.0, 56) ''2 exclu'' ;
    text id 14 start 29.9s at (150.0, 56) ''4 inclus'' ;
    text id 15 start 30.7s at (126.0, 32) ''[bold][color=#34D399]]2 ; 4][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : 3. Décomposition du Raisonnement Pas à Pas (49.4s - 74.1s)
    # ========================================================
    erase id 402 start 49.4s ;

    text id 11 start 49.7s for 24.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]3. Décomposition du Raisonnement Pas à Pas[/color][/bold]'' ;
    draw line id 123 start 49.9s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 12 start 50.2s at (4, 28) ''[bold][color=#FBBF24]Intervalles Non Bornés :[/color][/bold]'' ;
    text id 13 start 51.9s at (4, 42) ''$$x \ge 3 \iff x \in [3 ; +\infty[$$'' ;
    text id 14 start 54.4s at (4, 58) ''$$x < 0 \iff x \in ]-\infty ; 0[$$'' ;
    text id 15 start 56.9s at (4, 74) ''Du côté de ±∞, crochet TOUJOURS ouvert !'' ;
    draw arrow id 124 start 50.9s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 125 start 52.2s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(125, 52), (125, 60)] ;
    text id 16 start 52.4s at (123.5, 63) ''[bold]3[/bold]'' ;
    draw line id 126 start 53.2s for 1.2s color (251, 191, 36, 1) width 5.0 at [(125, 56), (168, 56)] ;
    text id 17 start 53.9s at (122.0, 50) ''[bold][color=#FBBF24][[/color][/bold]'' ;
    text id 18 start 54.6s at (162.0, 48) ''[bold]+∞[/bold]'' ;
    text id 19 start 55.4s at (135.0, 36) ''[bold][color=#FBBF24][3 ; +∞[[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 4 : 4. Exemple d'Application Concrète Type Bac (74.1s - 98.8s)
    # ========================================================
    erase id 403 start 74.1s ;

    text id 16 start 74.4s for 24.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]4. Exemple d'Application Concrète Type Bac[/color][/bold]'' ;
    draw line id 131 start 74.6s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 17 start 74.9s at (4, 28) ''[bold][color=#C084FC]Application Type Lycée :[/color][/bold]'' ;
    text id 18 start 76.6s at (4, 42) ''Soit l'encadrement : [bold]-4 ≤ x < 5[/bold]'' ;
    text id 19 start 78.6s at (4, 58) ''1. Borne -4 incluse (crochet fermé)'' ;
    text id 20 start 80.6s at (4, 74) ''2. Borne 5 exclue (crochet ouvert)'' ;
    draw arrow id 132 start 75.6s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 133 start 77.3s for 1.0s color (192, 132, 252, 1) width 4.5 at [(115, 56), (155, 56)] ;
    text id 21 start 78.1s at (112.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;
    text id 22 start 78.5s at (113.0, 63) ''-4'' ;
    text id 23 start 79.1s at (154.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;
    text id 24 start 79.5s at (154.0, 63) ''5'' ;
    text id 25 start 80.6s at (124.0, 36) ''[bold][color=#C084FC]S = [-4 ; 5[[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 5 : 5. Erreurs Fréquentes & Réflexe de Synthèse (98.8s - 123.5s)
    # ========================================================
    erase id 404 start 98.8s ;

    text id 21 start 99.1s for 24.2s at (6.0, 8.5)
         ''[bold][color=#38BDF8]5. Erreurs Fréquentes & Réflexe de Synthèse[/color][/bold]'' ;
    draw line id 139 start 99.3s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 22 start 99.6s at (4, 28) ''[bold][color=#38BDF8]Fiche Réflexe Épreuve :[/color][/bold]'' ;
    text id 23 start 101.3s at (4, 44) ''(+) Toujours ordonner les bornes : du plus petit au plus grand !'' ;
    text id 24 start 103.8s at (4, 60) ''(+) Inégalité large (≤) ⟹ crochet tourné vers le nombre'' ;
    text id 25 start 106.3s at (4, 76) ''(!) Piège : ne JAMAIS fermer le crochet sur ±∞'' ;
    draw circle id 140 start 100.8s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;
    text id 26 start 101.8s at (116.0, 48) ''[bold][color=#38BDF8]Synthèse Intervalles[/color][/bold]'' ;
    text id 27 start 103.3s at (118.0, 58) ''$$x \in [a ; b] \iff a \le x \le b$$'' ;

}