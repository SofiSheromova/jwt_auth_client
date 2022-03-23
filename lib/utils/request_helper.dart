import 'package:jwt_auth_client/data/errors/user_is_not_authorized_exception.dart';
import 'package:jwt_auth_client/domain/resource.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_cubit.dart';

class RequestHelper {
  final AuthCubit _authCubit;

  const RequestHelper(this._authCubit);

  /// Does not throw exceptions. wraps the result in the [ResourceSuccess] class,
  /// wraps the error in the [ResourceError] class.
  ///
  /// Authorization error handling is enabled by default, look at [withAuthCheck].
  Future<Resource<T>> safeApiCall<T>(
    Future<T> Function() apiRequest, {
    withAuthCheck = true,
  }) async {
    try {
      return Resource.success(await apiRequest());
    } catch (err) {
      if (withAuthCheck && err is UserIsNotAuthorizedException) {
        _authCubit.onLogout();
      }
      return Resource.error(err);
    }
  }
}
