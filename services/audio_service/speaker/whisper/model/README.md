# Modèle Whisper local pour l'alignement mot-par-mot (`LocalSherpaAligner`)

Ce dossier doit contenir un export ONNX **multilingue** (pas la variante `.en`,
car les transcripts générés par la pipeline sont en français) de type
`sherpa-onnx-whisper-tiny`, disponible sur les releases GitHub de
[k2-fsa/sherpa-onnx](https://github.com/k2-fsa/sherpa-onnx/releases) — cherche
un fichier `sherpa-onnx-whisper-tiny.tar.bz2` (ou équivalent `tiny.int8`).

Fichiers attendus ici, à plat :

```
speaker/whisper/model/
├── encoder.onnx  (ou encoder.int8.onnx, à renommer)
├── decoder.onnx  (ou decoder.int8.onnx, à renommer)
└── tokens.txt
```

Léger (~75 Mo au format int8). Les timestamps produits sont par token
(sous-mot Whisper), pas parfaitement au mot — approximatif mais suffisant
pour la règle de synchronisation 0.2–0.5s décrite dans `illimmi-doc.md` §2.4.
