import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/features/home_page/home_page.dart';
import 'package:flutter_img_to_pdf/features/splash_page/splash_page.dart';
import 'package:flutter_img_to_pdf/features/selecting_page/screens/select_image_screen.dart';

import '../../../common/widgets/error.dart';

Route<dynamic> genarateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SelectImageScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SelectImageScreen());
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Something wrong. This page doesn't exist"),
        ),
      );
  }
}
