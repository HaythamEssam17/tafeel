import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/auth_base_entity.dart';
import '../../../domain/use_cases/forget_password_user_case.dart';
import 'password_states.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  PasswordCubit(this._forgetUserCase) : super(ForgetPasswordStatesInit());

  static PasswordCubit get(BuildContext context) => BlocProvider.of(context);

  final PasswordUesCases _forgetUserCase;
  bool hideOldPassword = false;
  bool passwordValidation = false;

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  late TextEditingController oldPasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  void initialController() {
    oldPasswordController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    hideOldPassword = true;
    hidePassword = true;
    hideConfirmPassword = true;
    emit(ForgetPasswordStatesInit());
  }

  void disposeController() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emit(ForgetPasswordStatesInit());
  }

  void resetState() {
    emit(ForgetPasswordStatesInit());
  }

  void toggleHideOldPassword() {
    hideOldPassword = !hideOldPassword;
    emit(ToggleHidePassword());
  }

  void toggleHidePassword() {
    hidePassword = !hidePassword;
    emit(ToggleHidePassword());
  }

  void toggleConfirmPassword() {
    hideConfirmPassword = !hideConfirmPassword;
    emit(ToggleHidePassword());
  }

  void checkPasswordFieldValid(String fieldValue) {
    passwordValidation = fieldValue.isNotEmpty;
    emit(ChangePasswordValidation());
  }

  /// Send Verification Code To Email
  void sendVerificationCode({required String userCredential}) async {
    emit(SendVerificationStateLoading());
    final result = await _forgetUserCase.callSndVerificationCode(
      userCredential: userCredential,
    );
    result.fold((failure) => emit(SendVerificationStateError(error: failure)),
        (otpCode) => emit(SendVerificationStateSuccess(otpCode)));
  }

  /// Change New Password
  void changeNewPassword(
      {required String userCredential,
      required String otp,
      required String password,
      required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    final result = await _forgetUserCase.callChangeNewPassword(
        passwordAuthEntity: AuthBaseEntity(
            userCredential: userCredential, otp: otp, newPassword: password, confirmPassword: confirmPassword));

    result.fold(
        (failure) => emit(ChangePasswordStateError(error: failure)), (success) => emit(ChangePasswordStateSuccess()));
  }

  /// Change  Password
  void changePassword({required String oldPassword, required String password, required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    final result = await _forgetUserCase.callChangePassword(
        passwordAuthEntity:
            AuthBaseEntity(password: oldPassword, newPassword: password, confirmPassword: confirmPassword));

    result.fold(
        (failure) => emit(ChangePasswordStateError(error: failure)), (success) => emit(ChangePasswordStateSuccess()));
  }

  void checkPassword() async {
    emit(CheckPasswordLoadingState());
    final result = await _forgetUserCase.checkPassword(password: passwordController.text);

    result.fold(
        (failure) => emit(CheckPasswordFailedState(error: failure)), (success) => emit(CheckPasswordSuccessState()));
  }
}
