import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/exhibitions_repository.dart';
import 'package:jwt_auth_client/presentation/global_blocs/auth/has_auth_checker.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_state.dart';
import 'package:jwt_auth_client/utils/utils.dart';

class HomeCubit extends Cubit<HomeState> implements HasAuthChecker {
  @override
  final RequestWrapper withAuthCheck;
  final ExhibitionsRepository _repository;

  HomeCubit(this._repository, this.withAuthCheck) : super(InitHomeState()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await withAuthCheck(() async {
        final data = await _repository.getExhibitions();
        emit(SuccessfulDataFetchState(data.toString()));
      });
    } catch (err) {
      emit(FailedDataFetchState(error: getTextByError(err)));
    }
  }
}
