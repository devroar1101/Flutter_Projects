import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/dummydata.dart';

final meals = Provider((fn) {
  return dummyMeals;
});
