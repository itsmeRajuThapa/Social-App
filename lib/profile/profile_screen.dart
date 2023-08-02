import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../Model/userModel.dart';
import '../const/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<userModel> profileList = [];
  userModel? loginUsers;
  Future<List<String>> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          profileList = decodedData.map((e) => userModel.fromJson(e)).toList();
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
        print(loginUsers?.fullName);
      } catch (e) {
        print(e);
      }
    } else {
      loginUsers;
      print(loginUsers!.email);
    }
    return [];
  }

  @override
  void initState() {
    super.initState();

    getAllUserData();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: loginUsers != null &&
                        loginUsers!.image != null &&
                        loginUsers!.image != ""
                    ? CircleAvatar(
                        backgroundColor: lightGolden,
                        radius: 50,
                        backgroundImage: FileImage(loginUsers!.image!),
                      )
                    : const Text('No Image')),
            title: loginUsers != null &&
                    loginUsers!.fullName != null &&
                    loginUsers!.fullName != ""
                ? Text('${loginUsers!.fullName}')
                : Text('No Name'),
            subtitle: loginUsers != null &&
                    loginUsers!.email != null &&
                    loginUsers!.email != ""
                ? Text('${loginUsers!.email}')
                : Text('No Email'),
          ),
        ],
      ),
    );
  }
}
