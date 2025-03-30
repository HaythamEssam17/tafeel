import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../repository/phone_interface.dart';

class PhoneUseCase {
  final PhoneInterface _phoneInterface;

  PhoneUseCase(this._phoneInterface);

  Future<Either<CustomError, BaseModel>> changePhone({
    required String oldPhone,
    required String newPhone,
    required String password,
  }) async {
    return await _phoneInterface.changePhoneNumber(oldPhone: oldPhone, newPhone: newPhone, password: password);
  }
}
