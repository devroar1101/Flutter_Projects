import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenWidgets extends StatelessWidget {
  const HomeScreenWidgets(this.navigateScreen, {super.key});

  final void Function() navigateScreen;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 200,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          Text(
            'Learn flutter by fun way!!',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
          OutlinedButton.icon(
            onPressed: () {
              navigateScreen();
            },
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            label: const Text("Start Quiz"),
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
