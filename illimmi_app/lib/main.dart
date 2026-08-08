import 'package:flutter/material.dart';

import 'screens/app_shell.dart';
import 'state/session_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionController = SessionController();
  await sessionController.restoreSession();
  runApp(MyApp(sessionController: sessionController));
}

class MyApp extends StatelessWidget {
  final SessionController sessionController;

  const MyApp({super.key, required this.sessionController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ILLIMMI',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: AppShell(sessionController: sessionController),
    );
  }
}
