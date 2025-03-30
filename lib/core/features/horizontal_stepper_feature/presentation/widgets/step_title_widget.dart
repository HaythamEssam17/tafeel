import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../presentation/widgets/common_title_text.dart';

class StepTitleWidget extends StatelessWidget {
  final String title;

  const StepTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonTitleText(
        textKey: title,
        textStyle: context.textTheme.bodyMedium!,
        textAlign: TextAlign.center,
      ),
    );
  }
}
