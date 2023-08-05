import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';
import '../const/colors.dart';
import '../const/styles.dart';
import '../profile/custom.dart';

class FriendDetails extends StatefulWidget {
  const FriendDetails({super.key});

  @override
  State<FriendDetails> createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  List<UserModel> profileList = [];
  UserModel? friendId;
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
    String? userIdData = prefs.getString('profileId');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        friendId =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
      } catch (e) {
        print(e);
      }
    } else {
      friendId;
    }
    return [];
  }

  @override
  void initState() {
    getAllUserData();
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: friendId?.image?.path != ""
                          ? Image(
                              image: FileImage(friendId!.image!),
                              fit: BoxFit.cover,
                            )
                          : const Image(
                              image: NetworkImage(
                                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fiso.500px.com%2Fwp-content%2Fuploads%2F2016%2F05%2Fstock-photo-123002079-1500x1000.jpg&f=1&nofb=1&ipt=3a8ace2a1afa4697e90bff25ac5ed90ec1132af6292a26e7b6e15dc555e8b288&ipo=images"),
                              fit: BoxFit.cover,
                            )),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ))),
                Positioned(
                  left: 120,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 6.0, color: Colors.white),
                    ),
                    child: ClipOval(
                        child: friendId?.image?.path != ""
                            ? Image(
                                height: 100,
                                width: 100,
                                image: FileImage(friendId!.image!),
                                fit: BoxFit.cover,
                              )
                            : const Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    "https://imgs.search.brave.com/eyBWfBl_gk-E_C3l1t9cu58zTKpn24wX9TuMUiARvss/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/aW1uZXBhbC5jb20v/d3AtY29udGVudC91/cGxvYWRzLzIwMTcv/MTEvTmVwYWxpLUFj/dG9yLVN1cGVyc3Rh/ci1SYWplc2gtSGFt/YWwtUGljdHVyZS5q/cGc"),
                                fit: BoxFit.cover,
                              )),
                  ),
                )
              ],
            ),
            const Divider(
              color: brownColor,
              thickness: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  friendId?.fullName != ""
                      ? Text(' Name: ${friendId!.fullName}',
                          style:
                              const TextStyle(fontFamily: bold, fontSize: 16))
                      : const Text('No Name'),
                  const SizedBox(height: 8),
                  friendId?.email != ""
                      ? Text(
                          ' Email: ${friendId!.email}',
                          style: const TextStyle(fontFamily: semibold),
                        )
                      : const Text('No Email'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.person_add_alt_1),
                              SizedBox(width: 8),
                              Text('Add friend')
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.messenger_outline_outlined),
                              SizedBox(width: 8),
                              Text('Message')
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Contract info',
                      style: TextStyle(fontFamily: bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      '${friendId!.mobileNumber}',
                      style: const TextStyle(fontFamily: semibold),
                    ),
                    subtitle: const Text('Mobile'),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Basic info', style: TextStyle(fontFamily: bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.person_2_outlined),
                    ),
                    title: Text(
                      '${friendId!.gender}',
                      style: const TextStyle(fontFamily: semibold),
                    ),
                    subtitle: const Text('Gender'),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.cake),
                    ),
                    title: Text(
                      '${friendId!.dob}',
                      style: const TextStyle(fontFamily: semibold),
                    ),
                    subtitle: const Text('Birthday'),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Relationship',
                      style: TextStyle(fontFamily: bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.favorite_border),
                    ),
                    title: Text(
                      '${friendId!.maritialStatus}',
                      style: const TextStyle(fontFamily: semibold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  const Text('Work', style: TextStyle(fontFamily: bold)),
                  const SizedBox(height: 5),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.work_history_outlined),
                    ),
                    title: Text(
                      'Add Work Experience',
                      style: TextStyle(fontFamily: semibold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
