#!/usr/bin/env python3
"""
Automated self-test suite for `.agents/skills/corpus-illimmi/scripts/`.
Verifies all Layer 1, Layer 2, and Layer 3 Hypercourse guardrails deterministically without hitting YouTube.
"""

import json
import sys
import tempfile
from pathlib import Path

THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR))

PROJECT_ROOT = THIS_DIR.parents[3]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from step1_ingest_youtube import MAX_VIDEO_DURATION_SECONDS  # noqa: E402
from step2_align_audio import validate_layer1_and_layer2  # noqa: E402
from step3_render_and_verify import deep_audit_hc  # noqa: E402
from corpus_illimmi_1000.tools.world_model_verifier import WorldModelVerifier, WorldModelAutoCorrector  # noqa: E402


VALID_METADATA = {
    "course_id": "TEST_001",
    "title": "Test Course",
    "sections": [
        {"section_id": "sec_1", "title": "1. Accroche", "summary": "Intro", "support_visuel_suggere": "draw arrow + axis", "concepts_cles": ["intervalle"]},
        {"section_id": "sec_2", "title": "2. Exemple", "summary": "Ex", "support_visuel_suggere": "draw line", "concepts_cles": ["bornes"]},
        {"section_id": "sec_3", "title": "3. Définition", "summary": "Def", "support_visuel_suggere": "text", "concepts_cles": ["définition"]},
        {"section_id": "sec_4", "title": "4. Synthèse", "summary": "Syn", "support_visuel_suggere": "draw circle", "concepts_cles": ["bilan"]},
    ],
}

VALID_NARRATION = " ".join([
    "Bonjour et bienvenue dans ce cours de Seconde consacré aux intervalles de nombres réels et à leur représentation géométrique.",
    "Traçons tout d'abord à droite un axe gradué orienté afin de visualiser concrètement tous les nombres réels compris entre moins deux et six.",
    "Plaçons soigneusement les deux bornes sur cet axe et observons comment l'orientation des crochets indique immédiatement si chaque borne est incluse ou exclue.",
    "Prenons un premier cas concret très simple : lorsque le réel x est supérieur ou égal à deux et strictement inférieur à cinq, on tourne le crochet vers l'intérieur en deux et vers l'extérieur en cinq.",
    "Regarde maintenant sur la figure comment déterminer le centre et le rayon de cet intervalle étape par étape sans jamais te tromper de signe.",
    "L'amplitude totale grand A vaut toujours la borne supérieure b moins la borne inférieure a, soit six moins moins deux égale huit, et le rayon vaut exactement la moitié de cette longueur, soit quatre.",
    "Attention au piège classique en devoir surveillé : du côté de plus l'infini ou de moins l'infini, le crochet reste obligatoirement ouvert car l'infini n'est jamais un nombre réel atteignable.",
    "Observons également que l'intervalle contient une infinité continue de nombres décimaux et irrationnels comme pi ou racine de deux, contrairement à un simple ensemble fini d'entiers entre accolades.",
    "Encadrons enfin les deux formules essentielles au tableau pour bien les mémoriser et les appliquer sereinement dans tes prochains exercices d'entraînement.",
    "Continue à t'entraîner régulièrement en dessinant toujours un axe gradué au brouillon, et à très vite pour la suite du programme de mathématiques !",
])

