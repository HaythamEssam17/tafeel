import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';

abstract class PhoneDataSource {
  Future<Either<CustomError, BaseModel>> changePhoneNumber({
    required String oldPhone,
    required String newPhone,
    required String password,
  });
}

class PhoneDataSourceImpl extends PhoneDataSource {
  @override
  Future<Either<CustomError, BaseModel>> changePhoneNumber({
    required String oldPhone,
    required String newPhone,
    required String password,
  }) async {
    try {
      const String url = ApiKeys.changePhoneKey;

      final FormData formData = FormData();
      formData.fields.add(MapEntry('phone', oldPhone));
      formData.fields.add(MapEntry('new_phone', newPhone));
      formData.fields.add(MapEntry('password', password));

      final Response response = await DioHelper.instance.postData(url: url, data: formData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return left(CustomError(imgPath: ex.imgPath, type: ex.type, errorMassage: ex.errorMassage));
    }
  }
}
