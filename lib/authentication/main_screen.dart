import 'package:flutter/material.dart';
import 'package:project/authentication/login_screen.dart';
import 'package:project/const/styles.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/const/colors.dart';
import 'package:project/feed/home_screen.dart';
import 'package:project/friend/friend.dart';
import 'package:project/market/market_screen.dart';
import 'package:project/profile/profile_screen.dart';

import '../common_widget/auth_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final items = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.add,
      size: 30,
    ),
    Icon(
      Icons.store,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    )
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGolden,
        title: const Text(
          'CAN  WE  TALK',
          style: TextStyle(
              fontFamily: regular,
              fontWeight: FontWeight.bold,
              color: brownColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // Simulate user logout
                await AuthHelper.setUserLoggedOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
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
        animationDuration: const Duration(milliseconds: 300),
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
        widget = const HomeScreen();
        break;
      case 1:
        widget = const FriendScreen();
        break;
      case 2:
        widget = const MarketScreen();
        break;
      default:
        widget = const ProfileScreen();
        break;
    }
    return widget;
  }
}
