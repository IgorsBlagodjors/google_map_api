import 'package:google_map_api/domain/response_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_map_response.g.dart';

@JsonSerializable(createToJson: false)
class AdresResponse {
  List<AdresResult> results;
  AdresResponse({required this.results});

  factory AdresResponse.fromJson(Map<String, dynamic> json) =>
      _$AdresResponseFromJson(json);

  List<ResponseClass> toModel() {
    return results
        .map(
          (e) => ResponseClass(
            adress: e.formattedAddress,
          ),
        )
        .toList();
  }
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AdresResult {
  String? formattedAddress;
  AdresResult({required this.formattedAddress});
  factory AdresResult.fromJson(Map<String, dynamic> json) =>
      _$AdresResultFromJson(json);
}
