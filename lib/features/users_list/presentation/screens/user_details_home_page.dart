import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeal/core/constants/app_constants.dart';
import 'package:tafeal/core/helpers/shared.dart';
import 'package:tafeal/core/presentation/routes/route_argument_model.dart';
import 'package:tafeal/features/users_list/presentation/logic/user_details_cubit/user_details_states.dart';

import '../../../../core/app/app_scaffold_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/l10n/app_localizations.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/presentation/widgets/Images/common_cached_image_widget.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_error_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../logic/user_details_cubit/user_details_cubit.dart';

class UserDetailsHomePage extends StatelessWidget {
  final RouteArgument routeArgument;

  const UserDetailsHomePage({super.key, required this.routeArgument});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        backGroundColor: AppColors.mainColor,
        withAction: false,
        withBack: true,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblUserDetails,
        ),
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: BlocConsumer<UserDetailsCubit, UserDetailsStates>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
            } else if (state is UserDetailsFailed) {
              return CommonError(
                errorMassage: state.error,
                withButton: true,
                onTap:
                    () => context.read<UserDetailsCubit>().getUserDetails(
                      routeArgument.selectedUserId!,
                    ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  getSpaceHeight(AppConstants.padding16),
                  CommonCachedImageWidget(
                    imageUrl:
                        context.read<UserDetailsCubit>().userModel?.avatar ??
                        '',
                    width: 100,
                    height: 100,
                    radius: 100,
                  ),
                  getSpaceHeight(AppConstants.padding16),
                  CommonTitleText(
                    textKey:
                        '${context.read<UserDetailsCubit>().userModel?.firstName} ${context.read<UserDetailsCubit>().userModel?.lastName}',
                    textStyle: TextStyle(
                      color: AppColors.mainTextColor,
                      fontSize: AppConstants.fontSize24,
                    ),
                    maxLines: 3,
                  ),
                  getSpaceHeight(AppConstants.padding16),
                  CommonTitleText(
                    textKey:
                        '${context.read<UserDetailsCubit>().userModel?.email}',
                    textStyle: TextStyle(
                      color: AppColors.lightGrayColor,
                      fontSize: AppConstants.fontSize16,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
