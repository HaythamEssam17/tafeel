import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/model/setting_model.dart';
import '../../domain/ues_cases/setting_ues_cases.dart';
import 'setting_cubit_states.dart';

class SettingCubit extends Cubit<SettingCubitState> {
  SettingCubit(this._userUseCases) : super(SettingInitialState());

  final SettingUserCase _userUseCases;
  late SettingModel settingModel;

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  void getSetting() async {
    emit(SettingLoadingState());
    final result = await _userUseCases.callAppSetting();
    result.fold(
      (error) => emit(SettingFailedState(error)),
      (setting) {
        settingModel = setting;
        emit(SettingSuccessState());
      },
    );
  }

  void getAppInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    emit(SettingInitialState());
  }
}
