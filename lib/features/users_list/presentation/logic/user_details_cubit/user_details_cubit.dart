import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/usecases/user_use_case.dart';
import 'user_details_states.dart';

class UserDetailsCubit extends Cubit<UserDetailsStates> {
  UserDetailsCubit(this._userUseCase) : super(UserDetailsInit());

  final UserUseCase _userUseCase;

  UserModel selectedUserModel = UserModel();
  UserModel? userModel;

  getUserDetails(int userID) async {
    userModel = null;
    emit(UserDetailsLoading());
    var result = await _userUseCase.getUsersDetails(userID: userID);

    result.fold((l) => emit(UserDetailsFailed(l.errorMassage!)), (r) {
      userModel = r;
      emit(UserDetailsSuccess());
    });
  }
}
