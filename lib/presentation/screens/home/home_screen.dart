import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/components/default_layout.dart';
import 'package:jwt_auth_client/presentation/components/error_text.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_cubit.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home screen',
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is FailedDataFetchState) {
            return ErrorText(state.error);
          }
          if (state is SuccessfulDataFetchState) {
            return Text(state.data);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
