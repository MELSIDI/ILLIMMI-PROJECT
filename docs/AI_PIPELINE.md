# Pipeline IA & Feedback Visuel Multimodal (World Model)

> **Documentation complète du pipeline de génération IA à 2 couches et du système de feedback visuel pré-erase basés sur Google Gemini.**

---

## 1. Vue d'ensemble du Pipeline 2-Layers

La génération d'un cours ILLIMMI s'effectue en 2 étapes successives orchestrées par `services/generation-orchestrator` :

```
[Prompt Utilisateur (ex: "explique la dérivée", niveau optionnel)]
                               │
                               ▼
        ┌──────────────────────────────────────────────┐
        │ Layer 1 : Voix & Narration Orale             │
        │ • Rédige le discours oral complet du prof    │
        │ • Liberté pédagogique & durée totale         │
        │ • Voix Piper TTS + Timestamps Whisper        │
        └──────────────────────────────────────────────┘
                               │
                               ▼
        ┌──────────────────────────────────────────────┐
        │ Layer 2 : Tableau Blanc Hypercourse (.hc)    │
        │ • Reçoit la timeline compacte mot-à-mot      │
        │ • Commandes vectorielles synchronisées       │
        │ • Boucle d'auto-correction visuelle          │
        └──────────────────────────────────────────────┘
                               │
                               ▼
              [Cours (.hc + .wav) Validé & Prêt]
```

---

## 2. Détaillé des Couches (Layers)

### Layer 1 : Narration Audio & Alignement Mot-à-Mot (`Layer1AudioGenerator`)
- **Entrée** : Prompt utilisateur brut, niveau scolaire optionnel, langue.
- **IA** : `GeminiClient` génère le texte brut intégral parlé par le professeur (sans balises, avec phonétique mathématique pour le TTS).
- **Service Audio** : Le texte est envoyé à `audio-service` (`POST /narrate`), qui :
  1. Génère la voix off via Piper TTS (`fr_FR-siwis-medium.onnx`).
  2. Aligne les timestamps acoustiques de Whisper sur le texte officiel de narration (`NarrationSttAligner`).
  3. Produit la chronologie compacte `<base>_words.txt` (`<start>mot<end>`).
- **Sortie** : `TranscriptResult` (transcript horodaté, fichier audio `.wav`, et `compactTimeline`).
- **Documentation détaillée** : voir [AUDIO_ALIGNMENT_TIMELINE.md](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/docs/AUDIO_ALIGNMENT_TIMELINE.md).

---

### Layer 2 : Génération Visuelle Hypercourse (`Layer2VisualGenerator`)
- **Entrée** : `TranscriptResult` (avec `compactTimeline` mot-à-mot injectée directement sans regroupement arbitraire).
- **IA** : `GeminiClient` génère les instructions déclaratives Hypercourse (`text`, `draw`, `mouse`, `erase`).
- **Synchronisation fine** : Le LLM dispose des timestamps précis mot-à-mot (`<3.160>construire<3.600>`) pour caler les animations visuelles exactement à la seconde où chaque notion est prononcée.
- **Règles imposées au modèle** :
  - Déclenchement visuel synchronisé (±1s de la parole).
  - Respect strict de la plage des IDs par famille (`idgap`).
  - Positionnement dans le repère 16:9 (`x ∈ [0, 177.78], y ∈ [0, 100]`).
  - Insertion de commandes `erase` entre les grandes sections du cours.

---

## 3. Feedback Visuel Multimodal (World Model Pre-Erase)

### Le problème de la géométrie à l'aveugle
Un modèle de langage (LLM) qui génère un script texte à l'aveugle ne connaît pas la taille réelle rendue des formules LaTeX ni l'encombrement des éléments. Sans retour visuel, il produit inévitablement des chevauchements de texte, des débordements ou des flèches mal orientées.

### La solution : Stratégie de capture Pré-Erase ($N_{\text{images}} = \text{count}(\text{erase}) + 1$)
Au lieu de générer une capture d'écran par élément (trop lourd) ou par frame vidéo (inutilisable), ILLIMMI découpe le cours en **scènes** délimitées par les commandes `erase` :

```
Scène 1 (0s - 15s)          Erase 401 (15s)       Scène 2 (15s - 40s)         Fin du cours
├── Element Text 1           (Efface 1, 2)         ├── Element Text 3
├── Element Circle 101                             └── Element Arrow 102
└── Element Arrow 102 ───►  📸 Capture 1 (t=14.5s)                             📸 Capture 2 (t=39.5s)
                            [Tous éléments stables]                             [Tous éléments stables]
```

1. **Point de capture** : Situé à $t = \max(\text{startTime} + \text{duration})$ parmi tous les éléments de la scène juste avant l'effacement.
2. **État complet** : À cet instant précis, **tous les éléments de la scène sont entièrement affichés** et aucun n'a encore été effacé.
3. **Nombre d'images optimal** : Strictement égal au **nombre de commandes `erase` + 1**.

---

### Règle d'Immutabilité & Persistance
Si un élément survit à un effacement (non ciblé par `erase`), il passe du statut **Mutable** (nouvel élément à vérifier/corriger) au statut **Immutable** (déjà validé lors d'une scène précédente). 

Dans le prompt adressé au modèle multimodal (World Model Feedback) :
- **Éléments mutables (Liberté totale hors timing start)** : L'IA a le droit de modifier **absolument tous les paramètres** de l'élément pour résoudre tout défaut visuel (coordonnées `at (x, y)`, sommets `[(x, y), ...]`, durée `for`, épaisseur de trait `width`, rayon, couleurs `color` / `fillcolor`, balises de police/style `[bold]`, `[color=...]`, notation KaTeX `$$...$$` et retours à la ligne) **à l'exception stricte du timestamp `start`** qui demeure intangible pour garantir la parfaite synchronisation acoustique mot-à-mot avec la voix du cours.
- **Éléments immutables** : L'IA préserve leur ancrage spatial et leurs attributs afin de garantir la cohérence continue de la démonstration au fil des scènes.

---

## 4. Intégration de l'interface `LlmClient`

Toutes les étapes du pipeline communiquent à travers l'interface abstraite unifiée `LlmClient` ([llm_client.dart](file:///c:/Users/pc%20elqods/Desktop/ILLIMMI-PROJECT/services/generation_orchestrator/lib/pipeline/llm_client.dart)) :

```dart
abstract class LlmClient {
  Future<String> complete({required String system, required String userMessage, int maxTokens});
  Future<Map<String, dynamic>> completeJson({required String system, required String userMessage, required Map<String, dynamic> schema, int maxTokens});
  Future<Map<String, dynamic>> completeMultimodalJson({required String system, required List<ContentBlock> content, required Map<String, dynamic> schema, int maxTokens});
}
```

Par défaut, `JobStore` instancie `GeminiClient` (`gemini-2.5-flash`), tout en restant 100% interopérable avec `ClaudeClient`, `OpenAiClient` ou `DeepSeekClient`.
