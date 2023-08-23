import 'package:equatable/equatable.dart';
import 'package:google_map_api/domain/place_class.dart';

class PlacesListState extends Equatable {
  final List<Place> items;
  final String adress;
  final bool isLoading;
  final bool isError;

  const PlacesListState({
    required this.items,
    required this.isLoading,
    required this.isError,
    required this.adress,
  });

  PlacesListState copyWith({
    List<Place>? items,
    bool? isLoading,
    bool? isError,
    String? adress,
  }) =>
      PlacesListState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        adress: adress ?? this.adress,
      );

  @override
  List<Object?> get props => [items, isLoading, isError, adress];
}
