import 'dart:convert';

import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/entities/auth_base_entity.dart';
import '../../domain/repository/auth_interface.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';
import '../model/auth_base_model.dart';

class AuthRepository extends AuthRepositoryInterface {
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final AuthRemoteDataSourceInterface authRemoteDataSourceInterface;

  AuthRepository({required this.auhLocalDataSourceInterface, required this.authRemoteDataSourceInterface});

  /// singUp user to app
  @override
  Future<Either<CustomError, BaseModel>> userSingUp({required AuthBaseEntity authBaseEntity}) async {
    return await authRemoteDataSourceInterface.userSingUp(authBaseEntity: authBaseEntity);
  }

  /// login user to app
  @override
  Future<Either<CustomError, SuccessModel>> loginUser({required LoginEntity loginEntity}) async {
    ///login user in remote data source
    return await authRemoteDataSourceInterface.loginUser(loginEntity: loginEntity).then(
          (value) => value.fold(
            (failure) {
              return left(failure);
            },
            (success) async {
              ///save the user model in cache
              return await updateUserLocalData(success).then(
                (value) => value.fold(
                  (l) => left(l),
                  (r) async {
                    return await updateUserToken(success.token!).then(
                      (value) => value.fold(
                        (l) => left(l),
                        (r) async {
                          return await updateUserIsLogged();
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
  }

  Future<Either<CustomError, SuccessModel>> updateUserLocalData(AuthBaseModel user) async {
    try {
      final String jEncode = jsonEncode(user.toJson());
      await auhLocalDataSourceInterface.setUserMap(jEncode);
      SharedText.currentUser = AuthBaseModel.fromJson(user.toJson());
      return right(SuccessModel());
    } catch (e) {
      return left(
        CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted,
        ),
      );
    }
  }

  Future<Either<CustomError, SuccessModel>> updateUserToken(String userToken) async {
    try {
      await auhLocalDataSourceInterface.setAccessToken(userToken);
      SharedText.userToken = userToken;
      return right(SuccessModel());
    } catch (e) {
      return left(
        CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted,
        ),
      );
    }
  }

  Future<Either<CustomError, SuccessModel>> updateUserIsLogged() async {
    try {
      await auhLocalDataSourceInterface.setIsLogged(true);
      return right(SuccessModel());
    } catch (e) {
      return left(
        CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> logout() async {
    return await authRemoteDataSourceInterface.logOut().then(
          (value) => value.fold(
            (l) {
              auhLocalDataSourceInterface.setAccessToken('');
              auhLocalDataSourceInterface.setUserMap('');
              auhLocalDataSourceInterface.setIsLogged(false);
              return left(l);
            },
            (r) {
              auhLocalDataSourceInterface.setAccessToken('');
              auhLocalDataSourceInterface.setUserMap('');
              auhLocalDataSourceInterface.setIsLogged(false);
              return right(r);
            },
          ),
        );
  }

  @override
  Future<Either<CustomError, BaseModel>> startApp() async {
    final bool result = await auhLocalDataSourceInterface.getIsLogged() ?? false;

    if (result) {
      final userString = await auhLocalDataSourceInterface.getUserMap();
      final baseUserMap = json.decode(userString!);
      final AuthBaseModel userModel = AuthBaseModel.fromJson(baseUserMap);
      SharedText.currentUser = userModel;
      final String? token = await auhLocalDataSourceInterface.getAccessToken();

      if (token != null && token.isNotEmpty) {
        authRemoteDataSourceInterface.saveAuthToken(token: token);
        SharedText.userToken = token;
        devLog("sharedToken $token");
        return right(BaseModel());
      } else {
        return left(
          CustomError(
            errorMassage: "failed to get user from cached",
            type: CustomStatusCodeErrorType.unExcepted,
          ),
        );
      }
    } else {
      return left(
        CustomError(
          errorMassage: "failed to get user from cached",
          type: CustomStatusCodeErrorType.unExcepted,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> deleteAccount() async {
    return await authRemoteDataSourceInterface.deleteAccount().then(
          (value) => value.fold(
            (l) => left(l),
            (r) {
              ///remove the user model from cache
              auhLocalDataSourceInterface.setAccessToken('');
              auhLocalDataSourceInterface.setUserMap('');
              auhLocalDataSourceInterface.setIsLogged(false);

              ///return the right side of either (base model)
              return right(BaseModel());
            },
          ),
        );
  }
}
