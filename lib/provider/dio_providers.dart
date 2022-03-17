import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dio/dio.dart';

class DioProviders extends StatelessWidget {
  final Widget child;
  final String baseUrl = GlobalConfiguration().get('baseUrl');

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
          )..interceptors.addAll([]),
        ),
      ],
      child: child,
    );
  }
}
