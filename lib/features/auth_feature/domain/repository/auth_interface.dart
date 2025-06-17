import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class AuthRepositoryInterface {
  Future<Either<CustomError, BaseModel>> startApp();
}
