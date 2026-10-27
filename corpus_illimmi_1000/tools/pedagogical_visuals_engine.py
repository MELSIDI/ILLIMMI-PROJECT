"""
Pedagogical Visuals Engine for ILLIMMI Layer 3 Hypercourse Generation
====================================================================
Transforms pedagogical courses, transcripts, and concepts into authentic,
diverse, and visually stunning whiteboard scenes (.hc) tailored to each subject:
- Math:
    * Intervalles Cours fondamental (Droite des réels, crochets fermés/ouverts, infinis)
    * Intervalles Méthode pas à pas (Axe gradué, deux couleurs, intersection et réunion)
    * Intervalles Exemple guidé (Amplitudes L = b-a, centres c=(a+b)/2, rayons)
    * Intervalles Exercice classique (Énoncé lycée, Q1a, Q1b, Q2, résolution et pièges)
    * Intervalles Problème type Bac (Intervalles sécants vs disjoints avec ensemble vide)
    * Fonctions (Repère cartésien 2drep, courbe, tangente, extrema)
    * Vecteurs & Géométrie (Chasles, parallélogramme, coordonnées)
    * Ensembles de Nombres (Diagramme d'Euler concentrique N c Z c D c Q c R)
    * Valeur Absolue (Distance d(0, x), d(a, b), inéquations |x-a| <= r)
- Physics-Chemistry: Bilan des forces, trajectoires, cinématique, titrage.
- Languages: Blocs syntaxiques (Sujet + Verbe + Objet), flèches d'accord.
"""

import re
from typing import Dict, List, Tuple


