import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/userModel.dart';
import '../common_widget/auth_helper.dart';
import '../common_widget/textfield.dart';
import '../const/colors.dart';
import '../const/styles.dart';
import 'main_screen.dart';
import 'signup_screen.dart';

List<userModel> usersData = [];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible = true;
  bool value = false;

  Future<void> fetchUserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('dataList');
      //  print(jsonData);

      if (jsonData == null) {
        String? jsonData =
            await rootBundle.loadString('lib/services/user.json');
        final jsonList = json.decode(jsonData);
        print(jsonList);
        if (jsonList is List<dynamic>) {
          usersData = jsonList.map((json) => userModel.fromJson(json)).toList();
        } else if (jsonList is Map<String, dynamic>) {
          usersData.add(userModel.fromJson(jsonList));
        }
        List<Map<String, dynamic>> jsonDataList =
            usersData.map((cv) => cv.toJson()).toList();

        String jsonDataString = json.encode(jsonDataList);
        sharedPreferences.setString('dataList', jsonDataString);
      }
    } catch (e) {
      rethrow;
    }

    // Parse the jsonData from SharedPreferences
  }

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    print("asa${jsonData}");
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          usersData = decodedData.map((e) => userModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      usersData = [];
    }
    return [];
  }

  Future<bool> performLogin(String emaill, String passwordd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // ignore: unused_local_variable
      userModel users = usersData.firstWhere(
        (user) => user.email == emaill && user.password == passwordd,
      );
      prefs.setString('userID', users.id.toString());
      await AuthHelper.setUserLoggedIn();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'Login Sucessfully',
        )),
        backgroundColor: Colors.green,
      ));

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Email or Password Incorrect')),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  TextEditingController emlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
    fetchUserData();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightGolden,
                    ),
                    height: 200,
                    width: double.infinity,
                    child: const Text(
                      'Login Form',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: regular,
                        fontWeight: FontWeight.bold,
                        color: brownColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                      left: 40,
                      top: -10,
                      child: Column(
                        children: [
                          // const SizedBox(height: 12),
                          Image.asset(
                            'assets/logo2.png',
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(height: 12),
              textform(
                  //  keyType:  ,
                  validate: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: emlController,
                  labeltext: 'Email',
                  hint: 'Enter Your Email',
                  prefixIcon: Icons.email),
              const SizedBox(height: 12),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is Empty';
                  }
                  return null;
                },
                obscureText: _isVisible,
                controller: passwordController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: brownColor),
                    labelText: 'Password',
                    labelStyle:
                        const TextStyle(color: Colors.purple, fontSize: 16),
                    hintText: '*******',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              Row(
                children: [
                  Checkbox(
                      value: value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      }),
                  const Text('Remember Me'),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('Forget Password')),
                ],
              ),
              // const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        // login();
                        performLogin(
                            emlController.text, passwordController.text);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'or, create a new account ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
