import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 1, 82),
                Color.fromARGB(255, 3, 0, 7)
              ],
              begin: AlignmentDirectional.topCenter,
              end: Alignment.topRight,
            ),
          ),
          child: const Center(
            child: Text(
              "Hello World!",
              style: TextStyle(
                color: Color.fromARGB(97, 255, 255, 255),
                fontSize: 34,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
