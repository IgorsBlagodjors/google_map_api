import 'dart:convert';
import 'dart:io';

import 'package:google_map_api/data/google_map_api_client.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/domain/places_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InMemoryPlaceRepository implements PlacesRepository {
  final GoogleMapApiClient _googleMapApiClient;
  InMemoryPlaceRepository(this._googleMapApiClient);

  final String _myListKey = 'myListKey';
  List<Place> myList = [];
  late int index;

  @override
  Future<List<Place>> getPlace() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final serializedList = sharedPrefs.getStringList(_myListKey) ?? [];
    myList = serializedList
        .map((json) =>
            Place.fromJson(Map<String, dynamic>.from(jsonDecode(json))))
        .toList();
    return myList;
  }

  @override
  Future<void> addPlace(
      String title, File image, double lat, double long) async {
    final newPlace = Place(
      title: title,
      image: image,
      location: PlaceLocation(
          adress: await getAddress(lat, long) ?? 'Unknown',
          latitude: lat,
          longitude: long),
    );
    myList.add(newPlace);
    final sharedPrefs = await SharedPreferences.getInstance();
    final serializedList =
        myList.map((place) => jsonEncode(place.toJson())).toList();
    sharedPrefs.setStringList(_myListKey, serializedList);
  }

  @override
  Future<String?> getAddress(double lat, double long) async {
    final response = await _googleMapApiClient.getAdres(lat, long);
    return response[0].adress;
  }

  @override
  Future<void> removePlace(String id) async {
    index = myList.indexWhere((element) => element.id == id);
    myList.removeWhere((element) => element.id == id);
    final serializedList =
        myList.map((place) => jsonEncode(place.toJson())).toList();
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setStringList(_myListKey, serializedList);
  }

  @override
  Future<void> undo(Place deletedPlace) async {
    myList.insert(index, deletedPlace);
    final sharedPrefs = await SharedPreferences.getInstance();
    final serializedList =
        myList.map((place) => jsonEncode(place.toJson())).toList();
    sharedPrefs.setStringList(_myListKey, serializedList);
  }
}
