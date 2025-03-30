import 'package:clean_arch_demo_las_version/core/constants/enums/exception_enums.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:clean_arch_demo_las_version/core/services/socket/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'socket_feature_state.dart';

class SocketFeatureCubit extends Cubit<SocketFeatureState> {
  SocketFeatureCubit(this._service) : super(SocketFeatureInitial());

  final SocketService _service;

  void openSocket() {
    try {
      emit(SocketFeatureOpenSocketLoading());
      _service.init();
      emit(SocketFeatureOpenSocketSuccess());
    } catch (e) {
      emit(
        SocketFeatureOpenSocketFailed(
          customError: CustomError(
            errorMassage: e.toString(),
            type: CustomStatusCodeErrorType.unExcepted,
          ),
        ),
      );
    }
  }

  void dispose() {
    _service.dispose();
  }
}
