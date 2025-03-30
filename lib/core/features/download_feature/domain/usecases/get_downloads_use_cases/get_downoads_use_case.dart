import 'package:clean_arch_demo_las_version/core/features/download_feature/data/models/download_model.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/domain/repositories/download_interfaces.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';

class GetDownloadsUseCase {
  final IDownloadInterfaces _iDownloadInterfaces;

  GetDownloadsUseCase(IDownloadInterfaces iDownloadInterfaces) : _iDownloadInterfaces = iDownloadInterfaces;

  Future<Either<CustomError, List<DownloadModel>>> getDownloads() async {
    return _iDownloadInterfaces.getDownloads();
  }
}
