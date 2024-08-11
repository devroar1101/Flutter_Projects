import 'package:flutter/material.dart';

class MealCategory {
  MealCategory(
      {required this.id, required this.title, this.color = Colors.orange});

  final String id;
  final String title;
  final Color color;
}
