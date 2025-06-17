import 'dart:async';

import 'package:tafeal/core/constants/asset_paths/image_paths.dart';
import 'package:tafeal/core/helpers/extensions/context_extensions.dart';
import 'package:tafeal/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/routes/route_names.dart';

class SplashHomePage extends StatefulWidget {
  const SplashHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashHomePage> {
  @override
  void initState() {
    super.initState();
    goToHomePage();
  }

  goToHomePage() {
    Timer(
      const Duration(milliseconds: 2500),
      () => context.pushReplacementNamed(RouteNames.usersListHomePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightWhiteColor,
      body: Center(
        child: CommonAssetImageWidget(
          imageString: ImagePaths.logoPNG,
          height: 185,
          width: 224,
        ),
      ),
    );
  }
}
