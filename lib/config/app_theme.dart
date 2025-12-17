
import 'package:educube1/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import '../const/app_colors.dart';


ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.kPrimaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.kPrimaryColor,
        brightness: Brightness.dark,
        background: Colors.white,
        secondary: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    buttonTheme: _buttonThemeData(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
        color: AppColors.kPrimaryColor,
        fontSize: 34.fontMultiplier,
        fontWeight: FontWeight.w900,
        fontFamily: 'Poppins'),
    displayMedium: TextStyle(
        color: AppColors.kPrimaryColor,
        fontSize: 24.fontMultiplier,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'),
    displaySmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 26.fontMultiplier,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins'),
    headlineLarge: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 12.fontMultiplier,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    headlineMedium: TextStyle(
        color:  AppColors.colorTextPrimary,
        fontSize: 17.fontMultiplier,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    headlineSmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 12.fontMultiplier,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    titleLarge: TextStyle(
        color: AppColors.colorD9,
          fontSize: 12.fontMultiplier,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    titleMedium: TextStyle(
        color: AppColors.colorD9,
         fontSize: 12.fontMultiplier,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    titleSmall: TextStyle(
        color: AppColors.colorD9,
        fontSize: 12.fontMultiplier,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'),
    bodyMedium:  TextStyle(
        color: AppColors.colorTextPrimary, fontFamily: 'Poppins'),
    bodySmall:  TextStyle(
        color: AppColors.colorTextPrimary, fontFamily: 'Poppins'),
    labelLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 15.fontMultiplier,
      fontFamily: 'Poppins',
    ),

    labelSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 13.fontMultiplier,
      fontFamily: 'Poppins',
    ),

  );

}

ButtonThemeData _buttonThemeData() {
  return ButtonThemeData(
    buttonColor: AppColors.kPrimaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  );
}
