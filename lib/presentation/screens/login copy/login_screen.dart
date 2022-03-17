import 'package:flutter/material.dart';
import 'package:jwt_auth_client/presentation/components/default_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Login screen',
      child: Column(
        children: [
          TextField(
            controller: _emailController,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _emailController,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('login'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
