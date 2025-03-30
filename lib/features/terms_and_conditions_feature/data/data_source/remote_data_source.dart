import 'package:clean_arch_demo_las_version/core/network/dio_base_execute.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class TermsRemoteDataScoursInterface {
  Future<Either<CustomError, BaseModel>> getTermsData({
    required String endPoint,
  });
}

class TermsRemoteDataScoursImpl extends TermsRemoteDataScoursInterface {
  @override
  Future<Either<CustomError, BaseModel>> getTermsData({
    required String endPoint,
  }) async {
    return executeAndHandleError(() async {
      final Response result = await DioHelper.instance.getDate(url: endPoint);
      return (BaseModel.fromJson(result.data));
    });
  }
}
