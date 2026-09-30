# Installation Locale de Piper TTS & Whisper.cpp

> **Guide complet pour installer et configurer en local les moteurs exacts de synthèse vocale (Piper) et d'alignement temporel (whisper.cpp) utilisés par `services/audio_service`.**

---

## 1. Vue d'ensemble des Composants Locaux

Le service audio d'ILLIMMI (`services/audio_service`) fonctionne de manière **100% autonome et locale** (hors ligne et sans coût d'API) grâce à trois outils natifs :

| Outil | Rôle dans ILLIMMI | Fichier / Emplacement exact |
| :--- | :--- | :--- |
| **FFmpeg** | Convertit l'audio Piper (22.05 kHz) en WAV 16 kHz mono 16-bit requis par Whisper | Dans le `PATH` système (ou `FFMPEG_EXE_PATH`) |
| **Piper TTS** | Synthèse vocale neuronale ultra-rapide en français (voix Siwis) | `services/audio_service/speaker/piper/piper.exe` |
| **whisper.cpp** | Extraction acoustique des timestamps par mot (`-ml 1`) | `services/audio_service/speaker/whispercpp/Release/whisper-cli.exe` |

---

## 2. Arborescence Cible Requise

Pour que `audio_service` détecte automatiquement les binaires et modèles sans variable d'environnement, l'arborescence dans `services/audio_service/` doit être la suivante :

```text
services/audio_service/
└── speaker/
    ├── piper/
    │   ├── piper.exe                      <-- Exécutable Piper
    │   ├── espeak-ng.dll                  <-- Bibliothèques phonétiseur
    │   ├── onnxruntime.dll                <-- Runtime ONNX
    │   ├── piper_phonemize.dll
    │   ├── espeak-ng-data/                <-- Données de phonétisation
    │   └── model/
    │       ├── fr_FR-siwis-medium.onnx     <-- Modèle voix français (~63 Mo)
    │       └── fr_FR-siwis-medium.onnx.json
    │
    └── whispercpp/
        ├── Release/
        │   ├── whisper-cli.exe            <-- CLI de whisper.cpp
        │   ├── whisper.dll
        │   └── ggml.dll (et variantes CPU)
        └── models/
            └── ggml-small.bin              <-- Modèle Whisper small (~488 Mo)
```

---

## 3. Étape 1 : Installer FFmpeg (Indispensable)

Whisper nécessite impérativement un flux audio WAV à **16 000 Hz, 1 canal (mono), encodé en PCM 16-bit**. FFmpeg effectue cette conversion en mémoire avant l'alignement.

### Sous Windows :
Via Winget (recommandé) :
```powershell
winget install Gyan.FFmpeg
```
Ou via Chocolatey :
```powershell
choco install ffmpeg
```
*Vérifiez ensuite dans un nouveau terminal :*
```powershell
ffmpeg -version
```

### Sous Linux / Debian / Ubuntu :
```bash
sudo apt update && sudo apt install -y ffmpeg
```

### Sous macOS :
```bash
brew install ffmpeg
```

---

## 4. Étape 2 : Installer Piper TTS (Synthèse vocale)

### A. Télécharger le binaire Piper

1. Rendez-vous sur la page officielle des releases Piper :
   👉 **https://github.com/rhasspy/piper/releases**
2. Téléchargez l'archive correspondant à votre architecture :
   - **Windows x64** : `piper_windows_amd64.zip`
   - **Linux x86_64** : `piper_linux_x86_64.tar.gz`
   - **macOS (Apple Silicon)** : `piper_macos_aarch64.tar.gz`
3. Décompressez le contenu directement dans :
   `services/audio_service/speaker/piper/`

*Contenu décompressé attendu :* `piper.exe`, `espeak-ng.dll`, `onnxruntime.dll`, `piper_phonemize.dll` et le dossier `espeak-ng-data`.

---

### B. Télécharger le modèle vocal français (`siwis-medium`)

Le projet utilise par défaut la voix **Siwis** (`fr_FR-siwis-medium`), une voix féminine posée et pédagogique.

Créez le sous-dossier `model` :
```powershell
New-Item -ItemType Directory -Force "services\audio_service\speaker\piper\model"
```

Téléchargez les 2 fichiers suivants depuis Hugging Face :
1. **Modèle ONNX (~63 Mo)** :
   👉 [https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx](https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx)
   *Placer sous :* `services/audio_service/speaker/piper/model/fr_FR-siwis-medium.onnx`

