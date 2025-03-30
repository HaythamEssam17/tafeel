import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_global_button.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/phone_cubit/phone_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/phone_cubit/phone_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePhoneBottomSheet extends StatelessWidget {
  const ChangePhoneBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: BlocConsumer<PhoneCubit, PhoneStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: getWidgetHeight(AppConstants.padding16)) +
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                getSpaceHeight(AppConstants.padding8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblChangeMobileNumber,
                      textStyle: context.textTheme.headlineMedium!.copyWith(
                        color: AppConstants.mainColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.pop(),
                      child: const CommonAssetSvgImageWidget(
                        imageString: 'close.svg',
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
                getSpaceHeight(16),

                /// Title
                ...[
                  Row(
                    children: [
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblToConfirmChangingPhone,
                        textStyle: context.textTheme.bodySmall!.copyWith(
                          color: AppConstants.reasonsLightGreyColor,
                        ),
                      ),
                      CommonTitleText(
                        textKey: AppConstants.countryCode +
                            BlocProvider.of<PhoneCubit>(context).newPhoneController.text,
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                          color: AppConstants.lightBlackColor,
                        ),
                      ),
                    ],
                  ),
                ],
                getSpaceHeight(8),

                /// SubTitle
                ...[
                  Row(
                    children: [
                      CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblEnterPasswordForAccount,
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                          color: AppConstants.reasonsLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
                getSpaceHeight(16),

                /// Password TextField
                PasswordFormWidget(
                  passwordController: BlocProvider.of<PhoneCubit>(context).passwordController,
                  passwordOnChanged: (value) {
                    BlocProvider.of<PhoneCubit>(context).checkIsPasswordValid();
                    return value;
                  },
                  onSuffixTap: () {
                    BlocProvider.of<PhoneCubit>(context).showPassword();
                  },
                  showPasswordText: BlocProvider.of<PhoneCubit>(context).isShowPassword,
                  showPasswordColor: AppConstants.reasonsLightGreyColor,
                ),
                getSpaceHeight(60),

                /// Button
                Center(
                  child: CommonGlobalButton(
                    buttonText: AppLocalizations.of(context)!.lblConfirm,
                    onPressedFunction: () => BlocProvider.of<PhoneCubit>(context).changePhone(),
                    isEnable: BlocProvider.of<PhoneCubit>(context).state is! PhoneLoadingState &&
                        BlocProvider.of<PhoneCubit>(context).isPasswordValid,
                    isLoading: BlocProvider.of<PhoneCubit>(context).state is PhoneLoadingState,
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is PhoneSuccessState) {
            context.pop();
            context.pushNamed(
                RouteNames.verificationCodePageRoute,
                RouteArgument(
                    sourcePage: 'change-phone',
                    userCredential: BlocProvider.of<PhoneCubit>(context).newPhoneController.text));
          } else if (state is PhoneFailedState) {
            showSnackBar(
                context: context,
                title: state.customError.errorMassage!,
                color: AppConstants.lightRedColor);
            checkUserAuth(context: context, errorType: state.customError.type);
          }
        },
      ),
    );
  }
}
