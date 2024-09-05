import 'dart:ui';

class Category {
  Category(this.type, this.color);
  final String type;
  final Color color;
}

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}
