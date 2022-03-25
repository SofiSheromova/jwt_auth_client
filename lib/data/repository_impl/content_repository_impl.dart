import 'package:jwt_auth_client/data/api/content_api.dart';
import 'package:jwt_auth_client/data/repository_impl/base_repository.dart';
import 'package:jwt_auth_client/data/token_verifier.dart';
import 'package:jwt_auth_client/domain/repository/content_repository.dart';

class ContentRepositoryImpl extends BaseRepository implements ContentRepository {
  final ContentApi _contentApi;

  ContentRepositoryImpl(this._contentApi, TokenVerifier tokenVerifier) : super(tokenVerifier);

  @override
  Future<String> getContent() async {
    return withTokenVerification(
      () async => await _contentApi.getSecretContent(),
    );
  }
}
