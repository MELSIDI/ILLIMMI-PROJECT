import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/models/course.dart';
import 'package:illimmi_app/screens/corpus_explorer_dialog.dart';
import 'package:illimmi_app/services/corpus_service.dart';
import 'package:illimmi_app/state/session_controller.dart';
import 'package:path/path.dart' as p;

void main() {
  group('CorpusService Tests', () {
    late CorpusService corpusService;

    setUp(() {
      corpusService = CorpusService();
    });

    test('findCorpusDirectory discovers corpus_illimmi_1000 directory', () {
      final dir = CorpusService.findCorpusDirectory();
      expect(dir, isNotNull);
      expect(dir!.existsSync(), isTrue);
      expect(p.basename(dir.path), equals('corpus_illimmi_1000'));
    });

    test('getCorpusCourses retrieves all certified courses (MATH_001 to MATH_005)', () async {
      final courses = await corpusService.getCorpusCourses(forceRefresh: true);
      expect(courses.length, greaterThanOrEqualTo(5));

      final math001 = courses.firstWhere((c) => c.id == 'MATH_001');
      expect(math001.title, contains('Intervalles et encadrements de réels'));
      expect(math001.durationSeconds, greaterThan(1000.0));
      expect(math001.wordCount, equals(3018));
      expect(math001.renderedScenes, equals(7));
      expect(math001.hasAudio, isTrue);
      expect(math001.hasScript, isTrue);
      expect(math001.scenePngPaths.length, equals(7));

      final math002 = courses.firstWhere((c) => c.id == 'MATH_002');
      expect(math002.durationSeconds, greaterThan(300.0));
      expect(math002.wordCount, equals(910));
      expect(math002.renderedScenes, equals(4));

      final math003 = courses.firstWhere((c) => c.id == 'MATH_003');
      expect(math003.durationSeconds, greaterThan(390.0));
      expect(math003.wordCount, equals(1132));

      final math004 = courses.firstWhere((c) => c.id == 'MATH_004');
      expect(math004.durationSeconds, greaterThan(540.0));
      expect(math004.wordCount, equals(1640));

      final math005 = courses.firstWhere((c) => c.id == 'MATH_005');
      expect(math005.durationSeconds, greaterThan(200.0));
      expect(math005.wordCount, equals(665));
    });

    test('loadCourse parses course.hc and resolves audio path correctly', () async {
      final courses = await corpusService.getCorpusCourses();
      final math001 = courses.firstWhere((c) => c.id == 'MATH_001');

      final Course parsed = await corpusService.loadCourse(math001);
      expect(parsed.name, contains('Intervalles et encadrements de réels'));
      expect(parsed.config.audioPath, isNotNull);
      expect(File(parsed.config.audioPath!).existsSync(), isTrue);
      expect(parsed.globalRegistry.isNotEmpty, isTrue);
    });
  });

  group('SessionController Dev Role Tests', () {
    test('isDev identifies developer and AI engineer roles', () {
      final controller = SessionController();
      expect(controller.isDev, isFalse);

      controller.role = 'ai_engineer';
      expect(controller.isDev, isTrue);

      controller.role = 'dev';
      expect(controller.isDev, isTrue);

      controller.role = 'user';
      controller.email = 'ai.engineer@illimmi.ai';
      expect(controller.isDev, isTrue);

      controller.email = 'dev@illimmi.dev';
      expect(controller.isDev, isTrue);

      controller.email = 'student@gmail.com';
      controller.role = 'user';
      expect(controller.isDev, isFalse);
    });

    test('loginAsDev sets up dev session with ai_engineer role', () async {
      final controller = SessionController();
      await controller.loginAsDev();
      expect(controller.isLoggedIn, isTrue);
      expect(controller.isDev, isTrue);
      expect(controller.email, equals('ai.engineer@illimmi.ai'));
    });
  });

  group('CorpusExplorerDialog Widget Tests', () {
    testWidgets('Renders corpus explorer dialog with certified courses and filters', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final corpusService = CorpusService();
      // Précharge le cache pour que le rendu synchrone soit immédiat
      await corpusService.getCorpusCourses();
      CorpusCourse? selectedCourse;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CorpusExplorerDialog(
              corpusService: corpusService,
              onPlayCourse: (course) => selectedCourse = course,
            ),
          ),
        ),
      );

      // Permet à l'initialisation asynchrone de s'exécuter
      await tester.runAsync(() async {
        await Future.delayed(const Duration(milliseconds: 100));
      });
      await tester.pumpAndSettle();

      // Vérifie l'en-tête et les badges
      expect(find.text('Laboratoire Corpus ILLIMMI'), findsOneWidget);
      expect(find.text('AI ENGINEER / DEV'), findsOneWidget);

      // Vérifie la présence des cours certifiés
      expect(find.text('MATH_001'), findsOneWidget);
      expect(find.text('MATH_002'), findsOneWidget);

      // Test de recherche par filtre
      await tester.enterText(find.byType(TextField), 'MATH_001');
      await tester.pumpAndSettle();

      // Il y a 'MATH_001' dans le TextField et dans la carte du cours filtré
      expect(find.text('MATH_001'), findsNWidgets(2));
      expect(find.text('MATH_002'), findsNothing);

      // Test de sélection du cours pour le player
      final playBtn = find.widgetWithText(FilledButton, 'Lire le cours').first;
      await tester.tap(playBtn);
      await tester.pump();

      expect(selectedCourse, isNotNull);
      expect(selectedCourse!.id, equals('MATH_001'));
    });
  });
}