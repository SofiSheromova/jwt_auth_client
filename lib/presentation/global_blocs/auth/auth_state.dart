import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthLogoutState extends AuthState {}

class FailedAuthCheckState extends AuthState {}
