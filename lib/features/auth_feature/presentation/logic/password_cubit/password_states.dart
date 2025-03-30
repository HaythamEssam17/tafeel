import '../../../../../core/network/error_handling/custom_error.dart';

abstract class PasswordStates {}

class ForgetPasswordStatesInit extends PasswordStates {}

class ForgetPasswordLoadingState extends PasswordStates {}

class ForgetPasswordForgetSuccessState extends PasswordStates {}

class ForgetPasswordSuccessState extends PasswordStates {}

class ForgetPasswordErrorState extends PasswordStates {
  CustomError? error;

  ForgetPasswordErrorState({this.error});
}

/// Send Verification Code To Email
class SendVerificationStateLoading extends PasswordStates {}

class SendVerificationStateError extends PasswordStates {
  CustomError? error;

  SendVerificationStateError({this.error});
}

class SendVerificationStateSuccess extends PasswordStates {
  String code;

  SendVerificationStateSuccess(this.code);
}

/// Change Password
class ChangePasswordStateLoading extends PasswordStates {}

class ChangePasswordStateError extends PasswordStates {
  CustomError? error;

  ChangePasswordStateError({this.error});
}

class ChangePasswordStateSuccess extends PasswordStates {}

class ToggleHidePassword extends PasswordStates {}

class ChangePasswordValidation extends PasswordStates {}

/// Check Password to Delete Account
class CheckPasswordLoadingState extends PasswordStates {}

class CheckPasswordSuccessState extends PasswordStates {}

class CheckPasswordFailedState extends PasswordStates {
  CustomError? error;

  CheckPasswordFailedState({this.error});
}
