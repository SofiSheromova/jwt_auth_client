import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';

/// Adds an "X-API-SECRET" token to the headers
class SimpleSecretInterceptor extends Interceptor {
  final String _secret;

  SimpleSecretInterceptor(this._secret);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[RequestKeys.apiSecret] = _secret;

    super.onRequest(options, handler);
  }
}
