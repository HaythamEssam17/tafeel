import 'package:tafeal_demo/core/helpers/shared.dart';
import 'package:tafeal_demo/core/presentation/routes/route_animation.dart';
import 'package:flutter/material.dart';

import '../../../features/auth_feature/presentation/screens/splash_screen_home_page.dart';
import '../../../features/users_list/presentation/screens/users_list_home_page.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    devLog('Route: new route ---> ${settings.name!}');

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.usersListHomePage:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const UsersListHomePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(child: Text('presentation.Route Error')),
          ),
        );
    }
  }
}