2. **Fichier JSON de configuration (~5 Ko)** :
   👉 [https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx.json](https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx.json)
   *Placer sous :* `services/audio_service/speaker/piper/model/fr_FR-siwis-medium.onnx.json`

*(Optionnel - Modèles alternatifs supportés : `fr_FR-tom-medium` pour une voix masculine, `fr_FR-upmc-medium`).*

---

## 5. Étape 3 : Installer whisper.cpp (Alignement temporel)

### A. Télécharger le binaire `whisper-cli`

1. Rendez-vous sur la page officielle des releases whisper.cpp :
   👉 **https://github.com/ggerganov/whisper.cpp/releases**
2. Téléchargez :
   - **Windows x64** : `whisper-bin-x64.zip` (ou la version CUDA `whisper-cublas-bin-x64.zip` si vous possédez une carte NVIDIA).
   - **Linux / macOS** : Vous pouvez compiler directement en 1 minute :
     ```bash
     git clone https://github.com/ggerganov/whisper.cpp.git
     cd whisper.cpp
     cmake -B build
     cmake --build build --config Release -j
     ```
3. Décompressez les exécutables et DLLs dans :
   `services/audio_service/speaker/whispercpp/Release/`

*Exécutable requis par le projet :* `whisper-cli.exe` (ou `whisper-cli` sous Linux).

---

### B. Télécharger le modèle Whisper (`ggml-small.bin`)

Le projet utilise le modèle **`small`** (~488 Mo), offrant un équilibre parfait entre fidélité de transcription phonétique en français et rapidité de calcul CPU (< 3 secondes pour 3 minutes d'audio).

Créez le sous-dossier `models` :
```powershell
New-Item -ItemType Directory -Force "services\audio_service\speaker\whispercpp\models"
```

Téléchargez le modèle GGML :
👉 [https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin)
*Placer sous :* `services/audio_service/speaker/whispercpp/models/ggml-small.bin`

---

## 6. Script d'Installation Automatique (PowerShell Windows)

Pour installer l'ensemble en une seule commande sous Windows PowerShell :

```powershell
# Exécuter depuis la racine du projet ILLIMMI-PROJECT
$baseDir = Join-Path (Get-Location) "services\audio_service\speaker"

# 1. Dossiers
$piperDir   = Join-Path $baseDir "piper"
$piperModel = Join-Path $piperDir "model"
$whisperDir = Join-Path $baseDir "whispercpp\Release"
$whisperMod = Join-Path $baseDir "whispercpp\models"

New-Item -ItemType Directory -Force $piperModel, $whisperDir, $whisperMod | Out-Null

# 2. Modèles Piper (Siwis FR)
Write-Host "[1/4] Telechargement de la voix Piper Siwis..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx" -OutFile (Join-Path $piperModel "fr_FR-siwis-medium.onnx")
Invoke-WebRequest -Uri "https://huggingface.co/rhasspy/piper-voices/resolve/main/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx.json" -OutFile (Join-Path $piperModel "fr_FR-siwis-medium.onnx.json")

# 3. Modele Whisper Small
Write-Host "[2/4] Telechargement du modele whisper.cpp (ggml-small.bin)..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin" -OutFile (Join-Path $whisperMod "ggml-small.bin")

Write-Host "[OK] Modeles installes avec succes !" -ForegroundColor Green
Write-Host "Pensez a decompresser piper.exe dans $piperDir et whisper-cli.exe dans $whisperDir si ce n'est pas deja fait."
```

---

## 7. Variables d'Environnement (Optionnelles)

Si vous installez les binaires ou modèles dans d'autres répertoires, configurez simplement ces variables dans votre fichier `.env` :

```env
# Chemins personnalises pour Piper TTS
PIPER_EXE_PATH="C:/tools/piper/piper.exe"
PIPER_MODEL_PATH="C:/tools/piper/fr_FR-siwis-medium.onnx"

# Chemins personnalises pour whisper.cpp
WHISPERCPP_EXE_PATH="C:/tools/whisper/whisper-cli.exe"
WHISPERCPP_MODEL_PATH="C:/tools/whisper/ggml-small.bin"

# Chemin personnalise pour FFmpeg
FFMPEG_EXE_PATH="C:/tools/ffmpeg/bin/ffmpeg.exe"
```

---

## 8. Test & Validation de l'Installation

Pour vérifier que l'ensemble fonctionne parfaitement, exécutez la suite de tests automatisés :

```powershell
cd services/audio_service
dart test test/narration_stt_aligner_test.dart
dart test test/piper_service_test.dart
```

Si les tests affichent `All tests passed!`, votre stack locale TTS & Whisper est 100% opérationnelle !
