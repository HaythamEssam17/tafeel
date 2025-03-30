import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/model/auth_base_model.dart';
import '../entities/auth_base_entity.dart';
import '../repository/auth_interface.dart';

class AuthUserCase {
  final AuthRepositoryInterface repository;

  AuthUserCase({required this.repository});

  Future<Either<CustomError, SuccessModel>> callUserLogin(
      {required LoginEntity loginEntity}) async {
    return await repository.loginUser(loginEntity: loginEntity);
  }

  Future<Either<CustomError, AuthBaseModel>> callUserSignUp(
      {required AuthBaseEntity authBaseEntity}) async {
    return await repository
        .userSingUp(authBaseEntity: authBaseEntity)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(AuthBaseModel.fromJson(success.data));
            }));
  }

  Future<Either<CustomError, BaseModel>> callUserLogout() async {
    return await repository.logout();
  }

  Future<Either<CustomError, BaseModel>> callUserDeleteAccount() async {
    return await repository.deleteAccount();
  }

  Future<Either<CustomError, BaseModel>> callStartApp() async {
    return await repository.startApp();
  }
}
