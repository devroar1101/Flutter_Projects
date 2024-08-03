import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/provider/favourite_provider.dart';
import 'package:mealsapp/provider/filter_provider.dart';
import 'package:mealsapp/screens/filter_screen.dart';
import 'package:mealsapp/screens/meal_category_screen.dart';
import 'package:mealsapp/screens/meals_screen.dart';
import 'package:mealsapp/widgets/mealdrawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  void OnTabClick(index) {
    setState(() {
      tabIndex = index;
    });
  }

  int tabIndex = 0;

  // void onMenuClick(String menu) async {
  //   Navigator.pop(context);
  //   if (menu == 'Filters') {
  //     final content = await Navigator.push<Map<Filter, bool>>(
  //         context,
  //         MaterialPageRoute(
  //             builder: (ctx) => FilterScreen(
  //                   currentFilter: filteredMeals,
  //                 )));
  //     setState(() {
  //       filteredMeals = content ?? filteredMeals;
  //     });
  //   }
  // }

  void onMenuClick(String menu) {
    Navigator.pop(context);
    if (menu == 'Filters') {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> availableMeals = ref.watch(availableMealsFilter);

    final favMeals = ref.watch(favouriteMealPovider);

    Widget content = MealCategoryScreen(
      availableMeals: availableMeals,
    );
    var activeTitle = 'Categories';

    if (tabIndex == 1) {
      content = MealsScreen(
        meals: favMeals,
      );

      activeTitle = 'your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: Mealdrawer(
        onClickMenu: onMenuClick,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
          onTap: OnTabClick,
          currentIndex: tabIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites'),
          ]),
    );
  }
}
