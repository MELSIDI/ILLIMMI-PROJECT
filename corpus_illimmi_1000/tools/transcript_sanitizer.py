"""
Pedagogical Transcript Sanitizer & Math Phonetic Engine
========================================================
- Strips YouTuber brandings & identities (Yvan Monka, Florence Raffin, Romain Bourdel, Amélie Vioux, etc.)
- Eliminates platform noise (abonnements, cloche, pouce bleu, sponsors, liens description, PDF promos)
- Removes oral parasites ('euh', 'ben', 'voilà voilà')
- Converts mathematical & scientific formulas into natural spoken oral French/English
  (Strictly complying with ILLIMMI layer2_audio_system.md Rules 7 & 8)
"""

import re
import unicodedata
from typing import List

# Comprehensive list of creator names and channel signatures to purge
# Comprehensive list of creator names and channel signatures to purge
YOUTUBER_NAMES_PATTERNS = [
    r"(?i)\b(c'est|je\s+suis|avec|par)\s+(yvan\s+monka|florence\s+raffin|romain\s+bourdel|paul\s+olivier|am[eé]lie\s+vioux)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(yvan\s+monka|m@ths\s*et\s*tiques|maths\s*et\s*tiques|m@ths-et-tiques(\.fr)?)\b",
    r"(?i)\b(florence\s+raffin|romain\s+bourdel|paul\s+olivier|e-profs|physique\s+chimie\s+facile)\b",
    r"(?i)\b(am[eé]lie\s+vioux|m[eé]dusae|commentaire\s+et\s+dissertation)\b",
    r"(?i)\b(english\s+with\s+lucy|bbc\s+learning\s+english|learn\s+english\s+with\s+emma|mmmenglish)\b",
    r"(?i)\b(jaicompris(\.com)?|exo7|maths-cours(\.fr)?)\b",
]

# YouTube platform noise (intros, outros, subscriptions, bells, links, promos)
PLATFORM_NOISE_PATTERNS = [
    r"(?i)\b(n'h[eé]sitez?\s+pas\s+[àa]\s+vous\s+abonner|abonne[- ]toi|[aà]\s+t'abonner)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(activez?\s+la\s+cloche|la\s+petite\s+cloche(\s+des\s+notifications)?)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(mettez?\s+un\s+pouce\s+bleu|laissez?\s+un\s+(j'aime|pouce\s+bleu)|un\s+pouce\s+en\s+l'air|pouce\s+bleu)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(mettez?\s+un\s+commentaire|dis[- ]moi\s+en\s+commentaire|dans\s+les\s+commentaires)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(le\s+lien\s+(est\s+)?dans\s+la\s+description|en\s+barre\s+d'info|cliquez?\s+sur\s+le\s+lien)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(t[eé]l[eé]chargez?\s+la\s+fiche|mon\s+livre|mon\s+cahier\s+d'exercices|le\s+pdf\s+gratuit)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(merci\s+[àa]\s+notre\s+sponsor|code\s+promo|partenaire\s+de\s+cette\s+vid[eé]o)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(bienvenue\s+sur\s+ma\s+cha[îi]ne|sur\s+la\s+cha[îi]ne)[^\.\!\?]*[\.\!\?]?",
    r"(?i)\b(cliquez?\s+ici|retrouvez[- ]moi\s+sur\s+instagram|sur\s+tiktok|sur\s+facebook)\b[^\.\!\?]*[\.\!\?]?",
]

# Spoken oral parasites
PARASITE_PATTERNS = [
    r"(?i)\b(euh+|ben|bah|ouais|voil[aà]\s+voil[aà]|hop\s+l[aà])\b",
    r"(?i)\b(bon\s+alors\s+voil[aà]|alors\s+bon|bon\s+alors)\b",
]

