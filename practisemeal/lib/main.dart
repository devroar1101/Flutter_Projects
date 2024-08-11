import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:practisemeal/home/tabscreen.dart';

final themes = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(237, 172, 184, 3),
      brightness: Brightness.dark),
  textTheme: GoogleFonts.tinosTextTheme(),
);

void main() {
  runApp(
    ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes,
      home: const Tabscreen(),
    );
  }
}
