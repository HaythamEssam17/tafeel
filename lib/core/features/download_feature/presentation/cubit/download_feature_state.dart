abstract class DownloadFeatureState {
  const DownloadFeatureState();
}

class DownloadFeatureInitial extends DownloadFeatureState {}

class DownloadFeatureLoading extends DownloadFeatureState {}

class DownloadFeatureStarted extends DownloadFeatureState {}

class DownloadFeatureCompleted extends DownloadFeatureState {}

class DownloadFeaturePaused extends DownloadFeatureState {}

class DownloadFeatureFailed extends DownloadFeatureState {
  final String error;

  DownloadFeatureFailed({required this.error});
}