class PedagogicalVisualsEngine:

    @staticmethod
    def detect_archetype(course: dict, layer1: dict, narration_text: str) -> str:
        title_lower = course.get("title", "").lower()
        text_corpus = f"{course.get('domain', '')} {course.get('subject', '')} {' '.join(course.get('key_notions', []))} {narration_text[:600]}".lower()

        # 1. Primary check: Exact course title & pedagogical purpose
        if any(k in title_lower for k in ["intersection", "réunion", "union"]):
            return "MATH_INTERVALS_INTERSECTION_UNION"
        if any(k in title_lower for k in ["valeur absolue", "distance sur la droite"]):
            return "MATH_ABSOLUTE_VALUE"
        if any(k in title_lower for k in ["ensemble de nombre", "ensembles de nombre", "entiers naturels", "rationnels"]):
            return "MATH_NUMBER_SETS"
        if any(k in title_lower for k in ["intervalle", "encadrement", "inégalité", "crochet"]):
            return "MATH_INTERVALS_BOUNDED"
        if any(k in title_lower for k in ["fonction", "courbe", "tangente", "dérivée", "variation"]):
            return "MATH_FUNCTIONS"
        if any(k in title_lower for k in ["vecteur", "chasles", "colinéaire", "norme"]):
            return "MATH_VECTORS"

        # 2. Secondary check: Concepts and narration corpus
        if any(k in text_corpus for k in ["intersection", "réunion", "interagiss", "union"]):
            return "MATH_INTERVALS_INTERSECTION_UNION"
        if any(k in text_corpus for k in ["valeur absolue", "distance sur la droite", "|x", "|a"]):
            return "MATH_ABSOLUTE_VALUE"
        if any(k in text_corpus for k in ["intervalle", "encadrement", "inégalité", "crochet"]):
            return "MATH_INTERVALS_BOUNDED"
        if any(k in text_corpus for k in ["ensemble de nombre", "ensembles de nombres", "entiers naturels", "entiers relatifs"]):
            return "MATH_NUMBER_SETS"
        if any(k in text_corpus for k in ["fonction", "courbe", "tangente", "dérivée", "variation"]):
            return "MATH_FUNCTIONS"
        if any(k in text_corpus for k in ["vecteur", "chasles", "colinéaire", "norme"]):
            return "MATH_VECTORS"
        if any(k in text_corpus for k in ["force", "poids", "frottement", "newton", "mouvement", "vitesse", "accélération"]):
            return "PHYSICS_FORCES_KINEMATICS"
        if any(k in text_corpus for k in ["acide", "base", "ph", "titrage", "solution", "concentration", "chimie"]):
            return "CHEMISTRY_TITRATION"

        # Languages
        if course.get("subject", "").lower() in ["anglais", "français", "langues"]:
            return "LANGUAGES_GRAMMAR_SYNTAX"

        domain = course.get("domain", "").lower()
        if "physique" in domain or "chimie" in domain:
            return "PHYSICS_FORCES_KINEMATICS"
        if "langue" in domain or "anglais" in domain or "français" in domain:
            return "LANGUAGES_GRAMMAR_SYNTAX"
        return "MATH_INTERVALS_BOUNDED"

    @classmethod
    def generate_course_visuals(cls, course: dict, layer1: dict, narration_text: str, duration: float) -> str:
        """Generate high-fidelity, topic-specific Hypercourse DSL (.hc)."""
        archetype = cls.detect_archetype(course, layer1, narration_text)
        c_title = course["title"].replace('"', "'")
        c_id_int = int(re.sub(r'[^0-9]', '', course["id"]) or "1")
        wav_name = "narration.wav"

        lines = [
            f'course "{c_title}" id {c_id_int} idgap 100 for {round(duration, 1)}s audio "{wav_name}" {{',
            ""
        ]

        sections = layer1.get("sections", [])
        if not sections:
            dt = duration / 5.0
            sections = [
                {"section_id": f"sec_{i+1}", "title": f"Section {i+1}", "start_time": round(i*dt, 1), "end_time": round((i+1)*dt, 1)}
                for i in range(5)
            ]

        text_id = 1
        draw_id = 101
        erase_id = 401

        for s_idx, sec in enumerate(sections):
            s_start = sec["start_time"]
            s_end = sec["end_time"]
            s_dur = max(4.0, s_end - s_start)

            lines.append(f"    # ========================================================")
            lines.append(f"    # SCÈNE {s_idx + 1} : {sec['title']} ({s_start:.1f}s - {s_end:.1f}s)")
            lines.append(f"    # ========================================================")

            # Scene clean erase before new section
            if s_idx > 0:
                lines.append(f"    erase id {erase_id} start {s_start:.1f}s ;")
                erase_id += 1
                lines.append("")

            # Clean Chalkboard Header
            clean_title = sec['title'].replace("''", "'")
            lines.append(f"    text id {text_id} start {(s_start + 0.3):.1f}s for {(s_dur - 0.5):.1f}s at (6.0, 8.5)")
            lines.append(f"         ''[bold][color=#38BDF8]{clean_title}[/color][/bold]'' ;")
            text_id += 1

            lines.append(f"    draw line id {draw_id} start {(s_start + 0.5):.1f}s for 0.6s")
            lines.append(f"         color (56, 189, 248, 0.45) width 1.5")
            lines.append(f"         at [(6, 14), (172, 14)] ;")
            draw_id += 1

            s_text, s_draw = cls._generate_scene_content(
                archetype=archetype,
                scene_idx=s_idx,
                total_scenes=len(sections),
                course=course,
                sec=sec,
                s_start=s_start,
                s_dur=s_dur,
                text_id_start=text_id,
                draw_id_start=draw_id,
                narration=narration_text
            )

            text_id += len(s_text)
            draw_id += len(s_draw)

            for cmd in s_text:
                lines.append(f"    {cmd}")
            for cmd in s_draw:
                lines.append(f"    {cmd}")

            lines.append("")

        lines.append("}")
        return "\n".join(lines)

    @classmethod
    def _generate_scene_content(cls, archetype: str, scene_idx: int, total_scenes: int,
                                course: dict, sec: dict, s_start: float, s_dur: float,
                                text_id_start: int, draw_id_start: int, narration: str) -> Tuple[List[str], List[str]]:
        ptype = course.get("pedagogical_type", "")
        if archetype == "MATH_INTERVALS_BOUNDED":
            if ptype in ["methode_resolution", "methode"]:
                return cls._scene_math_intervals_methode(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
            elif ptype in ["exemple_detaille", "exemple"]:
                return cls._scene_math_intervals_exemple(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
            elif ptype in ["correction_exercice", "exercice"]:
                return cls._scene_math_intervals_exercice(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
            elif ptype in ["probleme_type_bac", "probleme"]:
                return cls._scene_math_intervals_probleme(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
            else:
                return cls._scene_math_intervals_cours(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "MATH_INTERVALS_INTERSECTION_UNION":
            return cls._scene_math_intersection_union(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "MATH_ABSOLUTE_VALUE":
            return cls._scene_math_absolute_value(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "MATH_NUMBER_SETS":
            return cls._scene_math_number_sets(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "MATH_FUNCTIONS":
            return cls._scene_math_functions(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "MATH_VECTORS":
            return cls._scene_math_vectors(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "PHYSICS_FORCES_KINEMATICS":
            return cls._scene_physics_forces(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        elif archetype == "LANGUAGES_GRAMMAR_SYNTAX":
            return cls._scene_languages(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)
        else:
            return cls._scene_math_intervals_cours(scene_idx, total_scenes, course, sec, s_start, s_dur, text_id_start, draw_id_start)

    # -------------------------------------------------------------------------
    # 1. MATH : INTERVALLES COURS FONDAMENTAL (MATH_001)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intervals_cours(cls, idx: int, total: int, course: dict, sec: dict,
                                   t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Définition fondamentale :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.2):.1f}s at (4, 42) ''Soient a et b deux réels avec [bold]a < b[/bold].'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.0):.1f}s at (4, 56) ''$$\\mathcal{{I}} = [a ; b] = \\{{ x \\in \\mathbb{{R}} \\mid a \\le x \\le b \\}}$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.5):.1f}s at (4, 74) ''Exemple : [bold][color=#60A5FA]x compris entre 2 et 4[/color][/bold]'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.0):.1f}s at (164, 48) ''[bold]+\\infty[/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 2.0):.1f}s at (96, 48) ''[bold]-\\infty[/bold]'' ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.5):.1f}s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(110, 53), (110, 59)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 2.7):.1f}s at (108.5, 62) ''0'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.0):.1f}s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(134, 53), (134, 59)] ;")
            draws.append(f"text id {tid+7} start {(t0 + 3.2):.1f}s at (132.5, 62) ''[bold][color=#60A5FA]2[/color][/bold]'' ;")
            draws.append(f"draw line id {did+3} start {(t0 + 3.5):.1f}s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(158, 53), (158, 59)] ;")
            draws.append(f"text id {tid+8} start {(t0 + 3.7):.1f}s at (156.5, 62) ''[bold][color=#60A5FA]4[/color][/bold]'' ;")
            draws.append(f"draw line id {did+4} start {(t0 + 5.0):.1f}s for 1.2s color (56, 189, 248, 1) width 5.0 at [(134, 56), (158, 56)] ;")
            draws.append(f"text id {tid+9} start {(t0 + 5.8):.1f}s at (131.0, 50) ''[bold][color=#60A5FA][[/color][/bold]'' ;")
            draws.append(f"text id {tid+10} start {(t0 + 6.2):.1f}s at (157.0, 50) ''[bold][color=#60A5FA]][/color][/bold]'' ;")
            draws.append(f"text id {tid+11} start {(t0 + 7.0):.1f}s at (138.0, 36) ''[bold][color=#38BDF8]I = [2 ; 4][/color][/bold]'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Règle des Crochets :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''[bold][color=#34D399]Crochet fermé (inclus) :[/color][/bold] Borne incluse ($\\le$ ou $\\ge$)'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''[bold][color=#F87171]Crochet ouvert (exclu) :[/color][/bold] Borne exclue (< ou >)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$x \\in ]2 ; 4] \\iff 2 < x \\le 4$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 50), (170, 50)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.0):.1f}s for 0.8s color (52, 211, 153, 1) width 4.5 at [(120, 50), (155, 50)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.8):.1f}s at (116.0, 44) ''[bold][color=#F87171]][/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (154.0, 44) ''[bold][color=#34D399]][/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.8):.1f}s at (118.0, 56) ''2 exclu'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.2):.1f}s at (150.0, 56) ''4 inclus'' ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.0):.1f}s at (126.0, 32) ''[bold][color=#34D399]]2 ; 4][/color][/bold]'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#FBBF24]Intervalles Non Bornés :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''$$x \\ge 3 \\iff x \\in [3 ; +\\infty[$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''$$x < 0 \\iff x \\in ]-\\infty ; 0[$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''Du côté de ±∞, crochet TOUJOURS ouvert !'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(125, 52), (125, 60)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (123.5, 63) ''[bold]3[/bold]'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.8):.1f}s for 1.2s color (251, 191, 36, 1) width 5.0 at [(125, 56), (168, 56)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (122.0, 50) ''[bold][color=#FBBF24][[/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.2):.1f}s at (162.0, 48) ''[bold]+∞[/bold]'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 6.0):.1f}s at (135.0, 36) ''[bold][color=#FBBF24][3 ; +∞[[/color][/bold]'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Application Type Lycée :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Soit l'encadrement : [bold]-4 ≤ x < 5[/bold]'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''1. Borne -4 incluse (crochet fermé)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.5):.1f}s at (4, 74) ''2. Borne 5 exclue (crochet ouvert)'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.2):.1f}s for 1.0s color (192, 132, 252, 1) width 4.5 at [(115, 56), (155, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 4.0):.1f}s at (112.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.4):.1f}s at (113.0, 63) ''-4'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.0):.1f}s at (154.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.4):.1f}s at (154.0, 63) ''5'' ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.5):.1f}s at (124.0, 36) ''[bold][color=#C084FC]S = [-4 ; 5[[/color][/bold]'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Fiche Réflexe Épreuve :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''(+) Toujours ordonner les bornes : du plus petit au plus grand !'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''(+) Inégalité large (≤) ⟹ crochet tourné vers le nombre'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''(!) Piège : ne JAMAIS fermer le crochet sur ±∞'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 2.0):.1f}s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (116.0, 48) ''[bold][color=#38BDF8]Synthèse Intervalles[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (118.0, 58) ''$$x \\in [a ; b] \\iff a \\le x \\le b$$'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 2. MATH : MÉTHODE DE RÉSOLUTION PAS À PAS (MATH_002)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intervals_methode(cls, idx: int, total: int, course: dict, sec: dict,
                                     t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Méthode : Graduer l'Axe des Réels[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Soient les intervalles à étudier :'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.0):.1f}s at (4, 56) ''[bold][color=#60A5FA]I = [-1 ; 3][/color][/bold] et [bold][color=#F87171]J = [0 ; 4][/color][/bold]'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.5):.1f}s at (4, 74) ''Étape 1 : Placer une échelle régulière sur l'axe.'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            # Ticks at -1(110), 0(122), 1(134), 2(146), 3(158), 4(166)
            draws.append(f"draw line id {did+1} start {(t0 + 2.5):.1f}s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(110, 53), (110, 59)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.7):.1f}s at (108.0, 62) ''-1'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.0):.1f}s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(122, 53), (122, 59)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.2):.1f}s at (120.5, 62) ''0'' ;")
            draws.append(f"draw line id {did+3} start {(t0 + 3.5):.1f}s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(158, 53), (158, 59)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 3.7):.1f}s at (156.5, 62) ''3'' ;")
            draws.append(f"draw line id {did+4} start {(t0 + 4.0):.1f}s for 0.3s color (226, 232, 240, 0.85) width 1.5 at [(166, 53), (166, 59)] ;")
            draws.append(f"text id {tid+7} start {(t0 + 4.2):.1f}s at (164.5, 62) ''4'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Étape 2 : Deux Couleurs Distinctes[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Colorer I en [bold][color=#60A5FA]Bleu[/color][/bold] au-dessus de l'axe.'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Colorer J en [bold][color=#F87171]Rouge[/color][/bold] en-dessous de l'axe.'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''Visualisation immédiate sans risque de confusion !'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            # Segment I in blue at y=48
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 1.0s color (56, 189, 248, 1) width 4.0 at [(110, 48), (158, 48)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.5):.1f}s at (107.0, 42) ''[bold][color=#60A5FA][-1[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.8):.1f}s at (158.0, 42) ''[bold][color=#60A5FA]3][/color][/bold]'' ;")
            # Segment J in red at y=64
            draws.append(f"draw line id {did+2} start {(t0 + 5.0):.1f}s for 1.0s color (248, 113, 113, 1) width 4.0 at [(122, 64), (166, 64)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.6):.1f}s at (119.0, 70) ''[bold][color=#F87171][0[/color][/bold]'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 6.0):.1f}s at (166.0, 70) ''[bold][color=#F87171]4][/color][/bold]'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Étape 3 : Intersection des Deux Intervalles[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Repérer la zone de [bold]double coloration[/bold].'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Zone commune entre 0 et 3 :'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$I \\cap J = [0 ; 3]$$ (0 et 3 sont dans les deux)'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.5):.1f}s for 0.5s color (37, 99, 235, 0.4) width 3.0 at [(110, 48), (158, 48)] ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.0):.1f}s for 0.5s color (220, 38, 38, 0.4) width 3.0 at [(122, 64), (166, 64)] ;")
            # Overlap Zone highlighted in Green
            draws.append(f"draw polygone id {did+3} start {(t0 + 4.0):.1f}s for 0.8s color (5, 150, 105, 0.8) fillcolor (52, 211, 153, 0.20) width 1.5 at [(122, 44), (158, 44), (158, 68), (122, 68)] ;")
            draws.append(f"draw line id {did+4} start {(t0 + 5.0):.1f}s for 0.8s color (5, 150, 105, 1) width 5.0 at [(122, 56), (158, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 6.0):.1f}s at (126.0, 34) ''$$I \\cap J = [0 ; 3]$$'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Étape 4 : Réunion des Deux Intervalles[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Prendre toute la zone ayant [bold]au moins une couleur[/bold].'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Couverture totale de -1 jusqu'à 4 :'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$I \\cup J = [-1 ; 4]$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 1.2s color (192, 132, 252, 1) width 5.5 at [(110, 56), (166, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.8):.1f}s at (107.0, 48) ''[bold][color=#C084FC][-1[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (166.0, 48) ''[bold][color=#C084FC]4][/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.5):.1f}s at (122.0, 36) ''$$I \\cup J = [-1 ; 4]$$'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Récapitulatif de la Méthode :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''1. Tracer la droite graduée'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 60) ''2. Colorer les deux intervalles (2 niveaux)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.5):.1f}s at (4, 76) ''3. Intersection = commune | Réunion = totale'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 1.8):.1f}s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (118.0, 48) ''[bold][color=#38BDF8]Méthode Clé[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (118.0, 58) ''2 Couleurs ⟹ Succès'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 3. MATH : EXEMPLE GUIDÉ ET CALCUL DÉTAILLÉ (MATH_003)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intervals_exemple(cls, idx: int, total: int, course: dict, sec: dict,
                                     t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Exemple Guidé : Calcul d'Amplitude[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Soit l'intervalle : [bold]I = [-2 ; 6][/bold]'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Amplitude (longueur) : $$L = b - a$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$L = 6 - (-2) = 6 + 2 = 8$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.0):.1f}s for 0.8s color (56, 189, 248, 1) width 4.5 at [(112, 56), (156, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.8):.1f}s at (109.0, 63) ''-2'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (154.0, 63) ''6'' ;")
            draws.append(f"draw arrow id {did+2} start {(t0 + 5.0):.1f}s for 0.8s color (251, 191, 36, 1) width 2.0 at [(112, 46), (156, 46)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.8):.1f}s at (126.0, 36) ''[bold][color=#FBBF24]Longueur L = 8[/color][/bold]'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Centre et Rayon de l'Intervalle[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Centre c : $$c = \\frac{{a + b}}{{2}} = \\frac{{-2 + 6}}{{2}} = 2$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''Rayon r : $$r = \\frac{{b - a}}{{2}} = \\frac{{8}}{{2}} = 4$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''$$I = [c - r ; c + r] = [2 - 4 ; 2 + 4]$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (52, 211, 153, 1) width 4.5 at [(112, 56), (156, 56)] ;")
            draws.append(f"draw circle id {did+2} start {(t0 + 3.8):.1f}s for 0.4s color (248, 250, 252, 1) fillcolor (248, 250, 252, 1) width 1.0 at (134, 56) radius 2.5 ;")
            draws.append(f"text id {tid+4} start {(t0 + 4.2):.1f}s at (131.0, 63) ''[bold]c = 2[/bold]'' ;")
            draws.append(f"draw arrow id {did+3} start {(t0 + 5.0):.1f}s for 0.6s color (251, 191, 36, 1) width 1.8 at [(134, 46), (112, 46)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 5.4):.1f}s at (120.0, 38) ''r = 4'' ;")
            draws.append(f"draw arrow id {did+4} start {(t0 + 5.8):.1f}s for 0.6s color (251, 191, 36, 1) width 1.8 at [(134, 46), (156, 46)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 6.2):.1f}s at (142.0, 38) ''r = 4'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#FBBF24]Lien avec la Valeur Absolue[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''$$x \\in [c - r ; c + r] \\iff |x - c| \\le r$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''Pour notre exemple (c=2, r=4) :'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''$$x \\in [-2 ; 6] \\iff |x - 2| \\le 4$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.0):.1f}s for 0.8s color (251, 191, 36, 1) width 4.5 at [(112, 56), (156, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 4.0):.1f}s at (109.0, 50) ''[bold][color=#FBBF24][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.4):.1f}s at (155.0, 50) ''[bold][color=#FBBF24]][/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.5):.1f}s at (122.0, 36) ''[bold][color=#FBBF24]|x - 2| \\le 4[/color][/bold]'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Calcul d'Intersection Associé[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Soit J = ]1 ; 8]. Calculons I ∩ J :'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''$$-2 \\le x \\le 6 \\quad \\text{{et}} \\quad 1 < x \\le 8$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$I \\cap J = ]1 ; 6]$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.0):.1f}s for 1.0s color (192, 132, 252, 1) width 5.0 at [(128, 56), (156, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.8):.1f}s at (124.0, 50) ''[bold][color=#C084FC]][/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (126.0, 63) ''1'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.6):.1f}s at (155.0, 50) ''[bold][color=#C084FC]][/color][/bold]'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.0):.1f}s at (154.0, 63) ''6'' ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.0):.1f}s at (124.0, 36) ''[bold][color=#C084FC]I ∩ J = ]1 ; 6][/color][/bold]'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Bilan des Formules Clés :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''(+) Longueur L = b - a (toujours > 0)'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''(+) Centre c = (a+b)/2 (milieu)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''(+) Rayon r = (b-a)/2 = L/2'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 1.8):.1f}s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (118.0, 48) ''[bold][color=#38BDF8]Bilan Calculs[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (118.0, 58) ''$$L = b - a$$'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 4. MATH : CORRECTION D'EXERCICE CLASSIQUE (MATH_004)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intervals_exercice(cls, idx: int, total: int, course: dict, sec: dict,
                                      t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Énoncé de l'Exercice :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''$$I = [-4 ; 5[ \\quad \\text{{et}} \\quad J = [2 ; +\\infty[$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Q1 : Représenter I et J sur un axe gradué.'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''Q2 : Déterminer $$I \\cap J$$ et $$I \\cup J$$.'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.0):.1f}s at (162.0, 48) ''[bold]+∞[/bold]'' ;")
            draws.append(f"draw line id {did+1} start {(t0 + 3.0):.1f}s for 0.4s color (226, 232, 240, 0.85) width 1.5 at [(124, 53), (124, 59)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.2):.1f}s at (122.5, 62) ''0'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.5):.1f}s at (114.0, 36) ''[bold][color=#38BDF8]Axe Prêt pour Tracé[/color][/bold]'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#60A5FA]Question 1a : Tracé de l'intervalle I[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.0):.1f}s at (4, 40) ''$$I = [-4 ; 5[$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 56) ''-4 est inclus (crochet fermé [)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.5):.1f}s at (4, 72) ''5 est exclu (crochet ouvert [)'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 1.0s color (56, 189, 248, 1) width 4.5 at [(106, 56), (154, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.5):.1f}s at (103.0, 50) ''[bold][color=#60A5FA][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.8):.1f}s at (104.0, 63) ''-4'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.5):.1f}s at (153.0, 50) ''[bold][color=#60A5FA][[/color][/bold]'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 4.8):.1f}s at (153.0, 63) ''5'' ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.0):.1f}s at (122.0, 36) ''$$I = [-4 ; 5[$$'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#F87171]Question 1b : Tracé de la demi-droite J[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.0):.1f}s at (4, 40) ''$$J = [2 ; +\\infty[$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 56) ''Demi-droite d'origine 2 incluse.'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 6.8):.1f}s at (4, 72) ''S'étend jusqu'à +∞ vers la droite.'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 1.2s color (248, 113, 113, 1) width 4.5 at [(132, 56), (168, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.5):.1f}s at (129.0, 50) ''[bold][color=#F87171][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.8):.1f}s at (130.5, 63) ''2'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.0):.1f}s at (136.0, 36) ''$$J = [2 ; +\\infty[$$'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Question 2 : Intersection des Ensembles[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Éléments communs à I et J :'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''$$I \\cap J = [2 ; 5[$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''2 est dans les deux, 5 est exclu de I !'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (5, 150, 105, 1) width 5.0 at [(132, 56), (154, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.5):.1f}s at (129.0, 50) ''[bold][color=#34D399][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.0):.1f}s at (153.0, 50) ''[bold][color=#34D399][[/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.5):.1f}s at (126.0, 36) ''$$I \\cap J = [2 ; 5[$$'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Question 3 : Réunion des Ensembles[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Toute la zone ayant au moins une couleur :'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''$$I \\cup J = [-4 ; +\\infty[$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''(!) Piège évité : -4 appartient à I donc à l'union !'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 1.2s color (192, 132, 252, 1) width 5.5 at [(106, 56), (168, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.8):.1f}s at (103.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (104.0, 63) ''-4'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.5):.1f}s at (124.0, 36) ''[bold][color=#C084FC]I ∪ J = [-4 ; +∞[[/color][/bold]'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 5. MATH : PROBLÈME TYPE BAC (MATH_005)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intervals_probleme(cls, idx: int, total: int, course: dict, sec: dict,
                                      t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Problème de Synthèse :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Étude de deux configurations fondamentales :'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Cas 1 : Intervalles sécants (qui se coupent)'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''Cas 2 : Intervalles disjoints (séparés)'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 2.0):.1f}s for 1.0s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.0 at (114, 56) radius 16 ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.5):.1f}s at (104.0, 54) ''Cas 1'' ;")
            draws.append(f"draw circle id {did+1} start {(t0 + 3.5):.1f}s for 1.0s color (248, 113, 113, 1) fillcolor (248, 113, 113, 0.20) width 2.0 at (150, 56) radius 16 ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.0):.1f}s at (140.0, 54) ''Cas 2'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Cas 1 : I = [0 ; 2[ et J = [1 ; 4][/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Les deux intervalles se chevauchent sur [1 ; 2[.'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''La réunion fusionne en un seul intervalle continu :'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''$$I \\cup J = [0 ; 4]$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (16, 185, 129, 0.6) width 3.5 at [(114, 48), (134, 48)] ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.5):.1f}s for 0.8s color (220, 38, 38, 0.6) width 3.5 at [(124, 64), (154, 64)] ;")
            draws.append(f"draw line id {did+3} start {(t0 + 5.0):.1f}s for 1.2s color (52, 211, 153, 1) width 5.5 at [(114, 56), (154, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 6.0):.1f}s at (122.0, 36) ''[bold][color=#34D399]I \\cup J = [0 ; 4][/color][/bold]'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#F87171]Cas 2 : I = ]3 ; +∞[ et J = [-1 ; 1][/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Ces deux intervalles sont disjoints !'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''Ils n'ont AUCUN point commun.'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''$$I \\cap J = \\emptyset$$ (ensemble vide)'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (56, 189, 248, 1) width 4.5 at [(105, 56), (121, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.2):.1f}s at (107.0, 63) ''[-1 ; 1]'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 4.0):.1f}s for 1.0s color (248, 113, 113, 1) width 4.5 at [(137, 56), (168, 56)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (140.0, 63) '']3 ; +∞['' ;")
            draws.append(f"text id {tid+6} start {(t0 + 6.0):.1f}s at (124.0, 36) ''[bold][color=#F87171]I ∩ J = ∅[/color][/bold]'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Réunion d'Intervalles Disjoints[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''La réunion ne peut PAS former un seul intervalle !'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''On conserve obligatoirement le symbole ∪ :'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''$$I \\cup J = [-1 ; 1] \\cup ]3 ; +\\infty[$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.5):.1f}s for 0.6s color (192, 132, 252, 1) width 5.0 at [(105, 56), (121, 56)] ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.2):.1f}s for 0.8s color (192, 132, 252, 1) width 5.0 at [(137, 56), (168, 56)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 4.5):.1f}s at (126.0, 50) ''[bold][color=#C084FC]∪[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 5.5):.1f}s at (114.0, 36) ''[bold][color=#C084FC][-1 ; 1] ∪ ]3 ; +∞[[/color][/bold]'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Réflexes Clés Épreuve Bac :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''(+) Chevauchement ⟹ fusion en un seul intervalle'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''(+) Disjoints ⟹ ∩ = ∅ et écriture avec ∪ obligatoire'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''(!) Ne jamais inventer une fausse borne intermédiaire !'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 1.8):.1f}s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (116.0, 48) ''[bold][color=#38BDF8]Bilan Réunion[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (116.0, 58) ''Sécants vs Disjoints'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 6. MATH : INTERSECTION ET RÉUNION D'INTERVALLES GÉNÉRAUX
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_intersection_union(cls, idx: int, total: int, course: dict, sec: dict,
                                      t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        return cls._scene_math_intervals_methode(idx, total, course, sec, t0, dur, tid, did)

    # -------------------------------------------------------------------------
    # 7. MATH : VALEUR ABSOLUE ET DISTANCE (|x - a| <= r)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_absolute_value(cls, idx: int, total: int, course: dict, sec: dict,
                                   t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        if idx == 0:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Valeur Absolue et Distance à 0 :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Pour tout réel x, [bold]|x| = d(0, x)[/bold].'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''$$|x| = x \\text{{ si }} x \\ge 0 \\quad \\text{{et}} \\quad |x| = -x \\text{{ si }} x < 0$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''Une valeur absolue est [bold]toujours positive ou nulle[/bold] !'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw line id {did+1} start {(t0 + 2.2):.1f}s for 0.4s color (15, 23, 42, 1) width 2.0 at [(133, 52), (133, 60)] ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.5):.1f}s at (131.5, 63) ''[bold]0[/bold]'' ;")
            draws.append(f"draw circle id {did+2} start {(t0 + 3.2):.1f}s for 0.4s color (56, 189, 248, 1) fillcolor (56, 189, 248, 1) width 1.5 at (113, 56) radius 2.5 ;")
            draws.append(f"text id {tid+5} start {(t0 + 3.5):.1f}s at (110.5, 63) ''-3'' ;")
            draws.append(f"draw circle id {did+3} start {(t0 + 4.0):.1f}s for 0.4s color (56, 189, 248, 1) fillcolor (56, 189, 248, 1) width 1.5 at (153, 56) radius 2.5 ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.3):.1f}s at (151.5, 63) ''+3'' ;")
            draws.append(f"draw arrow id {did+4} start {(t0 + 5.0):.1f}s for 0.6s color (251, 191, 36, 1) width 2.0 at [(133, 46), (113, 46)] ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.4):.1f}s at (120.0, 38) ''d = 3'' ;")
            draws.append(f"draw arrow id {did+5} start {(t0 + 5.8):.1f}s for 0.6s color (251, 191, 36, 1) width 2.0 at [(133, 46), (153, 46)] ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.2):.1f}s at (140.0, 38) ''d = 3'' ;")

        elif idx == 1:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#34D399]Distance entre Deux Points :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Soient A et B d'abscisses respectives a et b.'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''$$AB = d(a, b) = |b - a| = |a - b|$$'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''Exemple : d(2, 7) = |7 - 2| = 5'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw circle id {did+1} start {(t0 + 2.8):.1f}s for 0.4s color (52, 211, 153, 1) fillcolor (52, 211, 153, 1) width 1.5 at (116, 56) radius 2.5 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.2):.1f}s at (113.0, 63) ''A(a)'' ;")
            draws.append(f"draw circle id {did+2} start {(t0 + 3.8):.1f}s for 0.4s color (52, 211, 153, 1) fillcolor (52, 211, 153, 1) width 1.5 at (152, 56) radius 2.5 ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.2):.1f}s at (150.0, 63) ''B(b)'' ;")
            draws.append(f"draw line id {did+3} start {(t0 + 4.8):.1f}s for 0.8s color (52, 211, 153, 1) width 4.5 at [(116, 56), (152, 56)] ;")
            draws.append(f"text id {tid+6} start {(t0 + 5.8):.1f}s at (126.0, 42) ''[bold][color=#34D399]AB = |b - a|[/color][/bold]'' ;")

        elif idx == 2:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#FBBF24]Inéquations du Type |x - a| ≤ r :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''$$|x - a| \\le r \\iff x \\in [a - r ; a + r]$$'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 58) ''Points M(x) à distance ≤ r de A(a).'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 74) ''Centre [bold]c = a[/bold] et rayon [bold]r[/bold].'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw circle id {did+1} start {(t0 + 2.5):.1f}s for 0.4s color (251, 191, 36, 1) fillcolor (251, 191, 36, 1) width 1.5 at (133, 56) radius 2.5 ;")
            draws.append(f"text id {tid+4} start {(t0 + 2.8):.1f}s at (131.5, 63) ''[bold]a[/bold]'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 3.8):.1f}s for 1.0s color (251, 191, 36, 1) width 4.5 at [(115, 56), (151, 56)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (110.0, 63) ''a-r'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.9):.1f}s at (149.0, 63) ''a+r'' ;")
            draws.append(f"draw arrow id {did+3} start {(t0 + 5.5):.1f}s for 0.6s color (251, 191, 36, 1) width 1.8 at [(133, 46), (115, 46)] ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.8):.1f}s at (122.0, 38) ''r'' ;")
            draws.append(f"draw arrow id {did+4} start {(t0 + 6.2):.1f}s for 0.6s color (251, 191, 36, 1) width 1.8 at [(133, 46), (151, 46)] ;")
            draws.append(f"text id {tid+8} start {(t0 + 6.5):.1f}s at (140.0, 38) ''r'' ;")

        elif idx == 3:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#C084FC]Exemple Résolu :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 42) ''Résoudre dans ℝ : [bold]|x - 3| ≤ 2[/bold]'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 4.5):.1f}s at (4, 58) ''Le centre est [bold]3[/bold], le rayon est [bold]2[/bold].'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.0):.1f}s at (4, 74) ''$$x \\in [3 - 2 ; 3 + 2] \\implies x \\in [1 ; 5]$$'' ;")

            draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 2.0 at [(96, 56), (170, 56)] ;")
            draws.append(f"draw circle id {did+1} start {(t0 + 2.8):.1f}s for 0.4s color (192, 132, 252, 1) fillcolor (192, 132, 252, 1) width 1.5 at (133, 56) radius 2.5 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.2):.1f}s at (131.5, 63) ''3'' ;")
            draws.append(f"draw line id {did+2} start {(t0 + 4.0):.1f}s for 0.8s color (192, 132, 252, 1) width 4.5 at [(117, 56), (149, 56)] ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.6):.1f}s at (114.0, 50) ''[bold][color=#C084FC][[/color][/bold]'' ;")
            draws.append(f"text id {tid+6} start {(t0 + 4.9):.1f}s at (115.0, 63) ''1'' ;")
            draws.append(f"text id {tid+7} start {(t0 + 5.4):.1f}s at (148.0, 50) ''[bold][color=#C084FC]][/color][/bold]'' ;")
            draws.append(f"text id {tid+8} start {(t0 + 5.7):.1f}s at (148.0, 63) ''5'' ;")
            draws.append(f"text id {tid+9} start {(t0 + 6.8):.1f}s at (126.0, 36) ''[bold][color=#C084FC]S = [1 ; 5][/color][/bold]'' ;")

        else:
            texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Propriétés Clés à Retenir :[/color][/bold]'' ;")
            texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''(+) |-x| = |x| et √(x²) = |x|'' ;")
            texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''(+) Inégalité triangulaire : |x + y| ≤ |x| + |y|'' ;")
            texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''(!) Attention : |x - a| = r donne DEUX solutions : x = a - r ou x = a + r'' ;")

            draws.append(f"draw circle id {did} start {(t0 + 1.8):.1f}s for 1.2s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.5 at (132, 56) radius 22 ;")
            draws.append(f"text id {tid+4} start {(t0 + 3.0):.1f}s at (118.0, 48) ''[bold][color=#38BDF8]Bilan Distance[/color][/bold]'' ;")
            draws.append(f"text id {tid+5} start {(t0 + 4.5):.1f}s at (118.0, 58) ''$$|x - a| \\le r$$'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 8. MATH : ENSEMBLES DE NOMBRES (N c Z c D c Q c R)
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_number_sets(cls, idx: int, total: int, course: dict, sec: dict,
                               t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Les Ensembles de Nombres :[/color][/bold]'' ;")
        texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''$$\\mathbb{{N}} \\subset \\mathbb{{Z}} \\subset \\mathbb{{D}} \\subset \\mathbb{{Q}} \\subset \\mathbb{{R}}$$'' ;")
        texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''Tout entier naturel est un entier relatif, etc.'' ;")
        texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''Nombres irrationnels : π, √2 ∈ ℝ \\ ℚ'' ;")

        draws.append(f"draw circle id {did} start {(t0 + 1.5):.1f}s for 0.8s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 2.0 at (133, 56) radius 26 ;")
        draws.append(f"text id {tid+4} start {(t0 + 2.0):.1f}s at (110.0, 36) ''[bold][color=#38BDF8]ℝ[/color][/bold]'' ;")
        draws.append(f"draw circle id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.20) width 2.0 at (133, 58) radius 20 ;")
        draws.append(f"text id {tid+5} start {(t0 + 3.2):.1f}s at (116.0, 44) ''[bold][color=#34D399]ℚ[/color][/bold]'' ;")
        draws.append(f"draw circle id {did+2} start {(t0 + 4.0):.1f}s for 0.8s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.20) width 2.0 at (133, 60) radius 14 ;")
        draws.append(f"text id {tid+6} start {(t0 + 4.4):.1f}s at (122.0, 52) ''[bold][color=#FBBF24]𝔻[/color][/bold]'' ;")
        draws.append(f"draw circle id {did+3} start {(t0 + 5.2):.1f}s for 0.8s color (192, 132, 252, 1) fillcolor (192, 132, 252, 0.20) width 2.0 at (133, 63) radius 8 ;")
        draws.append(f"text id {tid+7} start {(t0 + 5.6):.1f}s at (130.0, 60) ''[bold][color=#C084FC]ℕ[/color][/bold]'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 9. MATH : FONCTIONS, COURBES ET VARIATIONS
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_functions(cls, idx: int, total: int, course: dict, sec: dict,
                             t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Étude Graphique de Fonction :[/color][/bold]'' ;")
        texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''Courbe représentative [bold]Cf[/bold] dans un repère.'' ;")
        texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''$$M(x ; y) \\in \\mathcal{{C}}_f \\iff y = f(x)$$'' ;")
        texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''Image de x par f et antécédents.'' ;")

        draws.append(f"draw arrow id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) width 1.8 at [(98, 68), (168, 68)] ;")
        draws.append(f"text id {tid+4} start {(t0 + 2.0):.1f}s at (166.0, 70.0) ''x'' ;")
        draws.append(f"draw arrow id {did+1} start {(t0 + 2.2):.1f}s for 0.8s color (248, 250, 252, 0.95) width 1.8 at [(110, 84), (110, 28)] ;")
        draws.append(f"text id {tid+5} start {(t0 + 2.5):.1f}s at (107.0, 30.0) ''y'' ;")
        draws.append(f"draw curve id {did+2} start {(t0 + 3.8):.1f}s for 1.4s color (56, 189, 248, 1) width 3.0 at [(102, 34), (118, 64), (133, 68), (148, 64), (164, 34)] ;")
        draws.append(f"text id {tid+6} start {(t0 + 5.0):.1f}s at (152.0, 36.0) ''[bold][color=#38BDF8]Cf[/color][/bold]'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 10. MATH : VECTEURS ET GÉOMÉTRIE
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_math_vectors(cls, idx: int, total: int, course: dict, sec: dict,
                           t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Vecteurs et Relation de Chasles :[/color][/bold]'' ;")
        texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''$$\\vec{{AB}} + \\vec{{BC}} = \\vec{{AC}}$$'' ;")
        texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''Direction, sens et norme (longueur).'' ;")
        texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''Règle du parallélogramme pour la somme.'' ;")

        draws.append(f"draw arrow id {did} start {(t0 + 1.8):.1f}s for 0.8s color (56, 189, 248, 1) width 2.5 at [(105, 68), (135, 68)] ;")
        draws.append(f"text id {tid+4} start {(t0 + 2.2):.1f}s at (118.0, 72.0) ''[bold][color=#60A5FA]u⃗[/color][/bold]'' ;")
        draws.append(f"draw arrow id {did+1} start {(t0 + 2.8):.1f}s for 0.8s color (52, 211, 153, 1) width 2.5 at [(135, 68), (155, 38)] ;")
        draws.append(f"text id {tid+5} start {(t0 + 3.2):.1f}s at (148.0, 52.0) ''[bold][color=#34D399]v⃗[/color][/bold]'' ;")
        draws.append(f"draw arrow id {did+2} start {(t0 + 4.2):.1f}s for 1.0s color (192, 132, 252, 1) width 3.0 at [(105, 68), (155, 38)] ;")
        draws.append(f"text id {tid+6} start {(t0 + 5.0):.1f}s at (122.0, 46.0) ''[bold][color=#C084FC]u⃗ + v⃗[/color][/bold]'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 11. PHYSIQUE : FORCES, VITESSE ET MÉCANIQUE
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_physics_forces(cls, idx: int, total: int, course: dict, sec: dict,
                             t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Bilan des Forces & Principe d'Inertie :[/color][/bold]'' ;")
        texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''$$\\sum \\vec{{F}}_{{ext}} = m \\vec{{a}}_G$$'' ;")
        texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''Poids : P⃗ = m g⃗ (vertical descendant)'' ;")
        texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''Réaction du support : R⃗ (perpendiculaire)'' ;")

        draws.append(f"draw polygone id {did} start {(t0 + 1.5):.1f}s for 0.8s color (248, 250, 252, 0.95) fillcolor (56, 189, 248, 0.25) width 2.0 at [(122, 50), (144, 50), (144, 64), (122, 64)] ;")
        draws.append(f"draw circle id {did+1} start {(t0 + 2.2):.1f}s for 0.4s color (248, 250, 252, 1) fillcolor (248, 250, 252, 1) width 1.0 at (133, 57) radius 2.0 ;")
        draws.append(f"text id {tid+4} start {(t0 + 2.4):.1f}s at (135.0, 56.0) ''G'' ;")
        draws.append(f"draw arrow id {did+2} start {(t0 + 3.2):.1f}s for 0.8s color (248, 113, 113, 1) width 2.5 at [(133, 57), (133, 82)] ;")
        draws.append(f"text id {tid+5} start {(t0 + 3.8):.1f}s at (136.0, 76.0) ''[bold][color=#F87171]P⃗[/color][/bold]'' ;")
        draws.append(f"draw arrow id {did+3} start {(t0 + 4.5):.1f}s for 0.8s color (56, 189, 248, 1) width 2.5 at [(133, 57), (133, 32)] ;")
        draws.append(f"text id {tid+6} start {(t0 + 5.0):.1f}s at (136.0, 36.0) ''[bold][color=#60A5FA]R⃗[/color][/bold]'' ;")

        return texts, draws

    # -------------------------------------------------------------------------
    # 12. LANGUES : GRAMMAIRE, SYNTAXE ET STRUCTURES
    # -------------------------------------------------------------------------
    @classmethod
    def _scene_languages(cls, idx: int, total: int, course: dict, sec: dict,
                        t0: float, dur: float, tid: int, did: int) -> Tuple[List[str], List[str]]:
        texts, draws = [], []

        texts.append(f"text id {tid} start {(t0 + 0.8):.1f}s at (4, 28) ''[bold][color=#38BDF8]Structure Grammaticale Fondamentale :[/color][/bold]'' ;")
        texts.append(f"text id {tid+1} start {(t0 + 2.5):.1f}s at (4, 44) ''Ordre canonique : [bold]Sujet + Verbe + Complément[/bold]'' ;")
        texts.append(f"text id {tid+2} start {(t0 + 5.0):.1f}s at (4, 60) ''Accord en genre et en nombre / Concordance des temps.'' ;")
        texts.append(f"text id {tid+3} start {(t0 + 7.5):.1f}s at (4, 76) ''Règles d'usage et expressions idiomatiques.'' ;")

        draws.append(f"draw polygone id {did} start {(t0 + 1.5):.1f}s for 0.6s color (56, 189, 248, 1) fillcolor (56, 189, 248, 0.20) width 1.8 at [(98, 42), (118, 42), (118, 62), (98, 62)] ;")
        draws.append(f"text id {tid+4} start {(t0 + 2.0):.1f}s at (101.0, 50.0) ''[bold][color=#38BDF8]Sujet[/color][/bold]'' ;")
        draws.append(f"draw polygone id {did+1} start {(t0 + 2.8):.1f}s for 0.6s color (52, 211, 153, 1) fillcolor (52, 211, 153, 0.20) width 1.8 at [(124, 42), (144, 42), (144, 62), (124, 62)] ;")
        draws.append(f"text id {tid+5} start {(t0 + 3.2):.1f}s at (127.0, 50.0) ''[bold][color=#34D399]Verbe[/color][/bold]'' ;")
        draws.append(f"draw polygone id {did+2} start {(t0 + 4.0):.1f}s for 0.6s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.20) width 1.8 at [(150, 42), (170, 42), (170, 62), (150, 62)] ;")
        draws.append(f"text id {tid+6} start {(t0 + 4.4):.1f}s at (152.0, 50.0) ''[bold][color=#FBBF24]Objet[/color][/bold]'' ;")
        draws.append(f"draw arrow id {did+3} start {(t0 + 5.2):.1f}s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(118, 52), (124, 52)] ;")
        draws.append(f"draw arrow id {did+4} start {(t0 + 5.8):.1f}s for 0.5s color (248, 250, 252, 0.95) width 2.0 at [(144, 52), (150, 52)] ;")

        return texts, draws
