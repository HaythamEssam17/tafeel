import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helpers/shared.dart';
import '../../../../helpers/shared_texts.dart';
import '../../../../presentation/widgets/common_title_text.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CommonAssetSvgImageWidget(
                imageString: 'no_internet.svg',
                height: 185,
                width: 280,
                fit: BoxFit.fill,
              ),
              getSpaceHeight(16),
              Center(
                child: CommonTitleText(
                  textKey:
                      SharedText.currentLocale == 'ar'
                          ? 'لا يوجد أنترنت '
                          : 'No Internet Connection',
                  textStyle: context.textTheme.headlineMedium!.copyWith(
                    color: AppConstants.lightBlackColor,
                  ),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              getSpaceHeight(8),
              CommonTitleText(
                textKey:
                    SharedText.currentLocale == 'ar'
                        ? 'اتاكد من الانترنت او جرب كمان شوية'
                        : 'Check internet connection or try again later',
                textStyle: context.textTheme.headlineMedium!.copyWith(
                  color: AppConstants.mainTextColor,
                ),
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
