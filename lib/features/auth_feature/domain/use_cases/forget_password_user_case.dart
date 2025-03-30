import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../entities/auth_base_entity.dart';
import '../repository/otp_interface.dart';
import '../repository/password_interface.dart';

class PasswordUesCases {
  final PasswordRepositoryInterface passwordRepositoryInterface;
  final OtpRepositoryInterface otpRepositoryInterface;

  PasswordUesCases(this.passwordRepositoryInterface, this.otpRepositoryInterface);

  Future<Either<CustomError, String>> callSndVerificationCode({required String userCredential}) {
    return otpRepositoryInterface
        .sendVerificationCode(userCredential: userCredential)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(success.data["otp_code"]);
            }));
  }

  Future<Either<CustomError, BaseModel>> callChangeNewPassword({required AuthBaseEntity passwordAuthEntity}) {
    return passwordRepositoryInterface.resetPassword(passwordAuthEntity: passwordAuthEntity);
  }

  Future<Either<CustomError, BaseModel>> callChangePassword({required AuthBaseEntity passwordAuthEntity}) {
    return passwordRepositoryInterface.changePassword(passwordAuthEntity: passwordAuthEntity);
  }

  Future<Either<CustomError, BaseModel>> checkPassword({required String password}) {
    return passwordRepositoryInterface.checkPassword(password: password);
  }
}
