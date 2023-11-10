// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdresResponse _$AdresResponseFromJson(Map<String, dynamic> json) =>
    AdresResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => AdresResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AdresResult _$AdresResultFromJson(Map<String, dynamic> json) => AdresResult(
      formattedAddress: json['formatted_address'] as String?,
    );
