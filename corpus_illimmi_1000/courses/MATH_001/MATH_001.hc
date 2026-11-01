course "Intervalles et encadrements de réels — Cours fondamental" id 1 idgap 1000 for 1017.97s audio "narration.wav" {

    # =========================================================================
    # SCÈNE 1 : INTRODUCTION ET DÉFINITION GÉOMÉTRIQUE D'UN INTERVALLE
    # =========================================================================

    text id 10 start 0.5s at (4.0, 7.5) ''[bold][color=#38BDF8]1. Introduction & Définition Géométrique d'un Intervalle[/color][/bold]'' ;
    draw line id 1010 start 1.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Notions & encadrement algébrique
    text id 11 start 25.0s for 4.8s at (4.0, 18.0) ''[color=#F8FAFC]Ensemble des nombres réels : $\mathbb{R}$ (droite continue)[/color]'' ;
    text id 12 start 45.5s for 3.8s at (4.0, 28.0) ''[color=#FBBF24][bold]Encadrement étudié :[/bold] $2 \le x \le 4$[/color]'' ;
    text id 13 start 53.0s for 5.1s at (4.0, 37.0) ''[color=#94A3B8]Exemples : $3$, $3{,}5$, $2{,}85$, $3{,}999$... (infinité de valeurs)[/color]'' ;
    text id 14 start 74.5s for 5.2s at (4.0, 48.0) ''[color=#34D399][bold]Définition :[/bold] Intervalle = sous-ensemble continu de $\mathbb{R}$.[/color]'' ;
    text id 15 start 122.0s for 3.8s at (4.0, 58.0) ''[color=#F8FAFC]Extrémités (ou bornes) : $2$ et $4$[/color]'' ;
    text id 16 start 136.0s for 4.3s at (4.0, 67.0) ''[color=#38BDF8]$x \ge 2$ et $x \le 4 \implies$ les bornes sont [bold]incluses[/bold][/color]'' ;
    text id 17 start 196.5s for 2.8s at (4.0, 78.0) ''[color=#34D399][bold]Notation :[/bold] $[2 ; 4]$ (intervalle fermé)[/color]'' ;
    text id 18 start 208.0s for 3.8s at (4.0, 87.0) ''[color=#C084FC]Inégalité : $2 \le x \le 4 \iff x \in [2 ; 4]$[/color]'' ;

    # Colonne droite : Axe gradué et représentation géométrique
    draw arrow id 1011 start 80.6s for 1.2s color (248, 250, 252, 0.9) width 1.5 at [(96.0, 50.0), (170.0, 50.0)] ;
    draw line id 1012 start 84.0s color (248, 250, 252, 0.7) width 1.2 at [(100.0, 48.0), (100.0, 52.0)] ;
    draw line id 1013 start 84.5s color (248, 250, 252, 0.7) width 1.2 at [(110.0, 48.0), (110.0, 52.0)] ;
    draw line id 1014 start 85.0s color (248, 250, 252, 0.7) width 1.2 at [(120.0, 48.0), (120.0, 52.0)] ;
    draw line id 1015 start 85.5s color (248, 250, 252, 0.7) width 1.2 at [(130.0, 48.0), (130.0, 52.0)] ;
    draw line id 1016 start 86.0s color (248, 250, 252, 0.7) width 1.2 at [(140.0, 48.0), (140.0, 52.0)] ;
    draw line id 1017 start 86.5s color (248, 250, 252, 0.7) width 1.2 at [(150.0, 48.0), (150.0, 52.0)] ;
    draw line id 1018 start 87.0s color (248, 250, 252, 0.7) width 1.2 at [(160.0, 48.0), (160.0, 52.0)] ;

    text id 20 start 87.5s at (98.0, 56.0) ''$-1$'' ;
    text id 21 start 88.0s at (108.5, 56.0) ''$0$'' ;
    text id 22 start 88.5s at (118.5, 56.0) ''$1$'' ;
    text id 23 start 89.0s at (128.5, 56.0) ''$2$'' ;
    text id 24 start 89.5s at (138.5, 56.0) ''$3$'' ;
    text id 25 start 90.0s at (148.5, 56.0) ''$4$'' ;
    text id 26 start 90.5s at (158.5, 56.0) ''$5$'' ;
    text id 27 start 91.0s for 1.8s at (168.0, 45.0) ''$\mathbb{R}$'' ;

    # Zone colorée [2 ; 4]
    draw line id 1020 start 109.7s for 1.2s color (251, 191, 36, 1) width 5.0 at [(130.0, 50.0), (150.0, 50.0)] ;
    text id 28 start 113.0s at (132.0, 40.0) ''[color=#FBBF24][bold]Zone $[2 ; 4]$[/bold][/color]'' ;

    # Crochets fermés tournés vers l'intérieur
    draw path id 1021 start 159.4s color (56, 189, 248, 1) width 3.0 at [(132.5, 45.0), (130.0, 45.0), (130.0, 55.0), (132.5, 55.0)] ;
    mouse move id 3010 start 160.0s for 1.0s at [(130.0, 62.0), (130.0, 52.0)] ;
    draw path id 1022 start 174.8s color (56, 189, 248, 1) width 3.0 at [(147.5, 45.0), (150.0, 45.0), (150.0, 55.0), (147.5, 55.0)] ;
    mouse move id 3011 start 175.5s for 1.0s at [(150.0, 62.0), (150.0, 52.0)] ;
    text id 29 start 185.0s for 3.7s at (98.0, 72.0) ''[color=#38BDF8]Crochets vers l'intérieur : bornes $2$ et $4$ incluses[/color]'' ;

    erase id 4001 start 224.5s ;

    # =========================================================================
    # SCÈNE 2 : APPARTENANCE ET EXCLUSION D'UNE BORNE
    # =========================================================================

    text id 110 start 226.0s at (4.0, 7.5) ''[bold][color=#38BDF8]2. Appartenance ($\in$) & Exclusion d'une Borne[/color][/bold]'' ;
    draw line id 1110 start 227.0s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche
    text id 111 start 238.7s for 3.9s at (4.0, 20.0) ''[color=#34D399][bold]Appartenance :[/bold] $3 \in [2 ; 4]$ ($3$ est dans l'intervalle)[/color]'' ;
    text id 112 start 246.0s for 3.8s at (4.0, 29.0) ''[color=#34D399]$2 \in [2 ; 4]$ et $4 \in [2 ; 4]$ (bornes incluses)[/color]'' ;
    text id 113 start 257.7s for 3.9s at (4.0, 38.0) ''[color=#F87171][bold]Non-appartenance :[/bold] $5 \notin [2 ; 4]$ ($5$ est à l'extérieur)[/color]'' ;
    text id 114 start 280.3s for 3.8s at (4.0, 50.0) ''[color=#FBBF24][bold]Borne exclue :[/bold] Encadrement $0 < x \le 1$[/color]'' ;
    text id 115 start 294.2s for 4.6s at (4.0, 59.0) ''[color=#94A3B8]$0{,}1 \in I$, $0{,}01 \in I$, mais $0$ est [bold]strictement exclu[/bold][/color]'' ;
    text id 116 start 314.5s at (4.0, 69.0) ''[color=#F8FAFC]Borne $1$ incluse ($x \le 1$) | Borne $0$ exclue ($x > 0$)[/color]'' ;
    text id 117 start 348.6s for 3.8s at (4.0, 79.0) ''[color=#34D399][bold]Notation :[/bold] $]0 ; 1]$ (intervalle semi-ouvert)[/color]'' ;
    text id 118 start 366.2s for 3.4s at (4.0, 88.0) ''[color=#38BDF8]Crochet vers l'extérieur en $0$ car $0 \notin ]0 ; 1]$[/color]'' ;

    # Colonne droite : Axe gradué semi-ouvert
    draw arrow id 1111 start 307.0s color (248, 250, 252, 0.9) width 1.5 at [(96.0, 50.0), (170.0, 50.0)] ;
    draw line id 1112 start 308.0s color (248, 250, 252, 0.7) width 1.2 at [(102.0, 48.0), (102.0, 52.0)] ;
    draw line id 1113 start 308.4s color (248, 250, 252, 0.7) width 1.2 at [(120.0, 48.0), (120.0, 52.0)] ;
    draw line id 1114 start 308.8s color (248, 250, 252, 0.7) width 1.2 at [(138.0, 48.0), (138.0, 52.0)] ;
    draw line id 1115 start 309.2s color (248, 250, 252, 0.7) width 1.2 at [(156.0, 48.0), (156.0, 52.0)] ;

    text id 120 start 309.5s at (100.0, 56.0) ''$-1$'' ;
    text id 121 start 310.0s at (118.5, 56.0) ''$0$'' ;
    text id 122 start 310.5s at (136.5, 56.0) ''$1$'' ;
    text id 123 start 311.0s at (154.5, 56.0) ''$2$'' ;

    # Zone colorée ]0 ; 1]
    draw line id 1116 start 311.5s for 1.0s color (52, 211, 153, 1) width 5.0 at [(120.0, 50.0), (138.0, 50.0)] ;
    draw path id 1117 start 315.0s for 0.8s color (52, 211, 153, 1) width 3.0 at [(135.5, 45.0), (138.0, 45.0), (138.0, 55.0), (135.5, 55.0)] ;
    text id 124 start 318.0s for 1.8s at (139.0, 40.0) ''[color=#34D399]$1$ inclus[/color]'' ;

    # Crochet ouvert en 0 tourné vers la gauche (extérieur)
    draw path id 1118 start 340.2s color (248, 113, 113, 1) width 3.0 at [(117.5, 45.0), (120.0, 45.0), (120.0, 55.0), (117.5, 55.0)] ;
    mouse move id 3110 start 341.0s for 1.0s at [(120.0, 62.0), (120.0, 52.0)] ;
    text id 125 start 343.0s for 1.8s at (106.0, 40.0) ''[color=#F87171]$0$ exclu[/color]'' ;

    # Cartouche règle d'or
    draw line id 1119 start 355.0s color (56, 189, 248, 0.4) width 1.0 at [(96.0, 72.0), (168.0, 72.0)] ;
    text id 126 start 356.0s for 1.7s at (98.0, 76.0) ''[color=#FBBF24][bold]Règle d'or des crochets :[/bold][/color]'' ;
    text id 127 start 358.0s for 1.8s at (98.0, 83.0) ''[color=#F8FAFC]Tourné vers l'ensemble : borne [bold]incluse[/bold] ($\le$ ou $\ge$)[/color]'' ;
    text id 128 start 360.0s for 3.5s at (98.0, 89.0) ''[color=#F8FAFC]Tourné vers l'extérieur : borne [bold]exclue[/bold] ($<$ ou $>$)[/color]'' ;

    erase id 4002 start 377.0s ;

    # =========================================================================
    # SCÈNE 3 : INTERVALLES NON BORNÉS ET NOTION D'INFINI
    # =========================================================================

    text id 210 start 379.0s at (4.0, 7.5) ''[bold][color=#38BDF8]3. Intervalles Non Bornés & Notion d'Infini ($+\infty$, $-\infty$)[/color][/bold]'' ;
    draw line id 1210 start 380.0s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche
    text id 211 start 385.4s for 3.8s at (4.0, 18.0) ''[color=#FBBF24][bold]Inégalité :[/bold] $x > 3$ (strictement supérieur à $3$)[/color]'' ;
    text id 212 start 395.0s for 3.8s at (4.0, 27.0) ''[color=#94A3B8]Valeurs : $3{,}1$, $4$, $10$, $1\,000$, $10^6$... sans fin ![/color]'' ;
    text id 213 start 463.4s for 4.5s at (4.0, 38.0) ''[color=#38BDF8]Symbole infini : $\infty$ (huit couché) $\implies +\infty$[/color]'' ;
    text id 214 start 503.4s for 3.7s at (4.0, 48.0) ''[color=#F87171][bold]Règle fondamentale :[/bold] $\pm\infty$ n'est pas un nombre réel.[/color]'' ;
    text id 215 start 508.0s for 4.4s at (4.0, 56.0) ''[color=#F8FAFC]On ne peut jamais l'atteindre $\implies$ [bold]crochet toujours ouvert ![/bold][/color]'' ;
    text id 216 start 514.4s for 3.8s at (4.0, 65.0) ''[color=#34D399][bold]Notation :[/bold] $x > 3 \iff x \in \, ]3 ; +\infty[$[/color]'' ;
    text id 217 start 523.0s for 3.5s at (4.0, 76.0) ''[color=#FBBF24][bold]Vers moins l'infini :[/bold] $x < -1 \iff x \in \, ]-\infty ; -1[$[/color]'' ;
    text id 218 start 549.9s for 3.8s at (4.0, 86.0) ''[color=#C084FC]Borne $-1$ exclue (crochet ouvert vers la droite)[/color]'' ;

    # Colonne droite : Demi-droite 1 vers +infini
    text id 220 start 421.0s at (96.0, 18.0) ''[color=#38BDF8]Demi-droite $x > 3$ vers $+\infty$[/color]'' ;
    draw arrow id 1211 start 421.5s for 1.0s color (248, 250, 252, 0.9) width 1.5 at [(96.0, 32.0), (170.0, 32.0)] ;
    draw line id 1212 start 423.0s color (248, 250, 252, 0.6) width 1.2 at [(106.0, 30.0), (106.0, 34.0)] ;
    draw line id 1213 start 423.3s color (248, 250, 252, 0.6) width 1.2 at [(118.0, 30.0), (118.0, 34.0)] ;
    draw line id 1214 start 423.6s color (248, 250, 252, 0.6) width 1.2 at [(130.0, 30.0), (130.0, 34.0)] ;
    draw line id 1215 start 423.9s color (248, 250, 252, 0.6) width 1.2 at [(142.0, 30.0), (142.0, 34.0)] ;
    draw line id 1216 start 424.2s color (248, 250, 252, 0.6) width 1.2 at [(154.0, 30.0), (154.0, 34.0)] ;

    text id 221 start 424.5s at (104.5, 38.0) ''$1$'' ;
    text id 222 start 424.8s at (116.5, 38.0) ''$2$'' ;
    text id 223 start 425.1s at (128.5, 38.0) ''$3$'' ;
    text id 224 start 425.4s at (140.5, 38.0) ''$4$'' ;
    text id 225 start 425.7s at (152.5, 38.0) ''$5$'' ;
    text id 226 start 426.0s for 1.2s at (166.0, 26.0) ''$+\infty$'' ;

    draw path id 1217 start 427.4s for 0.8s color (248, 113, 113, 1) width 3.0 at [(127.5, 27.0), (130.0, 27.0), (130.0, 37.0), (127.5, 37.0)] ;
    draw arrow id 1218 start 434.4s color (251, 191, 36, 1) width 4.5 at [(130.0, 32.0), (169.0, 32.0)] ;
    mouse move id 3210 start 435.0s for 1.2s at [(130.0, 32.0), (165.0, 32.0)] ;

    # Colonne droite : Demi-droite 2 vers -infini
    text id 227 start 538.0s for 1.1s at (96.0, 56.0) ''[color=#38BDF8]Demi-droite $x < -1$ depuis $-\infty$[/color]'' ;
    draw arrow id 1219 start 539.3s color (248, 250, 252, 0.9) width 1.5 at [(96.0, 70.0), (170.0, 70.0)] ;
    draw line id 1220 start 540.0s color (248, 250, 252, 0.6) width 1.2 at [(112.0, 68.0), (112.0, 72.0)] ;
    draw line id 1221 start 540.3s color (248, 250, 252, 0.6) width 1.2 at [(124.0, 68.0), (124.0, 72.0)] ;
    draw line id 1222 start 540.6s color (248, 250, 252, 0.6) width 1.2 at [(136.0, 68.0), (136.0, 72.0)] ;
    draw line id 1223 start 540.9s color (248, 250, 252, 0.6) width 1.2 at [(148.0, 68.0), (148.0, 72.0)] ;
    draw line id 1224 start 541.2s color (248, 250, 252, 0.6) width 1.2 at [(160.0, 68.0), (160.0, 72.0)] ;

    text id 228 start 541.5s at (109.5, 76.0) ''$-3$'' ;
    text id 229 start 541.8s at (121.5, 76.0) ''$-2$'' ;
    text id 230 start 542.1s at (133.5, 76.0) ''$-1$'' ;
    text id 231 start 542.4s at (146.5, 76.0) ''$0$'' ;
    text id 232 start 542.7s at (158.5, 76.0) ''$1$'' ;
    text id 233 start 543.0s at (92.0, 76.0) ''$-\infty$'' ;

    draw line id 1225 start 544.0s for 1.0s color (52, 211, 153, 1) width 4.5 at [(97.0, 70.0), (136.0, 70.0)] ;
    draw path id 1226 start 546.0s color (248, 113, 113, 1) width 3.0 at [(138.5, 65.0), (136.0, 65.0), (136.0, 75.0), (138.5, 75.0)] ;
    mouse move id 3211 start 547.0s for 1.0s at [(136.0, 82.0), (136.0, 72.0)] ;

    erase id 4003 start 554.0s ;

    # =========================================================================
    # SCÈNE 4 : CLASSIFICATION : INTERVALLES FERMÉS ET OUVERTS
    # =========================================================================

    text id 310 start 555.5s at (4.0, 7.5) ''[bold][color=#38BDF8]4. Classification : Intervalles Fermés & Ouverts[/color][/bold]'' ;
    draw line id 1310 start 556.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche
    text id 311 start 559.7s for 2.1s at (4.0, 19.0) ''[color=#34D399][bold]Intervalle Fermé :[/bold][/color]'' ;
    text id 312 start 562.0s for 2.8s at (4.0, 26.0) ''[color=#F8FAFC]Toutes ses bornes appartiennent à l'intervalle.[/color]'' ;
    text id 313 start 567.2s at (4.0, 33.0) ''[color=#94A3B8]Exemples : $[2 ; 4]$, $[-3 ; 5]$. Crochets tournés vers l'intérieur.[/color]'' ;

    text id 314 start 586.6s for 2.2s at (4.0, 44.0) ''[color=#F87171][bold]Intervalle Ouvert :[/bold][/color]'' ;
    text id 315 start 589.0s for 3.4s at (4.0, 51.0) ''[color=#F8FAFC]Aucune de ses bornes n'appartient à l'intervalle.[/color]'' ;
    text id 316 start 592.7s for 1.1s at (4.0, 58.0) ''[color=#94A3B8]Exemples : $]0 ; 1[$, $]3 ; +\infty[$, $]-\infty ; 6[$.[/color]'' ;

    text id 317 start 615.1s for 4.1s at (4.0, 68.0) ''[color=#FBBF24][bold]Intervalle Semi-ouvert :[/bold] Ouvert d'un côté, fermé de l'autre.[/color]'' ;
    text id 318 start 620.0s for 4.6s at (4.0, 75.0) ''[color=#94A3B8]Exemples : $]0 ; 1]$ (ouvert en $0$, fermé en $1$), $[-2 ; 7[$.[/color]'' ;

    text id 319 start 629.3s for 5.5s at (4.0, 85.0) ''[color=#C084FC][bold]Cas remarquable :[/bold] $\mathbb{R} = ]-\infty ; +\infty[$ (intervalle ouvert !)[/color]'' ;

    # Colonne droite : Tableau comparatif graphique
    draw polygone id 1311 start 565.0s color (56, 189, 248, 0.4) width 1.2 fillcolor (30, 41, 59, 0.25) at [(94.0, 16.0), (172.0, 16.0), (172.0, 92.0), (94.0, 92.0)] ;
    draw line id 1312 start 566.0s color (56, 189, 248, 0.3) width 1.0 at [(94.0, 55.0), (172.0, 55.0)] ;

    # Bloc fermé
    text id 320 start 568.0s for 1.8s at (98.0, 21.0) ''[color=#34D399][bold]INTERVALLE FERMÉ $[a ; b]$[/bold][/color]'' ;
    draw line id 1313 start 570.0s color (248, 250, 252, 0.7) width 1.5 at [(102.0, 31.0), (164.0, 31.0)] ;
    draw line id 1314 start 571.0s color (52, 211, 153, 1) width 4.5 at [(118.0, 31.0), (148.0, 31.0)] ;
    draw path id 1315 start 572.0s color (52, 211, 153, 1) width 2.5 at [(120.0, 26.0), (118.0, 26.0), (118.0, 36.0), (120.0, 36.0)] ;
    draw path id 1316 start 573.0s color (52, 211, 153, 1) width 2.5 at [(146.0, 26.0), (148.0, 26.0), (148.0, 36.0), (146.0, 36.0)] ;
    text id 321 start 574.0s at (117.0, 39.0) ''$a$'' ;
    text id 322 start 574.5s at (147.0, 39.0) ''$b$'' ;
    text id 323 start 576.0s for 3.8s at (98.0, 47.0) ''[color=#34D399]Inégalités larges : $a \le x \le b$[/color]'' ;

    # Bloc ouvert
    text id 324 start 594.0s for 1.8s at (98.0, 58.0) ''[color=#F87171][bold]INTERVALLE OUVERT $]a ; b[$[/bold][/color]'' ;
    draw line id 1317 start 596.0s color (248, 250, 252, 0.7) width 1.5 at [(102.0, 68.0), (164.0, 68.0)] ;
    draw line id 1318 start 597.0s color (248, 113, 113, 1) width 4.5 at [(118.0, 68.0), (148.0, 68.0)] ;
    draw path id 1319 start 598.0s color (248, 113, 113, 1) width 2.5 at [(116.0, 63.0), (118.0, 63.0), (118.0, 73.0), (116.0, 73.0)] ;
    draw path id 1320 start 599.0s color (248, 113, 113, 1) width 2.5 at [(150.0, 63.0), (148.0, 63.0), (148.0, 73.0), (150.0, 73.0)] ;
    text id 325 start 600.0s at (117.0, 75.0) ''$a$'' ;
    text id 326 start 600.5s at (147.0, 75.0) ''$b$'' ;
    text id 327 start 602.0s for 3.8s at (98.0, 83.0) ''[color=#F87171]Inégalités strictes : $a < x < b$[/color]'' ;

    erase id 4004 start 644.5s ;

    # =========================================================================
    # SCÈNE 5 : INTERSECTION ET RÉUNION D'ENSEMBLES (VENN)
    # =========================================================================

    text id 410 start 646.5s at (4.0, 7.5) ''[bold][color=#38BDF8]5. Intersection ($\cap$) & Réunion ($\cup$) d'Ensembles[/color][/bold]'' ;
    draw line id 1410 start 647.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche
    text id 411 start 698.7s for 2.0s at (4.0, 20.0) ''[color=#38BDF8][bold]1. L'Intersection : $A \cap B$[/bold][/color]'' ;
    text id 412 start 703.8s for 3.8s at (4.0, 29.0) ''[color=#F8FAFC]Éléments appartenant à $A$ [bold][color=#38BDF8]ET[/color][/bold] à $B$ en même temps.[/color]'' ;
    text id 413 start 712.6s for 4.2s at (4.0, 38.0) ''[color=#38BDF8]Symbole : $\cap$ (pont / U inversé). Se lit « A inter B ».[/color]'' ;
    text id 414 start 717.0s for 4.2s at (4.0, 47.0) ''[color=#94A3B8]$x \in (A \cap B) \iff (x \in A \text{ et } x \in B)$[/color]'' ;

    text id 415 start 726.2s for 2.8s at (4.0, 58.0) ''[color=#FBBF24][bold]2. La Réunion : $A \cup B$[/bold][/color]'' ;
    text id 416 start 734.6s for 3.8s at (4.0, 67.0) ''[color=#F8FAFC]Éléments appartenant à $A$ [bold][color=#FBBF24]OU[/color][/bold] à $B$ (ou aux deux).[/color]'' ;
    text id 417 start 747.7s for 2.1s at (4.0, 76.0) ''[color=#FBBF24]Symbole : $\cup$ (U pour Union). Se lit « A union B ».[/color]'' ;
    text id 418 start 752.0s for 4.2s at (4.0, 85.0) ''[color=#94A3B8]$x \in (A \cup B) \iff (x \in A \text{ ou } x \in B)$[/color]'' ;

    # Colonne droite : Diagramme de Venn
    text id 420 start 661.5s for 1.3s at (98.0, 18.0) ''[color=#F8FAFC]Diagramme de Venn : Ensembles $A$ et $B$[/color]'' ;
    draw circle id 1411 start 663.0s for 1.2s color (56, 189, 248, 1) width 2.5 fillcolor (56, 189, 248, 0.15) radius 22.0 at (122.0, 50.0) ;
    text id 421 start 665.0s for 1.8s at (108.0, 37.0) ''[color=#38BDF8][bold]Ensemble $A$[/bold][/color]'' ;

    draw circle id 1412 start 668.0s for 1.2s color (52, 211, 153, 1) width 2.5 fillcolor (52, 211, 153, 0.15) radius 22.0 at (146.0, 50.0) ;
    text id 422 start 670.0s for 1.8s at (140.0, 37.0) ''[color=#34D399][bold]Ensemble $B$[/bold][/color]'' ;

    text id 423 start 675.2s at (112.0, 46.0) ''[color=#38BDF8]$\bullet \, \bullet$[/color]'' ;
    text id 424 start 676.0s for 1.8s at (114.0, 54.0) ''[color=#38BDF8]$\bullet \, \bullet$[/color]'' ;
    text id 425 start 678.0s at (150.0, 46.0) ''[color=#34D399]$\bullet \, \bullet$[/color]'' ;
    text id 426 start 679.0s for 2.8s at (152.0, 54.0) ''[color=#34D399]$\bullet \, \bullet$[/color]'' ;
    text id 427 start 689.0s for 2.8s at (132.5, 48.0) ''[color=#FBBF24][bold]$\bullet \, \bullet \, \bullet$[/bold][/color]'' ;

    draw line id 1413 start 722.1s color (251, 191, 36, 0.9) width 1.5 at [(130.0, 42.0), (138.0, 42.0)] ;
    draw line id 1414 start 722.5s color (251, 191, 36, 0.9) width 1.5 at [(128.0, 50.0), (140.0, 50.0)] ;
    draw line id 1415 start 723.0s color (251, 191, 36, 0.9) width 1.5 at [(130.0, 58.0), (138.0, 58.0)] ;

    draw arrow id 1416 start 723.5s color (251, 191, 36, 1) width 2.0 at [(134.0, 72.0), (134.0, 60.0)] ;
    text id 428 start 724.0s for 2.0s at (118.0, 76.0) ''[color=#FBBF24][bold]Intersection $A \cap B$ (ET)[/bold][/color]'' ;
    text id 429 start 750.0s for 1.8s at (96.0, 86.0) ''[color=#F8FAFC]Réunion $A \cup B$ : totalité des zones réunies (OU)[/color]'' ;

    erase id 4005 start 758.5s ;

    # =========================================================================
    # SCÈNE 6 : APPLICATION CONCRÈTE SUR UN AXE : A = [-3 ; 4] ET B = [2 ; 5]
    # =========================================================================

    text id 510 start 760.5s at (4.0, 7.5) ''[bold][color=#38BDF8]6. Exemple Concret : $A = [-3 ; 4]$ et $B = [2 ; 5]$ sur un Axe[/color][/bold]'' ;
    draw line id 1510 start 761.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche
    text id 511 start 766.1s for 3.8s at (4.0, 18.0) ''[color=#F87171][bold]Intervalle A :[/bold] $A = [-3 ; 4]$ (tracé en rouge)[/color]'' ;
    text id 512 start 772.0s for 3.8s at (4.0, 26.0) ''[color=#34D399][bold]Intervalle B :[/bold] $B = [2 ; 5]$ (tracé en vert)[/color]'' ;
    text id 513 start 787.9s for 4.7s at (4.0, 35.0) ''[color=#38BDF8][bold]Méthode :[/bold] Superposer les couleurs sur la droite graduée.[/color]'' ;

    text id 514 start 840.7s for 2.8s at (4.0, 45.0) ''[color=#FBBF24][bold]Intersection $A \cap B$ (ET) :[/bold][/color]'' ;
    text id 515 start 844.0s for 4.3s at (4.0, 52.0) ''[color=#F8FAFC]Zone où les deux couleurs se superposent : de $2$ à $4$.[/color]'' ;
    text id 516 start 867.2s for 5.5s at (4.0, 59.0) ''[color=#94A3B8]Vérification des bornes : $2 \in A$ et $2 \in B$ ; $4 \in A$ et $4 \in B$.[/color]'' ;
    text id 517 start 898.0s for 2.8s at (4.0, 66.0) ''[color=#34D399][bold]Résultat :[/bold] $A \cap B = [2 ; 4]$[/color]'' ;

    text id 518 start 902.0s for 2.8s at (4.0, 75.0) ''[color=#C084FC][bold]Réunion $A \cup B$ (OU) :[/bold][/color]'' ;
    text id 519 start 905.0s for 4.7s at (4.0, 82.0) ''[color=#F8FAFC]Toute la zone couverte (au moins 1 couleur) : de $-3$ à $5$.[/color]'' ;
    text id 520 start 936.8s for 2.8s at (4.0, 89.0) ''[color=#34D399][bold]Résultat :[/bold] $A \cup B = [-3 ; 5]$[/color]'' ;

    # Colonne droite : Axe gradué et tracé bicolore
    draw arrow id 1511 start 802.9s color (248, 250, 252, 0.9) width 1.5 at [(94.0, 48.0), (172.0, 48.0)] ;

    draw line id 1512 start 804.0s color (248, 250, 252, 0.6) width 1.0 at [(96.0, 46.5), (96.0, 49.5)] ;
    draw line id 1513 start 804.2s color (248, 250, 252, 0.6) width 1.0 at [(103.0, 46.5), (103.0, 49.5)] ;
    draw line id 1514 start 804.4s color (248, 250, 252, 0.6) width 1.0 at [(110.0, 46.5), (110.0, 49.5)] ;
    draw line id 1515 start 804.6s color (248, 250, 252, 0.6) width 1.0 at [(117.0, 46.5), (117.0, 49.5)] ;
    draw line id 1516 start 804.8s color (248, 250, 252, 0.6) width 1.0 at [(124.0, 46.5), (124.0, 49.5)] ;
    draw line id 1517 start 805.0s color (248, 250, 252, 0.6) width 1.0 at [(131.0, 46.5), (131.0, 49.5)] ;
    draw line id 1518 start 805.2s color (248, 250, 252, 0.6) width 1.0 at [(138.0, 46.5), (138.0, 49.5)] ;
    draw line id 1519 start 805.4s color (248, 250, 252, 0.6) width 1.0 at [(145.0, 46.5), (145.0, 49.5)] ;
    draw line id 1520 start 805.6s color (248, 250, 252, 0.6) width 1.0 at [(152.0, 46.5), (152.0, 49.5)] ;
    draw line id 1521 start 805.8s color (248, 250, 252, 0.6) width 1.0 at [(159.0, 46.5), (159.0, 49.5)] ;
    draw line id 1522 start 806.0s color (248, 250, 252, 0.6) width 1.0 at [(166.0, 46.5), (166.0, 49.5)] ;

    text id 521 start 806.2s at (101.5, 53.0) ''$-3$'' ;
    text id 522 start 806.5s at (122.5, 53.0) ''$0$'' ;
    text id 523 start 806.8s at (136.5, 53.0) ''$2$'' ;
    text id 524 start 807.1s at (150.5, 53.0) ''$4$'' ;
    text id 525 start 807.4s at (157.5, 53.0) ''$5$'' ;

    # Intervalle A en rouge
    draw line id 1523 start 808.0s for 1.2s color (248, 113, 113, 1) width 4.5 at [(103.0, 48.0), (152.0, 48.0)] ;
    draw path id 1524 start 812.0s color (248, 113, 113, 1) width 2.5 at [(105.0, 44.0), (103.0, 44.0), (103.0, 52.0), (105.0, 52.0)] ;
    draw path id 1525 start 815.0s color (248, 113, 113, 1) width 2.5 at [(150.0, 44.0), (152.0, 44.0), (152.0, 52.0), (150.0, 52.0)] ;
    text id 526 start 817.0s for 1.8s at (104.0, 39.0) ''[color=#F87171][bold]$A = [-3 ; 4]$[/bold][/color]'' ;

    # Intervalle B en vert au-dessus
    draw line id 1526 start 821.3s for 1.2s color (52, 211, 153, 1) width 4.5 at [(138.0, 32.0), (159.0, 32.0)] ;
    draw path id 1527 start 825.0s color (52, 211, 153, 1) width 2.5 at [(140.0, 28.0), (138.0, 28.0), (138.0, 36.0), (140.0, 36.0)] ;
    draw path id 1528 start 828.0s color (52, 211, 153, 1) width 2.5 at [(157.0, 28.0), (159.0, 28.0), (159.0, 36.0), (157.0, 36.0)] ;
    text id 527 start 832.0s at (142.0, 24.0) ''[color=#34D399][bold]$B = [2 ; 5]$[/bold][/color]'' ;

    # Zone commune [2 ; 4]
    draw polygone id 1529 start 856.2s color (251, 191, 36, 0.8) width 1.5 fillcolor (251, 191, 36, 0.18) at [(138.0, 28.0), (152.0, 28.0), (152.0, 52.0), (138.0, 52.0)] ;
    mouse move id 3510 start 857.0s for 1.2s at [(138.0, 40.0), (152.0, 40.0)] ;
    draw arrow id 1530 start 858.5s for 0.8s color (251, 191, 36, 1) width 2.0 at [(145.0, 68.0), (145.0, 56.0)] ;
    text id 528 start 860.0s for 2.8s at (122.0, 72.0) ''[color=#FBBF24][bold]Zone commune : $A \cap B = [2 ; 4]$[/bold][/color]'' ;

    # Segment total réunion [-3 ; 5]
    draw line id 1531 start 917.4s for 1.2s color (192, 132, 252, 1) width 3.5 at [(103.0, 82.0), (159.0, 82.0)] ;
    draw path id 1532 start 922.0s color (192, 132, 252, 1) width 2.5 at [(105.0, 78.0), (103.0, 78.0), (103.0, 86.0), (105.0, 86.0)] ;
    draw path id 1533 start 925.0s color (192, 132, 252, 1) width 2.5 at [(157.0, 78.0), (159.0, 78.0), (159.0, 86.0), (157.0, 86.0)] ;
    text id 529 start 928.0s for 3.8s at (114.0, 89.0) ''[color=#C084FC][bold]Couverture totale : $A \cup B = [-3 ; 5]$[/bold][/color]'' ;

    erase id 4006 start 944.5s ;

    # =========================================================================
    # SCÈNE 7 : SYNTHÈSE ET RÉFLEXES DE CONTRÔLE
    # =========================================================================

    text id 610 start 946.5s at (4.0, 7.5) ''[bold][color=#38BDF8]7. Synthèse & Réflexes Infaillibles pour le Contrôle[/color][/bold]'' ;
    draw line id 1610 start 947.5s for 0.8s color (56, 189, 248, 0.6) width 1.2 at [(4.0, 12.0), (173.0, 12.0)] ;

    # Colonne gauche : Réflexes
    text id 611 start 953.2s for 2.6s at (4.0, 20.0) ''[color=#34D399][bold]1. Sens des crochets :[/bold][/color]'' ;
    text id 612 start 956.0s for 1.8s at (4.0, 27.0) ''[color=#F8FAFC]Tourné vers l'intérieur : borne [bold]incluse[/bold] ($\le$ ou $\ge$).[/color]'' ;
    text id 613 start 962.0s for 1.8s at (4.0, 34.0) ''[color=#F8FAFC]Tourné vers l'extérieur : borne [bold]exclue[/bold] ($<$ ou $>$).[/color]'' ;

    text id 614 start 972.0s for 2.3s at (4.0, 44.0) ''[color=#38BDF8][bold]2. Du côté de l'infini ($\pm\infty$) :[/bold][/color]'' ;
    text id 615 start 975.0s at (4.0, 51.0) ''[color=#F8FAFC]L'infini n'est pas un nombre réel $\implies$ crochet [bold]toujours ouvert[/bold] ![/color]'' ;

    text id 616 start 983.3s for 1.5s at (4.0, 61.0) ''[color=#FBBF24][bold]3. Intersection ($A \cap B$) : penser « ET »[/bold][/color]'' ;
    text id 617 start 986.0s for 1.8s at (4.0, 68.0) ''[color=#F8FAFC]Zone commune $\iff$ où les deux couleurs se superposent.[/color]'' ;

    text id 618 start 993.2s for 2.6s at (4.0, 78.0) ''[color=#C084FC][bold]4. Réunion ($A \cup B$) : penser « OU »[/bold][/color]'' ;
    text id 619 start 996.0s for 4.9s at (4.0, 85.0) ''[color=#F8FAFC]Tout ce qui est colorié au moins une fois (réunion totale).[/color]'' ;

    # Colonne droite : Tableau récapitulatif
    draw polygone id 1611 start 950.0s color (56, 189, 248, 0.4) width 1.2 fillcolor (30, 41, 59, 0.25) at [(94.0, 16.0), (172.0, 16.0), (172.0, 93.0), (94.0, 93.0)] ;
    text id 620 start 951.0s for 2.0s at (108.0, 20.0) ''[color=#FBBF24][bold]MÉMO FORMULES & CONSEILS[/bold][/color]'' ;

    text id 621 start 958.0s for 2.8s at (98.0, 28.0) ''[color=#38BDF8]$a \le x \le b \iff x \in [a ; b]$[/color]'' ;
    text id 622 start 964.0s for 2.8s at (98.0, 36.0) ''[color=#38BDF8]$a < x < b \iff x \in ]a ; b[$[/color]'' ;
    text id 623 start 970.0s for 1.8s at (98.0, 44.0) ''[color=#38BDF8]$x \ge a \iff x \in [a ; +\infty[$[/color]'' ;
    text id 624 start 976.0s for 2.8s at (98.0, 52.0) ''[color=#38BDF8]$x < b \iff x \in ]-\infty ; b[$[/color]'' ;

    draw line id 1612 start 980.0s color (56, 189, 248, 0.3) width 1.0 at [(96.0, 60.5), (170.0, 60.5)] ;

    text id 625 start 985.0s at (98.0, 64.0) ''[color=#34D399][bold]La méthode infaillible en contrôle :[/bold][/color]'' ;
    text id 626 start 988.0s for 3.8s at (98.0, 71.0) ''[color=#F8FAFC]1. Tracer immédiatement un axe gradué.[/color]'' ;
    text id 627 start 992.0s for 1.0s at (98.0, 78.0) ''[color=#F8FAFC]2. Utiliser deux couleurs différentes.[/color]'' ;
    text id 628 start 1004.6s for 3.8s at (98.0, 86.0) ''[color=#FBBF24]Automatismes acquis : 100% de réussite ![/color]'' ;

}
