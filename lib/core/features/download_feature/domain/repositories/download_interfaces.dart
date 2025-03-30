import 'package:clean_arch_demo_las_version/core/features/download_feature/data/models/download_model.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';

abstract class IDownloadInterfaces {
  Future<Either<CustomError, List<DownloadModel>>> getDownloads();
}
