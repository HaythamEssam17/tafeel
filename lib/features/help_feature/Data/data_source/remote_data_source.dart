import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';

abstract class HelpRemoteDataScoursInterface {
  Future<Either<CustomError, BaseModel>> getQuestionList({required int page, int? limit});

  Future<Either<CustomError, BaseModel>> getAnswer({required int questionId, required int page, int? limit});
}

class HelpRemoteDataScoursImp extends HelpRemoteDataScoursInterface {
  @override
  Future<Either<CustomError, BaseModel>> getAnswer({required int questionId, required int page, int? limit}) async {
    try {
      String answerUrl;
      if (limit == null) {
        answerUrl = '${ApiKeys.answerKey}?page=$page&question_id=$questionId';
      } else {
        answerUrl = '${ApiKeys.answerKey}?page=$page&limit=$limit&question_id=$questionId';
      }
      final Response response = await DioHelper.instance.getDate(url: answerUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getQuestionList({required int page, int? limit}) async {
    try {
      String questionUrl;
      if (limit == null) {
        questionUrl = '${ApiKeys.questionKey}?page=$page';
      } else {
        questionUrl = '${ApiKeys.questionKey}?page=$page&limit=$limit';
      }
      final Response response = await DioHelper.instance.getDate(url: questionUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
