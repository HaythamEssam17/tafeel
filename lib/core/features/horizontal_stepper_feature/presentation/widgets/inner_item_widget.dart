import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';

class InnerStepperItemWidget extends StatelessWidget {
  final int index;
  final int curStep;

  const InnerStepperItemWidget({
    super.key,
    required this.index,
    required this.curStep,
  });

  @override
  Widget build(BuildContext context) {
    if (index + 1 < curStep) {
      return const Icon(Icons.check, color: Colors.white, size: 16.0);
    } else if (index + 1 == curStep) {
      return Center(
        child: CommonTitleText(
          textKey: '$curStep',
          textStyle: context.textTheme.bodyMedium!,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
