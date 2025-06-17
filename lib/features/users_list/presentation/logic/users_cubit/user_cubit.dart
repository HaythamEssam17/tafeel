import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeal/features/users_list/domain/usecases/user_use_case.dart';

import '../../../data/models/user_model.dart';
import 'user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit(this._userUseCase) : super(UserInit());

  final UserUseCase _userUseCase;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  List<UserModel> usersList = [];

  Future onRefresh() async {
    await getUsersList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! UserLoadingMoreDateState && hasMoreData) {
        whenScrollUserPagination();
      }
    }
  }

  /// Pagination Function
  whenScrollUserPagination() async {
    emit(UserLoadingMoreDateState());

    page = page + 1;
    var result = await _userUseCase.getUsersList(page: page);
    result.fold((error) => emit(UserFailedMoreDateState(error.errorMassage!)), (
      userListData,
    ) {
      var tempList = userListData;
      hasMoreData = tempList.length == 10;
      usersList.addAll(tempList);
      emit(UserSuccessMoreDateState());
    });
  }

  /// Get All User List
  getUsersList() async {
    emit(UserLoading());
    page = 1;
    var result = await _userUseCase.getUsersList(page: page);
    result.fold((error) => emit(UserFailed(error.errorMassage!)), (
      userListData,
    ) {
      usersList = userListData;
      hasMoreData = usersList.length == 10;

      if (usersList.isEmpty) {
        emit(UserEmptyState());
      } else {
        emit(UserSuccess());
      }
    });
  }
}
