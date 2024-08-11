import 'package:flutter/material.dart';
import 'package:practisemeal/models/meal.dart';

class Mealextrainfo extends StatelessWidget {
  const Mealextrainfo({super.key, required this.meal});

  final Meal meal;

  String get mealAffordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get mealComplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.schedule,
          size: 10,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          '${meal.duration} min',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Icon(
          Icons.settings,
          size: 10,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          mealComplexity,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Icon(
          Icons.currency_rupee,
          size: 10,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          mealAffordability,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
