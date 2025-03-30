import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../constants/asset_paths/icon_path.dart';
import '../../helpers/shared.dart';
import 'common_title_text.dart';

void takePhotoBottomSheet({
  required BuildContext context,
  Function(XFile)? getPhoto,
  bool multiImage = false,
}) {
  showModalBottomSheet(
    backgroundColor: AppConstants.transparent,
    barrierColor: AppConstants.lightBlackColor.withAlpha(34),
    context: context,
    builder:
        (builderCtx) => Container(
          width: double.infinity,
          height: getWidgetHeight(160),
          decoration: const BoxDecoration(
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.padding16 - 1),
              topLeft: Radius.circular(AppConstants.padding16 - 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSpaceHeight(12),
              Center(
                child: Container(
                  width: getWidgetWidth(65),
                  height: getWidgetHeight(4),
                  color: AppConstants.lightBlackColor,
                ),
              ),
              getSpaceHeight(20),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  pickSingleImage(
                    getImage: getPhoto,
                    source: ImageSource.camera,
                  );
                  builderCtx.pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSpaceWidth(18),
                    const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.cameraIcon,
                      height: 18,
                      width: 20,
                    ),
                    getSpaceWidth(10),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblCamera,
                      textStyle: context.textTheme.displaySmall!,
                    ),
                  ],
                ),
              ),
              getSpaceHeight(15),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  if (multiImage) {
                    pickMultiImage(
                      getImage: getPhoto,
                      source: ImageSource.gallery,
                    );
                  } else {
                    pickSingleImage(
                      getImage: getPhoto,
                      source: ImageSource.gallery,
                    );
                  }
                  builderCtx.pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSpaceWidth(18),
                    const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.galleryIcon,
                      height: 18,
                      width: 20,
                    ),
                    getSpaceWidth(10),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblGallery,
                      textStyle: context.textTheme.displaySmall!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}

void pickSingleImage({
  required Function(XFile)? getImage,
  required ImageSource source,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
    } else {
      getImage!(pickedFile);
    }
  } catch (e) {
    devLog('Error Fetching Image: $e');
  }
}

void pickMultiImage({
  required Function(XFile)? getImage,
  required ImageSource source,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile.isEmpty) {
    } else {
      for (var element in pickedFile) {
        getImage!(element);
      }
    }
  } catch (e) {
    devLog('Error Fetching Image: $e');
  }
}
