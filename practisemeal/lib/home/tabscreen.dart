import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practisemeal/category/mealcategoryhome.dart';
import 'package:practisemeal/home/drawer.dart';
import 'package:practisemeal/home/provider/favouriteProvider.dart';
import 'package:practisemeal/meals/meallist.dart';
import 'package:practisemeal/models/meal.dart';

class Tabscreen extends ConsumerStatefulWidget {
  const Tabscreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabscreenState();
  }
}

int screenIndex = 0;

void onTabBottomNavigationButton(postion) {
  screenIndex = postion;
}

class _TabscreenState extends ConsumerState<Tabscreen> {
  @override
  Widget build(BuildContext context) {
    List<Meal> favMeals = ref.watch(favouriteMeals);
    Widget content = Mealcategoryhome();
    String screenTitle = 'Category';

    if (screenIndex == 1) {
      content = Meallist(meals: favMeals, title: 'Favourites');
      screenTitle = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      drawer: const Drawer(
        child: MealDrawer(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        onTap: (index) {
          setState(() {
            onTabBottomNavigationButton(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
      ),
      body: content,
    );
  }
}
