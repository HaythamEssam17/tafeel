import 'dart:async';

import 'package:clean_arch_demo_las_version/core/constants/asset_paths/image_paths.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../logic/splash_cubit/splash_cubit.dart';
import '../logic/splash_cubit/splash_states.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ValueNotifier notifierController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).getCachedUser();

    notifierController = ValueNotifier(0.0);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
      notifierController.value = controller.value;
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: BlocConsumer<SplashCubit, SplashStates>(
        listener: (splashCtx, splashState) {
          // if (splashState is UserFoundState) {
          //   Timer(
          //     const Duration(milliseconds: 2500),
          //     () => splashCtx.pushReplacementNamed(
          //       RouteNames.mainBottomNavPageRoute,
          //     ),
          //   );
          // } else if (splashState is UserNotFoundState) {
          Timer(
            const Duration(milliseconds: 2500),
            () => splashCtx.pushReplacementNamed(RouteNames.loginHomePageRoute),
          );
          // }
        },
        builder: (splashCtx, splashState) {
          return Center(
            child: CommonAssetImageWidget(
              imageString: ImagePaths.catsImage,
              height: 185,
              width: 224,
            ),
          );
          // return LottieBuilder.asset("assets/images/pmc_splash.json",
          //     controller: controller, width: double.infinity, height: double.infinity, fit: BoxFit.cover);
        },
      ),
    );
  }
}
