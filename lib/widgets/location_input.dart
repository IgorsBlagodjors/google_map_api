import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  final void Function(String lat, String long) locationCallback;
  const LocationInput({super.key, required this.locationCallback});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? lat;
  String? long;
  String? test;
  String? test2;
  String? test3;
  String? test4;

  var _isGettingPosition = false;

  Future<Position> _getCurrentLocation() async {
    Position locationData;
    bool serviseEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviseEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions permamently denied');
    }
    setState(() {
      _isGettingPosition = true;
    });

    locationData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    long = locationData.longitude.toString();
    lat = locationData.latitude.toString();

    setState(() {
      _isGettingPosition = false;
    });
    widget.locationCallback(lat ?? '', long ?? '');

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Widget viewContent = const Text('No location choosen');

    if (_isGettingPosition) {
      viewContent = const CircularProgressIndicator();
    }
    if (lat != null && long != null && !_isGettingPosition) {
      viewContent = Image.network(
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=AIzaSyChX4NdABW4hLxgB-exR7IsxX-fP1CpR-E',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: viewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
