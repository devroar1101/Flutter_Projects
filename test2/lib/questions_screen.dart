import 'package:flutter/material.dart';
import 'package:test2/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QusetionScreenState();
  }
}

class _QusetionScreenState extends State<QuestionsScreen> {
  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Questions'),
          const SizedBox(
            width: 30,
            height: 30,
          ),
          AnswerButton(answer: 'option1', tap: () {}),
          AnswerButton(answer: 'option2', tap: () {}),
          AnswerButton(answer: 'option3', tap: () {}),
          AnswerButton(answer: 'option4', tap: () {})
        ],
      ),
    );
  }
}
