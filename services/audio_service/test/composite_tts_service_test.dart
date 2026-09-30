import 'dart:io';

import 'package:audio_service/tts/composite_tts_service.dart';
import 'package:audio_service/tts/openrouter_tts_service.dart';
import 'package:audio_service/tts/piper_service.dart';
import 'package:test/test.dart';

class FakePiperService extends PiperServices {
  int callCount = 0;
  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    callCount++;
    return TtsResults(file: File('fake_piper.wav'), duration: 5.0);
  }
}

class FakeFailingOpenRouterService extends OpenRouterTtsService {
  int callCount = 0;
  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    callCount++;
    throw Exception('Simulated OpenRouter network or quota error');
  }
}

class FakeSuccessOpenRouterService extends OpenRouterTtsService {
  int callCount = 0;
  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    callCount++;
    return TtsResults(file: File('fake_openrouter.wav'), duration: 8.0);
  }
}

void main() {
  group('CompositeTtsService', () {
    test('utilise le TTS local quand le provider demandé est local ou piper', () async {
      final fakePiper = FakePiperService();
      final fakeOpenRouter = FakeSuccessOpenRouterService();
      final composite = CompositeTtsService(
        localPiper: fakePiper,
        openRouter: fakeOpenRouter,
      );

      final res = await composite.tts(
        text: 'Test',
        dirName: 'test_dir',
        fileName: 'audio',
        preferredProvider: 'local',
      );

      expect(res, isNotNull);
      expect(fakePiper.callCount, equals(1));
      expect(fakeOpenRouter.callCount, equals(0));
      expect(res!.file!.path, contains('fake_piper.wav'));
    });

    test('utilise OpenRouter quand disponible en mode openrouter', () async {
      final fakePiper = FakePiperService();
      final fakeOpenRouter = FakeSuccessOpenRouterService();
      final composite = CompositeTtsService(
        localPiper: fakePiper,
        openRouter: fakeOpenRouter,
      );

      final res = await composite.tts(
        text: 'Test',
        dirName: 'test_dir',
        fileName: 'audio',
        preferredProvider: 'openrouter',
      );

      expect(res, isNotNull);
      expect(fakeOpenRouter.callCount, equals(1));
      expect(fakePiper.callCount, equals(0));
      expect(res!.file!.path, contains('fake_openrouter.wav'));
    });

    test('bascule automatiquement sur Piper local en cas d\'erreur OpenRouter', () async {
      final fakePiper = FakePiperService();
      final fakeFailingOpenRouter = FakeFailingOpenRouterService();
      final composite = CompositeTtsService(
        localPiper: fakePiper,
        openRouter: fakeFailingOpenRouter,
      );

      final res = await composite.tts(
        text: 'Test',
        dirName: 'test_dir',
        fileName: 'audio',
        preferredProvider: 'openrouter',
      );

      expect(res, isNotNull);
      // A bien tenté OpenRouter
      expect(fakeFailingOpenRouter.callCount, equals(1));
      // Et a basculé automatiquement sur le fallback local
      expect(fakePiper.callCount, equals(1));
      expect(res!.file!.path, contains('fake_piper.wav'));
    });
  });
}
