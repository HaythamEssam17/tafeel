import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/get_downloads_feature/get_downloads_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/get_downloads_feature/get_downloads_states.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/widgets/build_download_list.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_app_bar_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_empty_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/no_permission_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadListHomePage extends StatefulWidget {
  const DownloadListHomePage({super.key});

  @override
  State<DownloadListHomePage> createState() => _DownloadListHomePageState();
}

class _DownloadListHomePageState extends State<DownloadListHomePage> {
  late DownloadFeatureCubit _downloadFeatureCubit;
  late GetDownloadsCubit _getDownloadsCubit;

  @override
  void initState() {
    super.initState();

    _downloadFeatureCubit = BlocProvider.of<DownloadFeatureCubit>(context);
    _getDownloadsCubit = BlocProvider.of<GetDownloadsCubit>(context);

    _getDownloadsCubit.checkStoragePermission();

    _downloadFeatureCubit.init();
  }

  @override
  void dispose() {
    _downloadFeatureCubit.unbindBackgroundIsolate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblAbout,
        ),
      ),
      body: BlocConsumer<GetDownloadsCubit, GetDownloadsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetDownloadsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DownloadFeaturePermissionFailed) {
            return const BuildNoPermissionWidget();
          } else if (state is GetDownloadsFailed) {
            return EmptyScreen(
              imageString: 'imageString',
              titleKey: AppLocalizations.of(context)!.lblTechnicalError,
              imageHeight: 200,
              imageWidth: 84,
              description: state.customError.errorMassage!,
            );
          } else if (state is GetDownloadsSuccess) {
            return BuildDownloadList(
              downloadModels: _getDownloadsCubit.downloads,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
