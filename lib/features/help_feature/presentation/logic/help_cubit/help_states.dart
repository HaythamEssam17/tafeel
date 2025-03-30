import '../../../../../core/network/error_handling/custom_error.dart';

abstract class HelpStates {}

class HelpInitState extends HelpStates {}

class HelpGetQuestionLoadingState extends HelpStates {}

class HelpGetMoreQuestionLoadingState extends HelpStates {}

class HelpGetQuestionSuccessState extends HelpStates {}

class HelpGetMoreQuestionSuccessState extends HelpStates {}

class HelpGetQuestionFailState extends HelpStates {
  final CustomError error;

  HelpGetQuestionFailState(this.error);
}

class HelpGetMoreQuestionFailState extends HelpStates {
  final CustomError error;

  HelpGetMoreQuestionFailState(this.error);
}

class HelpGetQuestionEmptyState extends HelpStates {}

class HelpSearchChangeState extends HelpStates {}
