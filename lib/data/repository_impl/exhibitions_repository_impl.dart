import 'package:jwt_auth_client/data/api/exhibitions_api.dart';
import 'package:jwt_auth_client/data/token_verifier.dart';
import 'package:jwt_auth_client/domain/repository/exhibitions_repository.dart';

class ExhibitionsRepositoryImpl implements ExhibitionsRepository {
  final ExhibitionsApi _exhibitionsApi;
  final TokenVerifier _tokenVerifier;

  ExhibitionsRepositoryImpl(this._exhibitionsApi, this._tokenVerifier);

  @override
  Future<Map<String, dynamic>> getExhibitions({int offset = 0, int limit = 20}) async {
    return _tokenVerifier.withTokenVerification(
      () async => await _exhibitionsApi.getExhibitions(
        offset: offset,
        limit: limit,
      ),
    );
  }
}
