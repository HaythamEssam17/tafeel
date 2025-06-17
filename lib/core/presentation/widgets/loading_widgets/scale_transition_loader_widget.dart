import 'package:tafeal/core/constants/asset_paths/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:tafeal/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';

import '../../../constants/app_constants.dart';

class LoadingShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;

  const LoadingShimmer({
    super.key,
    this.radius = AppConstants.padding8,
    this.height = 78,
    this.width = 237,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: CommonAssetSvgImageWidget(
        imageString: ImagePaths.logo,
        height: height!,
        width: width!,
        fit: BoxFit.fill,
      ),
    );
  }
}
