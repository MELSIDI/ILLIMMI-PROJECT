/// Un mot avec son timestamp, produit par un [WordAligner].
class WordTimestamp {
  static final RegExp _compactPattern = RegExp(r'^<(\d+\.?\d*)>(.*)<(\d+\.?\d*)>$');
  static final RegExp _surroundingPunct = RegExp(r'^[.,;:!?…»«"()\s]+|[.,;:!?…»«"()\s]+$');

  final String word;
  final double start;
  final double end;
  final String? confidence;

  WordTimestamp({
    required this.word,
    required this.start,
    required this.end,
    this.confidence,
  });

  /// Mot débarrassé de la ponctuation environnante pour comparaison textuelle
  String get cleanWord => word.replaceAll(_surroundingPunct, '').trim();

  /// Représentation compacte : `<début>mot<fin>` (ex. `<0.110>Bonjour !<1.300>`)
  String toCompact([int decimals = 3]) {
    final s = start.toStringAsFixed(decimals);
    final e = end.toStringAsFixed(decimals);
    return '<$s>$word<$e>';
  }

  /// Parse une ligne compacte `<début>mot<fin>`
  static WordTimestamp fromCompact(String line) {
    final trimmed = line.trim();
    final match = _compactPattern.firstMatch(trimmed);
    if (match == null) {
      throw FormatException('Ligne compacte invalide : "$line" (attendu: "<start>mot<end>")');
    }
    final start = double.parse(match.group(1)!);
    final word = match.group(2)!;
    final end = double.parse(match.group(3)!);
    return WordTimestamp(word: word, start: start, end: end);
  }

  factory WordTimestamp.fromJson(Map<String, dynamic> json) {
    return WordTimestamp(
      word: json['word'] as String,
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      confidence: json['confidence'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'word': word,
    'start': start,
    'end': end,
    if (confidence != null) 'confidence': confidence,
  };
}
