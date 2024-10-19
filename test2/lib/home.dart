import 'package:flutter/material.dart';
import 'package:test2/data/questions.dart';
import 'package:test2/data/result_page.dart';
import 'package:test2/start_page.dart';
import 'package:test2/question_page.dart';

class CommonWidget extends StatefulWidget {
  const CommonWidget({super.key});
  @override
  State<CommonWidget> createState() {
    return _CommonWidgetState();
  }
}

class _CommonWidgetState extends State<CommonWidget> {
  var activePage = 'start-page';

  List<String> answers = [];

  /*@override
  void initState() {
    activePage = HomepageWidgets(pageChange);
    super.initState();
  }*/
  void gatherAnswer(String answer) {
    answers.add(answer);

    if (answers.length == questions.length) {
      setState(() {
        activePage = 'result-page';
      });
    }
  }

  void pageChange() {
    setState(() {
      //activePage = const Questionspage();
      answers = [];
      activePage = 'question-page';
    });
  }

  @override
  Widget build(context) {
    Widget? navigatepage;

    if (activePage == 'start-page') {
      navigatepage = HomepageWidgets(pageChange);
    } else if (activePage == 'question-page') {
      navigatepage = Questionspage(selectedAnswer: gatherAnswer);
    } else if (activePage == 'result-page') {
      navigatepage = ResultPage(
        answers: answers,
        changepage: pageChange,
      );
    }

    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(137, 31, 2, 136),
            Color.fromARGB(255, 11, 1, 51)
          ]),
        ),
        child: navigatepage,
      )),
    );
  }
}
