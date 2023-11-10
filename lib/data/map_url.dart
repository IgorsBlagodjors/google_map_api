import 'package:google_map_api/data/api_key.dart';

const String staticMapBaseUrl =
    'https://maps.googleapis.com/maps/api/staticmap?';

String buildStaticMapUrl(double lat, double long) {
  return '$staticMapBaseUrl'
      'center=$lat,$long&'
      'zoom=16&'
      'size=600x300&'
      'maptype=roadmap&'
      'markers=color:red%7Clabel:A%7C$lat,$long&'
      'key=$apiKey';
}
