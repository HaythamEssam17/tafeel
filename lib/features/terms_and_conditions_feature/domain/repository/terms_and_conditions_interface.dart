import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class TermsAndConditionsRepositoryInterface {
  Future<Either<CustomError, BaseModel>> getTermsAndConditions({required String endPoint});
}
