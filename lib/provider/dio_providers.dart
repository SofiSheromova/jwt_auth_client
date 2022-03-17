import 'package:flutter/material.dart';
import 'package:jwt_auth_client/data/interceptor/date_time_interceptor.dart';
import 'package:jwt_auth_client/data/interceptor/error_parser_interceptor.dart';
import 'package:jwt_auth_client/data/interceptor/logger_interceptor.dart';
import 'package:jwt_auth_client/data/interceptor/secret_interceptor.dart';
import 'package:jwt_auth_client/data/interceptor/token_interceptor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dio/dio.dart';

class DioProviders extends StatelessWidget {
  final Widget child;
  final String baseUrl = GlobalConfiguration().get('baseUrl');
  final String secret = GlobalConfiguration().get('secret');

  DioProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(
          create: (context) => Dio(
            BaseOptions(
              connectTimeout: 5000,
              receiveTimeout: 5000,
              baseUrl: baseUrl,
            ),
          )..interceptors.addAll([
              ErrorParserInterceptor(),
              TokenInterceptor(),
              DateTimeInterceptor(),
              SecretInterceptor(secret),
              LoggerInterceptor(context.read<Logger>()),
            ]),
        ),
      ],
      child: child,
    );
  }
}
