import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.answer, required this.tap});

  final String answer;
  final void Function() tap;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      ),
      child: Text(answer),
    );
  }
}