# Oral Phonetic Math & Science Mappings (Rule 7 & 8 of ILLIMMI layer2_audio_system.md)
MATH_PHONETIC_REPLACEMENTS = [
    # Sequences & indices
    (r"\bu_\{n\s*\+\s*1\}|\bu_n\+1", "u indice n plus 1"),
    (r"\bu_n\b", "u indice n"),
    (r"\bu_0\b", "u zéro"),
    (r"\bu_1\b", "u un"),
    (r"\bv_\{n\s*\+\s*1\}|\bv_n\+1", "v indice n plus 1"),
    (r"\bv_n\b", "v indice n"),
    (r"\bv_0\b", "v zéro"),
    (r"\bw_n\b", "w indice n"),

    # Functions, derivatives & limits
    (r"f''\(x\)", "f seconde de x"),
    (r"f'\(x\)", "f prime de x"),
    (r"\bf\(x\)\b", "f de x"),
    (r"\bg\(x\)\b", "g de x"),
    (r"\bh\(x\)\b", "h de x"),
    (r"\\?lim_\{x\s*\\?to\s*\\?\+?\\?infty\}\s*", "la limite quand x tend vers plus l'infini "),
    (r"\\?lim_\{x\s*\\?to\s*-\\?infty\}\s*", "la limite quand x tend vers moins l'infini "),
    (r"\\?lim_\{x\s*\\?to\s*([^}]+)\}\s*", r"la limite quand x tend vers \1 "),
    (r"\blimite\s+en\s+\+inf(ini)?\b", "limite en plus l'infini"),
    (r"\blimite\s+en\s+-inf(ini)?\b", "limite en moins l'infini"),

    # Powers & Roots
    (r"\bx\^2\b", "x au carré"),
    (r"\bx\^3\b", "x au cube"),
    (r"([a-zA-Z0-9])\^2\b", r"\1 au carré"),
    (r"([a-zA-Z0-9])\^3\b", r"\1 au cube"),
    (r"([a-zA-Z0-9])\^n\b", r"\1 puissance n"),
    (r"\\?sqrt\{([^}]+)\}", r"racine carrée de \1"),
    (r"\\?sqrt\s*([a-zA-Z0-9]+)", r"racine carrée de \1"),

    # Vectors & Geometry
    (r"\\vec\{([a-zA-Z]+)\}|\\overrightarrow\{([a-zA-Z]+)\}", r"vecteur \1\2"),
    (r"\b([A-Z]{2})\s+vecteur\b", r"vecteur \1"),
    (r"\\Delta\b", "delta"),
    (r"\\pi\b", "pi"),
    (r"\\alpha\b", "alpha"),
    (r"\\beta\b", "bêta"),
    (r"\\lambda\b", "lambda"),

    # Operators & Logic (Backslash is mandatory to avoid matching French words: le, in, etc.)
    (r"\\iff\b|<=>", "ce qui équivaut à"),
    (r"\\implies\b|=>", "donc"),
    (r"\\in\b", "appartient à"),
    (r"\\notin\b", "n'appartient pas à"),
    (r"\\le\b|\\leq\b|<=", "inférieur ou égal à"),
    (r"\\ge\b|\\geq\b|>=", "supérieur ou égal à"),
    (r"\\neq\b|!=", "différent de"),
    (r"\\subset\b", "inclus dans"),
    (r"\\cap\b", "inter"),
    (r"\\cup\b", "union"),

    # Number sets
    (r"\\mathbb\{R\}", "l'ensemble des réels"),
    (r"\\mathbb\{N\}", "l'ensemble des entiers naturels"),
    (r"\\mathbb\{Z\}", "l'ensemble des entiers relatifs"),

    # Logarithm & Exponential
    (r"\\ln\b|\bln\(", "logarithme népérien "),
    (r"e\^x|\bexp\(x\)", "exponentielle de x"),

    # Additional math phonetics
    (r"\\frac\{([^}]+)\}\{([^}]+)\}", r"\1 sur \2"),
    (r"([a-zA-Z0-9]+)\s*/\s*([a-zA-Z0-9]+)", r"\1 sur \2"),
    (r"\\times|\*", " fois "),
    (r"\b([0-9]+)\s*\+\s*([0-9]+)\b", r"\1 plus \2"),
    (r"\b([0-9]+)\s*-\s*([0-9]+)\b", r"\1 moins \2"),
    (r"\[([a-zA-Z0-9\-\+\s]+)\s*;\s*([a-zA-Z0-9\-\+\s]+)\]", r"l'intervalle fermé \1 point-virgule \2"),
    (r"\]([a-zA-Z0-9\-\+\s]+)\s*;\s*([a-zA-Z0-9\-\+\s]+)\[", r"l'intervalle ouvert \1 point-virgule \2"),
    (r"\[([a-zA-Z0-9\-\+\s]+)\s*;\s*([a-zA-Z0-9\-\+\s]+)\[", r"l'intervalle semi-ouvert \1 point-virgule \2"),
    (r"\]([a-zA-Z0-9\-\+\s]+)\s*;\s*([a-zA-Z0-9\-\+\s]+)\]", r"l'intervalle semi-ouvert \1 point-virgule \2"),

    # Decimals
    (r"(\d+),(\d+)", r"\1 virgule \2"),
]


