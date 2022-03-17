import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpState extends Equatable {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  const SignUpState(this.email, this.password, this.confirmPassword);
  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class InitSignUpState extends SignUpState {
  const InitSignUpState(
    TextEditingController email,
    TextEditingController password,
    TextEditingController confirmPassword,
  ) : super(email, password, confirmPassword);
}

class SuccessfulSignUpState extends SignUpState {
  const SuccessfulSignUpState(
    TextEditingController email,
    TextEditingController password,
    TextEditingController confirmPassword,
  ) : super(email, password, confirmPassword);
}

class FailedSignUpState extends SignUpState {
  final String error;

  const FailedSignUpState(
    TextEditingController email,
    TextEditingController password,
    TextEditingController confirmPassword, {
    required this.error,
  }) : super(email, password, confirmPassword);
}
