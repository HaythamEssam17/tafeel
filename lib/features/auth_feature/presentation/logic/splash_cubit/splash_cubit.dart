import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/auth_use_case.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit(this._userUseCases) : super(SplashStatesInit());

  final AuthUserCase _userUseCases;

  // static SplashCubit get(context) => BlocProvider.of(context);

  void getCachedUser() async {
    final result = await _userUseCases.callStartApp();

    result.fold((failure) => emit(UserNotFoundState()), (success) => emit(UserFoundState()));
  }
}
