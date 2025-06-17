import 'package:tafeal_demo/core/constants/asset_paths/image_paths.dart';
import 'package:tafeal_demo/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class LoadingShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;

  const LoadingShimmer({
    Key? key,
    this.radius = AppConstants.padding8,
    this.height = 78,
    this.width = 237,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: CommonAssetImageWidget(
        imageString: ImagePaths.catsImage,
        height: height!,
        width: width!,
        fit: BoxFit.fill,
      ),
    );
  }
}
