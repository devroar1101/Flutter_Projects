import 'package:flutter/material.dart';
import 'package:nativefeature/place.dart';

class Placedetail extends StatelessWidget {
  const Placedetail({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Hero(
            tag: place.id,
            transitionOnUserGestures: true,
            child: Image.file(
              place.image,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
