import 'package:flutter/material.dart';
import 'my_app.dart';
import 'speech_manager/piper_servicices.dart';

void main() async {
  //runApp(MyApp());
  final piper = PiperServices();

  final tts = await piper.tts(
    text: "Bonjour, bah est ce que ça marche d'abord. On verra bien.",
    dirName: 'tests',
    fileName: 'test2',
  );

  if (tts != null) {
    print("bingo");
    print('Durée : ${tts.duration} sec');
  } else {
    print("bye");
  }
}
