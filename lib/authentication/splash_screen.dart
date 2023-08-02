import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/authentication/login_screen.dart';
import 'package:project/const/colors.dart';
import 'package:project/feed/home_screen.dart';

import '../common_widget/auth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // await AuthHelper.isUserLoggedIn()== true? ;
    Timer(
        const Duration(seconds: 3),
        () => AuthHelper.isUserLoggedIn() == true
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()))
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGolden,
      body: Center(
        child: Image.asset('assets/logo2.png'),
        //  CircleAvatar(
        //   radius: 80,
        //   backgroundImage: AssetImage('assets/logo1.jpg'),
        // ),
      ),
    );
  }
}
//Image.asset('assets/logo.png'),