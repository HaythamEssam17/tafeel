import 'package:clean_arch_demo_las_version/core/model/base_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../model/terms_and_conditions_model.dart';
import '../repository/terms_and_conditions_interface.dart';

class TermsAndConditionsUesCases {
  final TermsAndConditionsRepositoryInterface repositoryInterface;

  TermsAndConditionsUesCases(this.repositoryInterface);

  Future<Either<CustomError, TermsAndConditionsModel>> getTerms({
    required String endPoint,
  }) {
    return repositoryInterface
        .getTermsAndConditions(endPoint: endPoint)
        .then(
          (Either<CustomError, BaseModel> value) => value.fold(
            (CustomError l) => left(l),
            (BaseModel r) => right(TermsAndConditionsModel.fromJson(r.data)),
          ),
        );
  }
}
