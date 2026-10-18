#!/usr/bin/env python3
"""
Générateur de Datasets d'entraînement pour le Fine-Tuning de Gemma (format Chat / SFT).
Découpe le corpus selon les 3 Layers d'ILLIMMI :
- Tâche 1 : Prompt utilisateur -> Layer 1 (Planification Pédagogique JSON)
- Tâche 2 : Planification Layer 1 -> Layer 2 (Narration parlée avec ancrages visuels)
- Tâche 3 : Narration + Timestamps -> Layer 3 (Script Hypercourse DSL .hc)
- Tâche 4 : End-to-End Multitâche
"""

import argparse
import json
import os
from pathlib import Path
from typing import Dict, Any, List

ROOT_DIR = Path(__file__).resolve().parent.parent
CATALOG_PATH = ROOT_DIR / "catalog" / "corpus_1000_full.json"
DATASET_OUT_DIR = ROOT_DIR / "training_data"
DATASET_OUT_DIR.mkdir(parents=True, exist_ok=True)

PROMPT_L1_SYSTEM = (
    "Tu es ILLIMMI Layer 1, un ingénieur pédagogique d'élite. Tu conçois des plans de cours "
    "structurés, rigoureux et visuellement exploitables pour des lycéens (Seconde, Première, Terminale). "
    "Tu produis un JSON conforme avec sujet, niveau, durée cible, concepts clés et un plan pédagogique ordonné : "
    "accroche, prérequis, exemple concret, définition formelle / méthode, décomposition, erreur fréquente, synthèse."
)

PROMPT_L2_SYSTEM = (
    "Tu es un professeur bienveillant et pédagogue qui rédige le texte parlé intégral d'un cours ILLIMMI. "
    "Le texte est destiné à une synthèse vocale (Piper TTS) et doit guider l'œil de l'élève en synchronisation "
    "avec le tableau blanc. Tu dois obligatoirement verbaliser oralement chaque geste visuel (traçons, regardons, observons). "
    "Règle stricte : AUCUN code LaTeX brut ($x^2$, \\vec{u}) à l'oral ; écris tout en prononciation naturelle ('x au carré', 'vecteur u')."
)

PROMPT_L3_SYSTEM = (
    "Tu es ILLIMMI Layer 3, le compositeur graphique du tableau blanc interactif. "
    "À partir du plan de cours et de la chronologie mot-à-mot horodatée, génère le script Hypercourse (.hc) officiel. "
    "Respecte le repère 16:9 (x de 0 à 177.78, y de 0 à 100), la règle des plages d'ID par idgap, et insère "
    "des commandes 'erase' entre les grandes sections pédagogiques pour délimiter les scènes."
)

def build_layer1_sample(item: Dict[str, Any]) -> Dict[str, Any]:
    user_prompt = f"Explique-moi : {item['title']} (Niveau : {item['level']}, Matière : {item['subject']})"
    assistant_json = {
        "subject": item["subject"],
        "level": item["level"],
        "domain": item["domain"],
        "duration_target": item["layer1_spec"]["duration_target"],
        "concepts_cles": item["layer1_spec"]["concepts_cles"],
        "ton": item["layer1_spec"]["ton"],
        "plan_pedagogique": item["layer1_spec"]["plan_pedagogique"]
    }

    return {
        "id": f"{item['id']}_L1",
        "task": "layer1_planning",
        "messages": [
            {"role": "system", "content": PROMPT_L1_SYSTEM},
            {"role": "user", "content": user_prompt},
            {"role": "assistant", "content": json.dumps(assistant_json, ensure_ascii=False, indent=2)}
        ]
    }

def build_layer2_sample(item: Dict[str, Any]) -> Dict[str, Any]:
    l1_data = {
        "subject": item["subject"],
        "level": item["level"],
        "title": item["title"],
        "plan": item["layer1_spec"]["plan_pedagogique"],
        "concepts": item["layer1_spec"]["concepts_cles"]
    }
    user_prompt = f"Rédige la narration complète du cours à partir de ce plan pédagogique :\n{json.dumps(l1_data, ensure_ascii=False, indent=2)}"
    
    # Construction de la narration type
    speech_lines = [
        f"Bonjour et bienvenue dans cette leçon de {item['subject']}.",
        f"Aujourd'hui, nous allons étudier : {item['title']}.",
        f"Rappelons les bases indispensables : {', '.join(item['layer1_spec']['concepts_cles'][:2])}.",
        "Prenons un cas concret pour que tout devienne limpide.",
        f"{item['layer2_spec']['visual_anchor_verbalization']}",
        "Attention au piège fréquent que beaucoup d'élèves commettent ici en devoir.",
        "Retenez bien cette méthode en trois étapes et appliquez-la systématiquement.",
        "Bon entraînement et à très vite pour le prochain cours !"
    ]
    speech_output = " ".join(speech_lines)

    return {
        "id": f"{item['id']}_L2",
        "task": "layer2_narration",
        "messages": [
            {"role": "system", "content": PROMPT_L2_SYSTEM},
            {"role": "user", "content": user_prompt},
            {"role": "assistant", "content": speech_output}
        ]
    }

