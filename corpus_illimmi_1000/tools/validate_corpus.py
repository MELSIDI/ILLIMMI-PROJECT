#!/usr/bin/env python3
"""
Script de validation et d'audit de conformité pour le Catalogue ILLIMMI 1 000 cours (Lean Schema).
Vérifie :
1. Les quotas stricts : 500 Maths, 300 Physique-Chimie, 200 Langues (100 FR, 100 EN).
2. L'unicité absolue des identifiants (IDs).
3. La complétude et la conformité au schéma épuré (id, subject, level, domain, title, author).
4. L'absence absolue de couches artificielles (aucun layer1_spec, layer2_spec, layer3_spec).
5. La conformité du manifeste CSV (corpus_1000_manifest.csv) et des sous-catalogues.
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
    print("AUDIT DE CONFORMITÉ DU CATALOGUE ILLIMMI 1 000 COURS (LEAN SCHEMA)")
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

    # 4. Vérification des niveaux scolaires (Lycée)
    level_counts = Counter(item["level"] for item in data)
    print("\nRépartition par niveau scolaire :")
    for lvl, count in level_counts.items():
        print(f"  - {lvl:32} : {count}")

    # 5. Vérification du schéma épuré et de l'absence de layers fictifs
    print("\nVérification de la conformité du schéma (Lean Schema sans layers)...")
    forbidden_keys = {"layer1_spec", "layer2_spec", "layer3_spec", "pedagogical_target"}
    required_keys = {"id", "subject", "level", "domain", "title", "author"}

    for idx, item in enumerate(data):
        item_id = item.get("id", f"index_{idx}")
        # Champs obligatoires
        for req in required_keys:
            assert req in item and item[req], f"Item {item_id} manque le champ obligatoire '{req}'"

        # Longueurs minimales
        assert len(item["title"]) >= 10, f"Titre trop court pour {item_id}: {item['title']}"

        # Absence stricte de métadonnées de layers
        for forbidden in forbidden_keys:
            assert forbidden not in item, f"Violation Lean Schema : Item {item_id} contient '{forbidden}'"

    print("[PASS] Schéma épuré validé : aucun layer1_spec, layer2_spec ou layer3_spec résiduel.")

    # 6. Vérification des sous-catalogues
    math_path = CATALOG_DIR / "math_500.json"
    phys_path = CATALOG_DIR / "physique_300.json"
    lang_path = CATALOG_DIR / "langues_200.json"

    assert math_path.exists(), "math_500.json introuvable"
    assert phys_path.exists(), "physique_300.json introuvable"
    assert lang_path.exists(), "langues_200.json introuvable"

    with open(math_path, "r", encoding="utf-8") as f:
        assert len(json.load(f)) == 500, "math_500.json ne contient pas 500 cours"
    with open(phys_path, "r", encoding="utf-8") as f:
        assert len(json.load(f)) == 300, "physique_300.json ne contient pas 300 cours"
    with open(lang_path, "r", encoding="utf-8") as f:
        assert len(json.load(f)) == 200, "langues_200.json ne contient pas 200 cours"
    print("[PASS] Sous-catalogues math_500.json, physique_300.json et langues_200.json validés.")

    # 7. Audit du manifeste CSV
    csv_file = CATALOG_DIR / "corpus_1000_manifest.csv"
    assert csv_file.exists(), f"Fichier {csv_file} manquant"

    with open(csv_file, "r", encoding="utf-8") as f:
        reader = list(csv.reader(f))

    assert len(reader) == 1001, f"Le fichier CSV doit contenir 1 001 lignes (header + 1 000 cours), trouvé: {len(reader)}"
    expected_header = [
        "id", "subject", "level", "domain", "title",
        "author", "youtube_video_id", "youtube_url", "transcript_available"
    ]
    assert reader[0] == expected_header, f"Header CSV non conforme : {reader[0]} != {expected_header}"
    print(f"[PASS] Manifeste CSV validé avec {len(reader)-1} lignes et colonnes Lean conformes.")

    print("\n" + "=" * 70)
    print("CONFORMITÉ TOTALE 100% : LE CATALOGUE LEAN EST CERTIFIÉ CONFORME")
    print("=" * 70)


if __name__ == "__main__":
    validate()
