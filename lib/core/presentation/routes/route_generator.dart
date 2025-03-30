import 'package:clean_arch_demo_las_version/core/features/bottom_nav/presentation/Screens/Bottom_Nav_Screen/bottom_nav_bar.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/pages/download_list_home_page.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/pages/dynamic_form_home_page.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/pages/horizontal_stepper_home_page.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_animation.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/account_settings_home_page.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/change_phone_number_screen.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/delete_account_screens/delete_account_enter_password_screen.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/screens/delete_account_screens/delete_account_note_screen.dart';
import 'package:clean_arch_demo_las_version/features/notification_feature/presentation/notification_screen.dart';
import 'package:clean_arch_demo_las_version/features/side_menu_feature/presentation/screens/side_menu_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/auth_feature/presentation/screens/chanage_password_screen.dart';
import '../../../features/auth_feature/presentation/screens/forget_password_screen.dart';
import '../../../features/auth_feature/presentation/screens/login_home_page.dart';
import '../../../features/auth_feature/presentation/screens/new_password_screen.dart';
import '../../../features/auth_feature/presentation/screens/sign_up_screen.dart';
import '../../../features/auth_feature/presentation/screens/splash_screen_home_page.dart';
import '../../../features/auth_feature/presentation/screens/verification_code_screen.dart';
import '../../../features/terms_and_conditions_feature/presentation/screen/terms_and_conditions_screen.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    devLog('Route: new route ---> ${settings.name!}');

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.loginHomePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const LoginHomePage(),
        );
      case RouteNames.singUpPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const SignUpPage(),
        );
      case RouteNames.forgetPasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const ForgetPasswordScreen(),
        );
      case RouteNames.newPasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: NewPasswordScreen(argument: args as RouteArgument),
        );
      case RouteNames.verificationCodePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: VerificationCodeScreen(routeArgument: args as RouteArgument),
        );
      case RouteNames.changePasswordPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const ChangePasswordScreen(),
        );
      case RouteNames.sideMenuHomePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const SideMenuScreen(),
        );
      case RouteNames.deleteAccountNoteScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: DeleteAccountNoteScreen(routeArgument: args as RouteArgument),
        );
      case RouteNames.deleteAccountEnterPasswordScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: DeleteAccountEnterPasswordScreen(
            routeArgument: args as RouteArgument,
          ),
        );

      case RouteNames.mainBottomNavPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const BottomNavBar(),
        );
      case RouteNames.accountSettingsHomePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const AccountSettingsHomePage(),
        );

      case RouteNames.changePhoneNumberScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const ChangePhoneNumberScreen(),
        );

      case RouteNames.termsAndConditionsPageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: TermsAndConditionsScreen(routeArgument: args as RouteArgument),
        );

      case RouteNames.notificationListScreenRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const NotificationListScreen(),
        );

      case RouteNames.downloadListHomePage:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const DownloadListHomePage(),
        );

      case RouteNames.horizontalStepperHomePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const HorizontalStepperHomePage(),
        );

      case RouteNames.dynamicFormHomePageRoute:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const DynamicFormHomePage(),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: SafeArea(child: Text('presentation.Route Error')),
              ),
        );
    }
  }
}
