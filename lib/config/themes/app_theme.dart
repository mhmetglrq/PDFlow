import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/config/extensions/context_extension.dart';

import '../items/colors/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      fontFamily: "Urbanist",
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.scaffoldBgColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBgColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.05),
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.045),
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.04),
        ),
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.05),
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.035),
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.03),
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.05),
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.04),
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.dynamicHeight(0.035),
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.04),
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.03),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.025),
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.04),
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.03),
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.dynamicHeight(0.025),
        ),
      ),
    );
  }

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
  );
}
