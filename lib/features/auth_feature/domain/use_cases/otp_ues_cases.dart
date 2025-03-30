import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../repository/otp_interface.dart';

class OtpUsesCases {
  final OtpRepositoryInterface repositoryInterface;

  OtpUsesCases(this.repositoryInterface);

  Future<Either<CustomError, SuccessModel>> callVerifyAccount(
      {required String userCredential, required String code}) {
    return repositoryInterface.verifyAccount(userCredential: userCredential, code: code);
  }

  Future<Either<CustomError, String>> callResendCode({
    required String userCredential,
  }) {
    return repositoryInterface
        .resendOTP(
          userCredential: userCredential,
        )
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(success.data!['otp_code'].toString());
            }));
  }

  Future<Either<CustomError, BaseModel>> callCheckOtp({
    required String userCredential,
    required String code,
  }) {
    return repositoryInterface.checkOtp(userCredential: userCredential, code: code);
  }
}
