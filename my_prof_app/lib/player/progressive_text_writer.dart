import 'package:flutter/material.dart';

class ProgressiveTextWriter extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;

  const ProgressiveTextWriter({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: 2),
    this.style,
  });

  @override
  ProgressiveTextWriterState createState() => ProgressiveTextWriterState();
}

class ProgressiveTextWriterState extends State<ProgressiveTextWriter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Le Tween qui va de 0 au nombre total de caractères
    _characterCount = StepTween(begin: 0, end: widget.text.length).animate(_controller);

    // On lance l'animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        // On prend un substring du texte original
        String visibleText = widget.text.substring(0, _characterCount.value);
        
        return Text(
          visibleText,
          style: widget.style,
        );
      },
    );
  }
}