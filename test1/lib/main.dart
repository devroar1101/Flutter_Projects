import 'package:flutter/material.dart';
import 'package:test1/custom_widgets.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: CustomWidgets(
            Color.fromARGB(255, 10, 0, 27), Color.fromARGB(255, 180, 6, 58)),
      ),
    ),
  );
}
