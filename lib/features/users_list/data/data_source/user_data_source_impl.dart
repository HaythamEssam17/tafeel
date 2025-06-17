import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:tafeal/core/model/base_model.dart';
import 'package:tafeal/core/network/dio_base_execute.dart';
import 'package:tafeal/core/network/dio_helper.dart';

import 'package:tafeal/core/network/error_handling/custom_error.dart';

import 'user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<Either<CustomError, BaseModel>> getUsersList({
    required int page,
  }) async {
    return executeAndHandleError(() async {
      String url = dotenv.get('users_url');

      var response = await DioHelper.dio.get('$url?page=$page');

      return BaseModel.fromJson(response.data);
    });
  }

  @override
  Future<Either<CustomError, BaseModel>> getUserDetails({
    required int userID,
  }) async {
    return executeAndHandleError(() async {
      String url = dotenv.get('users_url');

      var response = await DioHelper.dio.get('$url/$userID');

      return BaseModel.fromJson(response.data);
    });
  }
}
