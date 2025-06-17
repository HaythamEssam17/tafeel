import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../presentation/widgets/loading_widgets/common_loading_widget.dart';

class ConnectionLoadingScreen extends StatelessWidget {
  const ConnectionLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppConstants.lightWhiteColor,
        body: Container(
          decoration: BoxDecoration(
            color: AppConstants.textInputColor.withOpacity(0.9),
          ),
          child: const Center(child: CommonLoadingWidget()),
        ),
      ),
    );
  }
}
