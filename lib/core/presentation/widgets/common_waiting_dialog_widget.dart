import 'package:tafeal/core/constants/asset_paths/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:tafeal/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';

Future showWaitingDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false, // Put it False to prevent user from back.
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          contentPadding: EdgeInsets.zero,
          content: CommonAssetSvgImageWidget(
            imageString: ImagePaths.logo,
            height: 78,
            width: 237,
          ),
        ),
      );
    },
  );
}
