import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/factories/switch_factory.dart';
import '../../../../core/presentation/routes/route_argument_model.dart';
import '../../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../../core/presentation/widgets/Side_Menu/side_menu_divider.dart';
import '../../../../core/presentation/widgets/Side_Menu/side_menu_item.dart';
import '../../../../core/presentation/widgets/common_waiting_dialog_widget.dart';
import '../../../../core/presentation/widgets/custom_bottom_sheet.dart';
import '../../../notification_feature/presentation/logic/notification_cubit.dart';
import '../../../notification_feature/presentation/logic/notification_states.dart';
import '../widgets/language_widget.dart';
import '/core/constants/app_constants.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/common_title_text.dart';
import '/features/language_feature/logic/language_cubit/language_cubit.dart';
import '/features/side_menu_feature/presentation/widgets/side_menu_section.dart';
import '/features/side_menu_feature/presentation/widgets/user_data_section.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  late NotificationCubit _notificationCubit;
  late LangCubit langCubit = LangCubit.get(context);

  @override
  void initState() {
    super.initState();
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);

    _notificationCubit.isNotified = SharedText.currentUser.isNotified!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: SharedText.screenWidth,
          height: SharedText.screenHeight,
          child: Column(
            children: [
              ///user data section
              const UserDataSection(),

              ///my account section
              SideMenuSection(
                sectionHeader: AppLocalizations.of(context)!.lblMyAccount,
                children: [
                  ///divider
                  const SideMenuDivider(),

                  ///addresses sector
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblAddresses,
                    onTab: () {
                      context.pushNamed(RouteNames.myAddressPageRoute);
                    },
                  ),
                ],
              ),

              ///app setting section
              SideMenuSection(
                sectionHeader: AppLocalizations.of(context)!.lblAppSetting,
                children: [
                  ///account setting sector
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblAccountSetting,
                    onTab:
                        () => context.pushNamed(
                          RouteNames.accountSettingsHomePageRoute,
                        ),
                  ),

                  ///divider
                  const SideMenuDivider(),

                  ///notifications sector
                  BlocConsumer<NotificationCubit, NotificationStates>(
                    listener: (context, state) {
                      if (state is EnableOrDisableNotificationLoadingState) {
                        showWaitingDialog(context);
                      } else if (state
                          is EnableOrDisableNotificationErrorState) {
                        context.pop();
                        showSnackBar(
                          context: context,
                          title: state.error!.errorMassage!,
                          color: AppConstants.lightRedColor,
                        );
                      } else if (state
                          is EnableOrDisableNotificationSuccessState) {
                        context.pop();

                        showSnackBar(
                          context: context,
                          title:
                              AppLocalizations.of(
                                context,
                              )!.lblChangeNotificationSuccess,
                        );
                      }
                    },
                    builder: (context, state) {
                      return SideMenuItemWidget(
                        title: AppLocalizations.of(context)!.lblNotifications,
                        onTab: () {},
                        trailingWidget: PlatformSwitch.buildSwitch(
                          context: context,
                          value: _notificationCubit.isNotified,
                          onChanged: (value) {
                            if (state
                                is! EnableOrDisableNotificationLoadingState) {
                              _notificationCubit.enableOrDisableNotification();
                            }
                          },
                        ),
                      );
                    },
                  ),

                  ///divider
                  const SideMenuDivider(),

                  ///language sector
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblLanguage,
                    onTab: () async {
                      showBottomModalSheet(
                        context: context,
                        height: 222,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.padding16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTitleText(
                                  textKey:
                                      AppLocalizations.of(
                                        context,
                                      )!.lblSelectLanguage,
                                  textStyle: context.textTheme.headlineMedium!
                                      .copyWith(
                                        color: AppConstants.sideHeaderTextColor,
                                      ),
                                ),
                                InkWell(
                                  onTap: () => context.pop(),
                                  child: const CommonAssetSvgImageWidget(
                                    imageString: IconPathsSVG.closeIcon,
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          getSpaceHeight(24),

                          /// Languages
                          ...[
                            LanguageItem(
                              onTap: () async {
                                if (langCubit.appLocal.languageCode == "en") {
                                  context.pop();
                                  await langCubit.changeLang('ar');
                                }
                              },
                              title: AppLocalizations.of(context)!.lblArabic,
                              imagePath: IconPathsSVG.arabicIcon,
                            ),
                            getSpaceHeight(AppConstants.padding16),
                            LanguageItem(
                              onTap: () async {
                                if (langCubit.appLocal.languageCode == "ar") {
                                  context.pop();
                                  await langCubit.changeLang('en');
                                }
                              },
                              title: AppLocalizations.of(context)!.lblEnglish,
                              imagePath: IconPathsSVG.englishIcon,
                            ),
                          ],
                        ],
                      );
                    },
                  ),

                  ///divider
                  const SideMenuDivider(),

                  ///Terms And Conditions sector
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblTermsAndConditions,
                    onTab: () {
                      context.pushNamed(
                        RouteNames.termsAndConditionsPageRoute,
                        RouteArgument(
                          screenName:
                              AppLocalizations.of(
                                context,
                              )!.lblTermsAndConditions,
                          endPoint: ApiKeys.termsAndConditionsKey,
                        ),
                      );
                    },
                  ),

                  ///divider
                  const SideMenuDivider(),

                  ///open ticket sector
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblHaveProblem,
                    onTab: () {
                      context.pushNamed(RouteNames.ticketListPageRoute);
                    },
                  ),

                  ///divider
                  const SideMenuDivider(),

                  ///FAQ
                  SideMenuItemWidget(
                    title: AppLocalizations.of(context)!.lblFAQ,
                    onTab: () {
                      context.pushNamed(RouteNames.questionsPageRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
