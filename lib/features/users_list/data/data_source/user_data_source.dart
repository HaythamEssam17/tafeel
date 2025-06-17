import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class UserDataSource {
  Future<Either<CustomError, BaseModel>> getUsersList({required int page});

  Future<Either<CustomError, BaseModel>> getUserDetails({required int userID});
}
