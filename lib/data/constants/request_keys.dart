class RequestKeys {
  // Headers
  static const String secretField = 'X-Signature';
  static const String dateTimeField = 'X-Datetime';
  static const String authorizationField = 'Authorization';

  // Body
  static const String refreshToken = 'refresh_token';
  static const String accessToken = 'access_token';
  static const String message = 'message';
  static const String expirationOn = 'exp';
  static const String code = 'code';

  // Extra
  static const String skipToken = 'skip_token';
}
