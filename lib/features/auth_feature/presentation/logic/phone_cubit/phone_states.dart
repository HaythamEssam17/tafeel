import '../../../../../core/network/error_handling/custom_error.dart';

abstract class PhoneStates {}

class PhoneInitState extends PhoneStates {}

class PhoneLoadingState extends PhoneStates {}

class PhoneSuccessState extends PhoneStates {}

class PhoneFailedState extends PhoneStates {
  final CustomError customError;

  PhoneFailedState(this.customError);
}
