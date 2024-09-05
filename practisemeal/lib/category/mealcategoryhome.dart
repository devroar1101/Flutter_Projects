import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practisemeal/home/provider/filterprovider.dart';
import 'package:practisemeal/meals/meallist.dart';
import 'package:practisemeal/models/dummydata.dart';
import 'package:practisemeal/models/meal.dart';
import 'package:practisemeal/models/mealcategory.dart';

class Mealcategoryhome extends ConsumerWidget {
  Mealcategoryhome({super.key});

  final categories = availableCategories;

  void onClickCategory(
      MealCategory category, BuildContext context, List<Meal> avaliableMeals) {
    final meals = avaliableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Meallist(
          meals: meals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(filteredMeals);

    final width = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 600 ? 4 : 2,
        crossAxisSpacing: 8,
        childAspectRatio: 1.5,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: categories.length,
      itemBuilder: (context, index) => InkWell(
        borderRadius: BorderRadius.circular(14),
        splashColor: Theme.of(context).primaryColor.withOpacity(1),
        onTap: () {
          onClickCategory(categories[index], context, meals);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                categories[index].color.withOpacity(0.7),
                categories[index].color,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categories[index].title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
            ],
          ),
        ),
      ),
    );
  }
}
