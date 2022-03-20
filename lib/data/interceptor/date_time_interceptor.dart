import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/utils/date_formats.dart';

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
