import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/model/setting_model.dart';
import '../repository/setting_interface.dart';

class SettingUserCase {
  final SettingRepositoryInterface repository;

  SettingUserCase({required this.repository});

  Future<Either<CustomError, SettingModel>> callAppSetting() async {
    return await repository
        .getSettingData()
        .then((value) => value.fold((l) => left(l), (settingData) => right(SettingModel.fromJson(settingData.data!))));
  }
}
