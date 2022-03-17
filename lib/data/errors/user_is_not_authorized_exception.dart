abstract class UserIsNotAuthorizedException implements Exception {}

/// Refresh token has revoked. Requires user login.
class RefreshTokenHasRevokedException extends UserIsNotAuthorizedException {}

/// No access or refresh token set. Requires user login.
class TokenNotFound extends UserIsNotAuthorizedException {}

class RegeneratingAccessTokenError implements Exception {
  final dynamic err;

  const RegeneratingAccessTokenError(this.err);
}
