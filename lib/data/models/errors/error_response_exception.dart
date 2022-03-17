import 'package:json_annotation/json_annotation.dart';

part 'error_response_exception.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponseException implements Exception {
  @JsonKey(defaultValue: '')
  final String type;
  @JsonKey(defaultValue: '')
  final String message;

  ErrorResponseException({
    required this.type,
    required this.message,
  });

  factory ErrorResponseException.fromJson(Map<String, dynamic> json) => _$ErrorResponseExceptionFromJson(json);
}
