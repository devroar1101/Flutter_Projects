import 'package:flutter/material.dart';
import 'package:mealsapp/models/dummydata.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/models/mealcategory.dart';
import 'package:mealsapp/screens/meals_screen.dart';
import 'package:mealsapp/widgets/meal_categort_item.dart';

// ignore: must_be_immutable
class MealCategoryScreen extends StatefulWidget {
  MealCategoryScreen({super.key, required this.availableMeals});

  List<Meal> availableMeals;

  @override
  State<MealCategoryScreen> createState() => _MealCategoryScreenState();
}

class _MealCategoryScreenState extends State<MealCategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  void onClickCategory(BuildContext context, MealCategory category) {
    final filteredMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
                  title: category.title,
                  meals: filteredMeals,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    List<MealCategory> filteredCategory = availableCategories.where((cat) {
      return widget.availableMeals
          .any((Meal meal) => meal.categories.contains(cat.id));
    }).toList();
    return AnimatedBuilder(
        animation: _animationController,
        builder: ((context, child) {
          return Padding(
            padding:
                EdgeInsets.only(top: 100 - _animationController.value * 100),
            child: child,
          );
        }),
        child: GridView(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width >= 600 ? 4 : 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: filteredCategory.map((category) {
            return MealCategortItem(
              mealCategory: category,
              onClickCategory: () {
                onClickCategory(context, category);
              },
            );
          }).toList(),
        ));
  }
}
