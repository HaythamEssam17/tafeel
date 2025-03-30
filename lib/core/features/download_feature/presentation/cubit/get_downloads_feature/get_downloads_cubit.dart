import 'package:clean_arch_demo_las_version/core/features/download_feature/data/models/download_model.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/domain/usecases/get_downloads_use_cases/get_downoads_use_case.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/get_downloads_feature/get_downloads_states.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class GetDownloadsCubit extends Cubit<GetDownloadsStates> {
  GetDownloadsCubit(this._getDownloadsUseCase) : super(GetDownloadsInitial());

  late final GetDownloadsUseCase _getDownloadsUseCase;

  List<DownloadModel> downloads = [];

  void checkStoragePermission() {
    checkPermission(Permission.storage).then(
      (value) {
        if (value) {
          getDownloads();
        } else {
          emit(DownloadFeaturePermissionFailed());
        }
      },
    );
  }

  void getDownloads() async {
    downloads = [];
    emit(GetDownloadsLoading());

    final result = await _getDownloadsUseCase.getDownloads();

    result.fold(
      (l) => emit(GetDownloadsFailed(customError: l)),
      (r) {
        downloads = r;

        emit(GetDownloadsSuccess());
      },
    );
  }
}
