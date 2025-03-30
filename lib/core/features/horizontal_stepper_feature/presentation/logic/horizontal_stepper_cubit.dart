import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/logic/horizontal_stepper_states.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/forget_password_screen.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/login_home_page.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalStepperCubit extends Cubit<HorizontalStepperStates> {
  HorizontalStepperCubit() : super(HorizontalStepperInit());

  int currentStep = 1;
  int totalSteps = 3;
  bool complete = false;
  List<Widget> stepsList = [];

  List<Widget> steppers = [
    const LoginHomePage(),
    const SignUpPage(),
    const ForgetPasswordScreen(),
  ];

  void init() {
    currentStep = 1;
    totalSteps = 3;
    complete = false;
    stepsList = [];

    emit(HorizontalStepperInit());
  }

  void next() {
    if (currentStep < totalSteps) {
      goTo(currentStep + 1);
    }
  }

  void back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    currentStep = step;
    if (currentStep > totalSteps) {
      complete = true;
    }

    emit(HorizontalStepperInit());
  }
}
