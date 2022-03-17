class ErrorTypes {
  /// The access token has been revoked. Need to update tokens and retry request.
  static const String tokenRevoked = 'token_revoked';

  /// When updating a token. At this point, all tokens are revoked. Login required
  static const String tokenAlreadyRevoked = 'token_already_revoked';

  /// This email is already occupied
  static const String emailOccupied = 'email_occupied';

  /// A non-existent email has been entered
  static const String nonExistentEmail = 'non_existent_email';

  /// A non-existent code has been entered. Probably the code has expired
  static const String nonExistentRestorePasswordCode = 'non_existent_restore_password_code';
}
