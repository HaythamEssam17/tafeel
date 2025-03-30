import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../model/faq_model.dart';
import '../repository/help_interface.dart';

class HelpUsesCases {
  final HelpInterface repositoryInterface;

  HelpUsesCases(this.repositoryInterface);

  Future<Either<CustomError, List<FAQModel>>> getQuestionList({required int page, int? limit}) {
    return repositoryInterface
        .getQuestionList(page: page, limit: limit ?? 10)
        .then((value) => value.fold((l) => Left(l), (r) => right(questionListFromJson(r.data))));
  }
}
