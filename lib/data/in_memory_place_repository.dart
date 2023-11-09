import 'dart:io';

import 'package:google_map_api/data/google_map_api_client.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/domain/places_repository.dart';

List<Place> myList = [];

class InMemoryPlaceRepository implements PlacesRepository {
  final GoogleMapApiClient _googleMapApiClient;
  InMemoryPlaceRepository(this._googleMapApiClient);
  @override
  Future<List<Place>> getTitle() async {
    return myList;
  }

  @override
  Future<void> addTitle(
      String title, File image, double lat, double long) async {
    final newPlace = Place(
      title: title,
      image: image,
      location: PlaceLocation(
          adress: await getAddress() ?? 'Unknown',
          latitude: lat,
          longitude: long),
    );
    myList.add(newPlace);
  }

  @override
  Future<String?> getAddress() async {
    final response = await _googleMapApiClient.getAdres();
    return response[0].adress;
  }
}
