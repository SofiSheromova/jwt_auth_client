/// Wrapper for response from API
abstract class Resource<T> {
  final T? data;
  final Object? error;

  const Resource._(this.data, this.error);

  factory Resource.success(T data) = ResourceSuccess;
  factory Resource.error(Object error) = ResourceError;
}

/// Wrapper for success response from api
class ResourceSuccess<T> extends Resource<T> {
  const ResourceSuccess(T data) : super._(data, null);
}

// Wrapper for failure response from api
class ResourceError<T> extends Resource<T> {
  const ResourceError(Object error) : super._(null, error);
}
