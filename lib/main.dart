import 'package:flutter/material.dart';
import 'package:project/const/colors.dart';
import 'authentication/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Time Project Scenario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brownColor),
      ),
      home: const SplashScreen(),
    );
  }
}