def build_layer3_sample(item: Dict[str, Any]) -> Dict[str, Any]:
    user_prompt = (
        f"Génère le script Hypercourse (.hc) synchronisé pour le cours '{item['title']}' "
        f"(Niveau: {item['level']}, Durée: {item['layer1_spec']['duration_target']}s)."
    )

    prims = item["layer3_spec"]["hypercourse_primitives"]
    prim_str = " ; ".join(f"{p} id 10{i+1} start {5 + i*15}.0s at (88.89, 50)" for i, p in enumerate(prims))

    hc_script = f"""course "{item['title']}" id 1 idgap 100 for {item['layer1_spec']['duration_target']}s audio "narration_{item['id']}.wav" {{
    # Scène 1 : Titre et introduction
    text id 1 start 1.0s for 15s at (88.89, 12) ''[bold][color=#1E3A8A]{item['title']}[/color][/bold]'' ;
    text id 2 start 4.5s for 20s at (88.89, 25) ''[italic]{item['pedagogical_target']}[/italic]'' ;

    # Scène 2 : Notions et démonstration visuelle
    erase id 401 start 28.0s ;
    {prim_str} ;

    # Scène 3 : Synthèse et conclusion
    erase id 402 start 85.0s ;
    text id 3 start 88.0s at (88.89, 45) ''[bold]Points clés à retenir :[/bold]'' ;
    text id 4 start 92.0s at (88.89, 60) ''{', '.join(item['layer1_spec']['concepts_cles'])}'' ;
}}"""

    return {
        "id": f"{item['id']}_L3",
        "task": "layer3_hypercourse",
        "messages": [
            {"role": "system", "content": PROMPT_L3_SYSTEM},
            {"role": "user", "content": user_prompt},
            {"role": "assistant", "content": hc_script}
        ]
    }

def main():
    parser = argparse.ArgumentParser(description="Export du dataset de Fine-Tuning Gemma pour ILLIMMI.")
    parser.add_argument("--format", choices=["jsonl", "json"], default="jsonl", help="Format de sortie")
    parser.add_argument("--split", choices=["all", "layer1", "layer2", "layer3"], default="all", help="Sous-ensemble de tâches")
    args = parser.parse_args()

    with open(CATALOG_PATH, "r", encoding="utf-8") as f:
        catalog = json.load(f)

    print(f"Chargement de {len(catalog)} cours depuis le catalogue...")

    l1_samples = [build_layer1_sample(item) for item in catalog]
    l2_samples = [build_layer2_sample(item) for item in catalog]
    l3_samples = [build_layer3_sample(item) for item in catalog]

    def write_jsonl(filename: Path, data: List[Dict[str, Any]]):
        with open(filename, "w", encoding="utf-8") as f:
            for entry in data:
                f.write(json.dumps(entry, ensure_ascii=False) + "\n")
        print(f"[OK] Écrit : {filename} ({len(data)} exemples)")

    if args.split in ("all", "layer1"):
        write_jsonl(DATASET_OUT_DIR / "gemma_layer1_planner.jsonl", l1_samples)
    if args.split in ("all", "layer2"):
        write_jsonl(DATASET_OUT_DIR / "gemma_layer2_audio.jsonl", l2_samples)
    if args.split in ("all", "layer3"):
        write_jsonl(DATASET_OUT_DIR / "gemma_layer3_visuals.jsonl", l3_samples)

    if args.split == "all":
        combined = l1_samples + l2_samples + l3_samples
        write_jsonl(DATASET_OUT_DIR / "gemma_illimmi_complete_3000_samples.jsonl", combined)

    print("\n[SUCCÈS] Datasets d'entraînement Gemma exportés avec succès dans :")
    print(f"  {DATASET_OUT_DIR}")

if __name__ == "__main__":
    main()
