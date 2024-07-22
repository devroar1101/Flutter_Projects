import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/custom_rolldice.dart';

class CustomWidgets extends StatelessWidget {
  const CustomWidgets(this.firstcolor, this.secondcolor, {super.key});

  // ignore: prefer_typing_uninitialized_variables
  final Color firstcolor;
  // ignore: prefer_typing_uninitialized_variables
  final Color secondcolor;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [secondcolor, firstcolor]),
      ),
      child: Center(
        child: DiceRoll(),
      ),
    );
  }
}
