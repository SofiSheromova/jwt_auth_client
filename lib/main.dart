import 'package:flutter/material.dart';
import 'package:jwt_auth_client/presentation/jwt_auth_client_app.dart';
import 'package:jwt_auth_client/provider/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const AppProviders(
      child: JwtAuthClientApp(),
    ),
  );
}
