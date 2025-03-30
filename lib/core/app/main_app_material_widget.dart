import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/responsive_ui/device_info.dart';
import 'package:clean_arch_demo_las_version/core/helpers/responsive_ui/ui_components.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_generator.dart';
import 'package:clean_arch_demo_las_version/core/utils/theme/app_theme.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/logic/language_cubit/language_cubit.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/logic/language_cubit/language_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          theme:
              LangCubit.get(context).appLocal.languageCode == 'ar'
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
              // SharedText.currentLocale = LangCubit.get(context).appLocal.languageCode;

              return homeWidget;
            },
          ),
        );
      },
    );
  }
}
