import 'package:clean_arch_demo_las_version/core/features/download_feature/data/models/download_model.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadListItem extends StatelessWidget {
  const DownloadListItem({
    super.key,
    this.data,
    this.onTap,
    this.onActionTap,
    this.onCancel,
  });

  final DownloadModel? data;
  final void Function(DownloadModel?)? onTap;
  final void Function(DownloadModel)? onActionTap;
  final void Function(DownloadModel)? onCancel;

  Widget _buildTrailing() {
    return BlocConsumer<DownloadFeatureCubit, DownloadFeatureState>(
      listener: (context, state) {},
      builder: (context, state) {
        if ((data!.getStatus == DownloadTaskStatus.undefined)) {
          return IconButton(
            onPressed: () => onActionTap?.call(data!),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.file_download),
            tooltip: 'Start',
          );
        } else if (data!.getStatus == DownloadTaskStatus.running) {
          return Row(
            children: [
              Text('${data!.progress}%'),
              IconButton(
                onPressed: () => onActionTap?.call(data!),
                constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                icon: const Icon(Icons.pause, color: Colors.yellow),
                tooltip: 'Pause',
              ),
            ],
          );
        } else if (data!.getStatus == DownloadTaskStatus.paused) {
          return Row(
            children: [
              Text('${data!.progress}%'),
              IconButton(
                onPressed: () => onActionTap?.call(data!),
                constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                icon: const Icon(Icons.play_arrow, color: Colors.green),
                tooltip: 'Resume',
              ),
              if (onCancel != null)
                IconButton(
                  onPressed: () => onCancel?.call(data!),
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                  ),
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  tooltip: 'Cancel',
                ),
            ],
          );
        } else if (data!.getStatus == DownloadTaskStatus.complete) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Ready', style: TextStyle(color: Colors.green)),
              IconButton(
                onPressed: () => onActionTap?.call(data!),
                constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                icon: const Icon(Icons.delete),
                tooltip: 'Delete',
              ),
            ],
          );
        } else if (data!.getStatus == DownloadTaskStatus.canceled) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Canceled', style: TextStyle(color: Colors.red)),
              if (onActionTap != null)
                IconButton(
                  onPressed: () => onActionTap?.call(data!),
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                  ),
                  icon: const Icon(Icons.cancel),
                  tooltip: 'Cancel',
                ),
            ],
          );
        } else if (data!.getStatus == DownloadTaskStatus.failed) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Failed', style: TextStyle(color: Colors.red)),
              IconButton(
                onPressed: () => onActionTap?.call(data!),
                constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                icon: const Icon(Icons.refresh, color: Colors.green),
                tooltip: 'Refresh',
              ),
            ],
          );
        } else if (data!.getStatus == DownloadTaskStatus.enqueued) {
          return const Text('Pending', style: TextStyle(color: Colors.orange));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          data!.getStatus == DownloadTaskStatus.complete
              ? () {
                onTap!(data!);
              }
              : null,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: InkWell(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 64,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data!.title!,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          _buildTrailing(),
                          if (data!.getStatus == DownloadTaskStatus.running ||
                              data!.getStatus == DownloadTaskStatus.paused)
                            Text(
                              (data!.progress! / 100).toString(),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
