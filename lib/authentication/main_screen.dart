import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/const/colors.dart';
import 'package:project/feed/home_screen.dart';
import 'package:project/friend/friend.dart';
import 'package:project/market/market_screen.dart';
import 'package:project/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/userModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<UserModel> profileList = [];
  UserModel? loginUsers;
  Future<List<String>> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          profileList = decodedData.map((e) => UserModel.fromJson(e)).toList();
        });
      } catch (e) {
        print("error occure ${e}");
      }
    } else {
      profileList = [];
    }
    return [];
  }

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        loginUsers =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
      } catch (e) {
        print(e);
      }
    } else {
      loginUsers;
    }
    return [];
  }

  @override
  void initState() {
    getAllUserData();
    getUserId();
    super.initState();
  }

  final items = const [
    Icon(Icons.home, size: 30, color: brownColor),
    Icon(Icons.add, size: 30, color: brownColor),
    Icon(Icons.store, size: 30, color: brownColor),
    Icon(Icons.person, size: 30, color: brownColor)
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: lightGolden,
        items: items,
        index: index,
        onTap: (selctedIndex) {
          setState(() {
            index = selctedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 500),
        // animationCurve: ,
      ),
      body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = HomeScreen(loginUsers: loginUsers);
        break;
      case 1:
        widget = FriendScreen(searchList: profileList);
        break;
      case 2:
        widget = const MarketScreen();
        break;
      default:
        widget = ProfileScreen(loginUsers: loginUsers);
        break;
    }
    return widget;
  }
}
