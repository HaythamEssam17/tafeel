import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeal_demo/core/helpers/l10n/app_localizations.dart';

import '../../features/language_feature/logic/language_cubit/language_cubit.dart';
import '../../features/language_feature/logic/language_cubit/language_states.dart';
import '../constants/app_constants.dart';
import '../helpers/responsive_ui/device_info.dart';
import '../helpers/responsive_ui/ui_components.dart';
import '../helpers/shared_texts.dart';
import '../presentation/routes/route_generator.dart';
import '../utils/theme/app_theme.dart';

class AppMaterialWidget extends StatelessWidget {
  final Widget homeWidget;

  const AppMaterialWidget({super.key, required this.homeWidget});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangCubit, LangState>(
      listener: (BuildContext context, LangState state) {},
      builder: (BuildContext context, LangState state) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
          title: AppConstants.appName,
          theme: LangCubit.get(context).appLocal.languageCode == 'ar'
              ? AppTheme.arabicTheme()
              : AppTheme.englishTheme(),
          debugShowCheckedModeBanner: false,
          locale: LangCubit.get(context).appLocal,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          /// widget that calculate width and height and type
          home: InfoComponents(
            builder: (
              BuildContext infoComponentsContext,
              DeviceInfo deviceInfo,
            ) {
              if (deviceInfo.orientation == Orientation.portrait) {
                SharedText.screenHeight = deviceInfo.screenHeight;
                SharedText.screenWidth = deviceInfo.screenWidth;
                SharedText.deviceType = deviceInfo;
              } else {
                SharedText.screenHeight = deviceInfo.screenWidth;
                SharedText.screenWidth = deviceInfo.screenHeight;
                SharedText.deviceType = deviceInfo;
              }
              SharedText.currentLocale =
                  LangCubit.get(context).appLocal.languageCode;

              return homeWidget;
            },
          ),
        );
      },
    );
  }
}
