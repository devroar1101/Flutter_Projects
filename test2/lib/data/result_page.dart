import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test2/data/questions.dart';
import 'package:test2/data/result_summary.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  ResultPage({super.key, required this.answers, required this.changescreen});

  List<Map<String, Object>> resultSummary() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < answers.length; i++) {
      summary.add({
        'QuestionNo': i,
        'Question': questions[i].question,
        'CorrectAnswer': questions[i].options[0],
        'SubmitedAnswer': answers[i],
      });
    }
    return summary;
  }

  void Function() changescreen;

  final List<String> answers;
  @override
  Widget build(context) {
    final summaryReult = resultSummary();
    final totalQuestion = questions.length;
    final correctAns = summaryReult.where((data) {
      return data['CorrectAnswer'] == data['SubmitedAnswer'];
    }).length;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total $correctAns Out of $totalQuestion is correct answer',
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ResultSummary(resultSummary()),
            Center(
              child: TextButton.icon(
                onPressed: changescreen,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, alignment: Alignment.center),
                label: const Text('Restart'),
                icon: const Icon(Icons.refresh),
              ),
            )
          ],
        ),
      ),
    );
  }
}
