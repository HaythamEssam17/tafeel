import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_model.dart';

abstract class IUserRepository {
  Future<Either<CustomError, List<UserModel>>> getUsersList({
    required int page,
  });

  Future<Either<CustomError, UserModel>> getUserDetails({required int userID});
}
