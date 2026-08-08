import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/state/session_controller.dart';
import 'package:illimmi_app/widgets/main_content_area.dart';

void main() {
  testWidgets('the player back button returns to the prompt screen, not a black screen', (tester) async {
    final courseActive = ValueNotifier<bool>(false);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MainContentArea(
            sessionController: SessionController(),
            courseActive: courseActive,
          ),
        ),
      ),
    );

    expect(find.text('Quel sujet veux-tu apprendre ?'), findsOneWidget);

    await tester.tap(find.text('Charger l\'exemple : Barycentres'));
    await tester.pump();
    // Le parsing lit le fichier .hc via de l'I/O disque réel (dart:io), qui
    // n'avance pas avec l'horloge simulée de pump(duration) : il faut laisser
    // tourner le vrai event loop via runAsync. Le cours joue ensuite une
    // AnimationController perpétuelle, donc pumpAndSettle ne conviendrait pas
    // de toute façon.
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 500)));
      await tester.pump();
      if (find.text('Chargement de l\'exemple...').evaluate().isEmpty) break;
    }

    expect(find.text('Quel sujet veux-tu apprendre ?'), findsNothing);
    expect(courseActive.value, isTrue);

    final backButton = find.byTooltip('Retour');
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pump();

    expect(find.text('Quel sujet veux-tu apprendre ?'), findsOneWidget);
    expect(courseActive.value, isFalse);
  });
}
