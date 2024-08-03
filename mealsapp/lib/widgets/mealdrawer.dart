import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Mealdrawer extends StatelessWidget {
  Mealdrawer({super.key, required this.onClickMenu});

  void Function(String menu) onClickMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Cooking Up !',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(
              Icons.set_meal_sharp,
              size: 26,
            ),
            onTap: () {
              onClickMenu('Meals');
            },
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 26,
            ),
            onTap: () {
              onClickMenu('Filters');
            },
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
