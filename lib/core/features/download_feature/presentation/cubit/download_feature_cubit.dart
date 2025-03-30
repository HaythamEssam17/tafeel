import 'dart:isolate';
import 'dart:ui';

import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/download_model.dart';
import 'download_feature_state.dart';

class DownloadFeatureCubit extends Cubit<DownloadFeatureState> {
  DownloadFeatureCubit() : super(DownloadFeatureInitial());
  late bool permissionReady;
  ReceivePort _port = ReceivePort();

  String localPath = '';

  List<DownloadModel> downloadModels = [];
  DownloadModel selectedDownloadModel = DownloadModel();

  void init() {
    prepareSaveDir().then(
      (value) => localPath = value,
    );

    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _prepare();
  }

  void bindBackgroundIsolate() {
    _port = ReceivePort();

    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      AppConstants.downloadSendPort,
    );
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen(
      (dynamic data) {
        final taskId = (data as List<dynamic>)[0] as String;
        final status = DownloadTaskStatus.fromInt(data[1] as int);
        final progress = data[2] as int;

        devLog(
          'Callback on UI isolate: '
          'task ($taskId) is in status ($status) and process ($progress)',
        );

        // if (downloadModels.isNotEmpty) {
        final task = downloadModels.firstWhere((task) => task.id == taskId);

        task
          ..status = status
          ..progress = progress;

        selectedDownloadModel.status = status;
        selectedDownloadModel.progress = progress;

        if (progress == 100) {
          emit(DownloadFeatureCompleted());
        } else {
          emit(DownloadFeatureInitial());
        }
        // }
      },
    );
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping(AppConstants.downloadSendPort);

    _port.close();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    devLog(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName(AppConstants.downloadSendPort)?.send([id, status, progress]);
  }

  Future<void> requestDownload() async {
    selectedDownloadModel.status = DownloadTaskStatus.running;
    await FlutterDownloader.enqueue(
      url: selectedDownloadModel.url!,
      headers: {'auth': 'test_for_sql_encoding'},
      savedDir: localPath,
      saveInPublicStorage: true,
    ).then(
      (value) {
        selectedDownloadModel.id = value!;
        selectedDownloadModel.status = DownloadTaskStatus.complete;
        return null;
      },
    );

    emit(DownloadFeatureStarted());
  }

  Future<void> pauseDownload() async {
    await FlutterDownloader.pause(taskId: selectedDownloadModel.id!).then(
      (value) => selectedDownloadModel.status = DownloadTaskStatus.paused,
    );

    emit(DownloadFeaturePaused());
  }

  Future<void> resumeDownload() async {
    await FlutterDownloader.resume(taskId: selectedDownloadModel.id!).then(
      (newTaskId) {
        selectedDownloadModel.id = newTaskId;
        selectedDownloadModel.status = DownloadTaskStatus.complete;

        emit(DownloadFeatureCompleted());
      },
    );
  }

  Future<void> retryDownload() async {
    await FlutterDownloader.retry(taskId: selectedDownloadModel.id!).then(
      (newTaskId) {
        selectedDownloadModel.id = newTaskId!;
        selectedDownloadModel.status = DownloadTaskStatus.running;
      },
    );

    emit(DownloadFeatureStarted());
  }

  Future<void> delete(DownloadModel model) async {
    await FlutterDownloader.remove(
      taskId: selectedDownloadModel.id!,
      shouldDeleteContent: true,
    ).then(
      (value) => selectedDownloadModel.status = DownloadTaskStatus.complete,
    );

    await _prepare();

    emit(DownloadFeatureFailed(error: '${selectedDownloadModel.title!} deleted'));
  }

  Future<bool> openDownloadedFile(DownloadModel? downloadModel) async {
    final String? taskId = downloadModel!.id;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }

  Future<void> _prepare() async {
    emit(DownloadFeatureLoading());

    final List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      devLog('No tasks were retrieved from the database.');
      return;
    }

    var count = 0;
    downloadModels = [];

    for (var i = count; i < downloadModels.length; i++) {
      downloadModels.add(
        DownloadModel(
          id: '${i + 1}',
          title: downloadModels[i].title!,
          url: downloadModels[i].url!,
        ),
      );
      count++;
    }

    for (final task in tasks) {
      for (final info in downloadModels) {
        if (info.url == task.url) {
          info
            ..id = task.taskId
            ..status = task.status
            ..progress = task.progress;
        }
      }
    }

    permissionReady = await checkPermission(Permission.storage);

    if (permissionReady) {
      await prepareSaveDir();
    }

    emit(DownloadFeatureInitial());
  }
}
