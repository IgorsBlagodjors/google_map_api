import 'dart:io';

import 'package:google_map_api/data/api_key.dart';
import 'package:google_map_api/data/google_map_api_client.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/domain/places_repository.dart';

List<Place> myList = [];

class InMemoryPlaceRepository implements PlacesRepository {
  final GoogleMapApiClient _googleMapApiClient;
  InMemoryPlaceRepository(this._googleMapApiClient);
  @override
  Future<List<Place>> getTitle() async {
    print('My list $myList');
    return myList;
  }

  @override
  Future<void> addTitle(
      String title, File image, String lat, String long) async {
    final adress = await getAddress();
    final newPlace = Place(
      title: title,
      image: image,
      adress: adress ?? 'Unknown',
      locationImage:
          'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$apiKey',
    );
    myList.add(newPlace);
  }

  @override
  Future<String?> getAddress() async {
    print('TESTIRUEM1');
    final response = await _googleMapApiClient.getAdres();
    print('TESTIRUEMMMMMMMMMMMMMMMMM');
    print('${response[0].adress}');
    return response[0].adress;
  }
}
