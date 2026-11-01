course "Problème type Bac : Intervalles et encadrements de réels — Raisonnement en plusieurs étapes" id 1 idgap 500 for 209s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION, SENS DE L'UNION & ÉNONCÉ DU PROBLÈME (0.0s -> 44.5s)
    # =========================================================================

    text id 1 start 0.5s at (4.0, 7.5) ''[bold][color=#38BDF8]Problème type Bac : Réunion de deux intervalles[/color][/bold]'' ;
    draw line id 501 start 1.5s color (56, 189, 248, 0.8) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 2.2s for 5.5s at (4.0, 19.0) ''[italic]Objectif : Déterminer la réunion $I \cup J$ dans deux cas fondamentaux.[/italic]'' ;

    text id 3 start 13.0s at (4.0, 27.5) ''[bold][color=#FBBF24]Définition fondamentale de la Réunion ($\cup$) :[/color][/bold]'' ;
    text id 4 start 14.5s at (6.0, 34.5) ''$x \in I \cup J \iff x \in I \quad \text{ou} \quad x \in J$'' ;
    text id 5 start 16.0s at (6.0, 41.5) ''(L'élément appartient à [bold]au moins l'un[/bold] des deux ensembles)'' ;

    text id 6 start 18.0s for 1.8s at (4.0, 51.0) ''[bold][color=#38BDF8]Cas 1 :[/color][/bold] $I = [0 ; 2[$ et $J = [1 ; 4]$'' ;
    text id 7 start 21.0s for 5.5s at (8.0, 58.0) ''• Pour $I = [0 ; 2[$ : borne $0 \in I$ (fermée), mais $2 \notin I$ (ouverte)'' ;
    text id 8 start 36.5s for 5.1s at (8.0, 65.0) ''• Pour $J = [1 ; 4]$ : bornes $1 \in J$ et $4 \in J$ (toutes deux fermées)'' ;

    # Illustration géométrique de la réunion (Venn) en colonne droite
    draw circle id 502 start 13.5s color (52, 211, 153, 0.9) fillcolor (52, 211, 153, 0.15) width 2.5 radius 18.0 at (122.0, 48.0) ;
    draw circle id 503 start 14.5s color (248, 113, 113, 0.9) fillcolor (248, 113, 113, 0.15) width 2.5 radius 18.0 at (145.0, 48.0) ;
    text id 9 start 15.5s at (115.0, 46.0) ''[bold][color=#34D399]I[/color][/bold]'' ;
    text id 10 start 16.0s at (152.0, 46.0) ''[bold][color=#F87171]J[/color][/bold]'' ;
    text id 11 start 16.8s at (133.5, 48.0) ''[color=#FBBF24]$I \cap J$[/color]'' ;
    text id 12 start 17.5s at (102.0, 74.0) ''[bold][color=#38BDF8]Réunion $I \cup J$ : totalité des deux disques[/color][/bold]'' ;
    draw arrow id 504 start 17.8s color (56, 189, 248, 0.8) width 2.0 at [(133.5, 71.0), (133.5, 62.0)] ;


    # =========================================================================
    # SCÈNE 2 : PREMIER CAS — AXE GRADUÉ & INTERVALLES SÉCANTS (44.5s -> 132.0s)
    # =========================================================================

    erase id 2001 start 44.5s ;

    text id 13 start 45.0s at (4.0, 7.5) ''[bold][color=#38BDF8]Premier Cas : Intervalles Sécants avec Chevauchement[/color][/bold]'' ;
    draw line id 505 start 45.5s color (56, 189, 248, 0.8) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 14 start 47.0s for 1.8s at (4.0, 19.0) ''[bold]Données :[/bold] $I = [0 ; 2[$ et $J = [1 ; 4]$'' ;
    text id 15 start 50.0s for 1.6s at (4.0, 26.0) ''[color=#FBBF24]Méthode réflexe :[/color] Représentation sur l'axe gradué'' ;

    # Axe gradué en colonne droite
    draw arrow id 506 start 51.8s color (248, 250, 252, 0.95) width 2.5 at [(94.0, 50.0), (172.0, 50.0)] ;

    # Graduations de -1 à 5
    draw line id 507 start 52.5s color (248, 250, 252, 0.8) width 1.8 at [(102.0, 48.5), (102.0, 51.5)] ;
    text id 16 start 52.8s at (102.0, 54.5) ''-1'' ;

    draw line id 508 start 53.0s color (248, 250, 252, 0.8) width 1.8 at [(113.0, 48.5), (113.0, 51.5)] ;
    text id 17 start 53.2s at (113.0, 54.5) ''0'' ;

    draw line id 509 start 53.4s color (248, 250, 252, 0.8) width 1.8 at [(124.0, 48.5), (124.0, 51.5)] ;
    text id 18 start 53.6s at (124.0, 54.5) ''1'' ;

    draw line id 510 start 53.8s color (248, 250, 252, 0.8) width 1.8 at [(135.0, 48.5), (135.0, 51.5)] ;
    text id 19 start 54.0s at (135.0, 54.5) ''2'' ;

    draw line id 511 start 54.2s color (248, 250, 252, 0.8) width 1.8 at [(146.0, 48.5), (146.0, 51.5)] ;
    text id 20 start 54.4s at (146.0, 54.5) ''3'' ;

    draw line id 512 start 54.6s color (248, 250, 252, 0.8) width 1.8 at [(157.0, 48.5), (157.0, 51.5)] ;
    text id 21 start 54.8s at (157.0, 54.5) ''4'' ;

    draw line id 513 start 55.0s color (248, 250, 252, 0.8) width 1.8 at [(168.0, 48.5), (168.0, 51.5)] ;
    text id 22 start 55.2s at (168.0, 54.5) ''5'' ;

    # Intervalle I = [0 ; 2[ en vert au-dessus
    draw line id 514 start 56.5s color (52, 211, 153, 1) width 4.5 at [(113.0, 41.0), (135.0, 41.0)] ;
    draw path id 515 start 62.0s color (52, 211, 153, 1) width 3.0 at [(115.0, 38.0), (113.0, 38.0), (113.0, 44.0), (115.0, 44.0)] ;
    draw path id 516 start 63.8s color (52, 211, 153, 1) width 3.0 at [(137.0, 38.0), (135.0, 38.0), (135.0, 44.0), (137.0, 44.0)] ;
    text id 23 start 57.0s for 1.8s at (118.0, 34.0) ''[color=#34D399]$\mathbf{I = [0 ; 2[}$[/color]'' ;

    # Intervalle J = [1 ; 4] en rouge en dessous
    draw line id 517 start 66.0s color (248, 113, 113, 1) width 4.5 at [(124.0, 63.0), (157.0, 63.0)] ;
    draw path id 518 start 71.0s color (248, 113, 113, 1) width 3.0 at [(126.0, 60.0), (124.0, 60.0), (124.0, 66.0), (126.0, 66.0)] ;
    draw path id 519 start 72.0s color (248, 113, 113, 1) width 3.0 at [(155.0, 60.0), (157.0, 60.0), (157.0, 66.0), (155.0, 66.0)] ;
    text id 24 start 67.0s for 1.8s at (140.5, 70.0) ''[color=#F87171]$\mathbf{J = [1 ; 4]}$[/color]'' ;

    # Explications gauche sur le sens de la réunion
    text id 25 start 80.0s for 2.8s at (4.0, 35.0) ''[bold]Condition de réunion :[/bold]'' ;
    text id 26 start 83.0s for 3.8s at (6.0, 42.0) ''$x \in I \cup J \iff x$ est vert [bold]OU[/bold] rouge'' ;

    # Zone couverte continue [0 ; 4]
    draw line id 520 start 94.5s color (56, 189, 248, 1) width 5.0 at [(113.0, 80.0), (157.0, 80.0)] ;
    draw path id 521 start 95.5s color (56, 189, 248, 1) width 3.0 at [(115.0, 77.0), (113.0, 77.0), (113.0, 83.0), (115.0, 83.0)] ;
    draw path id 522 start 96.0s color (56, 189, 248, 1) width 3.0 at [(155.0, 77.0), (157.0, 77.0), (157.0, 83.0), (155.0, 83.0)] ;
    text id 27 start 97.0s for 2.8s at (112.0, 87.0) ''[bold][color=#38BDF8]Couverture continue : $[0 ; 4]$[/color][/bold]'' ;

    # Statut des bornes et conclusion à gauche
    text id 28 start 107.5s for 2.3s at (4.0, 52.0) ''[bold][color=#FBBF24]Analyse du statut des bornes :[/color][/bold]'' ;
    text id 29 start 110.0s for 4.9s at (6.0, 59.0) ''• Borne $0$ : $0 \in I \implies 0 \in I \cup J$ [color=#34D399](crochet fermé)[/color]'' ;
    text id 30 start 116.0s for 4.9s at (6.0, 67.0) ''• Borne $4$ : $4 \in J \implies 4 \in I \cup J$ [color=#34D399](crochet fermé)[/color]'' ;

    text id 31 start 122.0s for 2.8s at (4.0, 78.0) ''[bold][color=#38BDF8]Conclusion Cas 1 :[/color][/bold]'' ;
    text id 32 start 127.5s for 2.8s at (6.0, 86.0) ''[color=#38BDF8]$\mathbf{I \cup J = [0 ; 4]}$[/color]'' ;


    # =========================================================================
    # SCÈNE 3 : DEUXIÈME CAS — INTERVALLES DISJOINTS & DEMI-DROITE (132.0s -> 179.5s)
    # =========================================================================

    erase id 2002 start 132.0s ;

    text id 33 start 132.5s at (4.0, 7.5) ''[bold][color=#38BDF8]Deuxième Cas : Intervalles Disjoints & Demi-Droite[/color][/bold]'' ;
    draw line id 523 start 133.0s color (56, 189, 248, 0.8) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 34 start 134.5s for 3.3s at (4.0, 19.0) ''[bold]Données :[/bold] $I = ]3 ; +\infty[$ et $J = [-1 ; 1]$'' ;
    text id 35 start 138.0s for 5.5s at (6.0, 27.0) ''• Pour $I = ]3 ; +\infty[$ : $3 \notin I$ (ouvert), demi-droite vers $+\infty$'' ;
    text id 36 start 147.0s for 4.8s at (6.0, 35.0) ''• Pour $J = [-1 ; 1]$ : $-1 \in J$ et $1 \in J$ (segment fermé)'' ;

    # Axe gradué en colonne droite
    draw arrow id 524 start 153.5s color (248, 250, 252, 0.95) width 2.5 at [(94.0, 50.0), (172.0, 50.0)] ;

    # Graduations de -2 à 6
    draw line id 525 start 154.0s color (248, 250, 252, 0.8) width 1.8 at [(100.0, 48.5), (100.0, 51.5)] ;
    text id 37 start 154.2s at (100.0, 54.5) ''-2'' ;

    draw line id 526 start 154.4s color (248, 250, 252, 0.8) width 1.8 at [(108.0, 48.5), (108.0, 51.5)] ;
    text id 38 start 154.6s at (108.0, 54.5) ''-1'' ;

    draw line id 527 start 154.8s color (248, 250, 252, 0.8) width 1.8 at [(116.0, 48.5), (116.0, 51.5)] ;
    text id 39 start 155.0s at (116.0, 54.5) ''0'' ;

    draw line id 528 start 155.2s color (248, 250, 252, 0.8) width 1.8 at [(124.0, 48.5), (124.0, 51.5)] ;
    text id 40 start 155.4s at (124.0, 54.5) ''1'' ;

    draw line id 529 start 155.6s color (248, 250, 252, 0.8) width 1.8 at [(132.0, 48.5), (132.0, 51.5)] ;
    text id 41 start 155.8s at (132.0, 54.5) ''2'' ;

    draw line id 530 start 156.0s color (248, 250, 252, 0.8) width 1.8 at [(140.0, 48.5), (140.0, 51.5)] ;
    text id 42 start 156.2s at (140.0, 54.5) ''3'' ;

    draw line id 531 start 156.4s color (248, 250, 252, 0.8) width 1.8 at [(148.0, 48.5), (148.0, 51.5)] ;
    text id 43 start 156.6s at (148.0, 54.5) ''4'' ;

    draw line id 532 start 156.8s color (248, 250, 252, 0.8) width 1.8 at [(156.0, 48.5), (156.0, 51.5)] ;
    text id 44 start 157.0s at (156.0, 54.5) ''5'' ;

    draw line id 533 start 157.2s color (248, 250, 252, 0.8) width 1.8 at [(164.0, 48.5), (164.0, 51.5)] ;
    text id 45 start 157.4s at (164.0, 54.5) ''6'' ;

    # Intervalle I = ]3 ; +infini[ en vert (demi-droite)
    draw arrow id 534 start 158.5s for 0.8s color (52, 211, 153, 1) width 4.5 at [(140.0, 41.0), (172.0, 41.0)] ;
    draw path id 535 start 162.0s color (52, 211, 153, 1) width 3.0 at [(138.0, 38.0), (140.0, 38.0), (140.0, 44.0), (138.0, 44.0)] ;
    text id 46 start 164.0s for 2.8s at (146.0, 34.0) ''[color=#34D399]$\mathbf{I = ]3 ; +\infty[}$[/color]'' ;

    # Intervalle J = [-1 ; 1] en rouge
    draw line id 536 start 168.5s color (248, 113, 113, 1) width 4.5 at [(108.0, 63.0), (124.0, 63.0)] ;
    draw path id 537 start 172.0s color (248, 113, 113, 1) width 3.0 at [(110.0, 60.0), (108.0, 60.0), (108.0, 66.0), (110.0, 66.0)] ;
    draw path id 538 start 172.8s color (248, 113, 113, 1) width 3.0 at [(122.0, 60.0), (124.0, 60.0), (124.0, 66.0), (122.0, 66.0)] ;
    text id 47 start 169.5s for 2.3s at (116.0, 70.0) ''[color=#F87171]$\mathbf{J = [-1 ; 1]}$[/color]'' ;

    # Zone vide entre les deux (intervalles disjoints)
    draw line id 539 start 173.8s color (251, 191, 36, 0.9) width 2.0 at [(124.0, 80.0), (140.0, 80.0)] ;
    text id 48 start 174.5s at (105.0, 86.0) ''[color=#FBBF24]Espace vide : aucun chevauchement[/color]'' ;

    text id 49 start 175.5s for 1.3s at (4.0, 48.0) ''[bold][color=#FBBF24]Constat géométrique :[/color][/bold]'' ;
    text id 50 start 177.0s for 2.2s at (6.0, 56.0) ''Les deux ensembles sont totalement disjoints.'' ;


    # =========================================================================
    # SCÈNE 4 : PIÈGE D'EXAMEN & ÉCRITURE IRRÉDUCTIBLE (179.5s -> 209.0s)
    # =========================================================================

    erase id 2003 start 179.5s ;

    text id 51 start 180.0s at (4.0, 7.5) ''[bold][color=#38BDF8]Piège d'Examen & Écriture Irréductible[/color][/bold]'' ;
    draw line id 540 start 180.5s color (56, 189, 248, 0.8) width 2.0 at [(4.0, 13.5), (173.0, 13.5)] ;

    # Le piège classique
    text id 52 start 181.5s at (4.0, 20.0) ''[bold][color=#F87171]Attention au piège fréquent :[/color][/bold]'' ;
    text id 53 start 183.0s at (6.0, 27.5) ''Ne confonds pas [bold]Réunion[/bold] ($\cup$) et [bold]Intersection[/bold] ($\cap$) !'' ;

    text id 54 start 185.0s at (6.0, 36.5) ''• [bold]Intersection vide :[/bold] [color=#F87171]$I \cap J = \emptyset$[/color]'' ;
    text id 55 start 188.0s for 2.8s at (10.0, 43.5) ''(aucun point commun, aucun chevauchement)'' ;

    text id 56 start 191.0s for 1.8s at (6.0, 52.5) ''• [bold]Réunion NON vide :[/bold] [color=#34D399]$I \cup J \neq \emptyset$[/color]'' ;
    text id 57 start 194.5s for 1.3s at (10.0, 59.5) ''(elle réunit tous les éléments de $J$ [bold]OU[/bold] de $I$)'' ;

    text id 58 start 199.0s at (4.0, 70.0) ''[bold][color=#FBBF24]Règle fondamentale :[/color][/bold]'' ;
    text id 59 start 201.0s for 1.8s at (6.0, 77.0) ''Deux intervalles disjoints [bold]ne peuvent pas[/bold] se fusionner.'' ;

    text id 60 start 206.0s for 2.3s at (4.0, 85.0) ''[bold][color=#38BDF8]Écriture irréductible obligatoire :[/color][/bold]'' ;
    text id 61 start 208.5s at (6.0, 92.5) ''[color=#38BDF8]$\mathbf{I \cup J = [-1 ; 1] \cup ]3 ; +\infty[}$[/color]'' ;

    # Colonne droite : Cadre Synthèse Réflexe
    draw polygone id 541 start 181.0s color (56, 189, 248, 0.9) fillcolor (56, 189, 248, 0.08) width 2.0 at [(92.0, 18.0), (173.0, 18.0), (173.0, 92.0), (92.0, 92.0)] ;
    text id 62 start 182.0s at (106.0, 23.5) ''[bold][color=#38BDF8]MÉTHODE RÉFLEXE TYPE BAC[/color][/bold]'' ;
    draw line id 542 start 183.0s color (56, 189, 248, 0.6) width 1.5 at [(96.0, 28.5), (169.0, 28.5)] ;

    text id 63 start 184.0s at (97.0, 34.0) ''[bold][color=#FBBF24]1. Axe gradué systématique :[/color][/bold]'' ;
    text id 64 start 186.0s for 1.8s at (101.0, 40.5) ''Colorer chaque intervalle sur la droite.'' ;

    text id 65 start 193.0s for 1.3s at (97.0, 47.5) ''[bold][color=#FBBF24]2. Sens de la réunion $\cup$ :[/color][/bold]'' ;
    text id 66 start 196.0s for 2.8s at (101.0, 54.0) ''Toute zone couverte par $I$ ou par $J$.'' ;

    text id 67 start 200.0s at (97.0, 61.0) ''[bold][color=#FBBF24]3. Simplification ou écriture :[/color][/bold]'' ;
    text id 68 start 203.0s for 1.8s at (101.0, 67.5) ''• Sécants $\implies$ intervalle $[a ; b]$.'' ;
    text id 69 start 205.0s at (101.0, 74.0) ''• Disjoints $\implies$ conserver $\cup$.'' ;

    text id 70 start 209.0s at (97.0, 81.0) ''[bold][color=#34D399]4. Règle des bornes :[/color][/bold]'' ;
    text id 71 start 211.0s at (101.0, 87.0) ''Fermée si $x \in$, ouverte sinon.'' ;
}
