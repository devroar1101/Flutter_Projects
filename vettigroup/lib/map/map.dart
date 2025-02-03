import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VgramMap extends StatefulWidget {
  const VgramMap({super.key});

  @override
  State<VgramMap> createState() => _VgramMapState();
}

class _VgramMapState extends State<VgramMap> {
  LatLng myCurrentLocation = const LatLng(30.3949, 84.1240);
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vgram Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: myCurrentLocation,
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
