import 'package:dio/dio.dart';
import 'package:jwt_auth_client/data/constants/request_keys.dart';
import 'package:jwt_auth_client/data/models/auth/auth_request.dart';
import 'package:jwt_auth_client/data/models/auth/auth_response.dart';
import 'package:jwt_auth_client/data/models/auth/update_tokens_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/auth/register')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> signUp(@Body() AuthRequest authRequest);

  @POST('/auth/login')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> login(@Body() AuthRequest authRequest);

  @POST('/auth/logout')
  Future<void> logout();

  @POST('/auth/update-tokens')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> updateTokens(@Body() UpdateTokensRequest updateTokensRequest);
}
