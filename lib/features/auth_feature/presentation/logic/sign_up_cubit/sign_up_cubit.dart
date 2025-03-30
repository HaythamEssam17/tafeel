import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/sign_up_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth_base_model.dart';
import '../../../domain/entities/auth_base_entity.dart';
import '../../../domain/use_cases/auth_use_case.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  AuthBaseModel userModel = AuthBaseModel();

  SignUpCubit(this._authUserCase) : super(SignUpStatesInit());

  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);
  final AuthUserCase _authUserCase;

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  List<TextEditingController> controllerList = [];

  // late TextEditingController userNameController;
  // late TextEditingController emailAddressController;
  // late TextEditingController phoneNumberController;
  // late TextEditingController passwordController;
  // late TextEditingController confirmPasswordController;
  // late TextEditingController referCodeController;
  late bool isDataFound;

  void setUpControllerList(List<TextEditingController> controllers) {
    controllerList.clear();
    controllerList.addAll(controllers);
    emit(SignUpStatesInit());
  }

  void setupController() {
    // userNameController = TextEditingController();
    // emailAddressController = TextEditingController();
    // phoneNumberController = TextEditingController();
    // passwordController = TextEditingController();
    // confirmPasswordController = TextEditingController();
    // referCodeController = TextEditingController();
    isDataFound = false;
    hidePassword = true;
    hideConfirmPassword = true;
    // controllerList.clear();
    // controllerList.add(userNameController);
    // controllerList.add(phoneNumberController);
    // controllerList.add(passwordController);
    // controllerList.add(confirmPasswordController);
    emit(SignUpStatesInit());
  }

  void switchPasswordToggle({bool? isMainPassword = true}) {
    if (isMainPassword!) {
      hidePassword = !hidePassword;
    } else {
      hideConfirmPassword = !hideConfirmPassword;
    }
    emit(ShowOrHidePasswordState());
  }

  void singUp({
    // required String username,
    // required String email,
    // required String phone,
    // required String password,
    // required String confirmPassword,
    // required String token,
    required SignUpEntity signUpEntity,
  }) async {
    emit(UserSignUpLoadingState());

    await _authUserCase
        .callUserSignUp(
          authBaseEntity: AuthBaseEntity(
            name: signUpEntity.username,
            email: signUpEntity.email,
            phone: signUpEntity.phone,
            password: signUpEntity.password,
            confirmPassword: signUpEntity.confirmPassword,
            referCode: 'referCode',
            token: signUpEntity.token,
          ),
        )
        .then(
          (value) => value.fold(
            (failure) => emit(UserSignUpErrorState(error: failure)),
            (success) => emit(UserSignUpSuccessState(success)),
          ),
        );
  }

  void isDataFount() {
    isDataFound = true;
    emit(CheckInputValidationState());

    for (var element in controllerList) {
      if (element.text.isEmpty) {
        isDataFound = false;
        return;
      }
    }
    emit(CheckInputValidationState());
  }
}
