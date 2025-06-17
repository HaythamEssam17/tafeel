import 'package:tafeal/core/helpers/extensions/double_extensions.dart';
import 'package:flutter/material.dart';

class CommonAssetImageWidget extends StatelessWidget {
  final String imageString;
  final double height;
  final double width;
  final Color? imageColor;
  final double? radius;

  final BoxFit? fit;

  final Function()? onTapImage;

  const CommonAssetImageWidget({
    Key? key,
    required this.imageString,
    required this.height,
    required this.width,
    this.imageColor,
    this.radius = 0.0,
    this.fit = BoxFit.contain,
    this.onTapImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.asset(
          'assets/images/$imageString',
          fit: fit,
          color: imageColor,
          height: height.getWidgetHeight(),
          width: width.getWidgetWidth(),
        ),
      ),
    );
  }
}
