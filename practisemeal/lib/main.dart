import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '360 Image View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PanoramaView(),
    );
  }
}

class PanoramaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("360 View")),
      body: Panorama(
        hotspots: [
          Hotspot(
            latitude: 0.0, // Center latitude
            longitude: 0.0, // Center longitude
            width: 100.0,
            height: 100.0,
            widget: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnotherPanoramaView(),
                  ),
                );
              },
              child: Icon(Icons.touch_app, color: Colors.blue, size: 50.0),
            ),
          ),
        ],
        child: Image.asset(
          'bryan-goff-IuyhXAia8EA-unsplash.jpg',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class AnotherPanoramaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Another 360 View")),
      body: Panorama(
        child: Image.asset(
          'allphoto-bangkok-GfXqtWmiuDI-unsplash.jpg',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
