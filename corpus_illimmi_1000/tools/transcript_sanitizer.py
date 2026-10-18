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
    r"(?i)\b(n'h[eé]sitez?\s+pas\s+[àa]\s+vous\s+abonner|abonne[- ]toi|[aà]\s+t'abonner)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(activez?\s+la\s+cloche|la\s+petite\s+cloche(\s+des\s+notifications)?)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(mettez?\s+un\s+pouce\s+bleu|laissez?\s+un\s+j'aime|un\s+pouce\s+en\s+l'air|pouce\s+bleu)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(mettez?\s+un\s+commentaire|dis[- ]moi\s+en\s+commentaire|dans\s+les\s+commentaires)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(le\s+lien\s+(est\s+)?dans\s+la\s+description|en\s+barre\s+d'info|cliquez?\s+sur\s+le\s+lien)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(t[eé]l[eé]chargez?\s+la\s+fiche|mon\s+livre|mon\s+cahier\s+d'exercices|le\s+pdf\s+gratuit)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(merci\s+[àa]\s+notre\s+sponsor|code\s+promo|partenaire\s+de\s+cette\s+vid[eé]o)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(bienvenue\s+sur\s+ma\s+cha[îi]ne|sur\s+la\s+cha[îi]ne)(?:\s+[a-zà-ÿ0-9']+){0,6}",
    r"(?i)\b(cliquez?\s+ici|retrouvez[- ]moi\s+sur\s+instagram|sur\s+tiktok|sur\s+facebook)\b(?:\s+[a-zà-ÿ0-9']+){0,6}",
]

# Spoken oral parasites
PARASITE_PATTERNS = [
    r"(?i)\b(euh+|ben|bah|ouais|voil[aà]\s+voil[aà]|hop\s+l[aà])\b",
    r"(?i)\b(bon\s+alors\s+voil[aà]|alors\s+bon|bon\s+alors)\b",
]

