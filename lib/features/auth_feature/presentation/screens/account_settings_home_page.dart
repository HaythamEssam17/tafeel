import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/constants/asset_paths/icon_path.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/constants/enums/reason_key_enum.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/alert_dialog_with_two_buttons.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/Side_Menu/side_menu_divider.dart';
import '../../../../core/presentation/widgets/Side_Menu/side_menu_item.dart';
import '../../../../core/presentation/widgets/common_waiting_dialog_widget.dart';
import '../logic/login_cubit/login_cubit.dart';
import '../logic/login_cubit/login_states.dart';

class AccountSettingsHomePage extends StatefulWidget {
  const AccountSettingsHomePage({super.key});

  @override
  State<AccountSettingsHomePage> createState() =>
      _AccountSettingsHomePageState();
}

class _AccountSettingsHomePageState extends State<AccountSettingsHomePage> {
  late LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblAccountSetting,
          textStyle: context.textTheme.headlineMedium!.copyWith(
            color: AppConstants.sideHeaderColor,
          ),
        ),
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is UserLogoutLoadingState) {
              showWaitingDialog(context);
            } else if (state is UserLogOutErrorState) {
              context.pop();
              showSnackBar(
                context: context,
                title: state.error!.errorMassage!,
                color: AppConstants.lightRedColor,
              );
              checkUserAuth(context: context, errorType: state.error!.type);
            } else if (state is UserLogoutSuccessState) {
              context.pushNamedAndRemoveUntil(RouteNames.splashPageRoute);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// Change Password
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblChangePassWord,
                    onTab:
                        () => context.pushNamed(
                          RouteNames.changePasswordPageRoute,
                        ),
                  ),
                  const SideMenuDivider(),

                  /// Change Phone
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblChangeMobileNumber,
                    onTab: () {
                      context.pushNamed(
                        RouteNames.changePhoneNumberScreenRoute,
                      );
                    },
                  ),
                  const SideMenuDivider(),

                  /// Delete Account
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblDeleteAccount,
                    onTab: () {
                      context.pushNamed(
                        RouteNames.deleteAccountNoteScreenRoute,
                        RouteArgument(reasonsKey: ReasonKey.deleteReasons),
                      );
                    },
                    titleColor: AppConstants.lightRedColor,
                  ),

                  /// LogOut
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      showAlertDialogWithTwoButton(
                        context: context,
                        title: AppLocalizations.of(context)!.lblLogOut,
                        description:
                            AppLocalizations.of(context)!.lblSureToLogout,
                        firstButtonText: AppLocalizations.of(context)!.lblYes,
                        secondButtonText: AppLocalizations.of(context)!.lblBack,
                        firstButtonOnTap: (ctx) {
                          ctx.pop();

                          _loginCubit.logOut();
                        },
                        secondButtonOnTap: (ctx) => ctx.pop(),
                        titleTextColor: AppConstants.lightRedColor,
                        secondButtonTextColor: AppConstants.mainColor,
                        isFirstButtonLoading: state is UserLogoutLoadingState,
                        showImage: true,
                        imagePath: 'log_out_car.png',
                        imageHeight: 95.92,
                        imageWidth: 105.97,
                      );
                    },
                    child: Container(
                      height: getWidgetHeight(48),
                      width: SharedText.screenWidth,
                      padding: const EdgeInsets.all(AppConstants.padding8),
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          /// Icon
                          const CommonAssetSvgImageWidget(
                            imageString: IconPathsSVG.logOutIcon,
                            height: 16,
                            width: 16,
                            imageColor: AppConstants.mainColor,
                          ),
                          getSpaceWidth(8),

                          /// Title
                          CommonTitleText(
                            textKey: AppLocalizations.of(context)!.lblLogOut,
                            textStyle: context.textTheme.bodyMedium!.copyWith(
                              color: AppConstants.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
