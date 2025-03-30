import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/model/faq_model.dart';
import '../../../Domain/ues_cases/help_ues_cases.dart';
import 'help_states.dart';

class HelpCubit extends Cubit<HelpStates> {
  final HelpUsesCases useCase;

  HelpCubit(this.useCase) : super(HelpInitState());

  static HelpCubit get(BuildContext context) => BlocProvider.of(context);

  List<FAQModel> questionList = [];
  List<FAQModel> questionTempList = [];

  ///Question pagination
  int questionPage = 1;
  late ScrollController questionScrollController;
  bool questionHasMoreData = false;

  void setupQuestionScrollController() {
    if (questionScrollController.offset > questionScrollController.position.maxScrollExtent - 200 &&
        questionScrollController.offset <= questionScrollController.position.maxScrollExtent) {
      if (state is! HelpGetMoreQuestionLoadingState && questionHasMoreData) {
        whenScrollQuestionPagination();
      }
    }
  }

  ///Question Pagination Function
  void whenScrollQuestionPagination() async {
    emit(HelpGetMoreQuestionLoadingState());

    questionPage = questionPage + 1;
    final result = await useCase.getQuestionList(page: questionPage);
    result.fold((error) => emit(HelpGetMoreQuestionFailState(error)), (list) {
      questionHasMoreData = list.length == 10;
      questionList.addAll(list);
      questionTempList.addAll(list);
      emit(HelpGetMoreQuestionSuccessState());
    });
  }

  ///get question list
  void getQuestions() async {
    emit(HelpGetQuestionLoadingState());
    questionPage = 1;
    final result = await useCase.getQuestionList(page: questionPage);
    result.fold((error) => emit(HelpGetQuestionFailState(error)), (list) {
      if (list.isEmpty) {
        emit(HelpGetQuestionEmptyState());
      } else {
        questionHasMoreData = list.length == 10;
        questionList = list;
        questionTempList = list;
        emit(HelpGetQuestionSuccessState());
      }
    });
  }

  void search(String str) {
    log("this the key to search  $str}");
    questionList = questionTempList.where((element) {
      return element.question.toLowerCase().contains(str.toLowerCase());
    }).toList();
    emit(HelpSearchChangeState());
  }
}
