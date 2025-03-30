import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../Domain/model/faq_model.dart';

class QuestionWidget extends StatefulWidget {
  final FAQModel faqModel;
  const QuestionWidget({super.key, required this.faqModel});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getWidgetWidth(AppConstants.padding16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonTitleText(
                    textKey: widget.faqModel.question,
                    textStyle: context.textTheme.headlineMedium!,
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppConstants.reasonsLightGreyColor,
                ),
              ],
            ),
          ),
          if (isOpen) ...[
            getSpaceHeight(AppConstants.padding8),
            CommonTitleText(
              textKey: widget.faqModel.answer,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                color: AppConstants.textInputColor,
              ),
              maxLines: 3,
            ),
            getSpaceHeight(AppConstants.padding8),
          ],
        ],
      ),
    );
  }
}
