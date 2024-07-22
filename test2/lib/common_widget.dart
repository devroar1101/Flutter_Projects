import 'package:flutter/material.dart';
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
  //Widget? activeScreen;

  var activeScreen = 'start-screen';

  /*@override
  void initState() {
    activeScreen = HomeScreenWidgets(screenChange);
    super.initState();
  }*/

  void screenChange() {
    setState(() {
      //activeScreen = const QuestionsScreen();

      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(137, 31, 2, 136),
            Color.fromARGB(255, 11, 1, 51)
          ]),
        ),
        child: activeScreen == 'start-screen'
            ? HomeScreenWidgets(screenChange)
            : const QuestionsScreen(),
      )),
    );
  }
}
