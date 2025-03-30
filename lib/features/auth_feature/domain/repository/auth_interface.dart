import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../entities/auth_base_entity.dart';

abstract class AuthRepositoryInterface {
  Future<Either<CustomError, BaseModel>> userSingUp({
    required AuthBaseEntity authBaseEntity,
  });
  Future<Either<CustomError, SuccessModel>> loginUser({
    required LoginEntity loginEntity,
  });
  Future<Either<CustomError, BaseModel>> logout();
  Future<Either<CustomError, BaseModel>> deleteAccount();
  Future<Either<CustomError, BaseModel>> startApp();
}
