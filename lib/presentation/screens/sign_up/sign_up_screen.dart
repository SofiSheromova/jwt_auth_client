import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/components/error_text.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_state.dart';
import 'package:jwt_auth_client/presentation/components/default_layout.dart';
import 'package:jwt_auth_client/presentation/screens/sign_up/bloc/sign_up_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/sign_up/bloc/sign_up_state.dart';
import 'package:jwt_auth_client/routing/home_route.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'SignUp screen',
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccessState) {
            Navigator.pushReplacement(context, HomeRoute());
          }
        },
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SuccessfulSignUpState) {
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
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: state.confirmPassword,
                    obscureText: true,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: 'confirm password'),
                    onEditingComplete: () => _onSubmit(context),
                  ),
                  if (state is FailedSignUpState) ErrorText(state.error),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Sign Up'),
                  )
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
    return context.read<SignUpCubit>().sendForm();
  }
}
