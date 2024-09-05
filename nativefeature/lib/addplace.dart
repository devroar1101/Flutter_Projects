import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeature/locationinput.dart';
import 'package:nativefeature/pickimage.dart';
import 'package:nativefeature/place.dart';
import 'package:nativefeature/placeprovider.dart';

// ignore: must_be_immutable
class Addplace extends ConsumerWidget {
  Addplace({super.key});

  String? title;

  Place? place;

  File? _selectedImage;

  PlaceLocation? location;

  final _formKey = GlobalKey<FormState>();

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'title',
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 0 ||
                        value.trim().length > 100) {
                      return 'Enter valid input';
                    }
                    return null;
                  },
                  onSaved: (newvalue) {
                    title = newvalue;
                  },
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(
                  height: 10,
                ),
                PickImageWidget(addImage: (image) {
                  _selectedImage = image;
                }),
                const SizedBox(
                  height: 10,
                ),
                LocationInputScreen(pickLocation: (loc) {
                  location = loc;
                }),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          onSaveForm();
                          ref
                              .read(placeProvider.notifier)
                              .onAddNewPlace(title,_selectedImage,location);
                          Navigator.pop(context);
                        },
                        child: const Text('Add Place'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
