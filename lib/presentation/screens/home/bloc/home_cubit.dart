import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/domain/repository/auth_repository.dart';
import 'package:jwt_auth_client/domain/repository/content_repository.dart';
import 'package:jwt_auth_client/domain/resource.dart';
import 'package:jwt_auth_client/utils/request_helper.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_state.dart';
import 'package:jwt_auth_client/utils/utils.dart';

class HomeCubit extends Cubit<HomeState> {
  final RequestHelper _requestHelper;
  final AuthRepository _authRepository;
  final ContentRepository _contentRepository;

  HomeCubit(
    this._contentRepository,
    this._authRepository,
    this._requestHelper,
  ) : super(InitHomeState()) {
    fetchData();
  }

  Future<void> fetchData() async {
    final resource = await _requestHelper.safeApiCall(_contentRepository.getContent);
    if (resource is ResourceSuccess) {
      emit(SuccessfulDataFetchState(resource.data.toString()));
    } else {
      emit(FailedDataFetchState(error: getTextByError(resource.error)));
    }
  }

  // Users will not be able to revoke all tokens. The request exists to test the work.
  Future<void> revokeAllTokens() async {
    final resource = await _requestHelper.safeApiCall(_authRepository.revokeAllTokens);
    if (resource is ResourceSuccess) {
      emit(SuccessfulDataFetchState(resource.data.toString()));
    } else {
      emit(FailedDataFetchState(error: getTextByError(resource.error)));
    }
  }
}
