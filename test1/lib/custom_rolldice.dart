import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoll extends StatefulWidget {
  const DiceRoll({super.key});

  @override
  State<DiceRoll> createState() {
    return DiceRollState();
  }
}

class DiceRollState extends State<DiceRoll> {
  var imageRollNo = 2;

  onclikRollButton() {
    setState(() {
      imageRollNo = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$imageRollNo.png',
          width: 200,
        ),
        TextButton(
          onPressed: onclikRollButton,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.only(top: 20),
          ),
          child: const Text('Roll The Dice'),
        )
      ],
    );
  }
}
