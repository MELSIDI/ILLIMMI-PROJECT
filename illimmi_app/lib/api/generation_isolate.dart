import 'dart:async';
import 'dart:isolate';

import 'generation_client.dart';

/// Lance la génération d'un cours (démarrage du job + polling du statut
/// jusqu'à complétion) dans un [Isolate] séparé de celui de l'UI, pour que
/// la boucle de polling ne puisse jamais provoquer de micro-freeze de
/// l'interface, même si le nombre de tentatives augmente ou que le réseau
/// est lent.
///
/// [onProgress] est appelé sur l'isolate principal (UI) à chaque mise à jour
/// de statut reçue de l'isolate de fond.
Future<GenerationResult> runGenerationInBackground(
  String prompt, {
  required String baseUrl,
  String? token,
  required void Function(String status, String message) onProgress,
}) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(
    _generationIsolateEntry,
    (sendPort: receivePort.sendPort, prompt: prompt, baseUrl: baseUrl, token: token),
  );

  final completer = Completer<GenerationResult>();
  late final StreamSubscription subscription;
  subscription = receivePort.listen((message) {
    final map = message as Map<String, dynamic>;
    switch (map['type']) {
      case 'progress':
        onProgress(map['status'] as String, map['message'] as String);
      case 'done':
        completer.complete(
          GenerationResult(
            script: map['script'] as String,
            audioUrl: map['audioUrl'] as String,
            duration: (map['duration'] as num).toDouble(),
          ),
        );
        subscription.cancel();
        receivePort.close();
      case 'error':
        completer.completeError(Exception(map['message'] as String));
        subscription.cancel();
        receivePort.close();
    }
  });

  return completer.future;
}

/// Point d'entrée exécuté dans l'isolate de fond : démarre le job puis poll
/// son statut, en renvoyant chaque mise à jour à l'isolate UI via [SendPort].
void _generationIsolateEntry(
  ({SendPort sendPort, String prompt, String baseUrl, String? token}) args,
) async {
  final client = GenerationClient(baseUrl: args.baseUrl);
  try {
    final jobId = await client.startGeneration(args.prompt, token: args.token);

    while (true) {
      final status = await client.getStatus(jobId);
      args.sendPort.send({
        'type': 'progress',
        'status': status.status,
        'message': status.message,
      });
      if (status.status == 'done') break;
      if (status.status == 'error') {
        args.sendPort.send({'type': 'error', 'message': status.message});
        return;
      }
      await Future.delayed(const Duration(milliseconds: 800));
    }

    final result = await client.getResult(jobId);
    args.sendPort.send({
      'type': 'done',
      'script': result.script,
      'audioUrl': result.audioUrl,
      'duration': result.duration,
    });
  } catch (e) {
    args.sendPort.send({'type': 'error', 'message': e.toString()});
  }
}
