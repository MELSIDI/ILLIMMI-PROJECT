// Test d'intégration : lance réellement `piper.exe` (spawn de subprocess) et
// vérifie que le fichier `.wav` produit existe bien à l'emplacement exact
// attendu par la route `/narrate` (voir `lib/routes/narrate_route.dart`) —
// c'est-à-dire `<AUDIO_OUTPUT_DIR>/<dirName>/<fileName>.wav`.
//
// Plus lent que d'autres tests (spawn réel de piper.exe) — c'est volontaire :
// c'est le seul test qui prouve la génération de voix bout-en-bout.

import 'package:test/test.dart';
import 'package:audio_service/tts/piper_service.dart';

void main() {
  test(
    'PiperServices.tts() produit un vrai fichier audio au chemin exact utilisé par /narrate',
    () async {
      final piper = PiperServices();
      final result = await piper.tts(
        text: 'Bonjour, ceci est un test de synthèse vocale.',
        dirName: 'test_integration',
        fileName: 'narration',
      );

      expect(result, isNotNull);
      expect(result!.file, isNotNull);
      expect(result.file!.existsSync(), isTrue);
      expect(result.file!.lengthSync(), greaterThan(0));
      expect(result.duration, greaterThan(0));

      // Chemin sous <AUDIO_OUTPUT_DIR>/test_integration/narration.wav, comme
      // le sert le handler statique monté sur /audios.
      expect(result.file!.path, contains('test_integration'));
      expect(result.file!.path, contains('narration.wav'));
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
