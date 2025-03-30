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
import '../../../../core/presentation/widgets/form_input_widgets/phone_form_widget.dart';
import '../logic/password_cubit/password_cubit.dart';
import '../logic/password_cubit/password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late PasswordCubit _forgetPasswordCubit;
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit = BlocProvider.of<PasswordCubit>(context);
    _forgetPasswordCubit.resetState();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: const CommonAppBar(withBack: true),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (forgetCtx, forgetState) {
          if (forgetState is SendVerificationStateSuccess) {
            forgetCtx.pushNamed(
              RouteNames.verificationCodePageRoute,
              RouteArgument(
                sourcePage: "forget",
                userCredential: phoneController.text,
                otp: forgetState.code,
              ),
            );
          } else if (forgetState is SendVerificationStateError) {
            showSnackBar(
              context: forgetCtx,
              title: forgetState.error!.errorMassage!,
              color: AppConstants.lightRedColor,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                      horizontal: AppConstants.padding16,
                    ) +
                    EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
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
                      textKey:
                          AppLocalizations.of(context)!.lblEnterYourPhoneNumber,
                      textStyle: context.textTheme.displayMedium!,
                    ),
                    getSpaceHeight(AppConstants.padding16),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblWillSendCode,
                      textStyle: context.textTheme.headlineMedium!.copyWith(
                        color: AppConstants.textInputColor,
                      ),
                    ),
                    getSpaceHeight(24),

                    /// Phone input field
                    PhoneFormWidget(
                      phoneController: phoneController,
                      phoneOnChanged: (value) {
                        _forgetPasswordCubit.checkPasswordFieldValid(value!);
                        return value;
                      },
                    ),

                    getSpaceHeight(210),
                    Center(
                      child: CommonGlobalButton(
                        isEnable: phoneController.text.isNotEmpty,
                        isLoading: state is SendVerificationStateLoading,
                        buttonText: AppLocalizations.of(context)!.lblSubmit,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _forgetPasswordCubit.sendVerificationCode(
                              userCredential: phoneController.text,
                            );
                          }
                        },
                      ),
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
