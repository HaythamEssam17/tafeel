import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:clean_arch_demo_las_version/core/utils/forms/login_form.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/login_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth_base_model.dart';
import '../../../domain/use_cases/auth_use_case.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._userUseCases) : super(LoginStatesInit());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  AuthBaseModel userModel = AuthBaseModel();

  final AuthUserCase _userUseCases;

  AuthBaseModel? userLoginData;

  bool loginValidation = false;
  bool passwordToggle = true;

  void checkLoginFieldValid(String fieldValue) {
    loginValidation = fieldValue.isNotEmpty;
    emit(LoginValidation());
  }

  void togglePassword() {
    passwordToggle = !passwordToggle;
    emit(LoginPasswordToggle());
  }

  void login({required LoginForm loginForm}) async {
    try {
      if (loginForm.formKey.currentState!.validate()) {
        emit(UserLoginLoadingState());

        final result = await _userUseCases.callUserLogin(
          loginEntity: LoginEntity(
            phone: loginForm.phoneController.text,
            password: loginForm.passwordController.text,
          ),
        );

        result.fold(
          (failure) => emit(UserLoginErrorState(error: failure)),
          (success) => emit(
            UserLogInSuccessState(),
          ),
        );
      }
    } catch (err) {
      emit(UserLoginErrorState(error: CustomError(errorMassage: err.toString())));
    }
  }

  void logOut() async {
    emit(UserLogoutLoadingState());
    final result = await _userUseCases.callUserLogout();
    result.fold(
      (failure) => emit(UserLogOutErrorState(error: failure)),
      (success) => emit(UserLogoutSuccessState()),
    );
  }

  void silentLogOut() async {
    await _userUseCases.callUserLogout();
  }
}
