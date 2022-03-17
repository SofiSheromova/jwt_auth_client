import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/home/home_screen.dart';

class HomeRoute extends MaterialPageRoute {
  HomeRoute()
      : super(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
            child: const HomeScreen(),
          ),
        );
}
