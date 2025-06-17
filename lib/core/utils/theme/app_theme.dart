import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class AppTheme {
  static ThemeData arabicTheme() => ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black54,
    ),
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xffFFFFFF)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          /// label large
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.fontSize18,
            color: AppColors.sideHeaderColor,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        textStyle: WidgetStateProperty.all(
          /// label large
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.fontSize18,
            color: AppColors.sideHeaderColor,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(const Color(0xffE57A7A)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize24,
        color: AppColors.sideHeaderColor,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize22,
        color: AppColors.sideHeaderColor,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize18,
        color: AppColors.sideHeaderColor,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: AppConstants.fontSize18,
        color: AppColors.sideHeaderColor,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: Color(0xff2B1B17),
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize14,
        color: AppColors.sideHeaderColor,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize12,
        color: Color(0xff2B1B17),
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConstants.fontSize18,
      ),
      titleMedium: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w500,
        color: AppColors.sideHeaderColor,
      ),
      titleSmall: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w400,
        color: Color(0xff2B1B17),
      ),
      labelSmall: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w300,
        color: Color(0xFF666666),
      ),
    ),
  );

  static ThemeData englishTheme() => ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black54,
    ),
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    fontFamily: 'TheSansArabBold',
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xffFFFFFF)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          /// label large
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.fontSize18,
            color: AppColors.sideHeaderColor,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        textStyle: WidgetStateProperty.all(
          /// label large
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.fontSize18,
            color: AppColors.sideHeaderColor,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(const Color(0xffE57A7A)),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize24,
        color: AppColors.sideHeaderColor,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize22,
        color: AppColors.sideHeaderColor,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize18,
        color: AppColors.sideHeaderColor,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: AppConstants.fontSize18,
        color: AppColors.sideHeaderColor,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: Color(0xff2B1B17),
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize16,
        color: AppColors.sideHeaderColor,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.fontSize14,
        color: AppColors.sideHeaderColor,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppConstants.fontSize12,
        color: Color(0xff2B1B17),
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConstants.fontSize18,
      ),
      titleMedium: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w500,
        color: AppColors.sideHeaderColor,
      ),
      titleSmall: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w400,
        color: Color(0xff2B1B17),
      ),
      labelSmall: TextStyle(
        fontSize: AppConstants.fontSize12,
        fontWeight: FontWeight.w300,
        color: Color(0xFF666666),
      ),
    ),
  );
}
