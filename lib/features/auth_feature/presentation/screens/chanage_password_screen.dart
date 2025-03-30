import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  late PasswordCubit passwordCubit;

  @override
  void initState() {
    super.initState();
    passwordCubit = PasswordCubit.get(context);
    passwordCubit.initialController();
  }

  @override
  void dispose() {
    passwordCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        withBack: true,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblChangePassWord,
          textStyle: context.textTheme.headlineMedium!.copyWith(
            color: AppConstants.sideHeaderColor,
          ),
        ),
      ),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (passwordCtx, passwordStates) {
          if (passwordStates is ChangePasswordStateSuccess) {
            passwordCtx.pushNamed(RouteNames.loginHomePageRoute);
          }
          if (passwordStates is ChangePasswordStateError) {
            showSnackBar(
              context: passwordCtx,
              title: passwordStates.error!.errorMassage!,
              color: AppConstants.lightRedColor,
            );
          }
        },
        builder: (passwordCtx, passwordStates) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSpaceHeight(32),

                    /// Old Password
                    PasswordFormWidget(
                      passwordController: passwordCubit.oldPasswordController,
                      showPasswordText: passwordCubit.hideOldPassword,
                      hintText: AppLocalizations.of(context)!.lblOldPassword,
                      passwordOnChanged: (value) {
                        passwordCubit.checkPasswordFieldValid(value!);

                        return value;
                      },
                    ),

                    getSpaceHeight(AppConstants.padding16),

                    /// Password
                    PasswordFormWidget(
                      passwordController: passwordCubit.passwordController,
                      // onSuffixTap: passwordCubit.toggleHidePassword,
                      showPasswordText: passwordCubit.hidePassword,
                      hintText: AppLocalizations.of(context)!.lblNewPassword,
                      passwordOnChanged: (value) {
                        passwordCubit.checkPasswordFieldValid(value!);

                        return value;
                      },
                    ),
                    getSpaceHeight(AppConstants.padding16),

                    /// Confirm Password
                    PasswordFormWidget(
                      passwordController:
                          passwordCubit.confirmPasswordController,
                      // onSuffixTap: passwordCubit.toggleConfirmPassword,
                      showPasswordText: passwordCubit.hideConfirmPassword,
                      hintText:
                          AppLocalizations.of(context)!.lblConfirmPassword,
                      passwordOnChanged: (value) {
                        passwordCubit.checkPasswordFieldValid(value!);

                        return value;
                      },
                    ),

                    /// Retype Password
                    getSpaceHeight(270),

                    /// Confirm Button
                    CommonGlobalButton(
                      isEnable: passwordCubit.passwordValidation,
                      isLoading: passwordStates is ChangePasswordStateLoading,
                      buttonText:
                          AppLocalizations.of(passwordCtx)!.lblSaveChanges,
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(passwordCtx).requestFocus(FocusNode());
                          passwordCubit.changePassword(
                            oldPassword:
                                passwordCubit.oldPasswordController.text,
                            password: passwordCubit.passwordController.text,
                            confirmPassword:
                                passwordCubit.confirmPasswordController.text,
                          );
                        }
                      },
                    ),
                    getSpaceHeight(50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
