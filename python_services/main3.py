import os
import uuid
import wave
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from piper import PiperVoice
import google.generativeai as genai
from synchronizer import CourseSynchronizer
from dotenv import load_dotenv
from fastapi.middleware.cors import CORSMiddleware

# 1. Chargement des variables d'environnement
load_dotenv()

# Vérification de la clé API
api_key = os.getenv("GOOGLE_API_KEY")
if not api_key:
    print("⚠️ ATTENTION: Clé API non trouvée. Gemini ne fonctionnera pas.")
    api_key = "PAS_DE_CLE"
else:
    print(f"✅ Clé API chargée (début: {api_key[:5]}...)")

app = FastAPI()

# Configuration CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

os.makedirs("static/audio", exist_ok=True)
app.mount("/static", StaticFiles(directory="static"), name="static")

# 2. CHARGEMENT PIPER
VOICE_MODEL_PATH = "static/voices/fr_FR-upmc-medium.onnx"
VOICE_CONFIG_PATH = "static/voices/fr_FR-upmc-medium.onnx.json"

piper_voice = None
print("⏳ Chargement de Piper en mémoire...")
try:
    if os.path.exists(VOICE_MODEL_PATH):
        piper_voice = PiperVoice.load(VOICE_MODEL_PATH, config_path=VOICE_CONFIG_PATH)
        print("✅ Piper est prêt !")
    else:
        print(f"❌ ERREUR : Fichiers voix introuvables : {VOICE_MODEL_PATH}")
except Exception as e:
    print(f"❌ ERREUR PIPER : {e}")

# 3. CONFIGURATION GEMINI
if api_key != "PAS_DE_CLE":
    genai.configure(api_key=api_key)

SYSTEM_INSTRUCTION = "Tu es un assistant pédagogique."
try:
    if os.path.exists('systemeprompt.txt'):
        with open('systemeprompt.txt', 'r', encoding='utf-8') as f:
            SYSTEM_INSTRUCTION = f.read()
            print("✅ Prompt système chargé.")
except Exception:
    pass

# Note: "gemini-2.5-flash" n'existe pas encore publiquement, j'ai mis "1.5-flash"
model = genai.GenerativeModel("gemini-2.5-flash", system_instruction=SYSTEM_INSTRUCTION)


# --- FONCTION DE NETTOYAGE STRICTE ---
def clean_gemini_output(text):
    """
    Extrait uniquement le bloc 'course "Titre" { ... }'
    et supprime tout le blabla autour (Markdown, explications, etc.)
    """
    # 1. Enlever les balises Markdown code
    text = text.replace("```hypercourse", "").replace("```dart", "").replace("```", "").strip()

    # 2. Trouver le début du script
    start_index = text.find("course")
    if start_index == -1:
        # Si on ne trouve pas "course", on renvoie le texte tel quel (c'est une erreur de l'IA)
        return text

        # 3. Compter les accolades pour trouver la vraie fin
    content = text[start_index:]
    open_braces = 0
    end_index = 0
    found_start_brace = False

    for i, char in enumerate(content):
        if char == '{':
            open_braces += 1
            found_start_brace = True
        elif char == '}':
            open_braces -= 1
            # Si on revient à 0 après avoir commencé, c'est la fin du script
            if found_start_brace and open_braces == 0:
                end_index = i + 1
                break

    if end_index > 0:
        return content[:end_index]

    return content  # Fallback


# 4. PROVIDER PIPER
def piper_provider(text):
    if piper_voice is None: return None, None
    try:
        filename = f"{uuid.uuid4()}.wav"
        local_path = f"static/audio/{filename}"
        with wave.open(local_path, "wb") as wav_file:
            piper_voice.synthesize(text, wav_file)
        # IMPORTANT: localhost pour ton PC
        public_url = f"http://localhost:8000/{local_path}"
        return local_path, public_url
    except Exception as e:
        print(f"Err Audio: {e}")
        return None, None


class CourseRequest(BaseModel):
    topic: str
    level: str = "débutant"


@app.post("/generate_course")
async def generate_course(request: CourseRequest):
    print(f"📩 Nouvelle demande : {request.topic} ({request.level})")

    # 1. Gemini génère le texte
    print("🤖 Gemini réfléchit...")
    try:
        response = model.generate_content(f"Sujet: {request.topic}. Niveau {request.level}.")
        raw_text = response.text
    except Exception as e:
        print(f"❌ Erreur Gemini: {e}")
        return {"error": str(e)}

    # 2. NETTOYAGE CHIRURGICAL
    # C'est ici qu'on enlève les explications et le Markdown
    cleaned_script = clean_gemini_output(raw_text)

    print("📝 Script nettoyé. Début de la synchronisation...")

    # 3. Piper génère l'audio et Synchronizer injecte les durées
    synchronizer = CourseSynchronizer(piper_provider)
    final_script = synchronizer.process_script(cleaned_script)

    print("🚀 Cours prêt !")
    # print(final_script) # Décommente si tu veux voir le résultat dans la console
    print(final_script)
    return {"script": final_script}