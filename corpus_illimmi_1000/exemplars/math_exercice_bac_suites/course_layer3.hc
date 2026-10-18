course "Résolution d'une Suite Arithmético-Géométrique au Bac" id 2 idgap 100 for 140s audio "math_exercice_bac_suites.wav" {

    # ========================================================
    # SCÈNE 1 : Énoncé du sujet de Bac (0s - 25s)
    # ========================================================
    text id 1 start 0.5s for 24s at (88.89, 12)
         ''[bold][color=#1E3A8A]Exercice Classique Type Bac : Suites Récurrentes[/color][/bold]'' ;

    draw polygone id 101 start 4.0s for 1.5s
         color (59, 130, 246, 0.5) fillcolor (239, 246, 255, 0.9) width 2
         at [(25, 25), (152.78, 25), (152.78, 75), (25, 75)] ;

    text id 2 start 5.5s at (88.89, 38)
         ''[bold]$$u_0 = 1 \quad \text{et} \quad u_{n+1} = 0{,}5 u_n + 3 \quad (\forall n \in \mathbb{N})$$[/bold]'' ;

    text id 3 start 12.0s at (88.89, 55)
         ''[italic]1) Exprimer $u_n$ en fonction de $n$ $\quad$ 2) Déterminer la limite de $(u_n)$[/italic]'' ;

    # ========================================================
    # SCÈNE 2 : Recherche du point fixe et suite auxiliaire (25s - 60s)
    # ========================================================
    erase id 401 start 25.0s ;

    text id 4 start 25.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Étape 1 : Point fixe & Suite Auxiliaire[/color][/bold]'' ;

    text id 5 start 28.0s at (88.89, 28)
         ''$$\text{Équation de point fixe : } \alpha = 0{,}5 \alpha + 3 \quad \Longrightarrow \quad 0{,}5 \alpha = 3 \quad \Longrightarrow \quad \alpha = 6$$'' ;

    text id 6 start 42.0s at (88.89, 50)
         ''[bold][color=#2563EB]On pose la suite auxiliaire : $\quad v_n = u_n - 6$[/color][/bold]'' ;

    # ========================================================
    # SCÈNE 3 : Démonstration que (vn) est géométrique (60s - 95s)
    # ========================================================
    erase id 402 start 60.0s ;

    text id 7 start 60.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Étape 2 : $(v_n)$ est géométrique[/color][/bold]'' ;

    text id 8 start 62.0s at (50, 28)
         ''$$v_{n+1} = u_{n+1} - 6 = (0{,}5 u_n + 3) - 6$$'' ;

    text id 9 start 68.0s at (50, 42)
         ''$$v_{n+1} = 0{,}5 u_n - 3 = 0{,}5 (u_n - 6) = 0{,}5 v_n$$'' ;

    text id 10 start 78.0s at (88.89, 60)
         ''[bold][color=#10B981]$(v_n)$ est géométrique de raison $q = 0{,}5$ et $v_0 = 1 - 6 = -5$[/color][/bold]'' ;

    text id 11 start 86.0s at (88.89, 78)
         ''$$v_n = -5 \times (0{,}5)^n \quad \Longrightarrow \quad [bold][color=#2563EB]u_n = 6 - 5 \times (0{,}5)^n[/color][/bold]$$'' ;

    # ========================================================
    # SCÈNE 4 : Calcul rigoureux de la limite & Barème Bac (95s - 140s)
    # ========================================================
    erase id 403 start 95.0s ;

    text id 12 start 95.5s at (88.89, 12)
         ''[bold][color=#1E3A8A]Étape 3 : Calcul de la limite de $(u_n)$[/color][/bold]'' ;

    draw polygone id 102 start 98.0s for 1.0s
         color (245, 158, 11, 0.6) fillcolor (254, 252, 232, 0.9) width 2
         at [(25, 25), (152.78, 25), (152.78, 55), (25, 55)] ;

    text id 13 start 99.0s at (88.89, 35)
         ''[bold][color=#B45309]JUSTIFICATION OBLIGATOIRE AU BACCALAURÉAT :[/color][/bold]'' ;

    text id 14 start 104.0s at (88.89, 45)
         ''$$\text{Comme } -1 < 0{,}5 < 1, \quad \lim_{n \to +\infty} (0{,}5)^n = 0$$'' ;

    text id 15 start 115.0s at (88.89, 70)
         ''[bold][color=#10B981]$$\lim_{n \to +\infty} u_n = 6 - 5 \times 0 = 6$$[/color][/bold]'' ;

    text id 16 start 125.0s at (88.89, 86)
         ''[italic]Conclusion : La suite $(u_n)$ est convergente et converge vers 6.[/italic]'' ;
}
