import '../../../../core/network/error_handling/custom_error.dart';

abstract class SettingCubitState {}

class SettingInitialState extends SettingCubitState {}

class SettingLoadingState extends SettingCubitState {}

class SettingSuccessState extends SettingCubitState {}

class SettingFailedState extends SettingCubitState {
  CustomError error;

  SettingFailedState(this.error);
}
