import 'package:clean_arch_demo_las_version/core/app/main_app_material_widget.dart';
import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_states.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/screens/no_connection_screen.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: AppConstants.lightWhiteColor,
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
