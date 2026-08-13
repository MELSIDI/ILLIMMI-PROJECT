import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/main.dart';
import 'package:illimmi_app/state/session_controller.dart';

void main() {
  testWidgets('App renders ILLIMMI Gemini Shell correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(sessionController: SessionController()));

    expect(find.text('ILLIMMI'), findsOneWidget);
    expect(find.text('Que veux-tu apprendre aujourd\'hui ?'), findsOneWidget);
  });
}
