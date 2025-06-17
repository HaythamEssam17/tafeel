import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeal/core/app/app_scaffold_page.dart';
import 'package:tafeal/core/constants/app_constants.dart';
import 'package:tafeal/core/helpers/l10n/app_localizations.dart';
import 'package:tafeal/core/helpers/shared.dart';
import 'package:tafeal/core/helpers/shared_texts.dart';
import 'package:tafeal/core/presentation/routes/route_argument_model.dart';
import 'package:tafeal/core/presentation/routes/route_names.dart';
import 'package:tafeal/core/presentation/widgets/Images/common_cached_image_widget.dart';
import 'package:tafeal/core/presentation/widgets/common_app_bar_widget.dart';
import 'package:tafeal/core/presentation/widgets/common_error_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/common_empty_widget.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../../../../core/presentation/widgets/loading_widgets/common_loading_widget.dart';
import '../../../../core/presentation/widgets/loading_widgets/list_loader_widget.dart';
import '../logic/user_details_cubit/user_details_cubit.dart';
import '../logic/users_cubit/user_cubit.dart';
import '../logic/users_cubit/user_states.dart';

class UsersListHomePage extends StatefulWidget {
  const UsersListHomePage({super.key});

  @override
  State<UsersListHomePage> createState() => _UsersListHomePageState();
}

class _UsersListHomePageState extends State<UsersListHomePage> {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();

    _userCubit = BlocProvider.of<UserCubit>(context);

    _userCubit.getUsersList();
    _userCubit.scrollController = ScrollController();
    _userCubit.scrollController.addListener(() {
      _userCubit.setupScrollController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        backGroundColor: AppColors.mainColor,
        withAction: true,
        withBack: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblUsersList,
        ),
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: BlocConsumer<UserCubit, UserStates>(
          builder: (context, state) {
            if (state is UserLoading) {
              return ListLoaderWidget(
                itemCount: 10,
                itemHeight: getWidgetHeight(65),
                itemRadius: AppConstants.borderRadius16,
                padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(8),
                  horizontal: getWidgetWidth(AppConstants.padding16),
                ),
              );
            } else if (state is UserFailed) {
              return CommonError(
                errorMassage: state.error,
                withButton: true,
                onTap: () => _userCubit.getUsersList(),
              );
            } else if (state is UserEmptyState) {
              return EmptyScreen(
                titleKey: AppLocalizations.of(context)!.lblNoUsers,
                imageString: 'empty.svg',
                imageHeight: 125,
                imageWidth: 180,
              );
            }

            return RefreshIndicator(
              color: AppColors.mainColor,
              onRefresh: _userCubit.onRefresh,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                controller: _userCubit.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _userCubit.usersList.length + 1,

                separatorBuilder: (c, i) => getSpaceHeight(0),
                itemBuilder: (context, index) {
                  if (index >= _userCubit.usersList.length &&
                      _userCubit.hasMoreData) {
                    return const CommonLoadingWidget();
                  } else if (index >= _userCubit.usersList.length) {
                    return const SizedBox();
                  } else {
                    bool isOven = index % 2 == 0;

                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<UserDetailsCubit>(
                          context,
                        ).getUserDetails(_userCubit.usersList[index].id!);

                        Navigator.pushNamed(
                          context,
                          RouteNames.userDetailsHomePage,
                          arguments: RouteArgument(
                            selectedUserId: _userCubit.usersList[index].id!,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.padding16,
                          vertical: AppConstants.padding8,
                        ),
                        color:
                            isOven
                                ? AppColors.lightWhiteColor
                                : AppColors.lightGreyColor,
                        child: Row(
                          children: [
                            CommonCachedImageWidget(
                              imageUrl: _userCubit.usersList[index].avatar!,
                              width: 38,
                              height: 38,
                              radius: 100,
                            ),
                            getSpaceWidth(AppConstants.padding16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTitleText(
                                    textKey:
                                        '${_userCubit.usersList[index].firstName} ${_userCubit.usersList[index].lastName}',
                                    textStyle: TextStyle(
                                      color: AppColors.mainTextColor,
                                      fontSize: AppConstants.fontSize18,
                                    ),
                                    maxLines: 3,
                                  ),
                                  CommonTitleText(
                                    textKey:
                                        '${_userCubit.usersList[index].email}',
                                    textStyle: TextStyle(
                                      color: AppColors.lightShadowColor,
                                      fontSize: AppConstants.fontSize12,
                                    ),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
