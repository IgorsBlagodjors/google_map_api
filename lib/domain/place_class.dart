import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_map_api/data/api_key.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String adress;
  final String locationImage;
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.adress})
      : locationImage =
            'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey';
}

class Place extends Equatable {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({required this.title, required this.image, required this.location})
      : id = uuid.v4();

  @override
  List<Object?> get props => [id, title, image, location];
}
