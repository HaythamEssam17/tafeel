import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_error_widget.dart';
import '../../../../core/presentation/widgets/common_loading_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../logic/terms_and_condition_cubit/terms_and_condition_cubit.dart';
import '../logic/terms_and_condition_cubit/terms_and_condition_states.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final RouteArgument routeArgument;
  const TermsAndConditionsScreen({super.key, required this.routeArgument});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  late TermsAndConditionsCubit termsAndConditionsCubit;

  @override
  void initState() {
    super.initState();
    termsAndConditionsCubit = BlocProvider.of<TermsAndConditionsCubit>(context);
    termsAndConditionsCubit.getTermsAndCondition(
      widget.routeArgument.endPoint!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centerTitle: true,
        titleWidget: CommonTitleText(
          textKey: widget.routeArgument.screenName!,
          textStyle: context.textTheme.headlineMedium!,
        ),
      ),
      body: BlocConsumer<TermsAndConditionsCubit, TermsAndConditionStates>(
        listener:
            (BuildContext termsContext, TermsAndConditionStates termsState) {},
        builder: (
          BuildContext termsContext,
          TermsAndConditionStates termsState,
        ) {
          if (termsState is TermsAndConditionLoadingState) {
            return const CommonLoadingWidget();
          } else if (termsState is TermsAndConditionErrorState) {
            return CommonError(
              withButton: true,
              errorMassage: termsState.error!.errorMassage,
              onTap: () {
                termsAndConditionsCubit.getTermsAndCondition(
                  widget.routeArgument.endPoint!,
                );
              },
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(
                  getWidgetHeight(AppConstants.padding16),
                ),
                child: RichText(
                  text: HTML.toTextSpan(
                    context,
                    termsAndConditionsCubit.termsEntity!.body!,
                    defaultTextStyle: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(
                      color: AppConstants.mainTextColor,
                      fontSize: AppConstants.fontSize16,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
