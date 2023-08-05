import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/authentication/login_screen.dart';
import 'package:project/authentication/main_screen.dart';
import 'package:project/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var finalEmail;

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
    getValidationData().whenComplete(() {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => finalEmail == null
                  ? const LoginScreen()
                  : const MainScreen())));
    });
  }

  Future getValidationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var optainedEmail = prefs.getString('email');
    setState(() {
      finalEmail = optainedEmail;
    });
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