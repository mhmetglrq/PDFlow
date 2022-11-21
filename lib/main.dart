import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/features/home_page/home_page.dart';
import 'package:flutter_img_to_pdf/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
        scaffoldBackgroundColor: const Color(0xFFCFD0CE),
      ),
      home: const HomePage(),
    );
  }
}
