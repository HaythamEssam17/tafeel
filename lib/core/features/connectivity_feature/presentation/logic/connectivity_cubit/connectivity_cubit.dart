import 'dart:async';

import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_states.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityCubit() : super(InternetLoading()) {
    try {
      _subscription = _connectivity.onConnectivityChanged.listen((
        List<ConnectivityResult> result,
      ) {
        if (result.isEmpty || result[0] == ConnectivityResult.none) {
          emit(InternetDisconnected());
        } else {
          emit(InternetConnected());
        }
      });
    } on CustomException catch (e) {
      devLog('Failed to check connection: $e');
      emit(InternetDisconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
