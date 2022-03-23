import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/models/errors/error_response_exception.dart';

/// Parse errors from json to models.
class ErrorParserInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.error is SocketException) {
      return handler.next(err);
    }

    final Map<String, dynamic>? jsonData = err.response?.data;

    if (jsonData == null) {
      return handler.next(err);
    }

    if (jsonData.containsKey(RequestKeys.message)) {
      return handler.next(
        DioError(
          requestOptions: err.requestOptions,
          response: err.response,
          error: ErrorResponseException.fromJson(jsonData, err.response?.statusCode),
        ),
      );
    }

    super.onError(err, handler);
  }
}
