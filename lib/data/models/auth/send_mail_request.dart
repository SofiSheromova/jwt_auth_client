import 'package:json_annotation/json_annotation.dart';

part 'send_mail_request.g.dart';

@JsonSerializable(createFactory: false)
class SendMailRequest {
  final String email;

  SendMailRequest({required this.email});

  Map<String, dynamic> toJson() => _$SendMailRequestToJson(this);
}
