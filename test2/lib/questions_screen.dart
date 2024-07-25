import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test2/answer_button.dart';
import 'package:test2/data/questions.dart';

// ignore: must_be_immutable
class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({super.key, required this.selectedAnswer});

  void Function(String answer) selectedAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var questionindex = 0;

  void incrementIndex(String ans) {
    widget.selectedAnswer(ans);

    setState(() {
      if (questionindex < 5) {
        questionindex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question1 = questions[questionindex];
    return Container(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question1.question,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 30,
              height: 30,
            ),
            ...question1.getShuffledAnswer().map((option) {
              return AnswerButton(
                  answer: option,
                  tap: () {
                    incrementIndex(option);
                  });
            }),
          ],
        ),
      ),
    );
  }
}
