import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/components/logout_button.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_state.dart';
import 'package:jwt_auth_client/routing/login_route.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const DefaultLayout({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutState) {
          Navigator.pushAndRemoveUntil(context, LoginRoute(), (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              if (state is AuthLoginSuccessState) const LogoutButton(),
            ],
          ),
          body: Center(
            child: child,
          ),
        );
      },
    );
  }
}
