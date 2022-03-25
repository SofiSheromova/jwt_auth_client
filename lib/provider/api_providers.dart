import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/api/auth_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_auth_client/data/api/content_api.dart';
import 'package:provider/provider.dart';

class ApiProviders extends StatelessWidget {
  final Widget child;

  const ApiProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthApi>(
          create: (context) => AuthApi(context.read<Dio>()),
        ),
        Provider<ContentApi>(
          create: (context) => ContentApi(context.read<Dio>()),
        ),
      ],
      child: child,
    );
  }
}
