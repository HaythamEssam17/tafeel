import 'package:tafeal/core/helpers/shared.dart';
import 'package:tafeal/core/presentation/routes/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:tafeal/core/presentation/routes/route_argument_model.dart';

import '../../../features/auth_feature/presentation/screens/splash_screen_home_page.dart';
import '../../../features/users_list/presentation/screens/user_details_home_page.dart';
import '../../../features/users_list/presentation/screens/users_list_home_page.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    devLog('Route: new route ---> ${settings.name!}');

    final ars = settings.arguments;

    switch (settings.name) {
      case RouteNames.splashPageRoute:
        return MaterialPageRoute(builder: (_) => const SplashHomePage());
      case RouteNames.usersListHomePage:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: const UsersListHomePage(),
        );
      case RouteNames.userDetailsHomePage:
        return RouteAnimation().animationFromCenterRightToCenterLeft(
          page: UserDetailsHomePage(routeArgument: ars as RouteArgument),
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
