import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitState()) {
    _updateUser();
  }

  Future<void> _updateUser() async {
    // It is not necessary to check at startup. Tokens will be updated on the first request.
    // This is done so that the screen does not flash (at the transition from the home screen to the login screen)
    // in case the user is not authorized.
    final isUserAuthorized = await _authRepository.updateTokens();
    if (isUserAuthorized) {
      emit(AuthLoginSuccessState());
    } else {
      emit(AuthLogoutState());
    }
  }

  Future<void> checkAuthorization() async {
    if (await _authRepository.checkTokenExistence()) {
      emit(AuthLoginSuccessState());
    }
  }

  Future<void> logout() {
    emit(AuthLogoutState());
    return _authRepository.logout();
  }
}
