import 'package:json_annotation/json_annotation.dart';

part 'error_response_exception.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponseException implements Exception {
  @JsonKey(defaultValue: '')
  final String type;
  @JsonKey(defaultValue: '')
  final String message;
  final int? code;

  ErrorResponseException({
    required this.type,
    required this.message,
    required this.code,
  });

  factory ErrorResponseException.fromJson(Map<String, dynamic> json, int? code) {
    json['code'] = code;
    return _$ErrorResponseExceptionFromJson(json);
  }
}
