import 'package:tafeal/core/model/base_model.dart';
import 'package:tafeal/core/network/error_handling/custom_error.dart';
import 'package:tafeal/core/network/error_handling/custom_exception.dart';
import 'package:dartz/dartz.dart';

// Future<Either<CustomError, BaseModel>> executeAndHandleError(
//   Future<BaseModel> Function() function,
// ) async {
//   try {
//     final BaseModel result = await function();
//     return right((result.data));
//   } on CustomException catch (ex) {
//     return Left(
//       CustomError(
//         type: ex.type,
//         errorMassage: ex.errorMassage,
//         imgPath: ex.imgPath,
//       ),
//     );
//   }
// }

Future<Either<CustomError, BaseModel>> executeAndHandleError(
  Future<BaseModel> Function() function,
) async {
  try {
    final result = await function();

    // if (result.model != null) {
    return Right(result);
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
