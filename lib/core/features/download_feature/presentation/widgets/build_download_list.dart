import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../../../presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../data/models/download_model.dart';
import '../cubit/download_feature_cubit.dart';
import 'download_list_item.dart';

class BuildDownloadList extends StatelessWidget {
  final List<DownloadModel>? downloadModels;

  const BuildDownloadList({super.key, this.downloadModels});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadFeatureCubit, DownloadFeatureState>(
      listener: (context, state) {
        if (state is DownloadFeatureStarted) {
          showSnackBar(
            context: context,
            title: 'Started...',
          );
        } else if (state is DownloadFeatureCompleted) {
          showSnackBar(
            context: context,
            title: 'Completed...',
          );
        } else if (state is DownloadFeaturePaused) {
          showSnackBar(
            context: context,
            title: 'Paused...',
            color: AppConstants.lightOrangeColor,
          );
        } else if (state is DownloadFeatureFailed) {
          showSnackBar(
            context: context,
            title: '${state.error}...',
            color: AppConstants.lightOrangeColor,
          );
        }
      },
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            ...downloadModels!.map(
              (item) {
                return DownloadListItem(
                  data: item,
                  onTap: (task) async {
                    await context.read<DownloadFeatureCubit>().openDownloadedFile(task).then(
                      (value) {
                        if (!value) {
                          showSnackBar(
                            context: context,
                            title: 'Cannot open this file',
                            color: AppConstants.lightRedColor,
                          );
                        }
                      },
                    );
                  },
                  onActionTap: (task) {
                    context.read<DownloadFeatureCubit>().selectedDownloadModel = task;

                    if (task.status == DownloadTaskStatus.undefined) {
                      context.read<DownloadFeatureCubit>().requestDownload();
                    } else if (task.status == DownloadTaskStatus.running) {
                      context.read<DownloadFeatureCubit>().pauseDownload();
                    } else if (task.status == DownloadTaskStatus.paused) {
                      context.read<DownloadFeatureCubit>().resumeDownload();
                    } else if (task.status == DownloadTaskStatus.complete ||
                        task.status == DownloadTaskStatus.canceled) {
                      context.read<DownloadFeatureCubit>().delete(task);
                    } else if (task.status == DownloadTaskStatus.failed) {
                      context.read<DownloadFeatureCubit>().retryDownload();
                    }
                  },
                  onCancel: context.read<DownloadFeatureCubit>().delete,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
