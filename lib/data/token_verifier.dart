import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_auth_client/data/api/auth_api.dart';
import 'package:jwt_auth_client/data/constants/error_types.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/errors/user_is_not_authorized_exception.dart';
import 'package:jwt_auth_client/data/models/auth/update_tokens_request.dart';
import 'package:jwt_auth_client/data/models/errors/error_response_exception.dart';
import 'package:jwt_auth_client/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart' as synchronized;

class TokenVerifier {
  final Dio _dio;
  final Logger _logger;
  final synchronized.Lock _lock;

  TokenVerifier(this._dio, this._logger, this._lock);

  Future<T> withTokenVerification<T>(Future<T> Function() request) async {
    try {
      // To avoid repeated update of the token, it is necessary to perform only one check at a time
      await _lock.synchronized(_verifyToken);
      return request();
    } on DioError catch (err) {
      if (err.error is ErrorResponseException && err.error.type == ErrorTypes.tokenRevoked) {
        // To avoid repeated update of the token, it is necessary to perform only one check at a time
        await _lock.synchronized(_tryRegenerateToken);
        return request();
      }
      rethrow;
    }
  }

  Future<void> _verifyToken<T>() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: RequestKeys.accessToken);
    final refreshToken = await storage.read(key: RequestKeys.refreshToken);
    if (accessToken == null || refreshToken == null) {
      await _removeTokens();
      throw TokenNotFound();
    }

    // Check if tokens have already expired or not.
    final accessTokenExpired = isTokenExpired(accessToken);
    final refreshTokenExpired = isTokenExpired(refreshToken);

    if (refreshTokenExpired) {
      await _removeTokens();
      throw RefreshTokenHasRevokedException();
    }

    if (accessTokenExpired) {
      await _regenerateAccessTokenWithErrorHandling(refreshToken);
    }
  }

  Future<void> _tryRegenerateToken<T>() async {
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: RequestKeys.refreshToken);

    if (refreshToken == null) {
      await _removeTokens();
      throw TokenNotFound();
    }

    await _regenerateAccessTokenWithErrorHandling(refreshToken);
  }

  Future<void> _regenerateAccessTokenWithErrorHandling(String refreshToken) async {
    try {
      await _regenerateAccessToken(refreshToken);
    } on Exception catch (err) {
      if (err is DioError && err.error is ErrorResponseException && err.error.type == ErrorTypes.tokenAlreadyRevoked) {
        // For some reasons the token can be invalidated before it is expired by the backend.
        // Then we should navigate the user back to login page.
        await _removeTokens();
        throw RefreshTokenHasRevokedException();
      }
      if (err is DioError && err.error is SocketException) {
        rethrow;
      }
      _logger.e('An exception occurred while regenerating access token: $err');
      throw RegeneratingAccessTokenError(err);
    }
  }

  Future<void> _regenerateAccessToken(String refreshToken) async {
    // Make request to server to get the new access token from server using refresh token
    final authResponse = await AuthApi(_dio).updateTokens(UpdateTokensRequest(refreshToken: refreshToken));
    await _saveTokens(authResponse.accessToken, refreshToken);
  }

  Future<void> _removeTokens() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: RequestKeys.accessToken);
    await storage.delete(key: RequestKeys.refreshToken);
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: RequestKeys.accessToken, value: accessToken);
    await storage.write(key: RequestKeys.refreshToken, value: refreshToken);
  }
}
