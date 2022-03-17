import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';

part 'auth_response.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponse {
  @JsonKey(name: RequestKeys.accessToken)
  final String accessToken;
  @JsonKey(name: RequestKeys.refreshToken)
  final String refreshToken;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
