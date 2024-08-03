import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/provider/meal_provider.dart';

enum Filter { gluten, lactose, vegetarian, vegan }

final filterProvider =
    StateNotifierProvider<_FilterProviderState, Map<Filter, bool>>((fn) {
  return _FilterProviderState();
});

class _FilterProviderState extends StateNotifier<Map<Filter, bool>> {
  _FilterProviderState()
      : super({
          Filter.gluten: false,
          Filter.lactose: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  bool onChangeFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
    return true;
  }
}

final availableMealsFilter = Provider((ref) {
  final mealsList = ref.watch(meals);
  final filteredMeals = ref.watch(filterProvider);

  return mealsList.where((meal) {
    if (filteredMeals[Filter.gluten]! && !meal.isGlutenFree) {
      return false;
    }
    if (filteredMeals[Filter.lactose]! && !meal.isLactoseFree) {
      return false;
    }
    if (filteredMeals[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filteredMeals[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
