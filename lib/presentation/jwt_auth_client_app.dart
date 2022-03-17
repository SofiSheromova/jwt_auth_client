import 'package:flutter/material.dart';
import 'package:jwt_auth_client/presentation/screens/home_screen.dart';

class JwtAuthClientApp extends StatelessWidget {
  const JwtAuthClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
