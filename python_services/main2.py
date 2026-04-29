import os
import uuid
import wave
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from piper import PiperVoice
import ollama  # <--- REMPLACEMENT DE GEMINI
from synchronizer import CourseSynchronizer
from dotenv import load_dotenv
from fastapi.middleware.cors import CORSMiddleware

# 1. Chargement des variables (plus besoin de clé API, mais on garde pour config)
load_dotenv()

app = FastAPI()

# --- AJOUT CÔTÉ SERVEUR POUR LE WEB (CORS) ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

os.makedirs("static/audio", exist_ok=True)
app.mount("/static", StaticFiles(directory="static"), name="static")

# --- 2. CHARGEMENT DU MODÈLE PIPER ---
VOICE_MODEL_PATH = "static/voices/fr_FR-upmc-medium.onnx"
VOICE_CONFIG_PATH = "static/voices/fr_FR-upmc-medium.onnx.json"

piper_voice = None
print("⏳ Chargement de Piper en mémoire...")
try:
    if os.path.exists(VOICE_MODEL_PATH):
        piper_voice = PiperVoice.load(VOICE_MODEL_PATH, config_path=VOICE_CONFIG_PATH)
        print("✅ Piper est prêt !")
    else:
        print(f"❌ ERREUR : Le fichier de voix est introuvable ici : {VOICE_MODEL_PATH}")
except Exception as e:
    print(f"❌ ERREUR PIPER : {e}")

# --- 3. CHARGEMENT DU PROMPT SYSTÈME ---
SYSTEM_INSTRUCTION = "Tu es un assistant pédagogique."
try:
    if os.path.exists('systemeprompt.txt'):
        with open('systemeprompt.txt', 'r', encoding='utf-8') as f:
            SYSTEM_INSTRUCTION = f.read()
            print("✅ Prompt système chargé.")
except Exception:
    print("⚠️ Prompt système par défaut utilisé.")
    pass


# --- 4. PROVIDER PIPER ---
def piper_provider(text):
    """Génère du WAV via Piper en local"""
    if piper_voice is None:
        return None, None

    try:
        filename = f"{uuid.uuid4()}.wav"
        local_path = f"static/audio/{filename}"

        with wave.open(local_path, "wb") as wav_file:
            piper_voice.synthesize(text, wav_file)

        # URL pour localhost
        public_url = f"http://localhost:8000/{local_path}"

        return local_path, public_url

    except Exception as e:
        print(f"Erreur Piper: {e}")
        return None, None


class CourseRequest(BaseModel):
    topic: str
    level: str = "débutant"


@app.post("/generate_course")
async def generate_course(request: CourseRequest):
    print(f"📩 Nouvelle demande : {request.topic} ({request.level})")
    print("🧠 Ollama (Gemma:2b) réfléchit...")

    try:
        # Appel à Ollama en local
        response = ollama.chat(
            model='gemma:2b',
            messages=[
                {'role': 'system', 'content': SYSTEM_INSTRUCTION},
                {'role': 'user', 'content': f"Sujet: {request.topic}. Niveau {request.level}."}
            ]
        )

        # Récupération du texte
        draft_script = response['message']['content']

    except Exception as e:
        print(f"❌ Erreur Ollama: {e}")
        # En cas d'erreur, on renvoie un JSON d'erreur propre
        # (Ou un script de secours si tu préfères)
        return {"error": "Ollama n'est pas accessible. Vérifie qu'il tourne bien."}

    # Nettoyage (Gemma 2b est parfois bavard)
    draft_script = draft_script.replace("```dart", "").replace("```", "").strip()

    # On cherche le début du script réel
    if "course" in draft_script:
        idx = draft_script.find("course")
        draft_script = draft_script[idx:]

    print("📝 Script généré par Gemma. Synchronisation audio...")

    # 2. Piper génère l'audio et on synchronise
    synchronizer = CourseSynchronizer(piper_provider)
    final_script = synchronizer.process_script(draft_script)

    print("🚀 Cours prêt !")
    print(final_script)
    return {"script": final_script}