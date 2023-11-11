import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_api/data/google_map_api_client.dart';
import 'package:google_map_api/domain/places_repository.dart';
import 'package:google_map_api/presentation/screens/places.dart';

import 'data/in_memory_place_repository.dart';

void main() {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://maps.googleapis.com/maps/api/geocode/json'),
  );
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final placesApiClient = GoogleMapApiClient(dio);
  final inMemoryRepositoryProvider = RepositoryProvider<PlacesRepository>(
    create: (context) => InMemoryPlaceRepository(placesApiClient),
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        inMemoryRepositoryProvider,
      ],
      child: MaterialApp(
        home: PlacesListScreen.withCubit(),
      ),
    ),
  );
}
