import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';
import '../../domain/entities/auth_base_entity.dart';

abstract class PasswordRemoteDataSourceInterface {
  ///change password
  Future<Either<CustomError, BaseModel>> changePassword({required AuthBaseEntity passwordAuthEntity});

  ///reset password
  Future<Either<CustomError, BaseModel>> resetPassword({required AuthBaseEntity passwordAuthEntity});

  Future<Either<CustomError, BaseModel>> checkPassword({required String password});
}

class PasswordRemoteDataSourceImpl extends PasswordRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> changePassword({required AuthBaseEntity passwordAuthEntity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.changePasswordKey;
      staticData.fields.add(MapEntry('password', passwordAuthEntity.newPassword!));
      staticData.fields.add(MapEntry('password_confirmation', passwordAuthEntity.confirmPassword!));
      staticData.fields.add(MapEntry('old_password', passwordAuthEntity.password!));

      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> resetPassword({required AuthBaseEntity passwordAuthEntity}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.resetPasswordKey;
      staticData.fields.add(MapEntry('password', passwordAuthEntity.newPassword!));
      staticData.fields.add(MapEntry('password_confirmation', passwordAuthEntity.confirmPassword!));
      staticData.fields.add(MapEntry('phone', passwordAuthEntity.userCredential!));
      staticData.fields.add(MapEntry('otp_code', passwordAuthEntity.otp!));
      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> checkPassword({required String password}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkPasswordKey;
      staticData.fields.add(MapEntry('password', password));

      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
