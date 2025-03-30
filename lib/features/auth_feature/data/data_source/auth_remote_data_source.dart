import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';
import '../../domain/entities/auth_base_entity.dart';
import '../model/auth_base_model.dart';

abstract class AuthRemoteDataSourceInterface {
  ///login user
  Future<Either<CustomError, AuthBaseModel>> loginUser({
    required LoginEntity loginEntity,
  });

  ///log out
  Future<Either<CustomError, BaseModel>> logOut();

  ///log out
  Future<Either<CustomError, BaseModel>> deleteAccount();

  ///User Create A new Account
  Future<Either<CustomError, BaseModel>> userSingUp({
    required AuthBaseEntity authBaseEntity,
  });

  void saveAuthToken({required String token});

  void deleteAuthToken();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> logOut() async {
    try {
      final FormData staticData = FormData();

      final String loginUrl = dotenv.env['logout_key'] ?? '';

      await DioHelper.instance.postData(url: loginUrl, data: staticData);

      ///delete user token from Auth header
      deleteAuthToken();

      return right(BaseModel());
    } on CustomException catch (ex) {
      return Left(
        CustomError(
          type: ex.type,
          errorMassage: ex.errorMassage,
          imgPath: ex.imgPath,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> deleteAccount() async {
    try {
      final FormData staticData = FormData();

      final String loginUrl = dotenv.env['delete_profile_account_key'] ?? '';

      await DioHelper.instance.postData(url: loginUrl, data: staticData);

      ///delete user token from Auth header
      deleteAuthToken();

      return right(BaseModel());
    } on CustomException catch (ex) {
      return Left(
        CustomError(
          type: ex.type,
          errorMassage: ex.errorMassage,
          imgPath: ex.imgPath,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, AuthBaseModel>> loginUser({
    required LoginEntity loginEntity,
  }) async {
    try {
      final FormData staticData = FormData();
      // String loginUrl = dotenv.env['login_key'] ?? '';
      // staticData.fields.add(MapEntry('phone', loginEntity.phone));
      // staticData.fields.add(MapEntry('password', loginEntity.password));
      // staticData.fields.add(MapEntry('device_token', SharedText.deviceToken));
      // Response response = await DioHelper.postData(url: loginUrl, data: staticData);

      staticData.fields.add(MapEntry('username', loginEntity.phone));
      staticData.fields.add(MapEntry('password', loginEntity.password));
      final Response response = await DioHelper.instance.getDate(
        url:
            'https://mawhibagatewayapistg.mawhiba.org/api/GenericService/get?serviceId=0&url=Login/Login?username=stud_test&password=Aa123456',
      );

      ///save user token and cash your data
      final AuthBaseModel user = AuthBaseModel.fromJson(
        response.data["data"]['customer'],
      );
      user.token = response.data["data"]['token'];
      saveAuthToken(token: response.data["data"]['token']);
      return right(user);
    } on CustomException catch (ex) {
      return Left(
        CustomError(
          type: ex.type,
          errorMassage: ex.errorMassage,
          imgPath: ex.imgPath,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> userSingUp({
    required AuthBaseEntity authBaseEntity,
  }) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.clear();
      final String pathUrl = dotenv.env['register_key'] ?? '';
      staticData.fields.add(MapEntry('name', authBaseEntity.name!));
      staticData.fields.add(MapEntry('email', authBaseEntity.email!));
      staticData.fields.add(MapEntry('phone', authBaseEntity.phone!));
      staticData.fields.add(MapEntry('password', authBaseEntity.password!));
      if (authBaseEntity.referCode != null) {
        staticData.fields.add(
          MapEntry('parent_invite_code', authBaseEntity.referCode!),
        );
      }
      staticData.fields.add(
        MapEntry('password_confirmation', authBaseEntity.confirmPassword!),
      );
      staticData.fields.add(MapEntry('device_token', authBaseEntity.token!));
      final Response response = await DioHelper.instance.postData(
        url: pathUrl,
        data: staticData,
      );
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(
        CustomError(
          type: ex.type,
          errorMassage: ex.errorMassage,
          imgPath: ex.imgPath,
        ),
      );
    }
  }

  @override
  void deleteAuthToken() {
    DioHelper.dio.options.headers.remove("Authorization");
  }

  @override
  void saveAuthToken({required String token}) {
    DioHelper.dio.options.headers.addAll({"Authorization": "Bearer $token"});
  }
}
