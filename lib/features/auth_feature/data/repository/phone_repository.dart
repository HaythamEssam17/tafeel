import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/phone_interface.dart';
import '../data_source/phone_data_source.dart';

class PhoneRepository extends PhoneInterface {
  final PhoneDataSource _phoneDataSource;

  PhoneRepository(this._phoneDataSource);

  @override
  Future<Either<CustomError, BaseModel>> changePhoneNumber(
      {required String oldPhone, required String newPhone, required String password}) async {
    return await _phoneDataSource.changePhoneNumber(oldPhone: oldPhone, newPhone: newPhone, password: password);
  }
}
