import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger;

  LoggerInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('${options.method} ${options.uri.path}', null, StackTrace.empty);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.d(
      'DioError: \n'
      'code: ${err.response?.statusCode}\n'
      'url: ${err.requestOptions.uri}\n'
      'requestHeaders: ${err.requestOptions.headers}\n'
      'requestBody: ${err.requestOptions.data}\n'
      'responseBody: ${err.response?.data}\n'
      'extra: ${err.requestOptions.extra}',
      err,
      err.stackTrace,
    );

    if (err.error is Error) {
      logger.e(
        'url: ${err.requestOptions.uri.path}\n'
        'responseBody: ${err.response?.data}',
      );
    }

    super.onError(err, handler);
  }
}
