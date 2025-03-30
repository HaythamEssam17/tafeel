import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/setting_interface.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class SettingRepository extends SettingRepositoryInterface {
  final SettingRemoteDataSourceInterface remoteDataSourceInterface;
  final SettingLocalDataSourceInterface localDataSourceInterface;

  SettingRepository(this.remoteDataSourceInterface, this.localDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getSettingData() {
    return remoteDataSourceInterface.getSettingData().then((value) => value.fold((failure) async {
          return await getCachedSetting();
        }, (settingData) {
          localDataSourceInterface.setSettingMap(settingMap: json.encode(settingData.toJson()));
          return right(settingData);
        }));
  }

  Future<Either<CustomError, BaseModel>> getCachedSetting() async {
    try {
      final String? settingModel = await localDataSourceInterface.getSettingMap();
      return right(BaseModel.fromJson(json.decode(settingModel!)));
    } catch (e) {
      return left(CustomError(errorMassage: e.toString(), type: CustomStatusCodeErrorType.unExcepted));
    }
  }
}
