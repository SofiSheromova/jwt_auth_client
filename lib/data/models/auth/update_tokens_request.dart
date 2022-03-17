import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';

part 'update_tokens_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateTokensRequest {
  @JsonKey(name: RequestKeys.refreshToken)
  final String refreshToken;

  UpdateTokensRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => _$UpdateTokensRequestToJson(this);
}
