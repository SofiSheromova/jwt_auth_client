typedef RequestWrapper = Future<void> Function(Future<void> Function() request);

/// This interface must be implemented by all Cubits that execute requests requiring user authorization.
abstract class HasAuthChecker {
  /// Handles unauthorized user errors. All requests requiring authorization must be wrapped with this function.
  final RequestWrapper withAuthCheck;

  const HasAuthChecker(this.withAuthCheck);
}
