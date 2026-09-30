import 'dart:io';

import 'openrouter_tts_service.dart';
import 'piper_service.dart';

/// Moteur TTS composite avec sélecteur (OpenRouter vs Local Piper)
/// et bascule automatique (fallback) vers le TTS local en cas d'erreur.
class CompositeTtsService implements TtsEngine {
  final PiperServices localPiper;
  final OpenRouterTtsService? openRouter;

  CompositeTtsService({
    required this.localPiper,
    this.openRouter,
  });

  @override
  String get outputDir => localPiper.outputDir;

  String get configuredProvider {
    return Platform.environment['TTS_PROVIDER']?.toLowerCase() ?? 'auto';
  }

  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    final provider = (preferredProvider ?? configuredProvider).toLowerCase();

    // 1. Si l'utilisateur demande explicitement le TTS local ou si OpenRouter n'est pas instancié
    if (provider == 'local' || provider == 'piper' || openRouter == null) {
      print('[TTS] Utilisation du moteur TTS local (Piper)...');
      return await localPiper.tts(text: text, dirName: dirName, fileName: fileName);
    }

    // 2. Mode OpenRouter ou Auto : tentative OpenRouter en priorité
    print('[TTS] 🎙️ Synthèse vocale via OpenRouter (${openRouter!.model} - voix: ${openRouter!.voice})...');
    try {
      final result = await openRouter!.tts(
        text: text,
        dirName: dirName,
        fileName: fileName,
      );

      if (result != null && result.file != null) {
        print('[TTS] ✅ Synthèse OpenRouter réussie (${result.duration.toStringAsFixed(2)}s).');
        return result;
      }
      throw Exception('Résultat vide reçu d\'OpenRouter TTS.');
    } catch (e) {
      // 3. Bascule automatique (fallback) transparente sur Piper local
      print('[TTS] ⚠️ Échec de synthèse OpenRouter : $e');
      print('[TTS] 🔄 Bascule automatique vers le moteur local (Piper TTS)...');
      return await localPiper.tts(
        text: text,
        dirName: dirName,
        fileName: fileName,
      );
    }
  }
}
