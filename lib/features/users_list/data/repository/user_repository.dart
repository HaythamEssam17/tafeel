import 'package:dartz/dartz.dart';
import 'package:tafeal/core/network/error_handling/custom_error.dart';
import 'package:tafeal/features/users_list/data/data_source/user_data_source.dart';
import 'package:tafeal/features/users_list/data/models/user_model.dart';
import 'package:tafeal/features/users_list/domain/repository/user_repository.dart';

class UserRepository implements IUserRepository {
  final UserDataSource _dataSource;

  UserRepository(this._dataSource);

  @override
  Future<Either<CustomError, List<UserModel>>> getUsersList({
    required int page,
  }) async {
    return await _dataSource.getUsersList(page: page).then((value) {
      return value.fold(
        (l) => left(l),
        (r) => right(userModelListFromJson(r.data)),
      );
    });
  }

  @override
  Future<Either<CustomError, UserModel>> getUserDetails({
    required int userID,
  }) async {
    return await _dataSource.getUserDetails(userID: userID).then((value) {
      return value.fold(
        (l) => left(l),
        (r) => right(UserModel.fromJson(r.data)),
      );
    });
  }
}
