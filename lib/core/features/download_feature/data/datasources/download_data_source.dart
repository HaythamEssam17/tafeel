import 'package:clean_arch_demo_las_version/core/model/base_model.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';

abstract class DownloadDataSource {
  Future<Either<CustomError, BaseModel>> getDownloads();
}
