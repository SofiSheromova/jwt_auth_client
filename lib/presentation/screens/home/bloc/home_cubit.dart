import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_auth_client/presentation/screens/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitHomeState());
}
