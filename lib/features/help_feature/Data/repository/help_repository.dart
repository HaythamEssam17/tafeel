import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../Domain/repository/help_interface.dart';
import '../data_source/remote_data_source.dart';

class HelpRepository extends HelpInterface {
  final HelpRemoteDataScoursInterface remoteDataScoursInterface;

  HelpRepository(this.remoteDataScoursInterface);

  @override
  Future<Either<CustomError, BaseModel>> getAnswer({required int questionId, required int page, int? limit}) {
    return remoteDataScoursInterface.getAnswer(questionId: questionId, page: page);
  }

  @override
  Future<Either<CustomError, BaseModel>> getQuestionList({required int page, int? limit}) {
    return remoteDataScoursInterface.getQuestionList(page: page);
  }
}
