import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/components/error_text.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_state.dart';
import 'package:jwt_auth_client/presentation/components/default_layout.dart';
import 'package:jwt_auth_client/presentation/screens/login/bloc/login_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/login/bloc/login_state.dart';
import 'package:jwt_auth_client/routing/home_route.dart';
import 'package:jwt_auth_client/routing/sign_up_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Login screen',
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccessState) {
            Navigator.pushReplacement(context, HomeRoute());
          }
        },
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              context.read<AuthCubit>().checkAuthorization();
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20.0),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: state.email,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'email'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: state.password,
                    obscureText: true,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: 'password'),
                    onEditingComplete: () => _onSubmit(context),
                  ),
                  if (state is FailedLoginState) ErrorText(state.error),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, SignUpRoute());
                      },
                      child: const Text('Don\'t have an account? Sign up'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onSubmit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    return context.read<LoginCubit>().sendForm();
  }
}
