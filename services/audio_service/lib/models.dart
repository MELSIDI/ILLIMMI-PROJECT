/// Un mot avec son timestamp, produit par un [WordAligner].
class WordTimestamp {
  final String word;
  final double start;
  final double end;

  WordTimestamp({required this.word, required this.start, required this.end});

  Map<String, dynamic> toJson() => {
    'word': word,
    'start': start,
    'end': end,
  };
}
