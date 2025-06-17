import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/network/error_handling/custom_error.dart';
import '../../../../../core/network/error_handling/custom_exception.dart';
import '../../model/auth_base_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImp extends AuthRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, AuthBaseModel>> loginUser(
      {required String userName, required String password}) async {
    try {
      final FormData staticData = FormData();
      staticData.fields.add(MapEntry('username', userName));
      staticData.fields.add(MapEntry('password', password));
      final Response response = await DioHelper.instance.getDate(
        url:
            'https://mawhibagatewayapistg.mawhiba.org/api/GenericService/get?serviceId=0&url=Login/Login?username=stud_test&password=Aa123456',
      );

      ///save user token and cash your data
      final AuthBaseModel user =
          AuthBaseModel.fromJson(response.data["data"]['customer']);
      user.token = response.data["data"]['token'];
      return right(user);
    } on CustomException catch (ex) {
      return Left(
        CustomError(
          type: ex.type,
          errorMassage: ex.errorMassage,
          imgPath: ex.imgPath,
        ),
      );
    }
  }
}
