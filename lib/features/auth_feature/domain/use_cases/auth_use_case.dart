import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../repository/auth_interface.dart';

class AuthUserCase {
  final AuthRepositoryInterface repository;

  AuthUserCase({required this.repository});

  Future<Either<CustomError, BaseModel>> callStartApp() async {
    return await repository.startApp();
  }
}
