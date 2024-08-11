import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practisemeal/home/provider/filterprovider.dart';

class Filterscreen extends ConsumerWidget {
  const Filterscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Filter, bool> filters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: filters[Filter.gluton]!,
            onChanged: ((change) => ref
                .read(filterProvider.notifier)
                .updatefilters(Filter.gluton, change)),
            title: Text('Is Gluton Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    )),
            subtitle: Text('only gluton free is inculded',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
          SwitchListTile(
            value: filters[Filter.lactose]!,
            onChanged: ((change) => ref
                .read(filterProvider.notifier)
                .updatefilters(Filter.lactose, change)),
            title: Text('Is Lactose Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    )),
            subtitle: Text('only lactose free is inculded',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
          SwitchListTile(
            value: filters[Filter.veg]!,
            onChanged: ((change) => ref
                .read(filterProvider.notifier)
                .updatefilters(Filter.veg, change)),
            title: Text('Is Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    )),
            subtitle: Text('only vegetarian food',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
          SwitchListTile(
            value: filters[Filter.vegan]!,
            onChanged: ((change) => ref
                .read(filterProvider.notifier)
                .updatefilters(Filter.vegan, change)),
            title: Text('Is Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    )),
            subtitle: Text('no dairy products',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
