course "Méthode pas à pas : Comment résoudre un problème de Intervalles et encadrements de réels" id 8 idgap 1000 for 601.45s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : PRÉSENTATION DE LA MÉTHODE & TABLEAU À TROIS COLONNES
    # =========================================================================
    text id 1 start 0.5s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]1. Présentation de la Méthode : Le Tableau à Trois Colonnes[/bold][/color]'' ;
    draw line id 1001 start 2.5s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 2 start 3.5s for 2.2s at (6.0, 20.0) ''[color=#F8FAFC]Objectif : Maîtriser le passage immédiat entre [color=#FBBF24]3 représentations[/color] :[/color]'' ;

    draw polygone id 1002 start 14.5s for 0.8s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 1.5 at [(10.0, 30.0), (55.0, 30.0), (55.0, 52.0), (10.0, 52.0)] ;
    text id 3 start 16.5s for 1.8s at (13.0, 35.0) ''[color=#F8FAFC][bold]1. Inégalité / Encadrement[/bold][/color]'' ;
    text id 4 start 19.5s for 1.5s at (13.0, 43.0) ''[color=#94A3B8]$a \le x \le b$  ou  $x < b$[/color]'' ;

    draw polygone id 1003 start 22.8s for 0.8s color (52, 211, 153, 0.8) fillcolor (52, 211, 153, 0.15) width 1.5 at [(65.0, 30.0), (110.0, 30.0), (110.0, 52.0), (65.0, 52.0)] ;
    text id 5 start 24.2s for 1.8s at (68.0, 35.0) ''[color=#F8FAFC][bold]2. Notation d'Intervalle[/bold][/color]'' ;
    text id 6 start 27.0s for 1.5s at (68.0, 43.0) ''[color=#94A3B8]$[a ; b]$ , $]a ; b]$ , $]-\infty ; b[$[/color]'' ;

    draw polygone id 1004 start 29.5s for 0.8s color (251, 191, 36, 0.8) fillcolor (251, 191, 36, 0.15) width 1.5 at [(120.0, 30.0), (167.0, 30.0), (167.0, 52.0), (120.0, 52.0)] ;
    text id 7 start 31.0s for 1.8s at (123.0, 35.0) ''[color=#F8FAFC][bold]3. Axe Gradué (Géométrie)[/bold][/color]'' ;
    text id 8 start 33.5s for 1.2s at (123.0, 43.0) ''[color=#94A3B8]Droite réelle & crochets[/color]'' ;

    draw arrow id 1005 start 35.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(56.0, 41.0), (64.0, 41.0)] ;
    draw arrow id 1006 start 36.5s for 0.8s color (248, 250, 252, 0.8) width 1.5 at [(111.0, 41.0), (119.0, 41.0)] ;

    text id 9 start 37.8s for 2.0s at (32.0, 62.0) ''[color=#38BDF8][bold]Équivalence totale :[/bold] passer de l'une à l'autre avec une fluidité absolue ![/color]'' ;

    erase id 4001 start 41.0s ;

    # =========================================================================
    # SCÈNE 2 : CAS 1 — ENCADREMENT FERMÉ & BORNES INCLUSES (2 <= x <= 4)
    # =========================================================================
    text id 50 start 41.6s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]2. Cas 1 : Encadrement Fermé & Bornes Incluses[/bold][/color]'' ;
    draw line id 1050 start 43.6s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 51 start 45.0s for 2.2s at (6.0, 20.0) ''[color=#F8FAFC]Inégalité donnée :[/color]  [color=#FBBF24]$$2 \le x \le 4$$[/color]'' ;
    text id 52 start 50.0s for 2.5s at (6.0, 31.0) ''[color=#F8FAFC]Lecture : [color=#38BDF8]$x$ est compris entre $2$ et $4$[/color][/color]'' ;
    text id 53 start 56.0s for 2.8s at (6.0, 39.0) ''[color=#94A3B8]$x$ se déplace librement dans la zone délimitée par 2 et 4.[/color]'' ;

    draw arrow id 1051 start 66.5s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 52.0), (168.0, 52.0)] ;
    text id 54 start 68.0s for 0.8s at (169.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 1052 start 69.5s color (248, 250, 252, 0.7) width 1.2 at [(98.0, 50.5), (98.0, 53.5)] ;
    text id 55 start 69.8s at (96.5, 56.5) ''[color=#94A3B8]0[/color]'' ;
    draw line id 1053 start 70.2s color (248, 250, 252, 0.7) width 1.2 at [(108.0, 50.5), (108.0, 53.5)] ;
    text id 56 start 70.5s at (106.5, 56.5) ''[color=#94A3B8]1[/color]'' ;

    draw line id 1054 start 71.8s for 0.6s color (56, 189, 248, 1) width 2.0 at [(118.0, 49.5), (118.0, 54.5)] ;
    text id 57 start 72.8s for 0.8s at (116.5, 57.0) ''[color=#38BDF8][bold]2[/bold][/color]'' ;
    draw line id 1055 start 74.0s for 0.6s color (56, 189, 248, 1) width 2.0 at [(138.0, 49.5), (138.0, 54.5)] ;
    text id 58 start 75.0s for 0.8s at (136.5, 57.0) ''[color=#38BDF8][bold]4[/bold][/color]'' ;

    draw line id 1056 start 85.8s for 2.2s color (248, 113, 113, 1) width 4.5 at [(118.0, 52.0), (138.0, 52.0)] ;
    text id 59 start 88.5s for 2.0s at (120.0, 43.0) ''[color=#F87171]Zone des réels $x$[/color]'' ;

    text id 60 start 106.5s for 2.5s at (6.0, 50.0) ''[color=#F8FAFC]En $2$ : $x \ge 2 \implies$ [color=#34D399][bold]2 est inclus[/bold][/color] (valeur autorisée).[/color]'' ;

    draw path id 1057 start 134.0s for 1.4s color (52, 211, 153, 1) width 3.0 at [(121.0, 48.0), (118.0, 48.0), (118.0, 56.0), (121.0, 56.0)] ;
    text id 61 start 138.0s for 2.0s at (104.0, 36.0) ''[color=#34D399]Crochet rentrant $[$[/color]'' ;

    text id 62 start 152.5s for 2.5s at (6.0, 60.0) ''[color=#F8FAFC]En $4$ : $x \le 4 \implies$ [color=#34D399][bold]4 est inclus[/bold][/color] (valeur autorisée).[/color]'' ;

    draw path id 1058 start 162.0s for 1.4s color (52, 211, 153, 1) width 3.0 at [(135.0, 48.0), (138.0, 48.0), (138.0, 56.0), (135.0, 56.0)] ;
    text id 63 start 165.0s for 2.0s at (136.0, 36.0) ''[color=#34D399]Crochet rentrant $]$[/color]'' ;

    text id 64 start 183.5s for 2.5s at (6.0, 72.0) ''[color=#F8FAFC]Notation d'intervalle :[/color]  [color=#38BDF8]$$\mathbf{x \in [2 ; 4]}$$[/color]'' ;
    text id 65 start 190.0s for 2.5s at (6.0, 83.0) ''[color=#94A3B8]Séparateur : [color=#FBBF24]point-virgule[/color] (pour ne pas confondre avec $2{,}4$).[/color]'' ;
    text id 66 start 202.5s for 2.5s at (6.0, 91.0) ''[color=#34D399][bold]Intervalle fermé :[/bold] les 2 bornes font partie de l'ensemble.[/color]'' ;

    erase id 4002 start 209.5s ;

    # =========================================================================
    # SCÈNE 3 : CAS 2 — INTERVALLE SEMI-OUVERT & BORNE EXCLUE (-1 < x <= 3)
    # =========================================================================
    text id 120 start 210.3s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]3. Cas 2 : Intervalle Semi-Ouvert & Borne Exclue[/bold][/color]'' ;
    draw line id 1120 start 212.3s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 121 start 213.5s for 2.2s at (6.0, 20.0) ''[color=#F8FAFC]Inégalité donnée :[/color]  [color=#FBBF24]$$-1 < x \le 3$$[/color]'' ;

    draw arrow id 1121 start 224.5s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 52.0), (168.0, 52.0)] ;
    text id 123 start 226.0s at (169.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 1122 start 226.5s color (248, 250, 252, 0.7) width 1.2 at [(108.0, 50.5), (108.0, 53.5)] ;
    text id 124 start 226.8s at (105.0, 57.0) ''[color=#38BDF8][bold]-1[/bold][/color]'' ;
    draw line id 1123 start 227.2s color (248, 250, 252, 0.7) width 1.2 at [(148.0, 50.5), (148.0, 53.5)] ;
    text id 125 start 227.5s at (146.5, 57.0) ''[color=#38BDF8][bold]3[/bold][/color]'' ;
    draw line id 1124 start 227.9s color (248, 250, 252, 0.5) width 1.0 at [(118.0, 50.5), (118.0, 53.5)] ;
    text id 126 start 228.2s at (117.0, 57.0) ''[color=#94A3B8]0[/color]'' ;

    text id 122 start 228.6s for 2.5s at (6.0, 31.0) ''[color=#F8FAFC]Lecture : [color=#38BDF8]$x$ strictement supérieur à $-1$ et $\le 3$[/color][/color]'' ;

    draw line id 1125 start 234.8s for 2.0s color (248, 113, 113, 1) width 4.5 at [(108.0, 52.0), (148.0, 52.0)] ;
    text id 127 start 237.2s for 1.8s at (118.0, 43.0) ''[color=#F87171]Zone autorisée pour $x$[/color]'' ;

    text id 128 start 247.5s for 2.8s at (6.0, 42.0) ''[color=#F8FAFC]En $-1$ : $x > -1$ (inégalité stricte) $\implies$ [color=#F87171][bold]-1 est exclu[/bold][/color].[/color]'' ;
    text id 129 start 254.0s for 2.5s at (6.0, 50.0) ''[color=#94A3B8]$x$ peut valoir $-0{,}9999$ mais jamais $-1$.[/color]'' ;

    draw path id 1126 start 271.2s for 1.4s color (248, 113, 113, 1) width 3.0 at [(105.0, 48.0), (108.0, 48.0), (108.0, 56.0), (105.0, 56.0)] ;
    text id 130 start 274.0s for 2.2s at (94.0, 36.0) ''[color=#F87171]Crochet sortant $]$[/color]'' ;

    text id 131 start 289.5s for 2.5s at (6.0, 60.0) ''[color=#F8FAFC]En $3$ : $x \le 3 \implies$ [color=#34D399][bold]3 est inclus[/bold][/color] (crochet rentrant).[/color]'' ;

    draw path id 1127 start 297.0s for 1.4s color (52, 211, 153, 1) width 3.0 at [(145.0, 48.0), (148.0, 48.0), (148.0, 56.0), (145.0, 56.0)] ;
    text id 132 start 300.0s for 2.0s at (140.0, 36.0) ''[color=#34D399]Crochet rentrant $[$[/color]'' ;

    text id 133 start 317.5s for 2.5s at (6.0, 72.0) ''[color=#F8FAFC]Notation d'intervalle :[/color]  [color=#38BDF8]$$\mathbf{x \in ]-1 ; 3]}$$[/color]'' ;
    text id 134 start 327.0s for 2.5s at (6.0, 83.0) ''[color=#34D399][bold]Intervalle semi-ouvert :[/bold] ouvert en $-1$, fermé en $3$.[/color]'' ;

    erase id 4003 start 331.0s ;

    # =========================================================================
    # SCÈNE 4 : CAS 3 — INTERVALLES NON BORNÉS VERS MOINS L'INFINI (]-inf ; 2[)
    # =========================================================================
    text id 190 start 331.5s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]4. Cas 3 : Intervalles Non Bornés vers $-\infty$[/bold][/color]'' ;
    draw line id 1190 start 333.5s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 191 start 343.5s for 2.2s at (6.0, 20.0) ''[color=#F8FAFC]Intervalle donné :[/color]  [color=#FBBF24]$$\mathbf{x \in ]-\infty ; 2[}$$[/color]'' ;
    text id 192 start 352.0s for 2.8s at (6.0, 31.0) ''[color=#F8FAFC]Sens de $-\infty$ : [color=#38BDF8]aucune limite à gauche[/color].[/color]'' ;
    text id 193 start 359.0s for 2.8s at (6.0, 39.0) ''[color=#94A3B8]$x$ peut être aussi petit que l'on veut ($-1000$, $-10^6$...).[/color]'' ;

    draw arrow id 1191 start 372.0s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 52.0), (168.0, 52.0)] ;
    text id 194 start 373.5s at (169.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 1192 start 374.0s color (248, 250, 252, 0.5) width 1.0 at [(100.0, 50.5), (100.0, 53.5)] ;
    text id 195 start 374.3s at (99.0, 57.0) ''[color=#94A3B8]0[/color]'' ;
    draw line id 1193 start 374.8s color (248, 250, 252, 0.5) width 1.0 at [(112.0, 50.5), (112.0, 53.5)] ;
    text id 196 start 375.1s at (111.0, 57.0) ''[color=#94A3B8]1[/color]'' ;
    draw line id 1194 start 375.6s for 0.6s color (56, 189, 248, 1) width 2.0 at [(124.0, 49.5), (124.0, 54.5)] ;
    text id 197 start 376.5s for 0.8s at (122.5, 57.0) ''[color=#38BDF8][bold]2[/bold][/color]'' ;

    draw line id 1195 start 377.5s for 2.5s color (248, 113, 113, 1) width 4.5 at [(94.0, 52.0), (124.0, 52.0)] ;
    text id 198 start 380.5s for 2.0s at (96.0, 65.0) ''[color=#F87171]Vient de $-\infty$ sans limite[/color]'' ;

    text id 199 start 395.0s for 2.8s at (6.0, 50.0) ''[color=#F8FAFC]À gauche : [color=#FBBF24]aucun crochet[/color] (l'infini n'est pas un réel).[/color]'' ;

    draw path id 1196 start 422.8s for 1.4s color (248, 113, 113, 1) width 3.0 at [(127.0, 48.0), (124.0, 48.0), (124.0, 56.0), (127.0, 56.0)] ;
    text id 200 start 425.0s for 2.0s at (122.0, 36.0) ''[color=#F87171]Crochet sortant $[$ ($2$ exclu)[/color]'' ;

    text id 201 start 442.2s for 2.5s at (6.0, 62.0) ''[color=#F8FAFC]Inégalité associée :[/color]  [color=#34D399]$$\mathbf{x < 2}$$[/color]'' ;

    text id 202 start 446.5s for 2.5s at (6.0, 75.0) ''[color=#F87171][bold]Piège classique d'examen :[/bold][/color]'' ;
    text id 203 start 450.5s for 2.5s at (6.0, 82.0) ''[color=#F87171]Ne JAMAIS écrire : « $-\infty < x < 2$ » ![/color]'' ;
    text id 204 start 457.0s for 2.8s at (6.0, 90.0) ''[color=#94A3B8]L'infini n'étant pas un réel, on laisse le côté gauche vide.[/color]'' ;

    erase id 4004 start 469.2s ;

    # =========================================================================
    # SCÈNE 5 : CAS 4 — INTERVALLES NON BORNÉS VERS PLUS L'INFINI ([1 ; +inf[)
    # =========================================================================
    text id 260 start 469.8s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]5. Cas 4 : Intervalles Non Bornés vers $+\infty$[/bold][/color]'' ;
    draw line id 1260 start 471.8s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    draw arrow id 1261 start 481.8s for 1.2s color (248, 250, 252, 0.95) width 2.0 at [(94.0, 52.0), (168.0, 52.0)] ;
    text id 261 start 483.2s at (169.0, 50.5) ''[color=#F8FAFC]$x$[/color]'' ;

    draw line id 1262 start 483.8s color (248, 250, 252, 0.5) width 1.0 at [(105.0, 50.5), (105.0, 53.5)] ;
    text id 262 start 484.1s at (104.0, 57.0) ''[color=#94A3B8]0[/color]'' ;
    draw line id 1263 start 484.8s for 0.6s color (56, 189, 248, 1) width 2.0 at [(118.0, 49.5), (118.0, 54.5)] ;
    text id 263 start 485.6s for 0.8s at (116.5, 57.0) ''[color=#38BDF8][bold]1[/bold][/color]'' ;

    draw line id 1264 start 487.0s for 2.5s color (248, 113, 113, 1) width 4.5 at [(118.0, 52.0), (168.0, 52.0)] ;
    text id 264 start 490.0s for 2.0s at (128.0, 65.0) ''[color=#F87171]Vers $+\infty$ sans interruption[/color]'' ;

    draw path id 1265 start 492.5s for 1.4s color (52, 211, 153, 1) width 3.0 at [(121.0, 48.0), (118.0, 48.0), (118.0, 56.0), (121.0, 56.0)] ;
    text id 265 start 494.5s for 2.0s at (106.0, 36.0) ''[color=#34D399]Crochet rentrant $[$[/color]'' ;

    text id 266 start 500.0s for 2.5s at (6.0, 22.0) ''[color=#F8FAFC]À droite : $x$ grandit sans borne $\implies$ [color=#38BDF8]$+\infty$[/color].[/color]'' ;
    text id 267 start 506.0s for 2.5s at (6.0, 32.0) ''[color=#94A3B8]L'infini n'étant jamais inclus, le crochet est [color=#F87171]ouvert : $[$[/color][/color]'' ;

    text id 268 start 518.0s for 2.5s at (6.0, 46.0) ''[color=#F8FAFC]Intervalle déduit :[/color]  [color=#38BDF8]$$\mathbf{x \in [1 ; +\infty[}$$[/color]'' ;

    text id 269 start 528.5s for 2.5s at (6.0, 62.0) ''[color=#F8FAFC]Inégalité associée :[/color]  [color=#34D399]$$\mathbf{x \ge 1}$$[/color]'' ;
    text id 270 start 534.5s for 2.5s at (6.0, 76.0) ''[color=#94A3B8]Aucune limite à droite $\implies$ rien à écrire à droite ![/color]'' ;
    text id 271 start 537.5s for 2.0s at (6.0, 85.0) ''[color=#FBBF24](On n'écrit jamais $x \le +\infty$)[/color]'' ;

    erase id 4005 start 540.2s ;

    # =========================================================================
    # SCÈNE 6 : SYNTHÈSE MÉTHODOLOGIQUE & RÉFLEXES POUR LE CONTRÔLE
    # =========================================================================
    text id 330 start 540.8s for 1.8s at (4.0, 7.5) ''[color=#38BDF8][bold]6. Synthèse Méthodologique & Réflexes pour le Contrôle[/bold][/color]'' ;
    draw line id 1330 start 542.8s for 0.8s color (56, 189, 248, 0.9) width 1.5 at [(4.0, 13.5), (173.0, 13.5)] ;

    text id 331 start 546.0s for 2.5s at (6.0, 20.0) ''[color=#FBBF24][bold]1. Encadrement borné (2 côtés) :[/bold][/color]'' ;
    text id 332 start 549.0s for 2.5s at (8.0, 28.0) ''[color=#F8FAFC]$a \le x \le b \iff x \in [a ; b]$[/color]'' ;

    text id 333 start 554.5s for 2.5s at (6.0, 40.0) ''[color=#38BDF8][bold]2. Inégalité simple (1 seul côté) :[/bold][/color]'' ;
    text id 334 start 557.5s for 2.8s at (8.0, 48.0) ''[color=#F8FAFC]$x \ge a \iff x \in [a ; +\infty[$  et  $x < b \iff x \in ]-\infty ; b[$[/color]'' ;

    text id 335 start 563.2s for 2.5s at (94.0, 20.0) ''[color=#34D399][bold]3. Règle d'or des crochets :[/bold][/color]'' ;
    text id 336 start 566.5s for 2.8s at (96.0, 28.0) ''[color=#F8FAFC]• Tourné vers l'intérieur : [color=#34D399]inclus ($\le, \ge$)[/color][/color]'' ;
    text id 337 start 575.5s for 2.8s at (96.0, 36.0) ''[color=#F8FAFC]• Tourné vers l'extérieur : [color=#F87171]exclu ($<, >$)[/color][/color]'' ;

    text id 338 start 582.5s for 2.8s at (94.0, 48.0) ''[color=#F87171][bold]4. Règle absolue des infinis :[/bold][/color]'' ;
    text id 339 start 586.0s for 2.8s at (96.0, 56.0) ''[color=#F8FAFC]$-\infty$ et $+\infty$ : [color=#F87171]crochet TOUJOURS ouvert[/color].[/color]'' ;
    text id 340 start 589.5s for 1.8s at (96.0, 64.0) ''[color=#94A3B8]Jamais d'infini dans une inégalité ![/color]'' ;

    draw polygone id 1331 start 591.5s for 1.0s color (56, 189, 248, 0.8) fillcolor (56, 189, 248, 0.15) width 1.5 at [(15.0, 75.0), (162.0, 75.0), (162.0, 94.0), (15.0, 94.0)] ;
    text id 341 start 593.0s for 2.5s at (20.0, 80.0) ''[color=#FBBF24][bold]Le réflexe gagnant :[/bold]  Inégalité  $\boldsymbol{\longleftrightarrow}$  Axe gradué  $\boldsymbol{\longleftrightarrow}$  Intervalle[/color]'' ;
    text id 342 start 596.5s for 2.5s at (24.0, 87.0) ''[color=#F8FAFC]En dessinant toujours l'axe au brouillon, aucune erreur de crochet n'est possible ![/color]'' ;

}
