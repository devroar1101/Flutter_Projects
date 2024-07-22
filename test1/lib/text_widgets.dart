import 'package:flutter/material.dart';

class TextWidgetsClass extends StatelessWidget {
  const TextWidgetsClass(this.text, {super.key});

  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 50),
    );
  }
}
