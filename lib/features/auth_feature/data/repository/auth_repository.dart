import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tafeal/core/helpers/shared.dart';

import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/auth_interface.dart';
import '../data_source/local_data_source/auth_local_data_source.dart';
import '../data_source/remote_data_source/auth_remote_data_source.dart';
import '../model/auth_base_model.dart';

class AuthRepository extends AuthRepositoryInterface {
  final AuthLocalDataSourceInterface auhLocalDataSourceInterface;
  final AuthRemoteDataSourceInterface authRemoteDataSourceInterface;

  AuthRepository({
    required this.auhLocalDataSourceInterface,
    required this.authRemoteDataSourceInterface,
  });

  @override
  Future<Either<CustomError, BaseModel>> startApp() async {
    final bool result =
        await auhLocalDataSourceInterface.getIsLogged() ?? false;

    if (result) {
      final userString = await auhLocalDataSourceInterface.getUserMap();
      final baseUserMap = json.decode(userString!);
      final AuthBaseModel userModel = AuthBaseModel.fromJson(baseUserMap);
      SharedText.currentUser = userModel;
      final String? token = await auhLocalDataSourceInterface.getAccessToken();

      if (token != null && token.isNotEmpty) {
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
}