# Oral Phonetic Math & Science Mappings (Rule 7 & 8 of ILLIMMI layer2_audio_system.md)
MATH_PHONETIC_REPLACEMENTS = [
    # Sequences & indices
    (r"\bu_n\b", "u indice n"),
    (r"\bu_\{n\+1\}\b|\bu_n\+1\b|\bu_\{n\s*\+\s*1\}\b", "u indice n plus 1"),
    (r"\bu_0\b", "u zéro"),
    (r"\bu_1\b", "u un"),
    (r"\bv_n\b", "v indice n"),
    (r"\bv_\{n\+1\}\b|\bv_n\+1\b", "v indice n plus 1"),
    (r"\bv_0\b", "v zéro"),
    (r"\bw_n\b", "w indice n"),

    # Functions, derivatives & limits
    (r"\bf'\(x\)\b", "f prime de x"),
    (r"\bf''\(x\)\b", "f seconde de x"),
    (r"\bf\(x\)\b", "f de x"),
    (r"\bg\(x\)\b", "g de x"),
    (r"\bh\(x\)\b", "h de x"),
    (r"\\lim_\{x\s*\\to\s*\\?\+?\\?infty\}\s*", "la limite quand x tend vers plus l'infini "),
    (r"\\lim_\{x\s*\\to\s*-\\infty\}\s*", "la limite quand x tend vers moins l'infini "),
    (r"\\lim_\{x\s*\\to\s*([^}]+)\}\s*", r"la limite quand x tend vers \1 "),
    (r"\blimite\s+en\s+\+inf(ini)?\b", "limite en plus l'infini"),
    (r"\blimite\s+en\s+-inf(ini)?\b", "limite en moins l'infini"),

    # Powers & Roots
    (r"\bx\^2\b", "x au carré"),
    (r"\bx\^3\b", "x au cube"),
    (r"([a-zA-Z0-9])\^2\b", r"\1 au carré"),
    (r"([a-zA-Z0-9])\^3\b", r"\1 au cube"),
    (r"([a-zA-Z0-9])\^n\b", r"\1 puissance n"),
    (r"\\sqrt\{([^}]+)\}", r"racine carrée de \1"),
    (r"\\sqrt\s*([a-zA-Z0-9]+)", r"racine carrée de \1"),

    # Vectors & Geometry
    (r"\\vec\{u\}|\\overrightarrow\{u\}", "vecteur u"),
    (r"\\vec\{v\}|\\overrightarrow\{v\}", "vecteur v"),
    (r"\\vec\{w\}|\\overrightarrow\{w\}", "vecteur w"),
    (r"\\overrightarrow\{AB\}|\bAB\s+vecteur\b", "vecteur AB"),
    (r"\\overrightarrow\{CD\}", "vecteur CD"),
    (r"\\overrightarrow\{OM\}", "vecteur OM"),
    (r"\\Delta\b", "delta"),
    (r"\\pi\b", "pi"),
    (r"\\alpha\b", "alpha"),
    (r"\\beta\b", "bêta"),
    (r"\\lambda\b", "lambda"),

    # Operators & Logic
    (r"\\iff\b|<=>|équivaut\s+à", "ce qui équivaut à"),
    (r"\\implies\b|=>|implique", "donc"),
    (r"\\in\b", "appartient à"),
    (r"\\notin\b", "n'appartient pas à"),
    (r"\\le\b|\\leq\b|<=", "inférieur ou égal à"),
    (r"\\ge\b|\\geq\b|>=", "supérieur ou égal à"),
    (r"\\neq\b|!=", "différent de"),
    (r"\\subset\b", "inclus dans"),
    (r"\\cap\b", "inter"),
    (r"\\cup\b", "union"),

    # Number sets
    (r"\\mathbb\{R\}|\bR\b(?=\s+est|\s+tout)", "l'ensemble des réels"),
    (r"\\mathbb\{N\}|\bN\b(?=\s+est|\s+tout)", "l'ensemble des entiers naturels"),
    (r"\\mathbb\{Z\}|\bZ\b(?=\s+est|\s+tout)", "l'ensemble des entiers relatifs"),

    # Logarithm & Exponential
    (r"\\ln\b|\bln\(", "logarithme népérien "),
    (r"e\^x|\bexp\(x\)", "exponentielle de x"),

    # Decimals
    (r"(\d+),(\d+)", r"\1 virgule \2"),
]


class TranscriptSanitizer:
    """Purifies raw transcripts into golden, clean, anonymized pedagogical speech."""

    @classmethod
    def sanitize(cls, raw_text: str, course_title: str = "", level: str = "Lycée") -> str:
        text = raw_text

        # 1. Remove YouTuber names and channel brandings
        for pat in YOUTUBER_NAMES_PATTERNS:
            text = re.sub(pat, "", text)

        # 2. Remove YouTube platform noise (calls to action, subscription requests, outro plugs)
        for pat in PLATFORM_NOISE_PATTERNS:
            text = re.sub(pat, "", text)

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
        text = re.sub(r"\n\s*\n+", "\n\n", text)
        text = text.strip()

        # 6. Ensure clean pedagogical opening and closing
        words = text.split()
        if len(words) > 420:
            words = words[:420]

        # Break into 4-5 well-structured paragraphs
        chunk_size = max(45, len(words) // 4)
        paragraphs = []

        # Intro
        p0 = " ".join(words[:chunk_size]).strip()
        if not any(g in p0.lower() for g in ["bonjour", "bienvenue", "salut"]):
            p0 = f"Bonjour à tous et bienvenue sur ILLIMMI. Aujourd'hui nous étudions {course_title}. " + p0
        paragraphs.append(p0)

        for i in range(1, 4):
            start_i = i * chunk_size
            end_i = (i + 1) * chunk_size if i < 3 else len(words)
            chunk = " ".join(words[start_i:end_i]).strip()
            if chunk:
                paragraphs.append(chunk)

        # Conclusion
        outro = "En résumé, retenez bien cette méthode fondamentale pour vos épreuves. Entraînez-vous régulièrement et à très vite sur ILLIMMI !"
        if not paragraphs[-1].endswith((".", "!", "?")):
            paragraphs[-1] += "."
        paragraphs.append(outro)

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
