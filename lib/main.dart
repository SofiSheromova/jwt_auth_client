import 'package:flutter/material.dart';
import 'package:jwt_auth_client/jwt_auth_client_app.dart';
import 'package:global_configuration/global_configuration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('config');

  runApp(const JwtAuthClientApp());
}
