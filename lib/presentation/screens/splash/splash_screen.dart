import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_state.dart';
import 'package:jwt_auth_client/presentation/res/image_assets.dart';
import 'package:jwt_auth_client/routing/home_route.dart';
import 'package:jwt_auth_client/routing/login_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          Navigator.pushReplacement(context, HomeRoute());
        }
        if (state is AuthLogoutState) {
          Navigator.pushReplacement(context, LoginRoute());
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(ImageAssets.key),
        ),
      ),
    );
  }
}
