import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practisemeal/models/dummydata.dart';

enum Filter { gluton, lactose, veg, vegan }

final filterProvider =
    StateNotifierProvider<_FilterProviderState, Map<Filter, bool>>((fn) {
  return _FilterProviderState();
});

class _FilterProviderState extends StateNotifier<Map<Filter, bool>> {
  _FilterProviderState()
      : super({
          Filter.gluton: false,
          Filter.lactose: false,
          Filter.veg: false,
          Filter.vegan: false,
        });

  void updatefilters(Filter filter, bool isactive) {
    state = {...state, filter: isactive};
  }
}

final filteredMeals = Provider((fn) {
  final currentFilters = fn.watch(filterProvider);

  return dummyMeals.where((meal) {
    if (currentFilters[Filter.gluton]! && !meal.isGlutenFree) {
      return false;
    }
    if (currentFilters[Filter.lactose]! && !meal.isLactoseFree) {
      return false;
    }
    if (currentFilters[Filter.veg]! && !meal.isVegetarian) {
      return false;
    }
    if (currentFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
