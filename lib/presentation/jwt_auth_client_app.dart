import 'package:flutter/material.dart';
import 'package:jwt_auth_client/routing/splash_route.dart';

class JwtAuthClientApp extends StatelessWidget {
  const JwtAuthClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onUnknownRoute: (settings) => SplashRoute(),
    );
  }
}
