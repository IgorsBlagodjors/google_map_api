import 'package:dio/dio.dart';
import 'package:google_map_api/data/google_map_response.dart';
import 'package:google_map_api/domain/response_class.dart';

class GoogleMapApiClient {
  final Dio _dio;

  GoogleMapApiClient(this._dio);

  Future<List<ResponseClass>> getAdres() async {
    final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=57.009700,24.160321&key=AIzaSyChX4NdABW4hLxgB-exR7IsxX-fP1CpR-E');
    final fullResponse = AdresResponse.fromJson(response.data);
    print('POLNIJ RESPONS $fullResponse');
    return fullResponse.toModel();
  }
}
