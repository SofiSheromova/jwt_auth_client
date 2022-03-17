import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  final TextEditingController email;
  final TextEditingController password;

  const LoginState(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class InitLoginState extends LoginState {
  const InitLoginState(
    TextEditingController email,
    TextEditingController password,
  ) : super(email, password);
}

class SuccessfulLoginState extends LoginState {
  const SuccessfulLoginState(
    TextEditingController email,
    TextEditingController password,
  ) : super(email, password);
}

class FailedLoginState extends LoginState {
  final String error;

  const FailedLoginState(
    TextEditingController email,
    TextEditingController password, {
    required this.error,
  }) : super(email, password);
}
