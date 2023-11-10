// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) =>
    PlaceLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      adress: json['adress'] as String,
    );

Map<String, dynamic> _$PlaceLocationToJson(PlaceLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'adress': instance.adress,
    };

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      title: json['title'] as String,
      image: const FileConverter().fromJson(json['image'] as String),
      location:
          PlaceLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'title': instance.title,
      'image': const FileConverter().toJson(instance.image),
      'location': instance.location,
    };
