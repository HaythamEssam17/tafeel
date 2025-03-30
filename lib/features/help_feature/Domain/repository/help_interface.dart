import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class HelpInterface {
  Future<Either<CustomError, BaseModel>> getQuestionList({required int page, int? limit});

  Future<Either<CustomError, BaseModel>> getAnswer({required int questionId, required int page, int? limit});
}
