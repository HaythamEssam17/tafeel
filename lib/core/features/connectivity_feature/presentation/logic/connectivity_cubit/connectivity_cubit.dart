import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helpers/shared.dart';
import '../../../../../network/error_handling/custom_exception.dart';
import 'connectivity_states.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  ConnectivityCubit() : super(InternetLoading()) {
    try {
      _subscription = _connectivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.none) {
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
