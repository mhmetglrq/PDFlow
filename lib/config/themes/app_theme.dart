import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../items/colors/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      centerTitle: true,
      titleTextStyle: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          color: Color(0xFF373A42),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          color: Color(0xFF373A42),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      bodyMedium: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          color: Color(0xFF373A42),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      headlineMedium: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          color: Color(0xFF373A42),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),
  );

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
