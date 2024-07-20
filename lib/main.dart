import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'injection_container.dart';
import 'my_app.dart';

Future main() async {
  await Future.delayed(
    const Duration(seconds: 2),
    () => FlutterNativeSplash.remove(),
  );
  await initializeDependencies();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
