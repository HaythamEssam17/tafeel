import 'package:clean_arch_demo_las_version/core/network/error_handling/custom_error.dart';

abstract class GetDownloadsStates {}

class GetDownloadsInitial extends GetDownloadsStates {}

class GetDownloadsLoading extends GetDownloadsStates {}

class GetDownloadsSuccess extends GetDownloadsStates {}

class GetDownloadsFailed extends GetDownloadsStates {
  final CustomError customError;

  GetDownloadsFailed({required this.customError});
}

class DownloadFeaturePermissionReady extends GetDownloadsStates {}

class DownloadFeaturePermissionFailed extends GetDownloadsStates {}
