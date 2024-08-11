import 'package:flutter/material.dart';
import 'package:practisemeal/meals/mealdetails.dart';
import 'package:practisemeal/meals/mealextrainfo.dart';

import 'package:practisemeal/models/meal.dart';

import 'package:transparent_image/transparent_image.dart';

class Meallist extends StatelessWidget {
  const Meallist({super.key, required this.meals, required this.title});

  final List<Meal> meals;

  final String title;

  void onClickMeal(meal, context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return Mealdetails(meal: meal);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != 'Favourites'
          ? AppBar(
              title: Text(title),
            )
          : null,
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            final meal = meals[index];
            return Card(
              elevation: 4,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  onClickMeal(meal, context);
                },
                child: Stack(
                  children: [
                    Hero(
                      tag: meal.id,
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(meal.imageUrl),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                meal.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Mealextrainfo(meal: meal),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
