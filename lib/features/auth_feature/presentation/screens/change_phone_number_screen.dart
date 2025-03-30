import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_global_button.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/widget/change_phone_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/custom_bottom_sheet.dart';
import '../../../../core/presentation/widgets/form_input_widgets/phone_form_widget.dart';
import '../logic/phone_cubit/phone_cubit.dart';
import '../logic/phone_cubit/phone_states.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  late PhoneCubit _phoneCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneCubit = BlocProvider.of<PhoneCubit>(context);
    _phoneCubit.initialController();
  }

  @override
  void dispose() {
    _phoneCubit.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblChangeMobileNumber,
          textStyle: context.textTheme.headlineMedium!.copyWith(
            color: AppConstants.sideHeaderColor,
          ),
        ),
      ),
      body: BlocConsumer<PhoneCubit, PhoneStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  getSpaceHeight(32),

                  /// Old Password
                  PhoneFormWidget(
                    phoneController: _phoneCubit.phoneController,
                    checkCurrentPhone: true,
                    phoneOnChanged: (value) {
                      _phoneCubit.checkIsDataValid();
                      return value;
                    },
                    hintKey: AppLocalizations.of(context)!.lblOldPhone,
                  ),
                  getSpaceHeight(AppConstants.padding16),

                  /// New Password
                  PhoneFormWidget(
                    phoneController: _phoneCubit.newPhoneController,
                    phoneOnChanged: (value) {
                      _phoneCubit.checkIsDataValid();
                      return value;
                    },
                    hintKey: AppLocalizations.of(context)!.lblNewPhone,
                  ),
                  getSpaceHeight(330),

                  /// Confirm Button
                  CommonGlobalButton(
                    buttonText: AppLocalizations.of(context)!.lblSaveChanges,
                    onPressedFunction: () {
                      if (formKey.currentState!.validate()) {
                        showBottomModalSheet(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.4,
                          children: [const ChangePhoneBottomSheet()],
                        );
                      }
                    },
                    isEnable: _phoneCubit.isDataValid,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
