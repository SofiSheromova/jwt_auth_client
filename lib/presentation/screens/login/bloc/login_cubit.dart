import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/screens/login/bloc/login_state.dart';
import 'package:jwt_auth_client/utils/utils.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(InitLoginState(TextEditingController(), TextEditingController()));

  Future<void> sendForm() async {
    try {
      await _authRepository.login(state.email.text.trim(), state.password.text.trim());
      emit(SuccessfulLoginState(state.email, state.password));
    } catch (err) {
      emit(FailedLoginState(
        state.email,
        state.password,
        error: getTextByError(err),
      ));
    }
  }

  @override
  Future<void> close() {
    state.email.dispose();
    state.password.dispose();
    return super.close();
  }
}
