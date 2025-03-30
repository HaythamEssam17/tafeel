import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_global_button.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../../core/presentation/widgets/form_input_widgets/password_form_widget.dart';
import '../../logic/password_cubit/password_cubit.dart';
import '../../logic/password_cubit/password_states.dart';

class DeleteAccountEnterPasswordScreen extends StatefulWidget {
  final RouteArgument routeArgument;

  const DeleteAccountEnterPasswordScreen({
    super.key,
    required this.routeArgument,
  });

  @override
  State<DeleteAccountEnterPasswordScreen> createState() =>
      _DeleteAccountEnterPasswordScreenState();
}

class _DeleteAccountEnterPasswordScreenState
    extends State<DeleteAccountEnterPasswordScreen> {
  late PasswordCubit _passwordCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordCubit = BlocProvider.of<PasswordCubit>(context);
    _passwordCubit.passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblDeleteAccount,
          textStyle: context.textTheme.headlineMedium!.copyWith(
            color: AppConstants.sideHeaderColor,
          ),
        ),
      ),
      body: BlocConsumer<PasswordCubit, PasswordStates>(
        listener: (passwordContext, passwordState) {
          if (passwordState is CheckPasswordSuccessState) {
            context.pushNamed(
              RouteNames.accountSettingsHomePageRoute,
              widget.routeArgument,
            );
          } else if (passwordState is CheckPasswordFailedState) {
            showSnackBar(
              context: context,
              title: passwordState.error!.errorMassage ?? "",
              color: AppConstants.lightRedColor,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  getSpaceHeight(24),
                  CommonTitleText(
                    textKey:
                        AppLocalizations.of(context)!.lblDeleteAccountPassword,
                    textStyle: context.textTheme.bodyMedium!.copyWith(
                      color: AppConstants.reasonsLightGreyColor,
                    ),
                    maxLines: 5,
                  ),
                  getSpaceHeight(24),
                  PasswordFormWidget(
                    passwordController: _passwordCubit.passwordController,
                    passwordOnChanged: (fieldValue) {
                      _passwordCubit.checkPasswordFieldValid(fieldValue!);
                      return fieldValue;
                    },
                    showPasswordText: _passwordCubit.hidePassword,
                    onSuffixTap: () => _passwordCubit.toggleHidePassword(),
                    borderColor: AppConstants.transparent,
                    showPasswordColor: AppConstants.reasonsLightGreyColor,
                  ),
                  getSpaceHeight(330),
                  CommonGlobalButton(
                    buttonText: AppLocalizations.of(context)!.lblNext,
                    onPressedFunction: () {
                      if (formKey.currentState!.validate()) {
                        _passwordCubit.checkPassword();
                      }
                    },
                    buttonTextColor: AppConstants.lightWhiteColor,
                    buttonBackgroundColor: AppConstants.lightRedColor,
                    icon: const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.arrowForwardIcon,
                      height: 16,
                      width: 16,
                    ),
                    isLoading: state is CheckPasswordLoadingState,
                    isEnable:
                        state is! CheckPasswordLoadingState &&
                        _passwordCubit.passwordValidation,
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
