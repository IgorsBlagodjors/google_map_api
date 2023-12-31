import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_api/domain/place_class.dart';
import 'package:google_map_api/domain/places_repository.dart';
import 'package:google_map_api/presentation/bloc/places_list_state.dart';
import 'package:logger/logger.dart';

class PlacesListCubit extends Cubit<PlacesListState> {
  final PlacesRepository _placesRepository;
  final logger = Logger();

  PlacesListCubit(this._placesRepository)
      : super(
          const PlacesListState(
            items: [],
            isLoading: false,
            isError: false,
          ),
        );
  Future<void> addPlace(
      String title, File image, double lat, double long) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _placesRepository.addPlace(title, image, lat, long);
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> getPlace() async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _placesRepository.getPlace();
      emit(state.copyWith(items: response, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> removePlace(String id) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _placesRepository.removePlace(id);
      getPlace();
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
    }
  }

  Future<void> undo(Place deletedPlace) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _placesRepository.undo(deletedPlace);
      getPlace();
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
    }
  }
}
