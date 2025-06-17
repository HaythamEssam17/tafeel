import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import '../../features/language_feature/logic/language_cubit/language_cubit.dart';
import '../features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';
import 'injection_container.dart' as di;

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({Key? key, required this.body})
      : super(key: key);

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
        BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()),
      ],
      child: widget.body,
    );
  }
}
