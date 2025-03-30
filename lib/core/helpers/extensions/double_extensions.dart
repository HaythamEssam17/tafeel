import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';

extension DoubleExtensions on double {
  double getWidgetHeight() {
    return SharedText.screenHeight * (this / SharedText.designHeight);
  }

  double getWidgetWidth() {
    return SharedText.screenWidth * (this / SharedText.designWidth);
  }
}
