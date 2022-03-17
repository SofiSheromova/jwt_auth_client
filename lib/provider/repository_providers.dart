import 'package:flutter/material.dart';
import 'package:jwt_auth_client/data/repository_impl/auth_repository_impl.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';

import 'package:provider/provider.dart';

class RepositoryProviders extends StatelessWidget {
  final Widget child;

  const RepositoryProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
      ],
      child: child,
    );
  }
}
