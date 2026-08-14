// Structures de données échangées entre les layers de la pipeline IA ILLIMMI
// (voir illimmi-doc.md §2).

/// Sortie du Layer 1 (planification pédagogique).
class CourseMetadata {
  final String subject;
  final String level;
  final int durationTarget;
  final List<String> conceptsCles;
  final String ton;
  final String langue;

  CourseMetadata({
    required this.subject,
    required this.level,
    required this.durationTarget,
    required this.conceptsCles,
    required this.ton,
    required this.langue,
  });

  factory CourseMetadata.fromJson(Map<String, dynamic> json) {
    return CourseMetadata(
      subject: json['subject'] as String,
      level: json['level'] as String,
      durationTarget: (json['duration_target'] as num).toInt(),
      conceptsCles: (json['concepts_cles'] as List)
          .map((e) => e as String)
          .toList(),
      ton: json['ton'] as String,
      langue: json['langue'] as String,
    );
  }
}

/// Un mot avec son timestamp (Layer 2 : `transcript_timestamped`).
class WordTimestamp {
  final String word;
  final double start;
  final double end;

  WordTimestamp({required this.word, required this.start, required this.end});

  factory WordTimestamp.fromJson(Map<String, dynamic> json) {
    return WordTimestamp(
      word: json['word'] as String,
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
    );
  }
}

/// Sortie du Layer 2 (transcript + audio + timestamps).
class TranscriptResult {
  final String transcript;
  final List<WordTimestamp> transcriptTimestamped;
  final double duration;
  final String audioFile;
  final String language;

  TranscriptResult({
    required this.transcript,
    required this.transcriptTimestamped,
    required this.duration,
    required this.audioFile,
    required this.language,
  });
}

/// Sortie du Layer 3 (idgap + visuels Hypercourse).
class Layer3Result {
  final int idGap;
  final String visualsText;

  Layer3Result({
    required this.idGap,
    required this.visualsText,
  });

  factory Layer3Result.fromJson(Map<String, dynamic> json) {
    return Layer3Result(
      idGap: (json['idgap'] as num?)?.toInt() ??
          (json['id_gap'] as num?)?.toInt() ??
          100,
      visualsText:
          (json['visualsText'] ?? json['visuals_text']) as String? ?? '',
    );
  }
}

