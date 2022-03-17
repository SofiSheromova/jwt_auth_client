import 'package:flutter/material.dart';
import 'package:jwt_auth_client/presentation/screens/splash/splash_screen.dart';

class SplashRoute extends MaterialPageRoute {
  SplashRoute()
      : super(
          builder: (context) => const SplashScreen(),
        );
}
