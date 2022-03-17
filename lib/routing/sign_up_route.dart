import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/screens/sign_up/bloc/sign_up_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/sign_up/sign_up_screen.dart';

class SignUpRoute extends MaterialPageRoute {
  SignUpRoute()
      : super(
          builder: (context) => BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(context.read<AuthRepository>()),
            child: const SignUpScreen(),
          ),
        );
}
