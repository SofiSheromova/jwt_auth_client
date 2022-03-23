import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_auth_client/data/api/auth_api.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/models/auth/auth_request.dart';
import 'package:jwt_auth_client/data/models/auth/auth_response.dart';
import 'package:jwt_auth_client/data/models/auth/update_tokens_request.dart';
import 'package:jwt_auth_client/data/repository_impl/base_repository.dart';
import 'package:jwt_auth_client/data/token_verifier.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/utils/utils.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthApi _authApi;
  final Logger _logger;

  AuthRepositoryImpl(this._authApi, this._logger, TokenVerifier tokenVerifier) : super(tokenVerifier);

  @override
  Future<bool> checkTokenExistence() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: RequestKeys.accessToken);
    final refreshToken = await storage.read(key: RequestKeys.refreshToken);
    return (accessToken != null && !isTokenExpired(accessToken)) &&
        (refreshToken != null && !isTokenExpired(refreshToken));
  }

  @override
  Future<void> signUp(String email, String password) async {
    final authResponse = await _authApi.signUp(AuthRequest(email: email, password: password));
    await _saveTokens(authResponse);
  }

  @override
  Future<void> login(String email, String password) async {
    final authResponse = await _authApi.login(AuthRequest(email: email, password: password));
    await _saveTokens(authResponse);
  }

  @override
  Future<bool> updateTokens() async {
    const storage = FlutterSecureStorage();

    final refreshToken = await storage.read(key: RequestKeys.refreshToken);
    if (refreshToken == null || isTokenExpired(refreshToken)) {
      return false;
    }
    try {
      final authResponse = await _authApi.updateTokens(UpdateTokensRequest(refreshToken: refreshToken));
      await _saveTokens(authResponse);
    } catch (err) {
      if (err is DioError && err.error is SocketException) {
        rethrow;
      }
      await _removeTokens();
      return false;
    }
    return true;
  }

  @override
  Future<void> logout() async {
    await withTokenVerification(_authApi.logout);
    await _removeTokens();
  }

  Future<void> _saveTokens(AuthResponse authResponse) async {
    const storage = FlutterSecureStorage();

    try {
      await storage.write(key: RequestKeys.accessToken, value: authResponse.accessToken);
      await storage.write(key: RequestKeys.refreshToken, value: authResponse.refreshToken);
    } on Exception catch (exception) {
      _logger.e('An exception occurred while saving user tokens: $exception');
      return;
    }
  }

  Future<void> _removeTokens() async {
    const storage = FlutterSecureStorage();

    try {
      await storage.delete(key: RequestKeys.accessToken);
      await storage.delete(key: RequestKeys.refreshToken);
    } on Exception catch (exception) {
      _logger.e('An exception occurred while removing user tokens: $exception');
      return;
    }
  }
}
