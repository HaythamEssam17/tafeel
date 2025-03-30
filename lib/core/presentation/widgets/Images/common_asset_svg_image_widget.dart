import 'package:clean_arch_demo_las_version/core/helpers/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAssetSvgImageWidget extends StatelessWidget {
  final String imageString;
  final double height;
  final double width;
  final bool isCircular;
  final Color? imageColor;
  final double radius;
  final BoxFit fit;

  const CommonAssetSvgImageWidget({
    super.key,
    required this.imageString,
    required this.height,
    required this.width,
    this.isCircular = false,
    this.radius = 0.0,
    this.imageColor,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SvgPicture.asset(
        'assets/images/$imageString',
        fit: fit,
        colorFilter:
            imageColor == null
                ? null
                : ColorFilter.mode(imageColor!, BlendMode.srcIn),
        height: height.getWidgetHeight(),
        width: isCircular ? height.getWidgetHeight() : width.getWidgetWidth(),
      ),
    );
  }
}
