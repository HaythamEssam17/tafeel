import 'package:clean_arch_demo_las_version/core/network/dio_base_execute.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class SettingRemoteDataSourceInterface {
  ///change password
  Future<Either<CustomError, BaseModel>> getSettingData();
}

class SettingRemoteDataSourceImpl extends SettingRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getSettingData() async {
    return executeAndHandleError(
      () async {
        const String pathUrl = ApiKeys.settingKey;

        final Response response = await DioHelper.instance.getDate(url: pathUrl);
        return BaseModel.fromJson(response.data);
      },
    );
  }
}
