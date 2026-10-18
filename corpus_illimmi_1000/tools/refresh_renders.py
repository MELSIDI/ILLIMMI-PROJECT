import json
from pathlib import Path
import subprocess
from corpus_illimmi_1000.tools.agentic_corpus_runner import generate_layer3_visuals_cognitive
from corpus_illimmi_1000.tools.world_model_verifier import WorldModelVerifier

def main():
    courses = ['MATH_001', 'MATH_002', 'MATH_003', 'MATH_004', 'MATH_005']
    with open('corpus_illimmi_1000/catalog/corpus_1000_full.json', 'r', encoding='utf-8') as f:
        cat = json.load(f)

    for cid in courses:
        cdir = Path('corpus_illimmi_1000/courses') / cid
        with open(cdir / 'metadata_layer1.json', 'r', encoding='utf-8') as f:
            l1 = json.load(f)
        with open(cdir / 'narration_layer2.txt', 'r', encoding='utf-8') as f:
            narr = f.read()
        c_meta = next(c for c in cat if c['id'] == cid)
        
        dur = l1.get('total_duration_seconds', 60.0)
        hc = generate_layer3_visuals_cognitive(c_meta, l1, narr, dur)
        hc_path = cdir / 'course_layer3.hc'
        with open(hc_path, 'w', encoding='utf-8') as f:
            f.write(hc)
        
        res_vm = WorldModelVerifier.verify_script(hc)
        print(f"[{cid}] World Model Score: {res_vm['score']}/10 (ok={res_vm['ok']})")
        
        cmd = [
            'dart', 'run', 'bin/render_course_to_images.dart',
            str(hc_path.resolve()),
            str((cdir / 'renders').resolve())
        ]
        res = subprocess.run(cmd, cwd='services/generation_orchestrator', capture_output=True, text=True, encoding='utf-8', errors='replace', shell=True)
        if res.returncode == 0:
            print(f"[{cid}] Successfully re-rendered 5 scenes to PNG.")
        else:
            print(f"[{cid}] Render FAILED: {res.stderr[:200]}")

if __name__ == '__main__':
    main()
