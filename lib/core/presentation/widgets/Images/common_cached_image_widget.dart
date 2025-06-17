import 'package:cached_network_image/cached_network_image.dart';
import 'package:tafeal_demo/core/constants/app_constants.dart';
import 'package:tafeal_demo/core/constants/asset_paths/image_paths.dart';
import 'package:tafeal_demo/core/helpers/extensions/double_extensions.dart';
import 'package:flutter/material.dart';

import 'common_asset_image_widget.dart';
import 'common_asset_svg_image_widget.dart';

class CommonCachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? imagePlaceHolder;
  final double width;
  final double height;
  final double? radius;
  final BoxFit? fit;
  final bool? isCircular;
  final bool? isProfile;
  final Color? errorImageColor;
  const CommonCachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.isCircular = false,
    this.isProfile = false,
    this.radius = 0.0,
    this.fit = BoxFit.fill,
    this.imagePlaceHolder,
    this.errorImageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageHeight = height.getWidgetHeight();
    final double imageWidth =
        isCircular! ? height.getWidgetHeight() : width.getWidgetWidth();

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder:
          (context, imageProvider) => Container(
            height: imageHeight,
            width: imageWidth,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius!),
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          ),
      placeholder:
          (context, img) => Container(
            height: imageHeight,
            width: imageWidth,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: AppConstants.mainColor),
            ),
          ),
      errorWidget:
          (context, url, error) =>
              isProfile!
                  ? CommonAssetImageWidget(
                    imageString: ImagePaths.defaultPNGImage,
                    height: imageHeight,
                    width: imageWidth,
                    radius: radius,
                    fit: fit,
                  )
                  : CommonAssetSvgImageWidget(
                    imageString: imagePlaceHolder ?? 'logo_cuted.svg',
                    height: imageHeight,
                    width: imageWidth,
                    fit: fit!,
                    radius: radius!,
                    isCircular: isCircular!,
                    imageColor: errorImageColor,
                  ),
    );
  }
}
