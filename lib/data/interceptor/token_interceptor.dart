import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/errors/user_is_not_authorized_exception.dart';

/// Adds the "Authorization" field to the headers.
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra[RequestKeys.skipToken] == true) {
      // If the request doesn't need token, then just continue to the next interceptor.
      return handler.next(options);
    }

    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: RequestKeys.accessToken);
    if (accessToken == null) {
      return handler.reject(
        DioError(requestOptions: options, error: TokenNotFound()),
        true,
      );
    }
    options.headers[RequestKeys.authorizationField] = 'Bearer $accessToken';

    super.onRequest(options, handler);
  }
}
