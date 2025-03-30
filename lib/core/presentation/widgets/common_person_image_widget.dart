import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_cached_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/take_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../constants/asset_paths/icon_path.dart';
import '../../helpers/shared.dart';
import 'common_file_image_widget.dart';

class CommonPersonImageWidget extends StatelessWidget {
  final BuildContext context;
  final Function(XFile)? pickPhoto;
  final Function() deletePhoto;
  final XFile? pickedImage;
  final String? cacheImage;
  final bool viewMode;
  final double radius;

  const CommonPersonImageWidget({
    super.key,
    required this.context,
    required this.pickPhoto,
    this.pickedImage,
    this.cacheImage,
    required this.deletePhoto,
    this.viewMode = false,
    this.radius = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (!viewMode) {
              takePhotoBottomSheet(context: context, getPhoto: pickPhoto);
            }
          },
          child: Stack(
            children: [
              Container(
                width: getWidgetHeight(radius),
                height: getWidgetHeight(radius),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.backGroundColor,
                ),
                child:
                    pickedImage != null
                        ? CommonFileImageWidget(
                          imagePath: pickedImage!.path,
                          height: 90,
                          width: 90,
                          radius: 1000,
                          fit: BoxFit.fill,
                        )
                        : viewMode && cacheImage != null
                        ? CommonCachedImageWidget(
                          imageUrl: cacheImage ?? '',
                          height: 90,
                          width: 90,
                          radius: 1000,
                          isCircular: true,
                          isProfile: true,
                        )
                        : const Padding(
                          padding: EdgeInsets.all(25),
                          child: CommonAssetSvgImageWidget(
                            imageString: IconPathsSVG.cameraIcon,
                            imageColor: AppConstants.mainColor,
                            height: 32,
                            width: 32,
                            fit: BoxFit.contain,
                          ),
                        ),
              ),
              !viewMode
                  ? pickedImage == null && cacheImage == null
                      ? const SizedBox()
                      : Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            deletePhoto();
                          },
                          child: Container(
                            height: getWidgetHeight(24),
                            width: getWidgetWidth(24),
                            decoration: const BoxDecoration(
                              color: AppConstants.mainTextColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CommonAssetSvgImageWidget(
                                imageString: IconPathsSVG.binIcon,
                                imageColor: AppConstants.lightWhiteColor,
                                height: 12,
                                width: 12,
                              ),
                            ),
                          ),
                        ),
                      )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
