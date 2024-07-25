import 'package:flutter/material.dart';
import 'package:test2/data/questions.dart';
import 'package:test2/data/result_page.dart';
import 'package:test2/home_screen.dart';
import 'package:test2/questions_screen.dart';

class CommonWidget extends StatefulWidget {
  const CommonWidget({super.key});
  @override
  State<CommonWidget> createState() {
    return _CommonWidgetState();
  }
}

class _CommonWidgetState extends State<CommonWidget> {
  var activeScreen = 'start-screen';

  List<String> answers = [];

  /*@override
  void initState() {
    activeScreen = HomeScreenWidgets(screenChange);
    super.initState();
  }*/
  void gatherAnswer(String answer) {
    answers.add(answer);

    if (answers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void screenChange() {
    setState(() {
      //activeScreen = const QuestionsScreen();
      answers = [];
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    Widget? navigateScreen;

    if (activeScreen == 'start-screen') {
      navigateScreen = HomeScreenWidgets(screenChange);
    } else if (activeScreen == 'question-screen') {
      navigateScreen = QuestionsScreen(selectedAnswer: gatherAnswer);
    } else if (activeScreen == 'result-screen') {
      navigateScreen = ResultPage(
        answers: answers,
        changescreen: screenChange,
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
        child: navigateScreen,
      )),
    );
  }
}
