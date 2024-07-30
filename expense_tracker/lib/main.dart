import 'package:expense_tracker/widgets/expense_home.dart';
import 'package:flutter/material.dart';

var kColorscheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(199, 122, 230, 125));

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: kColorscheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorscheme.inversePrimary,
            foregroundColor: kColorscheme.onPrimary,
          ),
          cardTheme: const CardTheme().copyWith(
              color: const Color.fromARGB(199, 122, 230, 125),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorscheme.onPrimary,
            ),
          ),
        ),
        home: const ExpenseHome()),
  );
}
