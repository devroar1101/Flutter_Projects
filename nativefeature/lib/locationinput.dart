import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:nativefeature/place.dart';

// ignore: must_be_immutable
class LocationInputScreen extends StatefulWidget {
  LocationInputScreen({super.key, required this.pickLocation});

  void Function(PlaceLocation location) pickLocation;
  @override
  State<StatefulWidget> createState() {
    return LocationInputScreenState();
  }
}

class LocationInputScreenState extends State<LocationInputScreen> {
  PlaceLocation? selectedLocation;

  bool isLocating = false;

  void onPickLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLocating = true;
    });

    _locationData = await location.getLocation();
    final lat = _locationData.latitude;
    final lon = _locationData.longitude;

    if (lat != null && lon != null) {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json');
      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final resData = json.decode(response.body);
          final road = resData['address']['road'] ?? '';
          final district = resData['address']['city'] ?? '';
          final address = '$road $district';

          setState(() {
            isLocating = false;
            selectedLocation =
                PlaceLocation(address: address, latitude: lat, longitude: lon);
            widget.pickLocation(selectedLocation!);
          });
        } else {
          print('Failed to get address: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    } else {
      print('Unable to get location');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'pick the location',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );

    if (isLocating) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Container(
          height: 124,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          child: content,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: onPickLocation,
              label: Text(
                'Current Location',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              icon: const Icon(Icons.location_on),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'locate on map',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
