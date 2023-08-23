import 'dart:io';

import 'package:google_map_api/domain/place_class.dart';

abstract class PlacesRepository {
  Future<List<Place>> getTitle();
  Future<void> addTitle(String title, File image);
  Future<String?> getAddress();
}
