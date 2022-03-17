import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/models/errors/error_response_exception.dart';

String getTextByError(err) {
  if (err is DioError && err.error is ErrorResponseException) {
    return err.error.message;
  }
  if (err is DioError && err.error is SocketException) {
    return 'Please check your internet connection and try again';
  }
  return 'Something went wrong';
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw ArgumentError('Invalid jwt token', token);
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw ArgumentError('Invalid jwt token payload', payload);
  }

  return payloadMap;
}

String _decodeBase64(String str) => utf8.decode(base64Url.decode(base64Url.normalize(str)));

bool isTokenExpired(String token) {
  final expiresOn = parseJwt(token)[RequestKeys.expirationOn] as int;
  return DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(expiresOn * 1000));
}
