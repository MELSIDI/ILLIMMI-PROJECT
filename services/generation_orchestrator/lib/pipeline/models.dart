// Structures de données échangées entre les layers de la pipeline IA ILLIMMI
// (voir illimmi-doc.md §2).

/// Sortie du Layer 1 (planification pédagogique).
/*class CourseMetadata {
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
}*/


// Structures de données échangées entre les layers de la pipeline IA ILLIMMI
// (voir illimmi-doc.md §2).

/// Une section du plan pédagogique produit par Layer 1, consommée par
/// Layer 2 (structure de la narration) et indirectement par Layer 3 (via
/// les ancrages visuels que Layer 2 verbalise dans le transcript).
class PlanSection {
  final String section; // accroche | prerequis | exemple_concret | ...
  final String objectif;
  final String contenuAttendu;
  final String supportVisuelSuggere;

  PlanSection({
    required this.section,
    required this.objectif,
    required this.contenuAttendu,
    required this.supportVisuelSuggere,
  });

  factory PlanSection.fromJson(Map<String, dynamic> json) {
    return PlanSection(
      section: json['section'] as String,
      objectif: json['objectif'] as String,
      contenuAttendu: json['contenu_attendu'] as String,
      supportVisuelSuggere: json['support_visuel_suggere'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'section': section,
    'objectif': objectif,
    'contenu_attendu': contenuAttendu,
    'support_visuel_suggere': supportVisuelSuggere,
  };
}

/// Sortie du Layer 1 (planification pédagogique).
class CourseMetadata {
  final String subject;
  final String level;
  final int durationTarget;
  final List<String> conceptsCles;
  final String ton;
  final String langue;
  final List<PlanSection> planPedagogique;

  CourseMetadata({
    required this.subject,
    required this.level,
    required this.durationTarget,
    required this.conceptsCles,
    required this.ton,
    required this.langue,
    this.planPedagogique = const [],
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
      planPedagogique: json['plan_pedagogique'] == null
          ? const []
          : (json['plan_pedagogique'] as List)
              .map((e) => PlanSection.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'subject': subject,
    'level': level,
    'duration_target': durationTarget,
    'concepts_cles': conceptsCles,
    'ton': ton,
    'langue': langue,
    'plan_pedagogique': planPedagogique.map((e) => e.toJson()).toList(),
  };
}

/// Un mot avec son timestamp (Layer 2 : `transcript_timestamped`).
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

/// Sortie du Layer 2 (transcript + audio + timestamps).
class TranscriptResult {
  final String transcript;
  final List<WordTimestamp> transcriptTimestamped;
  final double duration;
  final String audioFile;
  final String language;
  final String? compactTimeline;

  TranscriptResult({
    required this.transcript,
    required this.transcriptTimestamped,
    required this.duration,
    required this.audioFile,
    required this.language,
    this.compactTimeline,
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

