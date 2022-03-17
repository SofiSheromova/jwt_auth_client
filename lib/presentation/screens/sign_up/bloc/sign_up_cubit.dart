import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/presentation/screens/sign_up/bloc/sign_up_state.dart';
import 'package:jwt_auth_client/utils/utils.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository)
      : super(InitSignUpState(
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ));

  Future<void> sendForm() async {
    if (state.password.text.trim() != state.confirmPassword.text.trim()) {
      return emit(FailedSignUpState(
        state.email,
        state.password,
        state.confirmPassword,
        error: 'Password mismatch',
      ));
    }

    try {
      await _authRepository.signUp(state.email.text.trim(), state.password.text.trim());
      emit(SuccessfulSignUpState(state.email, state.password, state.confirmPassword));
    } catch (err) {
      emit(FailedSignUpState(
        state.email,
        state.password,
        state.confirmPassword,
        error: getTextByError(err),
      ));
    }
  }
}
