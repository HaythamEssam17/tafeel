import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class PhoneInterface {
  Future<Either<CustomError, BaseModel>> changePhoneNumber({
    required String oldPhone,
    required String newPhone,
    required String password,
  });
}
