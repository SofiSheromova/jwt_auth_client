import 'package:json_annotation/json_annotation.dart';

part 'set_password_request.g.dart';

@JsonSerializable(createFactory: false)
class SetPasswordRequest {
  @JsonKey(name: 'code')
  final String restoreCode;
  final String password;

  SetPasswordRequest({required this.restoreCode, required this.password});

  Map<String, dynamic> toJson() => _$SetPasswordRequestToJson(this);
}
