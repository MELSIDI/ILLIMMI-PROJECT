import re
import os
from mutagen.mp3 import MP3
from typing import Tuple


class CourseSynchronizer:
    def __init__(self, tts_provider_func, static_dir="static/audio"):
        """
        tts_provider_func: Fonction qui prend (texte) et retourne (chemin_fichier_local, url_web)
        static_dir: Dossier où sont stockés les fichiers
        """
        self.tts_provider = tts_provider_func
        self.static_dir = static_dir

    def get_audio_duration(self, file_path: str) -> float:
        """Mesure la durée exacte d'un MP3 en secondes"""
        try:
            ext = os.path.splitext(file_path)[1].lower()

            if ext == ".wav":
                audio = WAVE(file_path)
                return audio.info.length
            elif ext == ".mp3":
                audio = MP3(file_path)
                return audio.info.length
            else:
                return 0.0
        except Exception as e:
            print(f"Erreur lecture durée {file_path}: {e}")
            return 0.0

    def process_script(self, raw_script: str) -> str:
        """
        Lit le script, génère les audios, et recalcule tous les timestamps.
        """
        lines = raw_script.split('\n')
        new_lines = []

        # Le décalage temporel cumulé (en secondes)
        # Si un audio dure 1s de plus que prévu, shift_accumulator prend +1.0
        shift_accumulator = 0.0

        # Regex pour capturer: start X.Xs (et optionnellement duration Y.Ys)
        # Groupe 1: start value
        # Groupe 2: duration value (optionnel)
        time_pattern = re.compile(r'start\s+([\d\.]+)(?:s)?(?:\s+duration\s+([\d\.]+)(?:s)?)?')

        # Regex pour détecter une commande speech
        speech_pattern = re.compile(r'speech\s+"([^"]+)"')

        print("--- DÉBUT DE LA SYNCHRONISATION ---")

        for line in lines:
            # Si la ligne est vide ou un commentaire, on passe
            if not line.strip() or line.strip().startswith('#') or line.strip().startswith('course'):
                new_lines.append(line)
                continue

            # 1. On applique le décalage actuel au 'start' de la ligne
            current_line = line

            match_time = time_pattern.search(current_line)
            if match_time:
                original_start = float(match_time.group(1))

                # Nouveau départ = Ancien départ + Décalage accumulé
                new_start = round(original_start + shift_accumulator, 2)

                # On remplace dans le texte (méthode un peu brute mais efficace)
                # On remplace "start X.X" par "start Y.Y"
                current_line = re.sub(
                    r'start\s+[\d\.]+(?:s)?',
                    f'start {new_start}s',
                    current_line,
                    count=1
                )

            # 2. Si c'est un SPEECH, on doit générer l'audio et mettre à jour le décalage futur
            match_speech = speech_pattern.search(current_line)
            if match_speech:
                text_content = match_speech.group(1)

                # A. On génère l'audio (appel API OpenAI ou autre)
                local_path, public_url = self.tts_provider(text_content)

                if local_path and os.path.exists(local_path):
                    # B. On mesure la vraie durée
                    real_duration = self.get_audio_duration(local_path)
                    real_duration = round(real_duration, 2)

                    # C. On regarde quelle durée GPT avait imaginée (s'il en a mis une)
                    estimated_duration = 0.0
                    if match_time and match_time.group(2):
                        estimated_duration = float(match_time.group(2))
                    else:
                        # Si GPT n'a pas mis de durée, on suppose qu'il pensait que c'était instantané (0s)
                        # ou on prend une valeur par défaut.
                        estimated_duration = 0.0

                        # D. Calcul du nouveau décalage (Drift)
                    # Ex: GPT dit duration 2s. Réalité 3.5s.
                    # Drift = 3.5 - 2.0 = +1.5s
                    # Ce drift s'ajoute au shift_accumulator pour TOUTES les lignes suivantes
                    current_drift = real_duration - estimated_duration
                    shift_accumulator += current_drift

                    print(
                        f"🎤 Speech généré: {real_duration}s (Estimé: {estimated_duration}s) -> Décalage global: +{shift_accumulator}s")

                    # E. Mise à jour de la ligne speech avec URL et VRAIE durée
                    # Remplacement de l'URL
                    current_line = current_line.replace(f'"{text_content}"', f'"{public_url}"')

                    # Remplacement de la durée (ou ajout si absente)
                    if 'duration' in current_line:
                        current_line = re.sub(
                            r'duration\s+[\d\.]+(?:s)?',
                            f'duration {real_duration}s',
                            current_line
                        )
                    else:
                        # Si pas de durée, on l'ajoute à la fin
                        current_line += f' duration {real_duration}s'

            new_lines.append(current_line)

        print("--- SYNCHRONISATION TERMINÉE ---")
        return '\n'.join(new_lines)