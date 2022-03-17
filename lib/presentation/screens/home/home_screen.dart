import 'package:flutter/material.dart';
import 'package:jwt_auth_client/presentation/components/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Home screen',
      child: Text('hello world!'),
    );
  }
}
