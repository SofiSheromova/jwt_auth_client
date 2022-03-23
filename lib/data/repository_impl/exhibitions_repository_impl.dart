import 'package:jwt_auth_client/data/api/exhibitions_api.dart';
import 'package:jwt_auth_client/data/repository_impl/base_repository.dart';
import 'package:jwt_auth_client/data/token_verifier.dart';
import 'package:jwt_auth_client/domain/repository/exhibitions_repository.dart';

class ExhibitionsRepositoryImpl extends BaseRepository implements ExhibitionsRepository {
  final ExhibitionsApi _exhibitionsApi;

  ExhibitionsRepositoryImpl(this._exhibitionsApi, TokenVerifier tokenVerifier) : super(tokenVerifier);

  @override
  Future<Map<String, dynamic>> getExhibitions({int offset = 0, int limit = 20}) async {
    return withTokenVerification(
      () async => await _exhibitionsApi.getExhibitions(
        offset: offset,
        limit: limit,
      ),
    );
  }
}
