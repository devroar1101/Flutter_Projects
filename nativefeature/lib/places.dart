import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeature/addplace.dart';
import 'package:nativefeature/place.dart';
import 'package:nativefeature/placedetail.dart';
import 'package:nativefeature/placeprovider.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  void onClickAddNewPlaceButton(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => Addplace()),
    );
  }

  void onTapListTile(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => Placedetail(place: place)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Places',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          IconButton(
              onPressed: () {
                onClickAddNewPlaceButton(context);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
          itemCount: places.length,
          itemBuilder: (ctx, index) {
            Place place = places[index];
            return ListTile(
              onTap: () {
                onTapListTile(context, place);
              },
              leading: Hero(
                tag: place.id,
                transitionOnUserGestures: true,
                child: CircleAvatar(
                  foregroundImage: FileImage(place.image),
                ),
              ),
              subtitle: Text(
                place.location.address,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              title: Text(
                place.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            );
          }),
    );
  }
}
