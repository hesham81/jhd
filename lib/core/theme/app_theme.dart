import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      backgroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.secondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
