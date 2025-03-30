import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/terms_and_conditions_model.dart';
import '../../../domain/ues_cases/terms_and_conditions_ues_cases.dart';
import 'terms_and_condition_states.dart';

class TermsAndConditionsCubit extends Cubit<TermsAndConditionStates> {
  TermsAndConditionsCubit(this.getTermsUseCases) : super(TermsAndConditionInitState());

  final TermsAndConditionsUesCases getTermsUseCases;

  TermsAndConditionsModel? termsEntity;

  /// Get All notification List
  void getTermsAndCondition(String endPoint) async {
    emit(TermsAndConditionLoadingState());
    final Either<CustomError, TermsAndConditionsModel> result = await getTermsUseCases.getTerms(endPoint: endPoint);
    result.fold((CustomError error) => emit(TermsAndConditionErrorState(error: error)), (TermsAndConditionsModel data) {
      termsEntity = data;
      emit(TermsAndConditionSuccessState());
    });
  }
}
