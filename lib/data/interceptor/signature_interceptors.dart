import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/utils/date_formats.dart';

// If your application uses X-Signature then use the following interceptors.
// Note that the DateTimeInterceptor must be before the SecretInterceptor.

/// Adds the "X-Datetime" field to the headers.
/// explanations -> https://youtrack.doubletapp.ai/youtrack/articles/DTDEVOPS-A-73/X-Signature
class DateTimeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      RequestKeys.dateTimeField: DateFormats.dateTimeHeader.format(DateTime.now().toUtc()),
    });

    super.onRequest(options, handler);
  }
}

/// Adds an "X-Signature" token to the headers
/// explanations -> https://youtrack.doubletapp.ai/youtrack/articles/DTDEVOPS-A-73/X-Signature
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

class ApiSettings {
  /// Custom headers whose contents are used when calculating the "X-Signature" field
  static const customHeaders = [RequestKeys.authorizationField, RequestKeys.dateTimeField];
}
