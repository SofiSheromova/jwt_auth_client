import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/utils/request_helper.dart';
import 'package:provider/provider.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(context.read<AuthRepository>()),
        ),
        Provider<RequestHelper>(
          create: (context) => RequestHelper(context.read<AuthCubit>()),
          child: child,
        ),
      ],
      child: child,
    );
  }
}
