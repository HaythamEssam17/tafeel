import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../core/constants/enums/exception_enums.dart';
import '../../../../core/features/bottom_nav/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/routes/route_argument_model.dart';
import '../../../../core/presentation/routes/route_names.dart';
import '../../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/widgets/common_global_button.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';
import '../logic/login_cubit/login_cubit.dart';
import '../logic/otp_cubit/otp_cubit.dart';
import '../logic/otp_cubit/otp_states.dart';
import '../logic/timer_cubit/timer_cubit.dart';
import '../logic/timer_cubit/timer_states.dart';

class VerificationCodeScreen extends StatefulWidget {
  final RouteArgument routeArgument;

  const VerificationCodeScreen({super.key, required this.routeArgument});

  @override
  State<StatefulWidget> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late TextEditingController otpController;
  String? otp;
  String? otpError;
  late OtpCubit _otpCubit;
  late TimerCubit _timerCubit;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    _otpCubit = OtpCubit.get(context);
    _timerCubit = TimerCubit.get(context);
    _otpCubit.resetState();
    if (widget.routeArgument.otp == null) {
      _otpCubit.resendOTP(userCredential: widget.routeArgument.userCredential!);
    } else {
      otp = widget.routeArgument.otp;
    }
    _timerCubit.startTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timerCubit.stopTimer();
    super.dispose();
  }

  bool canBack() {
    if (widget.routeArgument.sourcePage == "change-phone") {
      context.pushNamedAndRemoveUntil(RouteNames.loginHomePageRoute);

      BlocProvider.of<LoginCubit>(context).silentLogOut();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: CommonAppBar(
        withBack: true,
        onBackPressed:
            widget.routeArgument.sourcePage == "change-phone"
                ? () {
                  context.pushNamedAndRemoveUntil(
                    RouteNames.loginHomePageRoute,
                  );

                  BlocProvider.of<LoginCubit>(context).silentLogOut();
                }
                : null,
      ),
      body: PopScope(
        canPop: canBack(),
        child: BlocConsumer<OtpCubit, OtpStates>(
          listener: (otpCtx, otpState) {
            if (otpState is OtpSuccessState) {
              if (widget.routeArgument.sourcePage == "forget") {
                otpCtx.pushReplacementNamed(
                  RouteNames.newPasswordPageRoute,
                  RouteArgument(
                    otp: otpController.text,
                    userCredential: widget.routeArgument.userCredential!,
                  ),
                );
              } else if (widget.routeArgument.sourcePage == "change-phone") {
                checkUserAuth(
                  context: context,
                  errorType: CustomStatusCodeErrorType.unVerified,
                );
              } else {
                BottomNavCubit.get(context).selectItem(0);
                otpCtx.pushNamedAndRemoveUntil(
                  RouteNames.mainBottomNavPageRoute,
                );
              }
            } else if (otpState is ResendOtpSuccessState) {
              otp = otpState.otp;
            } else if (otpState is OtpErrorState) {
              otpError = otpState.error!.errorMassage;
            }
          },
          builder: (otpCtx, otpState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding16,
                  ) +
                  EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSpaceHeight(AppConstants.padding24),
                    const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.logoCarCheckIcon,
                      height: 72,
                      width: 106,
                    ),
                    getSpaceHeight(AppConstants.padding16),

                    ///title
                    CommonTitleText(
                      textKey:
                          "${AppLocalizations.of(otpCtx)!.lblVerifyPhone}  ${otp ?? ""}",
                      textStyle: context.textTheme.bodyMedium,
                    ),

                    ///spacer
                    getSpaceHeight(AppConstants.padding8),

                    ///sub title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(
                                context,
                              )!.lblEnterVerificationCode,
                          textStyle: context.textTheme.bodyMedium,
                        ),
                        getSpaceWidth(AppConstants.padding4),
                        CommonTitleText(
                          textKey: "+2${widget.routeArgument.userCredential}",
                          textStyle: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    ///spacer
                    getSpaceHeight(AppConstants.padding8),

                    /// OTP
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(20),
                      ),
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        textStyle: const TextStyle(
                          color: AppConstants.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                        length: 6,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        hintCharacter: '',
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius24,
                          ),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          borderWidth: 1,
                          activeFillColor: AppConstants.lightWhiteColor,
                          inactiveColor: AppConstants.borderInputColor,
                          selectedColor: AppConstants.borderInputColor,
                          activeColor: AppConstants.borderInputColor,
                          inactiveFillColor: AppConstants.lightWhiteColor,
                          selectedFillColor: AppConstants.lightWhiteColor,
                          activeBoxShadow: [
                            const BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                          inActiveBoxShadow: [
                            const BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        controller: otpController,
                        enablePinAutofill: true,
                        onCompleted: (v) {},
                        onChanged: (value) {
                          _otpCubit.resetState();
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: otpCtx,
                      ),
                    ),

                    if (otpError != null) ...[
                      Center(
                        child: CommonTitleText(
                          textKey:
                              otpError ??
                              AppLocalizations.of(context)!.lblWrongHappen,
                          textStyle: context.textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppConstants.lightRedColor,
                          ),
                        ),
                      ),

                      ///spacer
                      getSpaceHeight(AppConstants.padding16),
                    ],

                    /// Resend code
                    BlocConsumer<TimerCubit, TimerStates>(
                      listener: (timerCtx, timerState) {},
                      builder:
                          (timerCtx, timerState) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonTitleText(
                                    textKey:
                                        AppLocalizations.of(
                                          context,
                                        )!.lblResendVerificationCode,
                                    textStyle: context.textTheme.bodyMedium!
                                        .copyWith(
                                          color: AppConstants.lightGrayColor,
                                        ),
                                  ),
                                  getSpaceWidth(4),
                                  CommonTitleText(
                                    textKey:
                                        "${_timerCubit.time} ${AppLocalizations.of(context)!.lblSecond}",
                                    textStyle: context.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              getSpaceHeight(AppConstants.padding4),
                              GestureDetector(
                                onTap: () {
                                  if (_timerCubit.time == 0) {
                                    if (otpState is! OtpLoadingState) {
                                      otpError = null;
                                      if (_timerCubit.time > 0) {
                                      } else {
                                        _otpCubit.resendOTP(
                                          userCredential:
                                              widget
                                                  .routeArgument
                                                  .userCredential!,
                                        );
                                        _timerCubit.time = 59;
                                        _timerCubit.startTimer();
                                        otpController.clear();
                                      }
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTitleText(
                                      textKey:
                                          AppLocalizations.of(
                                            context,
                                          )!.lblDontRecieveCode,
                                      textStyle: context.textTheme.bodyMedium!
                                          .copyWith(
                                            color: AppConstants.reSendColor,
                                          ),
                                    ),
                                    CommonTitleText(
                                      textKey:
                                          AppLocalizations.of(
                                            context,
                                          )!.lblResend,
                                      textStyle: context.textTheme.bodyMedium!
                                          .copyWith(
                                            color:
                                                _timerCubit.time == 0
                                                    ? AppConstants.mainColor
                                                    : AppConstants.reSendColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ),

                    getSpaceHeight(200),

                    CommonGlobalButton(
                      isEnable: otpController.text.length == 6,
                      isLoading:
                          otpState is OtpLoadingState ||
                          otpState is ResendOtpLoadingState,
                      buttonText: AppLocalizations.of(otpCtx)!.lblConfirm,
                      onPressedFunction: () {
                        if (widget.routeArgument.sourcePage == "forget") {
                          _otpCubit.checkOtp(
                            userCredential:
                                widget.routeArgument.userCredential!,
                            otp: otpController.text,
                          );
                        } else {
                          _otpCubit.verifyAccount(
                            userCredential:
                                widget.routeArgument.userCredential!,
                            otp: otpController.text,
                          );
                        }
                      },
                    ),

                    ///spacer
                    getSpaceHeight(50),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
