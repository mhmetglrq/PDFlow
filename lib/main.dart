import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/features/splash_page/splash_page.dart';
import 'package:flutter_img_to_pdf/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => genarateRoute(settings),
      theme: ThemeData(
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
        scaffoldBackgroundColor: scaffoldColor,
        textTheme: Theme.of(context).textTheme.copyWith(
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
      ),
      home: const SplashPage(),
    );
  }
}
