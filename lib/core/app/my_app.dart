import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../features/auth_feature/presentation/screens/splash_screen_home_page.dart';
import '../app_config/multi_bloc_provider_page.dart';
import 'app_lifycycle_observer.dart';
import 'main_app_material_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const AppLifecycleObserver(
      child: MultiBlocProvidersPage(
        body: OverlaySupport.global(
          child: AppMaterialWidget(homeWidget: SplashHomePage()),
        ),
      ),
    );
  }
}
