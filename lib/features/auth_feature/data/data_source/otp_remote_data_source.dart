import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';
import '../model/auth_base_model.dart';

abstract class OtpRemoteDataSourceInterface {
  ///verify account
  Future<Either<CustomError, AuthBaseModel>> verifyAccount({required String userCredential, required String code});

  ///check otp
  Future<Either<CustomError, BaseModel>> checkOtp({required String userCredential, required String code});

  ///send otp to email
  Future<Either<CustomError, BaseModel>> sendOtp({required String userCredential});

  ///resend otp
  Future<Either<CustomError, BaseModel>> resendOTP({
    required String userCredential,
  });
}

class OtpRemoteDataSourceImp extends OtpRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> resendOTP({required String userCredential}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.sendOtpKey;
      staticData.fields.add(MapEntry('phone', userCredential));

      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, AuthBaseModel>> verifyAccount(
      {required String userCredential, required String code}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkAndVerifyKey;
      staticData.fields.add(MapEntry('phone', userCredential));
      staticData.fields.add(MapEntry('otp_code', code));
      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);

      ///save user token and cash your data
      final AuthBaseModel user = AuthBaseModel.fromJson(response.data["data"]['customer']);
      user.token = response.data["data"]['token'];
      saveAuthToken(token: response.data["data"]['token']);
      return right(user);
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> checkOtp({required String userCredential, required String code}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.checkOtpKey;
      staticData.fields.add(MapEntry('phone', userCredential));
      staticData.fields.add(MapEntry('otp_code', code));

      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> sendOtp({required String userCredential}) async {
    try {
      final FormData staticData = FormData();

      const String pathUrl = ApiKeys.sendOtpKey;
      staticData.fields.add(MapEntry('phone', userCredential));

      final Response response = await DioHelper.instance.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  void saveAuthToken({required String token}) {
    DioHelper.dio.options.headers.addAll({"Authorization": "Bearer $token"});
  }
}
