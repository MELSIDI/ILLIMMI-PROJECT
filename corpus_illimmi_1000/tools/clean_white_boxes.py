import re
from pathlib import Path

def clean_engine():
    engine_path = Path("corpus_illimmi_1000/tools/pedagogical_visuals_engine.py")
    content = engine_path.read_text(encoding="utf-8")

    # 1. Translucent chalk fills instead of opaque white/pastel fills
    fill_replacements = [
        ('fillcolor (239, 246, 255, 0.95)', 'fillcolor (56, 189, 248, 0.20)'),
        ('fillcolor (239, 246, 255, 0.8)', 'fillcolor (56, 189, 248, 0.20)'),
        ('fillcolor (239, 246, 255, 1)', 'fillcolor (56, 189, 248, 0.20)'),
        ('fillcolor (254, 242, 242, 0.95)', 'fillcolor (248, 113, 113, 0.20)'),
        ('fillcolor (209, 250, 229, 0.8)', 'fillcolor (52, 211, 153, 0.20)'),
        ('fillcolor (240, 253, 244, 0.8)', 'fillcolor (52, 211, 153, 0.20)'),
        ('fillcolor (240, 253, 244, 1)', 'fillcolor (52, 211, 153, 0.20)'),
        ('fillcolor (255, 251, 235, 0.8)', 'fillcolor (251, 191, 36, 0.20)'),
        ('fillcolor (255, 251, 235, 1)', 'fillcolor (251, 191, 36, 0.20)'),
        ('fillcolor (245, 243, 255, 0.8)', 'fillcolor (192, 132, 252, 0.20)'),
        ('fillcolor (241, 245, 249, 1)', 'fillcolor (56, 189, 248, 0.20)'),
        # Near-black dots to chalk white dots
        ('color (15, 23, 42, 1) fillcolor (15, 23, 42, 1)', 'color (248, 250, 252, 1) fillcolor (248, 250, 252, 1)'),
    ]

    for old_s, new_s in fill_replacements:
        content = content.replace(old_s, new_s)

    engine_path.write_text(content, encoding="utf-8")
    print("Cleaned all opaque fills to translucent chalkboard tints.")

if __name__ == "__main__":
    clean_engine()
