import 'package:flutter/material.dart';
import 'package:jwt_auth_client/provider/api_providers.dart';
import 'package:jwt_auth_client/provider/bloc_providers.dart';
import 'package:jwt_auth_client/provider/common_providers.dart';
import 'package:jwt_auth_client/provider/dio_providers.dart';
import 'package:jwt_auth_client/provider/repository_providers.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonProviders(
      child: DioProviders(
        child: ApiProviders(
          child: RepositoryProviders(
            child: BlocProviders(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
