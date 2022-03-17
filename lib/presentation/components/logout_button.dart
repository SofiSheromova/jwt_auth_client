import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.logout),
          SizedBox(width: 10.0),
          Text('Logout'),
        ],
      ),
      onPressed: context.read<AuthCubit>().logout,
    );
  }
}
