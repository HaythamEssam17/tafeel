import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/asset_paths/icon_path.dart';
import '../../../../../helpers/shared.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../../logic/Bottom_Nav_Cubit/bottom_nav_cubit_state.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    /// Pages
    const List<Widget> widgetOptions = <Widget>[];

    return BlocConsumer<BottomNavCubit, BottomNavCubitState>(
      listener: (bottomNavCtx, bottomNavState) {},
      builder: (bottomNavCtx, bottomNavState) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.only(
                  bottom: getWidgetHeight(AppConstants.padding16),
                ) +
                EdgeInsets.symmetric(horizontal: getWidgetWidth(50)),
            child: Container(
              width: getWidgetWidth(272),
              height: getWidgetHeight(50),
              decoration: BoxDecoration(
                color: AppConstants.lightWhiteColor,
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadius24,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.lightBlackColor.withAlpha(8),
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      bottomNavCtx.read<BottomNavCubit>().selectItem(0);
                    },
                    child: SizedBox(
                      width: getWidgetWidth(40),
                      height: getWidgetHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonAssetSvgImageWidget(
                          imageString:
                              bottomNavCtx
                                          .read<BottomNavCubit>()
                                          .selectedIndex ==
                                      0
                                  ? IconPathsSVG.homeActiveIcon
                                  : IconPathsSVG.homeIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bottomNavCtx.read<BottomNavCubit>().selectItem(1);
                    },
                    child: SizedBox(
                      width: getWidgetWidth(40),
                      height: getWidgetHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonAssetSvgImageWidget(
                          imageString:
                              bottomNavCtx
                                          .read<BottomNavCubit>()
                                          .selectedIndex ==
                                      1
                                  ? IconPathsSVG.walletActiveIcon
                                  : IconPathsSVG.walletIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      bottomNavCtx.read<BottomNavCubit>().selectItem(2);
                    },
                    child: SizedBox(
                      width: getWidgetWidth(40),
                      height: getWidgetHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonAssetSvgImageWidget(
                          imageString:
                              bottomNavCtx
                                          .read<BottomNavCubit>()
                                          .selectedIndex ==
                                      2
                                  ? IconPathsSVG.accountActiveIcon
                                  : IconPathsSVG.accountIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: widgetOptions.elementAt(
              bottomNavCtx.read<BottomNavCubit>().selectedIndex,
            ),
          ),
        );
      },
    );
  }
}
