import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/state/session_controller.dart';
import 'package:illimmi_app/widgets/main_content_area.dart';

void main() {
  testWidgets('the player back button returns to the prompt screen, not a black screen', (tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

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

    expect(find.text('Que veux-tu apprendre aujourd\'hui ?'), findsOneWidget);

    await tester.tap(find.text('Théorie des Barycentres'), warnIfMissed: false);
    await tester.pump();

    for (var i = 0; i < 10; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 500)));
      await tester.pump();
      if (find.text('Chargement de l\'exemple...').evaluate().isEmpty) break;
    }

    expect(find.text('Que veux-tu apprendre aujourd\'hui ?'), findsNothing);
    expect(courseActive.value, isTrue);

    final backButton = find.byTooltip('Retour');
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pump();

    expect(find.text('Que veux-tu apprendre aujourd\'hui ?'), findsOneWidget);
    expect(courseActive.value, isFalse);
  });
}
