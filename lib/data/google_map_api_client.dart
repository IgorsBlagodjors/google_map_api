import 'package:dio/dio.dart';
import 'package:google_map_api/data/api_key.dart';
import 'package:google_map_api/data/models/google_map_response.dart';
import 'package:google_map_api/domain/response_class.dart';

class GoogleMapApiClient {
  final Dio _dio;

  GoogleMapApiClient(this._dio);

  Future<List<ResponseClass>> getAdres(double lat, double long) async {
    final queryParam = {
      'latlng': '$lat,$long',
      'key': apiKey,
    };
    final response = await _dio.get('', queryParameters: queryParam);
    final fullResponse = AdresResponse.fromJson(response.data);
    return fullResponse.toModel();
  }
}
