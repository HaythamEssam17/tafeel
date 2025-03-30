import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/constants/asset_paths/image_paths.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/utils/forms/signup_form.dart';
import 'package:clean_arch_demo_las_version/core/utils/forms/utils_shared_forms.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/sign_up_entitiy.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/widget/check_terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/form_input_widgets/email_form_widget.dart';
import '../../../../core/presentation/widgets/form_input_widgets/name_form_widget.dart';
import '../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../../../../core/presentation/widgets/form_input_widgets/phone_form_widget.dart';
import '../logic/sign_up_cubit/sign_up_cubit.dart';
import '../logic/sign_up_cubit/sign_up_states.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit _signUpCubit;
  final SignUpForm _signUpForm = Forms.signUp;

  @override
  void initState() {
    super.initState();
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    _signUpCubit.setupController();
  }

  @override
  void dispose() {
    _signUpForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (loginCtx, signUpState) {
          if (signUpState is UserSignUpSuccessState) {
            loginCtx.pushReplacementNamed(
              RouteNames.verificationCodePageRoute,
              RouteArgument(
                userCredential: _signUpForm.phoneController.text,
                sourcePage: "active",
                otp: signUpState.model.otp.toString(),
              ),
            );
          }
          if (signUpState is UserSignUpErrorState) {
            showSnackBar(
              context: loginCtx,
              title: signUpState.error!.errorMassage!,
              color: AppConstants.lightRedColor,
            );
          }
        },
        builder: (signUpCtx, signUpstate) {
          return PopScope(
            canPop: signUpstate is! UserSignUpLoadingState,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                            horizontal: AppConstants.padding16,
                          ) +
                          EdgeInsets.only(
                            bottom: MediaQuery.of(signUpCtx).viewInsets.bottom,
                          ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ///spacer
                          getSpaceHeight(50),

                          ///app logo
                          CommonAssetImageWidget(
                            imageString: ImagePaths.defaultPNGImage,
                            height: 64,
                            width: 96,
                          ),

                          ///spacer
                          getSpaceHeight(AppConstants.padding16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblWelcome,
                                textStyle: context.textTheme.labelLarge,
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
                                    AppLocalizations.of(
                                      context,
                                    )!.lblCreateYourAccount,
                                textStyle: context.textTheme.headlineMedium!,
                              ),
                            ],
                          ),

                          ///spacer
                          getSpaceHeight(48),
                          Form(
                            key: _signUpForm.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// User Name
                                NameFormWidget(
                                  nameController:
                                      _signUpForm.userNameController,
                                  nameOnChanged: (value) {
                                    _signUpCubit.isDataFount();
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                /// Phone
                                PhoneFormWidget(
                                  phoneController: _signUpForm.phoneController,
                                  phoneOnChanged: (value) {
                                    _signUpCubit.isDataFount();
                                    return null;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                /// Email
                                EmailFormWidget(
                                  emailController: _signUpForm.emailController,
                                  emailOnChanged: (value) {
                                    _signUpCubit.isDataFount();
                                    return value;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                /// Password
                                PasswordFormWidget(
                                  passwordController:
                                      _signUpForm.passwordController,
                                  onSuffixTap:
                                      _signUpCubit.switchPasswordToggle,
                                  showPasswordText: _signUpCubit.hidePassword,
                                  passwordOnChanged: (value) {
                                    _signUpCubit.isDataFount();
                                    return value;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                /// Confirm Password
                                PasswordFormWidget(
                                  hintText:
                                      AppLocalizations.of(
                                        context,
                                      )!.lblConfirmPassword,
                                  passwordController:
                                      _signUpForm.confirmPasswordController,
                                  onSuffixTap: () {
                                    _signUpCubit.switchPasswordToggle(
                                      isMainPassword: false,
                                    );
                                  },
                                  showPasswordText:
                                      _signUpCubit.hideConfirmPassword,
                                  passwordValidator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(
                                        signUpCtx,
                                      )!.lblPasswordIsEmpty;
                                    } else if (value.length < 8) {
                                      return AppLocalizations.of(
                                        signUpCtx,
                                      )!.lblPasswordMustBeMoreThan;
                                    } else if (value !=
                                        _signUpForm.passwordController.text) {
                                      return AppLocalizations.of(
                                        signUpCtx,
                                      )!.lblPasswordDontMatch;
                                    } else {
                                      return null;
                                    }
                                  },
                                  passwordOnChanged: (value) {
                                    _signUpCubit.isDataFount();
                                    return value;
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),
                                const CheckTermsAndConditions(),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                /// Create Account Button
                                CommonGlobalButton(
                                  isEnable: _signUpCubit.isDataFound,
                                  isLoading:
                                      signUpstate is UserSignUpLoadingState,
                                  buttonText:
                                      AppLocalizations.of(signUpCtx)!.lblSignup,
                                  onPressedFunction: () {
                                    if (_signUpForm.formKey.currentState!
                                        .validate()) {
                                      FocusScope.of(
                                        signUpCtx,
                                      ).requestFocus(FocusNode());

                                      _signUpCubit.singUp(
                                        signUpEntity: SignUpEntity(
                                          username:
                                              _signUpForm
                                                  .userNameController
                                                  .text,
                                          email:
                                              _signUpForm.emailController.text,
                                          phone:
                                              _signUpForm.phoneController.text,
                                          confirmPassword:
                                              _signUpForm
                                                  .confirmPasswordController
                                                  .text,
                                          password:
                                              _signUpForm
                                                  .passwordController
                                                  .text,
                                        ),
                                      );

                                      // _signUpCubit.singUp(
                                      //   email: _signUpForm.emailAddressController.text,
                                      //   password: _signUpForm.passwordController.text,
                                      //   confirmPassword:
                                      //       _signUpCubit.confirmPasswordController.text,
                                      //   phone: _signUpCubit.phoneNumberController.text,
                                      //   username: _signUpCubit.userNameController.text,
                                      //   referCode: _signUpCubit.referCodeController.text,
                                      //   token: SharedText.deviceToken,
                                      // );
                                    }
                                  },
                                ),

                                ///spacer
                                getSpaceHeight(AppConstants.padding16),

                                ///Login
                                InkWell(
                                  onTap: () {
                                    signUpCtx.pushNamedAndRemoveUntil(
                                      RouteNames.loginHomePageRoute,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTitleText(
                                        textKey:
                                            AppLocalizations.of(
                                              context,
                                            )!.lblAlreadyHaveAccount,
                                        textStyle: context.textTheme.labelLarge!
                                            .copyWith(
                                              color:
                                                  AppConstants.textInputColor,
                                            ),
                                      ),
                                      CommonTitleText(
                                        textKey:
                                            AppLocalizations.of(
                                              context,
                                            )!.lblLogin,
                                        textStyle: context.textTheme.labelLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                ///spacer
                                getSpaceHeight(35),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
