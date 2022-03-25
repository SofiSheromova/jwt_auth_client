import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/domain/repository/content_repository.dart';
import 'package:jwt_auth_client/utils/request_helper.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/home/home_screen.dart';

class HomeRoute extends MaterialPageRoute {
  HomeRoute()
      : super(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              context.read<ContentRepository>(),
              context.read<AuthRepository>(),
              context.read<RequestHelper>(),
            ),
            child: const HomeScreen(),
          ),
        );
}
