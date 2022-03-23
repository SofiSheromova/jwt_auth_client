import 'package:jwt_auth_client/data/token_verifier.dart';

abstract class BaseRepository {
  final TokenVerifier _tokenVerifier;

  const BaseRepository(this._tokenVerifier);

  Future<T> withTokenVerification<T>(Future<T> Function() apiRequest) =>
      _tokenVerifier.withTokenVerification(apiRequest);
}
