import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_map_api/data/api_key.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'place_class.g.dart';

const uuid = Uuid();

@JsonSerializable()
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String adress;
  final String locationImage;
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.adress})
      : locationImage =
            'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey';

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceLocationToJson(this);
}

class FileConverter implements JsonConverter<File, String> {
  const FileConverter();

  @override
  File fromJson(String json) {
    return File(json);
  }

  @override
  String toJson(File file) {
    return file.path;
  }
}

@JsonSerializable(converters: [FileConverter()])
class Place extends Equatable {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({
    required this.title,
    required this.image,
    required this.location,
  }) : id = uuid.v4();

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  @override
  List<Object?> get props => [id, title, image, location];
}
