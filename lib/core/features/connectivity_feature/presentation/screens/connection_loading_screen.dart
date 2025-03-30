import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';

class ConnectionLoadingScreen extends StatelessWidget {
  const ConnectionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppConstants.lightWhiteColor,
        body: Container(
          decoration: BoxDecoration(
            color: AppConstants.textInputColor.withAlpha(90),
          ),
          child: const Center(child: CommonLoadingWidget()),
        ),
      ),
    );
  }
}
