import 'package:clean_arch_demo_las_version/core/features/download_feature/data/datasources/download_data_source.dart';
import 'package:clean_arch_demo_las_version/core/model/base_model.dart';
import 'package:clean_arch_demo_las_version/core/network/dio_base_execute.dart';
import 'package:clean_arch_demo_las_version/core/network/dio_helper.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';
import 'package:dartz/dartz.dart';

class DownloadDataSourceImpl extends DownloadDataSource {
  @override
  Future<Either<CustomError, BaseModel>> getDownloads() async {
    return executeAndHandleError(() async {
      const String url = '';

      final response = await DioHelper.instance.getDate(url: url);

      return BaseModel.fromJson(response.data);
    });
  }
}
