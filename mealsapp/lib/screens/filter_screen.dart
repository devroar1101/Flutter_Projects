import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) return;
          // Navigator.of(context).pop({
          //   Filter.gluten: isGlutanFree,
          //   Filter.lactose: isLactoseFree,
          //   Filter.vegetarian: isVegetarian,
          //   Filter.vegan: isVegan
          // });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: activeFilters[Filter.gluten]!,
              onChanged: (change) {
                ref
                    .read(filterProvider.notifier)
                    .onChangeFilter(Filter.gluten, change);
              },
              title: Text(
                'Gluten Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.onSurface,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              subtitle: Text(
                'olny gluten free foods !',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
              ),
            ),
            SwitchListTile(
              value: activeFilters[Filter.lactose]!,
              onChanged: (change) {
                ref
                    .read(filterProvider.notifier)
                    .onChangeFilter(Filter.lactose, change);
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.onSurface,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              subtitle: Text(
                'olny Lactose free foods !',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
              ),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (change) {
                ref
                    .read(filterProvider.notifier)
                    .onChangeFilter(Filter.vegetarian, change);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.onSurface,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              subtitle: Text(
                'olny Vegetarian !',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
              ),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (change) {
                ref
                    .read(filterProvider.notifier)
                    .onChangeFilter(Filter.vegan, change);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.onSurface,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              subtitle: Text(
                'olny vegan !',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
