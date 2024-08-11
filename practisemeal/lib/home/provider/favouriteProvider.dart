import 'package:practisemeal/models/meal.dart';
import 'package:riverpod/riverpod.dart';

final favouriteMeals =
    StateNotifierProvider<_FavoutiteMealsState, List<Meal>>((fn) {
  return _FavoutiteMealsState();
});

class _FavoutiteMealsState extends StateNotifier<List<Meal>> {
  _FavoutiteMealsState() : super([]);

  bool mealExist(Meal meal) {
    bool isExist = state.contains(meal);
    return isExist;
  }

  bool onAddFavourite(Meal meal) {
    bool isExist = state.contains(meal);

    if (isExist) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}
