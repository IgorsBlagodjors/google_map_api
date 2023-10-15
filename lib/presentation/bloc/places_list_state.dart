import 'package:equatable/equatable.dart';
import 'package:google_map_api/domain/place_class.dart';

class PlacesListState extends Equatable {
  final List<Place> items;

  final bool isLoading;
  final bool isError;

  const PlacesListState({
    required this.items,
    required this.isLoading,
    required this.isError,
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
      );

  @override
  List<Object?> get props => [items, isLoading, isError];
}
