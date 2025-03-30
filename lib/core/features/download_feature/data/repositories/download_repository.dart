import 'package:clean_arch_demo_las_version/core/features/download_feature/data/datasources/download_data_source.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/data/models/download_model.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/domain/repositories/download_interfaces.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';

class DownloadRepository extends IDownloadInterfaces {
  final DownloadDataSource _dataSource;

  DownloadRepository(DownloadDataSource dataSource) : _dataSource = dataSource;

  @override
  Future<Either<CustomError, List<DownloadModel>>> getDownloads() async {
    return _dataSource.getDownloads().then(
      (value) => value.fold(
        (l) => left(l),
        (r) => right(downloadListFromJson(r.data)),
      ),
    );
  }
}
