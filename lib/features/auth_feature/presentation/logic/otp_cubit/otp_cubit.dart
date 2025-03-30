import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/otp_ues_cases.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit(this._otpUsesCases) : super(OtpStatesInit());

  static OtpCubit get(BuildContext context) => BlocProvider.of(context);

  final OtpUsesCases _otpUsesCases;

  void resetState() {
    emit(OtpStatesInit());
  }

  /// Verify Forget Password
  void verifyAccount({required String userCredential, required String otp}) async {
    emit(OtpLoadingState());
    final result = await _otpUsesCases.callVerifyAccount(userCredential: userCredential, code: otp);
    result.fold((failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (r) => emit(OtpSuccessState()));
  }

  ///check otp
  void checkOtp({required String userCredential, required String otp}) async {
    emit(OtpLoadingState());
    final result = await _otpUsesCases.callCheckOtp(userCredential: userCredential, code: otp);
    result.fold((failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (r) => emit(OtpSuccessState()));
  }

  ///re send
  void resendOTP({required String userCredential}) async {
    emit(ResendOtpLoadingState());
    final result = await _otpUsesCases.callResendCode(userCredential: userCredential);
    result.fold((failure) {
      emit(OtpErrorState(
        error: failure,
      ));
    }, (otp) => emit(ResendOtpSuccessState(otp)));
  }
}
