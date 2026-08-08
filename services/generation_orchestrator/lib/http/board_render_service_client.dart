import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/course.dart';
import '../pipeline/board_capture_planner.dart';
import '../pipeline/board_capture_serializer.dart';

/// Une image rendue pour un [CapturePoint], étiquetée par le(s) ID(s) de
/// l'élément dont l'achèvement a déclenché la capture.
class CapturedImage {
  final List<int> triggerElementIds;
  final Uint8List bytes;
  CapturedImage({required this.triggerElementIds, required this.bytes});
}

/// Client HTTP vers le microservice `board-render-service` (rendu headless
/// Flutter, réutilisant `BoardPainter`/`LatexWidget` d'`illimmi_app`), base
/// URL configurable via `BOARD_RENDER_SERVICE_URL`.
class BoardRenderServiceClient {
  final String baseUrl;

  BoardRenderServiceClient({String? baseUrl})
    : baseUrl =
          baseUrl ??
          Platform.environment['BOARD_RENDER_SERVICE_URL'] ??
          'http://localhost:5001';

  /// Rend un [CaptureBatch] entier en un seul appel : renvoie une image par
  /// [CapturePoint], dans le même ordre que `batch.points`.
  Future<List<CapturedImage>> renderBatch(Course course, CaptureBatch batch) async {
    final response = await http.post(
      Uri.parse('$baseUrl/render'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(serializeCaptureBatch(course, batch)),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur board-render-service (${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final images = body['images'] as List;
    return images
        .map(
          (img) => CapturedImage(
            triggerElementIds: List<int>.from(img['triggerElementIds'] as List),
            bytes: base64Decode(img['imageBase64'] as String),
          ),
        )
        .toList();
  }
}