VALID_HC = """course "Test Course" id 1 idgap 100 for 95.0s audio "narration.wav" {
    # Scene 1
    text id 1 start 0.3s at (4.0, 8.0) ''[bold][color=#38BDF8]1. Accroche & Axe Réel[/color][/bold]'' ;
    draw line id 101 start 0.5s for 0.6s color (56, 189, 248, 0.45) width 1.5 at [(4, 14), (173, 14)] ;
    text id 2 start 1.2s at (4.0, 28.0) ''Étudions l'intervalle $[2 ; 5[$ :'' ;
    text id 3 start 4.0s at (4.0, 44.0) ''$$x \\in [2 ; 5[ \\iff 2 \\le x < 5$$'' ;
    draw arrow id 102 start 2.0s for 1.0s color (248, 250, 252, 0.95) width 2.0 at [(96, 54), (170, 54)] ;
    draw line id 103 start 3.5s for 0.8s color (56, 189, 248, 1) width 4.5 at [(118, 54), (154, 54)] ;
    draw path id 104 start 4.4s for 0.5s color (52, 211, 153, 1) width 2.5 at [(121, 49), (118, 49), (118, 59), (121, 59)] ;

    # Scene 2
    erase id 401 start 32.0s ;
    text id 4 start 32.4s at (4.0, 8.0) ''[bold][color=#34D399]2. Dérivée Seconde & Courbe[/color][/bold]'' ;
    draw line id 105 start 32.6s for 0.5s color (52, 211, 153, 0.45) width 1.5 at [(4, 14), (173, 14)] ;
    text id 5 start 34.0s at (4.0, 30.0) ''Convexité : $$f^{\\prime\\prime}(x) \\ge 0$$'' ;
    draw 2drep id 106 start 35.0s for 1.0s at (132, 56) color (248, 250, 252, 0.9) width 1.5 scale = 6.0 grid = true step = 1 x_range = [-3, 3] y_range = [-1, 5] ;
    draw 2dfunc id 107 start 36.5s for 1.5s color (56, 189, 248, 1) width 2.5 at 106 y = 0.5 * x^2 ;

    # Scene 3
    erase id 402 start 65.0s ;
    text id 6 start 65.4s at (4.0, 8.0) ''[bold][color=#FBBF24]3. Synthèse & Piège Classique[/color][/bold]'' ;
    draw line id 108 start 65.6s for 0.5s color (251, 191, 36, 0.45) width 1.5 at [(4, 14), (173, 14)] ;
    text id 7 start 67.0s at (4.0, 32.0) ''Crochet toujours ouvert en $\\pm\\infty$ : $]-\\infty ; 3[$'' ;
    draw circle id 109 start 69.0s for 1.0s color (251, 191, 36, 1) fillcolor (251, 191, 36, 0.18) width 2.0 radius 18 at (132, 56) ;
    mouse move id 301 start 71.0s for 1.5s at [(114, 56), (150, 56)] ;
}
"""


