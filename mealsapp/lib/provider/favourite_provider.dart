import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';

final favouriteMealPovider =
    StateNotifierProvider<_FavouriteMealPoviderState, List<Meal>>((fn) {
  return _FavouriteMealPoviderState();
});

class _FavouriteMealPoviderState extends StateNotifier<List<Meal>> {
  _FavouriteMealPoviderState() : super([]);

  bool onAddFavourite(Meal meal) {
    final alreadyFav = state.contains(meal);

    if (alreadyFav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isFavourite(meal) {
    return state.contains(meal);
  }
}
