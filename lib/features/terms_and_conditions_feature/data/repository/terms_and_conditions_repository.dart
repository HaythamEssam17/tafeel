import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/terms_and_conditions_interface.dart';
import '../data_source/remote_data_source.dart';

class TermsAndConditionsListRepository extends TermsAndConditionsRepositoryInterface {
  final TermsRemoteDataScoursInterface remoteDataScoursInterface;

  TermsAndConditionsListRepository(this.remoteDataScoursInterface);

  @override
  Future<Either<CustomError, BaseModel>> getTermsAndConditions({required String endPoint}) {
    return remoteDataScoursInterface.getTermsData(endPoint: endPoint);
  }
}
