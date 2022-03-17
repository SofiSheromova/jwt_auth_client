import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';

class ApiSettings {
  static const customHeaders = [RequestKeys.authorizationField, RequestKeys.dateTimeField];
}

/// Adds an "X-Signature" token to the headers
class SecretInterceptor extends Interceptor {
  final String _secret;

  SecretInterceptor(this._secret);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final signature = _encryptSignature(
      options.method,
      options.uri.path,
      options.queryParameters,
      options.headers,
    );

    options.headers[RequestKeys.secretField] = signature;

    super.onRequest(options, handler);
  }

  String _encryptSignature(
    String method,
    String url,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> headers,
  ) {
    final customHeaders = Map.fromEntries(
      headers.entries.where((entry) => ApiSettings.customHeaders.contains(entry.key)),
    );

    final queryForSignature = _getCanonicalString(_parseDictToListOfLines(queryParams));
    final headersForSignature = _getCanonicalString(_parseDictToListOfLines(customHeaders));
    final canonicalRequest = '$method\n$url\n$queryForSignature\n$headersForSignature';

    final hmac = Hmac(sha256, utf8.encode(_secret));
    return hmac.convert(utf8.encode(canonicalRequest)).toString();
  }

  String _getCanonicalString(List<String> elements) {
    final items = List.from(elements);
    items.sort();
    return items.join('\n');
  }

  List<String> _parseDictToListOfLines(Map<String, dynamic> dict) {
    return dict.entries.map((e) => '${e.key}:${e.value}').toList();
  }
}
