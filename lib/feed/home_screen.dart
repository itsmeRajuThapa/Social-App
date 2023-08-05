import 'package:flutter/material.dart';
import 'package:project/Model/userModel.dart';
import 'package:project/const/styles.dart';
import '../const/colors.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? loginUsers;
  const HomeScreen({super.key, required this.loginUsers});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGolden,
        title: const Text("CAN WE TALK",
            style: TextStyle(
                fontFamily: bold,
                color: brownColor,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  //  border: Border.all(width: 6.0, color: Colors.white),
                ),
                child: ClipOval(
                    child: widget.loginUsers!.image!.path != ""
                        ? Image(
                            height: 50,
                            width: 50,
                            image: FileImage(widget.loginUsers!.image!),
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            height: 50,
                            width: 50,
                            image: AssetImage("assets/logo1.jpg"),
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
