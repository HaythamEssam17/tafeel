import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../entities/auth_base_entity.dart';

abstract class PasswordRepositoryInterface {
  Future<Either<CustomError, BaseModel>> resetPassword({required AuthBaseEntity passwordAuthEntity});

  Future<Either<CustomError, BaseModel>> changePassword({required AuthBaseEntity passwordAuthEntity});

  Future<Either<CustomError, BaseModel>> checkPassword({required String password});
}
