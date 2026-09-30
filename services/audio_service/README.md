# Audio Service (`services/audio_service`)

Service autonome en Dart pour la synthèse vocale (TTS) et l'alignement temporel mot-à-mot (STT) utilisé par le pipeline ILLIMMI.

## Fonctionnalités

1. **Synthèse vocale (TTS)** :
   - Moteur local par défaut : **Piper TTS** (`speaker/piper/piper.exe` avec modèle `fr_FR-siwis-medium.onnx`).
   - Moteur cloud optionnel : **OpenRouter TTS** (`deepgram/aura-2` avec voix `aura-2-agathe-fr`) avec bascule automatique vers Piper en cas de panne réseau ou quota épuisé.
2. **Alignement temporel (STT)** :
   - Moteur local : **whisper.cpp** (`speaker/whispercpp/Release/whisper-cli.exe` avec modèle `ggml-small.bin`).
   - Algorithme hybride : `NarrationSttAligner` (utilise `narration.txt` comme source de vérité textuelle et Whisper pour les timestamps).
   - Génération de la chronologie compacte `<base>_words.txt` (`<start>mot<end>`).

---

## Installation des Binaires Locaux (Piper, Whisper, FFmpeg)

Pour installer les exécutables et les modèles nécessaires à l'exécution locale :
👉 **Consultez le guide complet : [docs/LOCAL_AUDIO_SETUP.md](../../docs/LOCAL_AUDIO_SETUP.md)**

---

## Lancement

```powershell
dart pub get
dart run bin/server.dart
```

*Le service écoute par défaut sur `http://localhost:8082`.*

---

## Tests

```powershell
dart test
```
