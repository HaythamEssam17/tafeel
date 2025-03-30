import 'package:clean_arch_demo_las_version/core/features/bottom_nav/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/get_downloads_feature/get_downloads_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/cubit/dynamic_form_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/logic/horizontal_stepper_cubit.dart';
import 'package:clean_arch_demo_las_version/core/presentation/logic/search_filter_cubit/search_filter_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/login_cubit/login_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/otp_cubit/otp_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/password_cubit/password_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/timer_cubit/timer_cubit.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/presentation/logic/help_cubit/help_cubit.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/logic/language_cubit/language_cubit.dart';
import 'package:clean_arch_demo_las_version/features/notification_feature/presentation/logic/notification_cubit.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/logic/setting_cubit/setting_cubit.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/presentation/logic/terms_and_condition_cubit/terms_and_condition_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({super.key, required this.body});

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LangCubit>(
          lazy: false,
          create: (_) => di.sl<LangCubit>()..getLang(),
        ),
        BlocProvider<ConnectivityCubit>(
          lazy: false,
          create: (_) => di.sl<ConnectivityCubit>(),
        ),
        BlocProvider<SettingCubit>(
          lazy: false,
          create: (_) => di.sl<SettingCubit>(),
        ),
        BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()),
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<TimerCubit>(create: (_) => TimerCubit()),
        BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<OtpCubit>(create: (_) => di.sl<OtpCubit>()),
        BlocProvider<PasswordCubit>(create: (_) => di.sl<PasswordCubit>()),
        BlocProvider<AllFilterCubit>(create: (_) => di.sl<AllFilterCubit>()),
        BlocProvider<TermsAndConditionsCubit>(
          create: (_) => di.sl<TermsAndConditionsCubit>(),
        ),
        BlocProvider<HelpCubit>(create: (_) => di.sl<HelpCubit>()),
        BlocProvider<NotificationCubit>(
          create: (_) => di.sl<NotificationCubit>(),
        ),
        BlocProvider<DownloadFeatureCubit>(
          create: (_) => di.sl<DownloadFeatureCubit>(),
        ),
        BlocProvider<GetDownloadsCubit>(
          create: (_) => di.sl<GetDownloadsCubit>(),
        ),
        BlocProvider<HorizontalStepperCubit>(
          create: (_) => di.sl<HorizontalStepperCubit>(),
        ),
        BlocProvider<DynamicFormFeatureCubit>(
          create: (_) => di.sl<DynamicFormFeatureCubit>(),
        ),
      ],
      child: widget.body,
    );
  }
}
