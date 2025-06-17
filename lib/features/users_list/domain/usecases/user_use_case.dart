import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/models/user_model.dart';
import '../repository/user_repository.dart';

class UserUseCase {
  final IUserRepository _iUserRepository;

  UserUseCase(this._iUserRepository);

  Future<Either<CustomError, List<UserModel>>> getUsersList({
    required int page,
  }) async {
    return await _iUserRepository.getUsersList(page: page);
  }

  Future<Either<CustomError, UserModel>> getUsersDetails({
    required int userID,
  }) async {
    return await _iUserRepository.getUserDetails(userID: userID);
  }
}
