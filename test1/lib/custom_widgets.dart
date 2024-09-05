import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/custom_rolldice.dart';

class CustomWidgets extends StatelessWidget {
  const CustomWidgets({super.key});

  // ignore: prefer_typing_uninitialized_variables
  final Color firstcolor = const Color.fromARGB(255, 10, 0, 27);
  // ignore: prefer_typing_uninitialized_variables
  final Color secondcolor = const Color.fromARGB(255, 180, 6, 58);

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [secondcolor, firstcolor]),
        ),
        child: Center(
          child: DiceRoll(),
        ),
      ),
    );
  }
}
