import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/constants/asset_paths/image_paths.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/utils/forms/login_form.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/logic/setting_cubit/setting_cubit.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/logic/setting_cubit/setting_cubit_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/features/bottom_nav/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_argument_model.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../../../../core/presentation/widgets/form_input_widgets/phone_form_widget.dart';
import '../../../../core/utils/forms/utils_shared_forms.dart';
import '../logic/login_cubit/login_cubit.dart';
import '../logic/login_cubit/login_states.dart';
import '../logic/otp_cubit/otp_cubit.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  late LoginCubit loginCubit;

  final LoginForm _loginForm = Forms.login;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    BlocProvider.of<SettingCubit>(context).getAppInfo();

    debugPrint('here\'s from login page');
  }

  @override
  void dispose() {
    _loginForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (loginCtx, loginState) {
          if (loginState is UserLogInSuccessState) {
            // Set Bottom Navigation Index = 0 to handle if user comes from settings screen.
            BottomNavCubit.get(context).selectItem(0);

            loginCtx.pushNamedAndRemoveUntil(RouteNames.mainBottomNavPageRoute);
          }
          if (loginState is UserLoginErrorState) {
            if (loginState.error!.type ==
                CustomStatusCodeErrorType.unVerified) {
              BlocProvider.of<OtpCubit>(
                context,
              ).resendOTP(userCredential: _loginForm.phoneController.text);

              loginCtx.pushNamed(
                RouteNames.verificationCodePageRoute,
                RouteArgument(userCredential: _loginForm.phoneController.text),
              );
              _loginForm.clear();
            } else {
              showSnackBar(
                context: loginCtx,
                title: loginState.error!.errorMassage!,
                color: AppConstants.lightRedColor,
              );
            }
          }
        },
        builder: (loginCtx, loginState) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: AppConstants.padding16) +
                EdgeInsets.only(
                  bottom: MediaQuery.of(loginCtx).viewInsets.bottom,
                ),
            child: Column(
              children: [
                ///spacer
                getSpaceHeight(50),

                ///app logo
                CommonAssetImageWidget(
                  imageString: ImagePaths.defaultJPGImage,
                  height: 64,
                  width: 96,
                ),

                ///spacer
                getSpaceHeight(AppConstants.padding16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblWelcome,
                      textStyle: context.textTheme.labelLarge!,
                    ),
                  ],
                ),

                ///spacer
                getSpaceHeight(AppConstants.padding8),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTitleText(
                      textKey:
                          AppLocalizations.of(context)!.lblLoginToYourAccount,
                      textStyle: TextStyle(color: Colors.red),
                    ),
                  ],
                ),

                ///spacer
                getSpaceHeight(48),

                Form(
                  key: _loginForm.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Phone input field
                      PhoneFormWidget(
                        phoneController: _loginForm.phoneController,
                        phoneOnChanged: (value) {
                          loginCtx.read<LoginCubit>().checkLoginFieldValid(
                            value!,
                          );
                          return value;
                        },
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding16),

                      ///password input field
                      PasswordFormWidget(
                        passwordController: _loginForm.passwordController,
                        onSuffixTap: loginCtx.read<LoginCubit>().togglePassword,
                        showPasswordText:
                            loginCtx.read<LoginCubit>().passwordToggle,
                        passwordOnChanged: (value) {
                          loginCtx.read<LoginCubit>().checkLoginFieldValid(
                            value!,
                          );
                          return value;
                        },
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding8),

                      /// Forget Password Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              loginCtx.pushNamedAndRemoveUntil(
                                RouteNames.forgetPasswordPageRoute,
                              );
                            },
                            child: CommonTitleText(
                              textKey:
                                  AppLocalizations.of(
                                    context,
                                  )!.lblIsForgetPassword,
                              textStyle: context.textTheme.bodySmall!,
                            ),
                          ),
                        ],
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding8),

                      /// Build Version
                      BlocConsumer<SettingCubit, SettingCubitState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Center(
                            child: CommonTitleText(
                              textKey:
                                  '${AppLocalizations.of(context)!.lblVersion} ${context.read<SettingCubit>().version}',
                              textStyle: context.textTheme.bodySmall!,
                            ),
                          );
                        },
                      ),

                      getSpaceHeight(AppConstants.padding8),

                      ///login button
                      CommonGlobalButton(
                        isEnable: loginCubit.loginValidation,
                        isLoading: loginState is UserLoginLoadingState,
                        buttonText: AppLocalizations.of(context)!.lblLogin,
                        onPressedFunction: () {
                          context.hideKeyboard();

                          loginCtx.read<LoginCubit>().login(
                            loginForm: _loginForm,
                          );
                        },
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding16),

                      ///create account
                      InkWell(
                        onTap: () {
                          _loginForm.clear();
                          loginCtx.pushNamed(RouteNames.singUpPageRoute);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonTitleText(
                              textKey:
                                  AppLocalizations.of(
                                    context,
                                  )!.lblDonotHaveAccount,
                              textStyle: context.textTheme.bodySmall!,
                            ),
                            CommonTitleText(
                              textKey:
                                  AppLocalizations.of(
                                    context,
                                  )!.lblCreateYourAccount,
                              textStyle: context.textTheme.bodyMedium!,
                            ),
                          ],
                        ),
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding16),
                      CommonGlobalButton(
                        buttonText: 'Dynamic Form Page',
                        onPressedFunction: () {
                          context.pushNamed(
                            RouteNames.dynamicFormHomePageRoute,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
