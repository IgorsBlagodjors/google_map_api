import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_api/presentation/bloc/places_list_cubit.dart';
import 'package:google_map_api/presentation/bloc/places_list_state.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
  static Widget withCubit() => BlocProvider(
        create: (context) => PlacesListCubit(
          context.read(),
        ),
        child: const LocationInput(),
      );
}

class _LocationInputState extends State<LocationInput> {
  late final PlacesListCubit _cubit;
  late String lat;
  late String long;

  var _isGettingPosition = false;
  @override
  void initState() {
    _cubit = BlocProvider.of<PlacesListCubit>(context);

    super.initState();
  }

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
    setState(() {
      _isGettingPosition = false;
    });

    print('LATITUDE ${locationData.latitude}');
    print('ALTITUDE ${locationData.altitude}');
    long = locationData.longitude.toString();
    lat = locationData.latitude.toString();
    _cubit.lat = locationData.latitude.toString();
    _cubit.long = locationData.latitude.toString();

    _cubit.getAdress();
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesListCubit, PlacesListState>(
      builder: (context, state) {
        Widget child;
        if (state.isError) {
          child = const Text('Failure error');
        } else if (state.adress.isEmpty) {
          child = const Text('No location chosen');
        } else if (state.isLoading) {
          child = const CircularProgressIndicator();
        } else {
          final data = state.adress;
          child = Image.network(
            'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$long&key=AIzaSyChX4NdABW4hLxgB-exR7IsxX-fP1CpR-E',
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
              child: child,
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
      },
    );
  }
}
