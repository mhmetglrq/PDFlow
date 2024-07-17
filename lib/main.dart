import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'my_app.dart';

Future main() async {
  await Future.delayed(
    const Duration(seconds: 2),
    () => FlutterNativeSplash.remove(),
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
