import 'package:flutter/material.dart';
import 'package:mealsapp/models/mealcategory.dart';

// ignore: must_be_immutable
class MealCategortItem extends StatelessWidget {
  MealCategortItem(
      {super.key, required this.mealCategory, required this.onClickCategory});
  final MealCategory mealCategory;
  void Function() onClickCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClickCategory();
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              mealCategory.color.withOpacity(0.55),
              mealCategory.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          mealCategory.title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
