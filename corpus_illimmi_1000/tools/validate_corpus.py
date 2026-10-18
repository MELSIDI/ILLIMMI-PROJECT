#!/usr/bin/env python3
"""
Script de validation et d'audit de conformité pour le Corpus ILLIMMI 1 000 cours.
Vérifie :
1. Les quotas stricts : 500 Maths, 300 Physique-Chimie, 200 Langues (100 FR, 100 EN).
2. L'unicité absolue des identifiants (IDs).
3. La complétude et la conformité au schéma de chaque entrée.
4. La présence des types pédagogiques clés (cours, méthodes, exemples, exercices corrigés, problèmes, synthèses).
5. La conformité de l'alignement 3-Layers (Layer 1, Layer 2, Layer 3).
"""

import json
import csv
import sys
from pathlib import Path
from collections import Counter

ROOT_DIR = Path(__file__).resolve().parent.parent
CATALOG_DIR = ROOT_DIR / "catalog"

def validate():
    print("=" * 70)
    print("AUDIT DE CONFORMITÉ DU CORPUS ILLIMMI 1 000 COURS")
    print("=" * 70)

    full_path = CATALOG_DIR / "corpus_1000_full.json"
    if not full_path.exists():
        print(f"[ERREUR FATALE] Le catalogue {full_path} n'existe pas.")
        sys.exit(1)

    with open(full_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    print(f"Total d'entrées chargées : {len(data)}")

    # 1. Vérification du nombre total
    assert len(data) == 1000, f"Erreur de quota : {len(data)} entrées trouvées au lieu de 1 000."
    print("[PASS] Total exact de 1 000 cours validé.")

    # 2. Vérification de l'unicité des IDs
    ids = [item["id"] for item in data]
    id_counts = Counter(ids)
    duplicates = [item_id for item_id, count in id_counts.items() if count > 1]
    assert len(duplicates) == 0, f"Erreur IDs dupliqués détectés : {duplicates}"
    print("[PASS] Unicité des 1 000 identifiants validée.")

    # 3. Vérification des quotas par discipline
    subject_counts = Counter(item["subject"] for item in data)
    print("\nRépartition par discipline :")
    for subj, count in subject_counts.items():
        print(f"  - {subj:18} : {count}")

    assert subject_counts["Mathématiques"] == 500, f"Erreur quota Maths: {subject_counts['Mathématiques']} != 500"
    assert subject_counts["Physique-Chimie"] == 300, f"Erreur quota Physique: {subject_counts['Physique-Chimie']} != 300"
    assert subject_counts["Français"] == 100, f"Erreur quota Français: {subject_counts['Français']} != 100"
    assert subject_counts["Anglais"] == 100, f"Erreur quota Anglais: {subject_counts['Anglais']} != 100"
    print("[PASS] Quotas par discipline rigoureusement respectés (500 Maths / 300 Phys / 100 FR / 100 EN).")

    # 4. Vérification de la typologie pédagogique
    type_counts = Counter(item["pedagogical_type"] for item in data)
    print("\nRépartition par type pédagogique :")
    for ptype, count in type_counts.items():
        print(f"  - {ptype:22} : {count}")

    mandatory_types = [
        "cours_notion",
        "methode_resolution",
        "exemple_detaille",
        "correction_exercice",
        "probleme_complexe",
        "synthese_revision"
    ]
    for mtype in mandatory_types:
        assert type_counts[mtype] > 0, f"Type pédagogique manquant : {mtype}"
    print("[PASS] Tous les types pédagogiques (notions, méthodes, exemples, exercices corrigés, problèmes, synthèses) sont bien représentés.")

    # 5. Vérification des niveaux (Lycée)
    level_counts = Counter(item["level"] for item in data)
    print("\nRépartition par niveau scolaire :")
    for lvl, count in level_counts.items():
        print(f"  - {lvl:32} : {count}")

    # 6. Vérification de la conformité du schéma et des 3 Layers
    print("\nVérification de la structure interne des entrées...")
    for idx, item in enumerate(data):
        assert "id" in item and item["id"]
        assert "subject" in item and item["subject"]
        assert "level" in item and item["level"]
        assert "domain" in item and item["domain"]
        assert "title" in item and len(item["title"]) >= 10
        assert "creator" in item and item["creator"]
        assert "search_query" in item and item["search_query"]
        assert "pedagogical_target" in item and len(item["pedagogical_target"]) >= 15

        # Layer 1
        l1 = item.get("layer1_spec")
        assert l1 is not None, f"Item {item['id']} manque layer1_spec"
        assert 60 <= l1["duration_target"] <= 300
        assert len(l1["concepts_cles"]) >= 2
        assert len(l1["plan_pedagogique"]) >= 3
        for section in l1["plan_pedagogique"]:
            assert "section" in section
            assert "role" in section
            assert "support_visuel_suggere" in section

        # Layer 2
        l2 = item.get("layer2_spec")
        assert l2 is not None, f"Item {item['id']} manque layer2_spec"
        assert "style_guidance" in l2
        assert "spoken_math_rule" in l2
        assert "visual_anchor_verbalization" in l2 and len(l2["visual_anchor_verbalization"]) > 10

        # Layer 3
        l3 = item.get("layer3_spec")
        assert l3 is not None, f"Item {item['id']} manque layer3_spec"
        assert len(l3["hypercourse_primitives"]) >= 1
        assert l3["recommended_scene_count"] >= 2
        assert l3["pre_erase_validation"] is True

    print("[PASS] Intégrité structurelle des 1 000 entrées validée sans aucune erreur.")

    # 7. Vérification des fichiers annexes
    csv_file = CATALOG_DIR / "corpus_1000_manifest.csv"
    assert csv_file.exists(), "Fichier manifest CSV manquant"
    with open(csv_file, "r", encoding="utf-8") as f:
        reader = list(csv.reader(f))
        assert len(reader) == 1001, f"Lignes CSV : {len(reader)} au lieu de 1001 (en-tête inclus)"
    print("[PASS] Fichier manifeste CSV synchronisé et complet (1 000 lignes).")

    print("\n" + "=" * 70)
    print("TOUS LES CONTRÔLES SONT AU VERT : LE CORPUS EST 100% VALIDE !")
    print("=" * 70)

if __name__ == "__main__":
    validate()
