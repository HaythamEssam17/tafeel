import 'package:tafeal_demo/core/model/base_model.dart';
import 'package:tafeal_demo/core/network/error_handling/custom_error.dart';
import 'package:tafeal_demo/core/network/error_handling/custom_exception.dart';
import 'package:dartz/dartz.dart';

Future<Either<CustomError, BaseModel>> executeAndHandleError(
  Future<BaseModel> Function() function,
) async {
  try {
    final BaseModel result = await function();
    return right(BaseModel.fromJson(result.data));
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
