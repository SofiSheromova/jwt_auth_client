abstract class AuthRepository {
  Future<bool> checkTokenExistence();

  Future<void> login(String email, String password);

  Future<void> signUp(String email, String password);

  Future<bool> updateTokens();

  Future<void> logout();

  // Users will not be able to revoke all tokens. The request exists to test the work.
  Future<String> revokeAllTokens();
}
