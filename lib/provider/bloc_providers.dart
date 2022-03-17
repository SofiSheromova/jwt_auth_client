import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(context.read<AuthRepository>()),
        ),
      ],
      child: child,
    );
  }
}
