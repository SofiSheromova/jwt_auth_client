import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/exhibitions_repository.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/home/home_screen.dart';

class HomeRoute extends MaterialPageRoute {
  HomeRoute()
      : super(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              context.read<ExhibitionsRepository>(),
              context.read<AuthCubit>().withAuthCheck,
            ),
            child: const HomeScreen(),
          ),
        );
}