class TranscriptSanitizer:
    """Purifies raw transcripts into golden, clean, anonymized pedagogical speech."""

    # Key pedagogical transition anchors used to segment unpunctuated speech
    TRANSITION_MARKERS = [
        r"\b(aujourd'hui\s+nous\s+allons|dans\s+cette\s+vidéo|dans\s+ce\s+cours)\b",
        r"\b(pour\s+commencer|tout\s+d'abord|en\s+premier\s+lieu|premièrement)\b",
        r"\b(rappelons\s+que|rappelons\s+la\s+définition|définissons|la\s+définition\s+est)\b",
        r"\b(par\s+exemple|prenons\s+un\s+exemple|considérons|regardons\s+ici|sur\s+notre\s+figure)\b",
        r"\b(première\s+étape|deuxième\s+étape|troisième\s+étape|ensuite|de\s+plus|en\s+outre)\b",
        r"\b(première\s+question|deuxième\s+question|troisième\s+question)\b",
        r"\b(attention\s+toutefois|attention|remarquons\s+que|notons\s+bien)\b",
        r"\b(en\s+conclusion|en\s+résumé|pour\s+terminer|au\s+final|on\s+retient\s+que)\b",
        r"\b(c'est-à-dire\s+que|ce\s+qui\s+signifie\s+que|ce\s+qui\s+veut\s+dire\s+que)\b",
        r"\b(donc\s+on\s+a|par\s+conséquent|ainsi\s+on\s+obtient|on\s+en\s+déduit\s+que)\b",
    ]

    @classmethod
    def _restore_punctuation_and_sentences(cls, text: str) -> List[str]:
        """
        Transforms unpunctuated continuous speech stream into well-punctuated grammatical sentences.
        """
        # If the text already has abundant periods, split naturally
        period_count = text.count('.') + text.count('!') + text.count('?')
        word_count = len(text.split())

        if period_count > word_count // 25 and period_count >= 5:
            # Already punctuated: split on sentence boundaries
            raw_sents = re.split(r'(?<=[.!?])\s+', text)
            clean_sents = [s.strip() for s in raw_sents if len(s.strip()) > 5]
            if len(clean_sents) >= 4:
                return clean_sents

        # Unpunctuated stream: inject sentence boundaries on transition markers and clause conjunctions
        punctuated = text
        for marker in cls.TRANSITION_MARKERS:
            punctuated = re.sub(f"(?i)(?<![.!?])\\s+({marker})", r". \1", punctuated)

        # Split on newly created boundaries or natural sentence terminators
        raw_chunks = re.split(r'(?<=[.!?])\s+', punctuated)
        sentences = []

        for chunk in raw_chunks:
            chunk = re.sub(r'\s+', ' ', chunk).strip()
            if not chunk:
                continue

            # If a chunk is still excessively long (> 35 words), split on secondary conjunctions
            words = chunk.split()
            if len(words) > 35:
                sub_parts = re.split(r'(?i)\b(alors|donc|ainsi|puis|car|mais|or)\b', chunk)
                current_sub = ""
                for part in sub_parts:
                    part_str = part.strip()
                    if not part_str:
                        continue
                    if part_str.lower() in {"alors", "donc", "ainsi", "puis", "car", "mais", "or"}:
                        if len(current_sub.split()) >= 12:
                            sentences.append(current_sub.strip())
                            current_sub = part_str.capitalize() + " "
                        else:
                            current_sub = (current_sub + " " + part_str).strip() + " "
                    else:
                        current_sub = (current_sub + " " + part_str).strip() + " "
                if current_sub.strip():
                    sentences.append(current_sub.strip())
            else:
                sentences.append(chunk)

        # Capitalize, clean spacing, and ensure terminal punctuation on every sentence
        final_sentences = []
        for s in sentences:
            s = re.sub(r'\s+', ' ', s).strip()
            # Remove any stray punctuation at start
            s = re.sub(r'^[.,;:!?\s]+', '', s).strip()
            if not s or len(s) < 3:
                continue
            s = s[0].upper() + s[1:]
            if not s.endswith(('.', '!', '?')):
                s += '.'
            final_sentences.append(s)

        return final_sentences

    @classmethod
    def sanitize(cls, raw_text: str, course_title: str = "", level: str = "Lycée") -> str:
        text = raw_text

        # 1. Remove YouTuber names and channel brandings
        for pat in YOUTUBER_NAMES_PATTERNS:
            text = re.sub(pat, "", text)

        # 2. Remove YouTube platform noise (calls to action, subscription requests, outro plugs)
        for pat in PLATFORM_NOISE_PATTERNS:
            text = re.sub(pat, "", text)

        # 2b. Transform video references into interactive course references
        text = re.sub(r"(?i)\bdans\s+cette\s+vid[eé]o\b", "dans ce cours", text)
        text = re.sub(r"(?i)\bcette\s+vid[eé]o\b", "ce cours", text)
        text = re.sub(r"(?i)\bde\s+cette\s+vid[eé]o\b", "de ce cours", text)

        # 3. Remove oral parasite words
        for pat in PARASITE_PATTERNS:
            text = re.sub(pat, " ", text)

        # 3b. Clean residual incomplete call-to-action fragments
        residual_pat = r"(?i)\b(laissez|mettez|cliquez|abonnez|n'hésitez|téléchargez)\s+(?:un\s+pouce|la\s+cloche|le\s+lien|votre\s+avis)\b"
        text = re.sub(residual_pat, "", text)

        # 4. Apply oral phonetic math replacements
        for pat, rep in MATH_PHONETIC_REPLACEMENTS:
            text = re.sub(pat, rep, text)

        # 5. Clean whitespace & collapse spaces
        text = re.sub(r"[ \t]+", " ", text)
        text = re.sub(r"\n\s*\n+", " ", text).strip()

        # 6. Punctuate and structure into grammatically complete sentences
        sentences = cls._restore_punctuation_and_sentences(text)

        # 7. Select coherent content strictly on sentence boundaries (NO mid-sentence cuts!)
        # Target: 250 - 420 words
        accumulated_sentences = []
        current_word_count = 0
        max_words = 380

        for sent in sentences:
            sent_words = len(sent.split())
            if current_word_count + sent_words > max_words and current_word_count >= 200:
                # Stop cleanly at this complete sentence boundary
                break
            accumulated_sentences.append(sent)
            current_word_count += sent_words

        if not accumulated_sentences:
            accumulated_sentences = sentences[:5]

        # 8. Build canonical pedagogical structure (Introduction, Core sections, Synthesis)
        intro_greeting = f"Bonjour ! Dans ce cours de {level}, nous allons étudier en détail {course_title}."
        if not any(g in accumulated_sentences[0].lower() for g in ["bonjour", "bienvenue", "salut"]):
            accumulated_sentences.insert(0, intro_greeting)

        outro = "Nous avons ainsi passé en revue les points essentiels de cette notion. Entraîne-toi régulièrement et à très bientôt sur ILLIMMI !"
        if not accumulated_sentences[-1].endswith(('.', '!', '?')):
            accumulated_sentences[-1] += '.'
        accumulated_sentences.append(outro)

        # 9. Group into 4 to 5 balanced, readable paragraphs
        total_sents = len(accumulated_sentences)
        num_paras = min(5, max(3, total_sents // 3))
        para_size = max(1, total_sents // num_paras)

        paragraphs = []
        for i in range(num_paras):
            start_i = i * para_size
            end_i = (i + 1) * para_size if i < num_paras - 1 else total_sents
            p_text = " ".join(accumulated_sentences[start_i:end_i]).strip()
            if p_text:
                paragraphs.append(p_text)

        return "\n\n".join(paragraphs)


if __name__ == "__main__":
    sample = (
        "Bonjour à tous c'est Yvan Monka de m@ths-et-tiques ! "
        "Aujourd'hui on résout l'équation u_{n+1} = 0,5 u_n + 3 avec u_0 = 1. "
        "Euh bon alors n'hésitez pas à vous abonner et activez la petite cloche ! "
        "Calculons lim_{x \\to +\\infty} f(x) et f'(x). Laissez un pouce bleu et téléchargez la fiche en description !"
    )
    cleaned = TranscriptSanitizer.sanitize(sample, "Suites récurrentes")
    print("--- RAW ---")
    print(sample)
    print("\n--- SANITIZED ---")
    print(cleaned)
