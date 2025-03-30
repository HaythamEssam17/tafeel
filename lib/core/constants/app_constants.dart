import 'package:flutter/material.dart';

class AppConstants {
  /// Colors in Light Version ...
  static const Color mainColor = Color(0xff42B979);
  static const Color mainTextColor = Color(0xFF024878);
  static const Color verificationCodeColor = Color(0xFFFBF6F7);
  static const Color textInputColor = Color(0xFF6E6E6E);
  static const Color borderInputColor = Color(0xFFECECEC);
  static const Color lightBlackColor = Color(0xFF000000);
  static const Color lightWhiteColor = Color(0xFFFFFFFF);
  static const Color lightOffBlueColor = Color(0xff22B07D);
  static const Color greenColor = Color(0xff30DE78);
  static const Color lightPurplerColor = Color(0xff7E468D);
  static const Color lightGrayBackgroundColor = Color(0xffF7FDFF);
  static const Color lightGreyColor = Color(0xffDADADA);
  static const Color starRatingColor = Color(0xffFFC73B);
  static const Color darkFieldColor = Color(0XFF2F2F2F);
  static const Color darkTextColor = Color(0XFFEDEDED);
  static const Color backGroundColor = Color(0xFFFFF8F5);
  static const Color loaderBackGroundColor = Color(0xFFCFCCCC);
  static const Color successColor = Color(0XFF16A085);
  static const Color lightOrangColor = Color(0XFFFFF5EB);
  static const Color sideHeaderColor = Color(0xff024978);
  static const Color sideHeaderTextColor = Color(0xff42B979);
  static const Color sideSplitterColor = Color(0xFFD9D9D9);
  static const Color sectionSplitterColor = Color(0xFFECECEC);
  static const Color sectionUserDataColor = Color(0xFFFBFFFD);
  static const Color lightGrayColor = Color(0xFF82858A);
  static const Color addressBGColor = Color(0xFFF5F9FB);
  static const Color reSendColor = Color(0xffd0cdcd);
  static const Color lightRedColor = Color(0xFFD61003);
  static const Color warningColor = Color(0xFFF73C2C);
  static const Color logOutColor = Color(0xFFFF0000);
  static const Color lightOpacityRedColor = Color(0xFFFCF5F5);
  static const Color lightBlueColor = Color(0xFF3243CD);
  static const Color lightShadowColor = Color(0xFF2E2E2E);
  static const Color lightBorderColor = Color(0xFFAEAEAE);
  static const Color lightContentColor = Color(0xFF8A8895);
  static const Color lightGreyTextColor = Color(0xFFF3F3F3);
  static const Color lightOrangeColor = Color(0xFFff8204);
  static const Color greyColor = Color(0xffA8A8A8);
  static const Color lightSecondShadowColor = Color(0xffDADADA);
  static const Color lightShadowSecColor = Color(0xffF5F6F7);
  static const Color lightGrayShadowColor = Color(0xffAAAAAA);
  static const Color arrowIconColor = Color(0xff262626);
  static const Color transparent = Colors.transparent;
  static const Color lightGreyBackGround = Color(0xffF7F7F7);
  static const Color lightTextColor = Color(0xFF1F1F1F);
  static const Color lightButtonGrayColor = Color(0xFFF4F6F5);
  static const Color formFillColor = Color(0xFFE0EFE9);
  static const Color shadowColor = Color(0x26000000);
  static const Color dividerColor = Color(0x1F1F1F26);
  static const Color lightGray = Color(0xFF888888);
  static const Color lightShadowGray = Color(0x7F1E1E1E);
  static const Color lightTextGray = Color(0xff1E1E1E);
  static const Color reasonsLightGreyColor = Color(0xff6F6F6F);
  static const Color transactionGateGreyColor = Color(0xff525252);
  static const Color hintColor = Color(0xffA9A9A9);
  static const Color backArrowColor = Color(0xffFCFFFD);
  static const Color appBarTitleColor = Color(0xff024978);
  static const Color howToUseColor = Color(0x147BADCE);
  static const Color orangeColor = Color(0xFFFB6900);
  static const Color lightPurpler = Color(0xFFFEFAFA);
  static const Color negativePurplerColor = Color(0xFFD71004);
  static const Color dateRangeBGColor = Color(0xFFf5f9fb);
  static const Color test = Color(0xFF333333);

  ///chat colors
  static const Color chatTextColor = Color(0XFF12004C);
  static const Color onlineGreenColor = Color(0XFF2AD750);
  static const Color audioBGColor = Color(0xFF303030);
  static const Color gradientColor = Color(0xFF68CBFF);

  static Color fetchUnReadCheckColor(bool isMe) => isMe ? lightGrayColor : audioBGColor;

  static Color fetchReadedCheckColor(bool isMe) => isMe ? lightGrayColor : mainColor;

  /// Colors in Dark Version ...
  static const Color darkOffWhiteColor = Color(0XFFF6F6F6);
  static const Color darkBackgroundWidgetsColor = Color(0xFF212121);

  /// Font Sizes
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize24 = 24.0;

  /// Border Radius
  static const double borderRadius4 = 4.0;
  static const double borderRadius6 = 6.0;
  static const double borderRadius8 = 8.0;
  static const double borderRadius10 = 10.0;
  static const double borderRadius14 = 14.0;
  static const double borderRadius15 = 15.0;
  static const double borderRadius16 = 16.0;
  static const double borderRadius18 = 18.0;
  static const double borderRadius20 = 20.0;
  static const double borderRadius24 = 24.0;
  static const double borderRadius25 = 25.0;
  static const double borderRadius28 = 28.0;
  static const double borderRadius40 = 40.0;

  /// Page Padding
  static const double padding2 = 2.0;
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding24 = 24.0;

  /// Length
  static const int phoneLength = 11;
  static const int passwordMinLength = 8;

  /// Animation
  static const int fieldAnimationMilliseconds = 2000;
  static const int imageAnimationMilliseconds = 2000;
  static const int minBalanceAdd = 0;

  /// Const Strings
  static const String appName = '';
  static const String countryCode = '+2';
  static const String downloadSendPort = 'downloader_send_port';
}
