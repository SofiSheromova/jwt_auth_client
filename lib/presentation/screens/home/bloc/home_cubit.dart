import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/exhibitions_repository.dart';
import 'package:jwt_auth_client/domain/resource.dart';
import 'package:jwt_auth_client/utils/request_helper.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_state.dart';
import 'package:jwt_auth_client/utils/utils.dart';

class HomeCubit extends Cubit<HomeState> {
  final RequestHelper _requestHelper;
  final ExhibitionsRepository _repository;

  HomeCubit(this._repository, this._requestHelper) : super(InitHomeState()) {
    fetchData();
  }

  Future<void> fetchData() async {
    final resource = await _requestHelper.safeApiCall(_repository.getExhibitions);
    if (resource is ResourceSuccess) {
      emit(SuccessfulDataFetchState(resource.data.toString()));
    } else {
      emit(FailedDataFetchState(error: getTextByError(resource.error)));
    }
  }
}
