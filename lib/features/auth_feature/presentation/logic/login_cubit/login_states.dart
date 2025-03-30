import '../../../../../core/network/error_handling/custom_error.dart';

abstract class LoginStates {}

class LoginStatesInit extends LoginStates {}

class LoginValidation extends LoginStates {}

class LoginPasswordToggle extends LoginStates {}

/// show loader for user login
class UserLoginLoadingState extends LoginStates {}

/// go to home after success
class UserLogInSuccessState extends LoginStates {}

class UserLogoutSuccessState extends LoginStates {
  UserLogoutSuccessState();
}

class LoginUnVerifiedState extends LoginStates {
  String? userPhone;

  LoginUnVerifiedState({this.userPhone});
}

/// show failed login for user
class UserLoginErrorState extends LoginStates {
  CustomError? error;

  UserLoginErrorState({this.error});
}

class UserLogoutLoadingState extends LoginStates {}

class UserLogOutErrorState extends LoginStates {
  CustomError? error;

  UserLogOutErrorState({this.error});
}

class UserDeleteAccountLoadingState extends LoginStates {}
