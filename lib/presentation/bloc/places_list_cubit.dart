import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  Future<void> addTitle(String title, File image) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _placesRepository.addTitle(title, image);
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  Future<void> getTitle() async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _placesRepository.getTitle();
      emit(state.copyWith(items: response, isLoading: false));
    } on Exception catch (ex, stacktrace) {
      logger.e('Failed to load: ex $ex, stacktrace: $stacktrace');
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
