import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_empty_widget.dart';
import '../../../../core/presentation/widgets/common_error_widget.dart';
import '../../../../core/presentation/widgets/common_loading_widget.dart';
import '../../../../core/presentation/widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../logic/help_cubit/help_cubit.dart';
import '../logic/help_cubit/help_states.dart';
import '../widget/question_widget.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late HelpCubit helpCubit;

  @override
  void initState() {
    super.initState();
    helpCubit = HelpCubit.get(context);
    helpCubit.questionScrollController = ScrollController();
    helpCubit.questionScrollController.addListener(() {
      helpCubit.setupQuestionScrollController();
    });
    helpCubit.getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        centerTitle: true,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblFAQ,
          textStyle: context.textTheme.headlineMedium!,
        ),
      ),
      body: BlocConsumer<HelpCubit, HelpStates>(
        listener: (helpCtx, helpState) {},
        builder: (helpCtx, helpState) {
          if (helpState is HelpGetQuestionLoadingState) {
            return const CommonLoadingWidget();
          } else if (helpState is HelpGetQuestionFailState) {
            return CommonError(
              withButton: true,
              errorMassage: helpState.error.errorMassage,
              onTap: () {
                helpCubit.getQuestions();
              },
            );
          } else if (helpState is HelpGetQuestionEmptyState) {
            return EmptyScreen(
              imageString: 'empty_vehicle.svg',
              imageHeight: 125,
              imageWidth: 180,
              titleKey: AppLocalizations.of(context)!.lblNoQuestionFound,
            );
          } else {
            return Column(
              children: [
                getSpaceHeight(AppConstants.padding8),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidgetWidth(AppConstants.padding16),
                  ),
                  child: CommonTextFormField(
                    hintKey: AppLocalizations.of(context)!.lblSearchHere,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: CommonAssetSvgImageWidget(
                        imageColor: AppConstants.mainColor,
                        imageString: IconPathsSVG.searchIcon,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    onChanged: (str) {
                      helpCubit.search(str!);
                      return str;
                    },
                  ),
                ),
                getSpaceHeight(AppConstants.padding16),
                if (helpCubit.questionList.isEmpty) ...[
                  EmptyScreen(
                    imageString: "empty_vehicle.svg",
                    imageWidth: 250,
                    imageHeight: 200,
                    titleKey: AppLocalizations.of(context)!.lblNoQuestionFound,
                    withButton: false,
                  ),
                ] else ...[
                  Expanded(
                    child: ListView.separated(
                      controller: helpCubit.questionScrollController,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            getSpaceHeight(AppConstants.padding8),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: AppConstants.sectionSplitterColor,
                            ),
                            getSpaceHeight(AppConstants.padding8),
                          ],
                        );
                      },
                      itemBuilder:
                          (context, index) => Column(
                            children: [
                              QuestionWidget(
                                faqModel: helpCubit.questionList[index],
                              ),
                              if (helpState
                                      is HelpGetMoreQuestionLoadingState &&
                                  helpCubit.questionList.length - 1 == index)
                                const CommonLoadingWidget(),
                            ],
                          ),
                      itemCount: helpCubit.questionList.length,
                    ),
                  ),
                ],
                // Container(
                //   // height: getWidgetHeight(60),
                //   width: SharedText.screenWidth,
                //   decoration: BoxDecoration(
                //     color: AppConstants.lightWhiteColor,
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(AppConstants.borderRadius24),
                //       topRight: Radius.circular(AppConstants.borderRadius24),
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: AppConstants.lightBlackColor.withOpacity(0.08),
                //         blurRadius: 8,
                //         offset: const Offset(0, 0),
                //         spreadRadius: 0,
                //       )
                //     ],
                //   ),
                //   padding:
                //       EdgeInsets.symmetric(vertical: getWidgetHeight(AppConstants.padding24)),
                //   child: Column(children: [
                //     Center(
                //       child: CommonTitleText(
                //         textKey: AppLocalizations.of(context)!.lblQuestionNotFound,
                //         textWeight: FontWeight.w500,
                //         textFontSize: AppConstants.fontSize16,
                //         textColor: AppConstants.appBarTitleColor,
                //       ),
                //     ),
                //     getSpaceHeight(AppConstants.padding8),
                //     CommonGlobalButton(
                //         width: 220,
                //         buttonText: AppLocalizations.of(context)!.lblOpenTicket,
                //         onPressedFunction: () {
                //           context.pushNamed(RouteNames.reasonsHomePageRoute,
                //                RouteArgument(reasonsKey: ReasonKey.ticketReasons,),);
                //         }),
                //   ]),
                // ),
              ],
            );
          }
        },
      ),
    );
  }
}
