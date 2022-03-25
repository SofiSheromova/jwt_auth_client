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

  @POST('/auth_service/register')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> signUp(@Body() AuthRequest authRequest);

  @POST('/auth_service/login')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> login(@Body() AuthRequest authRequest);

  @POST('/auth_service/logout')
  Future<void> logout();

  @PUT('/auth_service/update_tokens')
  @Extra({RequestKeys.skipToken: true})
  Future<AuthResponse> updateTokens(@Body() UpdateTokensRequest updateTokensRequest);

  // Users will not be able to revoke all tokens. The request exists to test the work.
  @POST('/auth_service/revoke_all_tokens')
  @Extra({RequestKeys.skipToken: true})
  Future<String> revokeAllTokens(@Body() UpdateTokensRequest updateTokensRequest);
}
