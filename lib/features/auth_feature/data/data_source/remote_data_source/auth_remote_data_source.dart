import 'package:dartz/dartz.dart';

import '../../../../../core/network/error_handling/custom_error.dart';
import '../../model/auth_base_model.dart';

abstract class AuthRemoteDataSourceInterface {
  Future<Either<CustomError, AuthBaseModel>> loginUser(
      {required String userName, required String password});
}
