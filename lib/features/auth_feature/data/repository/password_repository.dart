import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/entities/auth_base_entity.dart';
import '../../domain/repository/password_interface.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/password_remote_data_source.dart';

class PasswordRepository extends PasswordRepositoryInterface {
  final PasswordRemoteDataSourceInterface remoteDataSourceInterface;
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;

  PasswordRepository(this.remoteDataSourceInterface, this.auhLocalDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> changePassword({required AuthBaseEntity passwordAuthEntity}) async {
    return remoteDataSourceInterface
        .changePassword(passwordAuthEntity: passwordAuthEntity)
        .then((value) => value.fold((l) {
              auhLocalDataSourceInterface.setAccessToken('');
              auhLocalDataSourceInterface.setUserMap('');
              auhLocalDataSourceInterface.setIsLogged(false);
              return left(l);
            }, (r) {
              auhLocalDataSourceInterface.setAccessToken('');
              auhLocalDataSourceInterface.setUserMap('');
              auhLocalDataSourceInterface.setIsLogged(false);
              return right(r);
            }));
  }

  @override
  Future<Either<CustomError, BaseModel>> resetPassword({required AuthBaseEntity passwordAuthEntity}) async {
    return remoteDataSourceInterface.resetPassword(passwordAuthEntity: passwordAuthEntity);
  }

  @override
  Future<Either<CustomError, BaseModel>> checkPassword({required String password}) async {
    return remoteDataSourceInterface.checkPassword(password: password);
  }
}