def run_tests():
    with tempfile.TemporaryDirectory() as tmp:
        cdir = Path(tmp) / "TEST_001"
        cdir.mkdir(parents=True)
        (cdir / "metadata.json").write_text(json.dumps(VALID_METADATA), encoding="utf-8")
        (cdir / "narration.txt").write_text(VALID_NARRATION, encoding="utf-8")

        # 1. Valid Layer 1 & Layer 2
        errs = validate_layer1_and_layer2(cdir)
        assert not errs, f"Expected valid L1/L2, got: {errs}"

        # 2. Catch raw LaTeX & YouTuber leak in Layer 2
        (cdir / "narration.txt").write_text(VALID_NARRATION + " Calculons $x^2$ avec Yvan Monka, abonne-toi !", encoding="utf-8")
        errs_bad = validate_layer1_and_layer2(cdir)
        assert len(errs_bad) >= 3, f"Expected >=3 L2 errors, got: {errs_bad}"

        # 3. Valid Hypercourse .hc passes deep_audit_hc cleanly
        lock_file = cdir / "initial_starts.json"
        hc_errs, _, hc_info = deep_audit_hc(VALID_HC, 95.0, lock_file, unlock_starts=False)
        assert not hc_errs, f"Expected valid HC, got errors: {hc_errs}"
        lock_file.write_text(json.dumps(hc_info["current_starts"]), encoding="utf-8")

        # 4. Catch timing lock mutation on visual-fix pass
        mutated_hc = VALID_HC.replace("text id 2 start 1.2s", "text id 2 start 2.5s")
        lock_errs, _, _ = deep_audit_hc(mutated_hc, 95.0, lock_file, unlock_starts=False)
        assert any("TIMING LOCK VIOLATION" in e for e in lock_errs), f"Expected timing lock error, got: {lock_errs}"

        # 5. Catch f''(x) early string termination + duplicate ID + raw bracket
        broken_hc = VALID_HC.replace("text id 4", "text id 2").replace("$[2 ; 5[$", "[2 ; 5[")
        dup_errs, _, _ = deep_audit_hc(broken_hc, 95.0, lock_file, unlock_starts=True)
        assert any("DUPLICATE ID 2" in e for e in dup_errs), f"Expected duplicate ID error, got: {dup_errs}"
        assert any("Raw '[' or ']'" in e for e in dup_errs), f"Expected raw bracket error, got: {dup_errs}"

        fprime_hc = VALID_HC.replace("f^{\\prime\\prime}(x)", "f''(x)")
        fp_errs, _, _ = deep_audit_hc(fprime_hc, 95.0, lock_file, unlock_starts=True)
        assert fp_errs, "Expected tokenizer error on f''(x) inside ''...''"

        # 6. Verify ZERO upper cap: 10,000+ words narration & 20 sections pass cleanly, while summarizing is caught
        assert MAX_VIDEO_DURATION_SECONDS == 3600, f"Expected 3600s YouTube cap, got {MAX_VIDEO_DURATION_SECONDS}"
        long_dir = Path(tmp) / "TEST_10000"
        long_dir.mkdir(parents=True)
        long_meta = {
            "course_id": "TEST_10000",
            "title": "Long Full Course",
            "sections": [
                {
                    "section_id": f"sec_{k}",
                    "title": f"{k}. Étape approfondie",
                    "summary": "Développement intégral",
                    "support_visuel_suggere": "draw 2drep + draw 2dfunc",
                    "concepts_cles": ["analyse"],
                }
                for k in range(1, 21)
            ],
        }
        long_narration = " ".join([VALID_NARRATION] * 60)  # > 10,000 words
        assert len(long_narration.split()) > 10000
        (long_dir / "metadata.json").write_text(json.dumps(long_meta), encoding="utf-8")
        (long_dir / "raw_transcript.txt").write_text(long_narration, encoding="utf-8")
        (long_dir / "narration.txt").write_text(long_narration, encoding="utf-8")
        errs_10k = validate_layer1_and_layer2(long_dir)
        assert not errs_10k, f"Expected 10,000+ word course to pass with zero upper limit, got: {errs_10k}"

        # Catch accidental summarization when raw_transcript is long
        (long_dir / "narration.txt").write_text(VALID_NARRATION, encoding="utf-8")
        errs_trunc = validate_layer1_and_layer2(long_dir)
        assert any("TRUNCATION/SUMMARIZATION DETECTED" in e for e in errs_trunc), f"Expected truncation guard, got: {errs_trunc}"

        # 7. World Model Verifier: 2drep & 2dfunc scale and grid checks
        wm_valid = WorldModelVerifier.verify_script(VALID_HC, 95.0)
        assert wm_valid["ok"], f"Expected VALID_HC to pass WorldModelVerifier, got: {wm_valid['issues']}"

        # Scale too small (scale = 1.0 on x in [-3, 3] gives width = 6u < 22u)
        small_hc = VALID_HC.replace("scale = 6.0", "scale = 1.0")
        wm_small = WorldModelVerifier.verify_script(small_hc, 95.0)
        assert not wm_small["ok"], "Expected WorldModelVerifier to reject tiny repere with scale=1.0"
        assert any("trop petit" in iss for iss in wm_small["issues"]), f"Expected scale warning, got: {wm_small['issues']}"

        # Overflowing canvas (scale = 25.0 extends to 132 + 3*25 = 207 > 177.78)
        overflow_hc = VALID_HC.replace("scale = 6.0", "scale = 25.0")
        wm_over = WorldModelVerifier.verify_script(overflow_hc, 95.0)
        assert not wm_over["ok"], "Expected WorldModelVerifier to reject overflowing repere"
        assert any("déborde du canevas" in iss for iss in wm_over["issues"]), f"Expected bounding error, got: {wm_over['issues']}"

        # 8. Positive Domain Repère: [0, 10] x [0, 10] placed at bottom-left at (104, 84) with scale = 5.5
        pos_hc = VALID_HC.replace(
            "draw 2drep id 106 start 35.0s for 1.0s at (132, 56) color (248, 250, 252, 0.9) width 1.5 scale = 6.0 grid = true step = 1 x_range = [-3, 3] y_range = [-1, 5] ;",
            "draw 2drep id 106 start 35.0s for 1.0s at (104, 84) color (248, 250, 252, 0.9) width 1.5 scale = 5.5 grid = true step = 1 x_range = [0, 10] y_range = [0, 10] ;"
        ).replace("y = 0.5 * x^2", "y = sqrt(x)")
        wm_pos = WorldModelVerifier.verify_script(pos_hc, 95.0)
        assert wm_pos["ok"], f"Expected positive-quadrant repere at (104, 84) to pass, got: {wm_pos['issues']}"

        # 9. AutoCorrector: Reposition overflowing repere adaptively
        bad_pos_hc = VALID_HC.replace(
            "draw 2drep id 106 start 35.0s for 1.0s at (132, 56) color (248, 250, 252, 0.9) width 1.5 scale = 6.0 grid = true step = 1 x_range = [-3, 3] y_range = [-1, 5] ;",
            "draw 2drep id 106 start 35.0s for 1.0s at (132, 56) color (248, 250, 252, 0.9) width 1.5 scale = 6.0 grid = true step = 1 x_range = [0, 10] y_range = [0, 10] ;"
        )
        corrected_hc = WorldModelAutoCorrector.correct_script(bad_pos_hc)
        wm_corr = WorldModelVerifier.verify_script(corrected_hc, 95.0)
        assert wm_corr["ok"], f"Expected auto-corrected script to pass, got: {wm_corr['issues']}"
        assert "at (103.0, 85.0)" in corrected_hc or "at (103, 85)" in corrected_hc, f"Expected adaptive origin near bottom-left, got: {corrected_hc}"

    print("ALL 9 SELF-TESTS PASSED SUCCESSFULLY!")


if __name__ == "__main__":
    run_tests()
