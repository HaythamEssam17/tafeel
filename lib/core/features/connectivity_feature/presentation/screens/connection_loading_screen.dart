import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../presentation/widgets/loading_widgets/common_loading_widget.dart';

class ConnectionLoadingScreen extends StatelessWidget {
  const ConnectionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.lightWhiteColor,
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.textInputColor.withOpacity(0.9),
          ),
          child: const Center(child: CommonLoadingWidget()),
        ),
      ),
    );
  }
}
