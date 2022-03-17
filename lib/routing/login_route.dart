import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/screens/login/bloc/login_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/login/login_screen.dart';

class LoginRoute extends MaterialPageRoute {
  LoginRoute()
      : super(
          builder: (context) => BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
            child: const LoginScreen(),
          ),
        );
}
