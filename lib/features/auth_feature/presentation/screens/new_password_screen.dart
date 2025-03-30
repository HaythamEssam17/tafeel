import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_argument_model.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';

class NewPasswordScreen extends StatefulWidget {
  final RouteArgument argument;

  const NewPasswordScreen({super.key, required this.argument});

  @override
  State<StatefulWidget> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
      appBar: const CommonAppBar(withBack: true),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (passwordCtx, passwordStates) {
          if (passwordStates is ChangePasswordStateSuccess) {
            showSnackBar(
              context: context,
              title: AppLocalizations.of(context)!.lblNewPasswordSet,
            );

            context.pushNamedAndRemoveUntil(RouteNames.loginHomePageRoute);
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
              padding: const EdgeInsets.all(AppConstants.padding16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSpaceHeight(24),
                    const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.logoCarCheckIcon,
                      height: 72,
                      width: 106,
                    ),
                    getSpaceHeight(24),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblForgetPassword,
                      textStyle: context.textTheme.displayMedium!,
                    ),
                    getSpaceHeight(AppConstants.padding16),
                    CommonTitleText(
                      textKey:
                          AppLocalizations.of(context)!.lblNowAddNewPassword,
                      textStyle: context.textTheme.headlineMedium!.copyWith(
                        color: AppConstants.textInputColor,
                      ),
                    ),
                    getSpaceHeight(24),

                    /// Password
                    PasswordFormWidget(
                      passwordController: passwordCubit.passwordController,
                      onSuffixTap: passwordCubit.toggleHidePassword,
                      showPasswordText: passwordCubit.hidePassword,
                      passwordOnChanged: (value) {
                        passwordCubit.checkPasswordFieldValid(value!);

                        return value;
                      },
                    ),

                    getSpaceHeight(AppConstants.padding16),

                    /// Confirm Password
                    PasswordFormWidget(
                      hintText:
                          AppLocalizations.of(context)!.lblConfirmPassword,
                      passwordController:
                          passwordCubit.confirmPasswordController,
                      onSuffixTap: passwordCubit.toggleConfirmPassword,
                      showPasswordText: passwordCubit.hideConfirmPassword,
                      passwordValidator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.lblPasswordIsEmpty;
                        } else if (value.length < 8) {
                          return AppLocalizations.of(
                            context,
                          )!.lblPasswordMustBeMoreThan;
                        } else if (value !=
                            passwordCubit.passwordController.text) {
                          return AppLocalizations.of(
                            context,
                          )!.lblPasswordDontMatch;
                        } else {
                          return null;
                        }
                      },
                      passwordOnChanged: (value) {
                        passwordCubit.checkPasswordFieldValid(value!);

                        return value;
                      },
                    ),

                    /// Retype Password
                    getSpaceHeight(120),

                    CommonGlobalButton(
                      isEnable: passwordCubit.passwordValidation,
                      isLoading: passwordStates is ChangePasswordStateLoading,
                      buttonText: AppLocalizations.of(passwordCtx)!.lblSubmit,
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(passwordCtx).requestFocus(FocusNode());
                          passwordCubit.changeNewPassword(
                            otp: widget.argument.otp!,
                            userCredential: widget.argument.userCredential!,
                            confirmPassword:
                                passwordCubit.confirmPasswordController.text,
                            password: passwordCubit.passwordController.text,
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
