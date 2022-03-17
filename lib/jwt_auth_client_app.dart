import 'package:flutter/material.dart';
import 'package:jwt_auth_client/home_page.dart';

class JwtAuthClientApp extends StatelessWidget {
  const JwtAuthClientApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
