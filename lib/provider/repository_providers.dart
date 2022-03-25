import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/api/content_api.dart';
import 'package:jwt_auth_client/data/repository_impl/content_repository_impl.dart';
import 'package:jwt_auth_client/domain/repository/content_repository.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart' as synchronized;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:jwt_auth_client/data/api/auth_api.dart';
import 'package:jwt_auth_client/data/repository_impl/auth_repository_impl.dart';
import 'package:jwt_auth_client/data/token_verifier.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';

class RepositoryProviders extends StatelessWidget {
  final Widget child;

  const RepositoryProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TokenVerifier>(
      create: (context) => TokenVerifier(
        context.read<Dio>(),
        context.read<Logger>(),
        synchronized.Lock(),
      ),
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              Provider<AuthRepository>(
                create: (context) => AuthRepositoryImpl(
                  context.read<AuthApi>(),
                  context.read<Logger>(),
                  context.read<TokenVerifier>(),
                ),
              ),
              Provider<ContentRepository>(
                create: (context) => ContentRepositoryImpl(
                  context.read<ContentApi>(),
                  context.read<TokenVerifier>(),
                ),
              ),
            ],
            child: child,
          );
        },
      ),
    );
  }
}
