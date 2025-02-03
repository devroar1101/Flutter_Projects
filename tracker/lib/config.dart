import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Configuration {
  static ThemeData get theme => ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF59DCEB), brightness: Brightness.light),
      textTheme: GoogleFonts.latoTextTheme(),
      scaffoldBackgroundColor: const Color(0xFF59DCEB));

  static Color appcolor = const Color(0xFF59DCEB);
  static Color appWhite = Colors.white;
  static Color cardColor = const Color(0xFF34495E);
}
