import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class OtpRepositoryInterface {
  Future<Either<CustomError, BaseModel>> sendVerificationCode({required String userCredential});

  Future<Either<CustomError, SuccessModel>> verifyAccount({required String userCredential, required String code});
  Future<Either<CustomError, BaseModel>> checkOtp({required String userCredential, required String code});

  Future<Either<CustomError, BaseModel>> resendOTP({required String userCredential});
}
