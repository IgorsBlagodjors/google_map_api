import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_api/data/map_url.dart';
import 'package:google_map_api/presentation/screens/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final void Function(double lat, double long) locationCallback;
  const LocationInput({super.key, required this.locationCallback});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double? lat;
  double? long;

  bool _isGettingPosition = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isGettingPosition = true;
    });
    Position locationData;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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

    locationData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      long = locationData.longitude;
      lat = locationData.latitude;
    });
    widget.locationCallback(lat ?? 0, long ?? 0);
    setState(() {
      _isGettingPosition = false;
    });
  }

  void selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    setState(() {
      lat = pickedLocation.latitude;
      long = pickedLocation.longitude;
    });
    widget.locationCallback(lat ?? 0, long ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    Widget viewContent = const Text('No location chosen');

    if (_isGettingPosition) {
      viewContent = const CircularProgressIndicator();
    }
    if (lat != null && long != null && !_isGettingPosition) {
      viewContent = Image.network(
        buildStaticMapUrl(lat!, long!),
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
              onPressed: selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
