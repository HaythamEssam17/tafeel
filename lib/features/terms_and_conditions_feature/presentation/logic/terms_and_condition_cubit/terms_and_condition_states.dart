import '../../../../../core/network/error_handling/custom_error.dart';

abstract class TermsAndConditionStates {}

class TermsAndConditionInitState extends TermsAndConditionStates {}

/// Terms And Condition
class TermsAndConditionLoadingState extends TermsAndConditionStates {}

class TermsAndConditionSuccessState extends TermsAndConditionStates {}

class TermsAndConditionErrorState extends TermsAndConditionStates {
  CustomError? error;

  TermsAndConditionErrorState({this.error});
}
