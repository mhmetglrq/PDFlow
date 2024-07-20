// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import '../../features/pdflow/presentation/pages/home/home.dart';
import '../../features/pdflow/presentation/pages/pdf/select_image.dart';
import '../../features/pdflow/presentation/pages/pdf/take_picture.dart';
import '../../features/pdflow/presentation/pages/onboarding/onboarding.dart';
import '../../features/pdflow/presentation/widgets/error.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return _materialRoute(const Home());
      case RouteNames.takePicture:
        return _materialRoute(const TakePicture());
      case RouteNames.selectImage:
        return _materialRoute(const SelectImage());
      case RouteNames.onboarding:
        return _materialRoute(const Onboarding());
      default:
        return _materialRoute(const Scaffold(
            body: ErrorScreen(
                error: "Something wrong. This page doesn't exist")));
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> _slideRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: end,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _fadeRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _scaleRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _rotateRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _sizeRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
    );
  }
}
