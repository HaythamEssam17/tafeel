import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeal/core/constants/app_colors.dart';
import 'package:tafeal/core/helpers/extensions/context_extensions.dart';

import '../features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';
import '../features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_states.dart';
import '../features/connectivity_feature/presentation/screens/no_connection_screen.dart';
import '../helpers/shared.dart';
import '../helpers/shared_texts.dart';
import 'main_app_material_widget.dart';

class AppScaffoldPage extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const AppScaffoldPage({super.key, required this.body, this.appBar});

  @override
  State<AppScaffoldPage> createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends State<AppScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightWhiteColor,
      appBar: widget.appBar,
      body: GestureDetector(
        onTap: () => context.hideKeyboard(),
        child: BlocConsumer<ConnectivityCubit, ConnectivityState>(
          listener: (
            BuildContext connectivityCxt,
            ConnectivityState connectivityState,
          ) {
            devLog('connectivityState: from state $connectivityState');
          },
          builder: (BuildContext context, ConnectivityState connectivityState) {
            if (connectivityState is InternetDisconnected) {
              return const AppMaterialWidget(homeWidget: NoConnectionScreen());
            }

            /// This is the main body
            return SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: widget.body,
            );
          },
        ),
      ),
    );
  }
}
