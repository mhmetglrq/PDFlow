import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/features/splash_page/splash_page.dart';
import 'package:flutter_img_to_pdf/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';

Future main() async {
  await Future.delayed(
      const Duration(seconds: 2), () => FlutterNativeSplash.remove());
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
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
