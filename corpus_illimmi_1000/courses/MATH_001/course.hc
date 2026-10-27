course "Intervalles et encadrements de réels — Cours fondamental et définitions" id 1 idgap 100 for 99.2s audio "narration.wav" {

    # ========================================================
    # SCÈNE 1 : 1. Accroche & Problématique Concrète (0.0s - 33.1s)
    # ========================================================
    text id 1 start 0.3s for 32.6s at (6.0, 8.5)
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
    # SCÈNE 2 : 2. Définition Formelle & Propriété Clé (33.1s - 66.1s)
    # ========================================================
    erase id 401 start 33.1s ;

    text id 6 start 33.4s for 32.5s at (6.0, 8.5)
         ''[bold][color=#38BDF8]2. Définition Formelle & Propriété Clé[/color][/bold]'' ;
    draw line id 115 start 33.6s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 7 start 33.9s at (4, 28) ''[bold][color=#34D399]Règle des Crochets :[/color][/bold]'' ;
    text id 8 start 35.6s at (4, 42) ''[bold][color=#34D399]Crochet fermé (inclus) :[/color][/bold] Borne incluse ($\le$ ou $\ge$)'' ;
    text id 9 start 37.6s at (4, 58) ''[bold][color=#F87171]Crochet ouvert (exclu) :[/color][/bold] Borne exclue (< ou >)'' ;
    text id 10 start 40.1s at (4, 74) ''$$x \in ]2 ; 4] \iff 2 < x \le 4$$'' ;
    draw arrow id 116 start 34.6s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 50), (170, 50)] ;
    draw line id 117 start 36.1s for 0.8s color (52, 211, 153, 1) width 4.5 at [(120, 50), (155, 50)] ;
    text id 11 start 36.9s at (116.0, 44) ''[bold][color=#F87171]][/color][/bold]'' ;
    text id 12 start 37.3s at (154.0, 44) ''[bold][color=#34D399]][/color][/bold]'' ;
    text id 13 start 37.9s at (118.0, 56) ''2 exclu'' ;
    text id 14 start 38.3s at (150.0, 56) ''4 inclus'' ;
    text id 15 start 39.1s at (126.0, 32) ''[bold][color=#34D399]]2 ; 4][/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : 3. Décomposition du Raisonnement Pas à Pas (66.1s - 99.2s)
    # ========================================================
    erase id 402 start 66.1s ;

    text id 11 start 66.4s for 32.6s at (6.0, 8.5)
         ''[bold][color=#38BDF8]3. Décomposition du Raisonnement Pas à Pas[/color][/bold]'' ;
    draw line id 123 start 66.6s for 0.6s
         color (56, 189, 248, 0.45) width 1.5
         at [(6, 14), (172, 14)] ;
    text id 12 start 66.9s at (4, 28) ''[bold][color=#FBBF24]Intervalles Non Bornés :[/color][/bold]'' ;
    text id 13 start 68.6s at (4, 42) ''$$x \ge 3 \iff x \in [3 ; +\infty[$$'' ;
    text id 14 start 71.1s at (4, 58) ''$$x < 0 \iff x \in ]-\infty ; 0[$$'' ;
    text id 15 start 73.6s at (4, 74) ''Du côté de ±∞, crochet TOUJOURS ouvert !'' ;
    draw arrow id 124 start 67.6s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;
    draw line id 125 start 68.9s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(125, 52), (125, 60)] ;
    text id 16 start 69.1s at (123.5, 63) ''[bold]3[/bold]'' ;
    draw line id 126 start 69.9s for 1.2s color (251, 191, 36, 1) width 5.0 at [(125, 56), (168, 56)] ;
    text id 17 start 70.6s at (122.0, 50) ''[bold][color=#FBBF24][[/color][/bold]'' ;
    text id 18 start 71.3s at (162.0, 48) ''[bold]+∞[/bold]'' ;
    text id 19 start 72.1s at (135.0, 36) ''[bold][color=#FBBF24][3 ; +∞[[/color][/bold]'' ;

}