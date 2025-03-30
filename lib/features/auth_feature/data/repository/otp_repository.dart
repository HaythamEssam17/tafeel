import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/otp_interface.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/otp_remote_data_source.dart';
import '../model/auth_base_model.dart';

class OtpRepository extends OtpRepositoryInterface {
  final OtpRemoteDataSourceInterface remoteDataSourceInterface;
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;

  OtpRepository(this.remoteDataSourceInterface, this.auhLocalDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> resendOTP({required String userCredential}) {
    return remoteDataSourceInterface.resendOTP(userCredential: userCredential);
  }

  @override
  Future<Either<CustomError, SuccessModel>> verifyAccount(
      {required String userCredential, required String code}) async {
    return await remoteDataSourceInterface
        .verifyAccount(userCredential: userCredential, code: code)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) async {
              ///save the user model in cache
              return await updateUserLocalData(success).then((value) => value.fold((l) => left(l), (r) async {
                    return await updateUserToken(success.token!).then((value) => value.fold((l) => left(l), (r) async {
                          return await updateUserIsLogged();
                        }));
                  }));
            }));
  }

  Future<Either<CustomError, SuccessModel>> updateUserLocalData(AuthBaseModel user) async {
    try {
      final String jEncode = jsonEncode(user.toJson());
      await auhLocalDataSourceInterface.setUserMap(jEncode);
      SharedText.currentUser = AuthBaseModel.fromJson(user.toJson());
      return right(SuccessModel());
    } catch (e) {
      return left(CustomError(errorMassage: e.toString(), type: CustomStatusCodeErrorType.unExcepted));
    }
  }

  Future<Either<CustomError, SuccessModel>> updateUserToken(String userToken) async {
    try {
      await auhLocalDataSourceInterface.setAccessToken(userToken);
      SharedText.userToken = userToken;
      return right(SuccessModel());
    } catch (e) {
      return left(CustomError(errorMassage: e.toString(), type: CustomStatusCodeErrorType.unExcepted));
    }
  }

  Future<Either<CustomError, SuccessModel>> updateUserIsLogged() async {
    try {
      await auhLocalDataSourceInterface.setIsLogged(true);
      return right(SuccessModel());
    } catch (e) {
      return left(CustomError(errorMassage: e.toString(), type: CustomStatusCodeErrorType.unExcepted));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> checkOtp({required String userCredential, required String code}) {
    return remoteDataSourceInterface.checkOtp(userCredential: userCredential, code: code);
  }

  @override
  Future<Either<CustomError, BaseModel>> sendVerificationCode({required String userCredential}) {
    return remoteDataSourceInterface.sendOtp(userCredential: userCredential);
  }
}
