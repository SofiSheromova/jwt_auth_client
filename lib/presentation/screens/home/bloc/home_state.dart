import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeState {}

class SuccessfulDataFetchState extends HomeState {
  final String data;

  SuccessfulDataFetchState(this.data);

  @override
  List<Object?> get props => [data];
}

class FailedDataFetchState extends HomeState {
  final String error;

  FailedDataFetchState({required this.error});

  @override
  List<Object?> get props => [error];
}
