import 'package:project/const/styles.dart';
import 'package:project/profile/custom.dart';
import 'package:flutter/material.dart';
import '../Model/userModel.dart';
import '../const/colors.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel? loginUsers;
  const ProfileScreen({super.key, required this.loginUsers});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                      child: widget.loginUsers?.image?.path != ""
                          ? Image(
                              image: FileImage(widget.loginUsers!.image!),
                              fit: BoxFit.cover,
                            )
                          : const Image(
                              image: NetworkImage(
                                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fiso.500px.com%2Fwp-content%2Fuploads%2F2016%2F05%2Fstock-photo-123002079-1500x1000.jpg&f=1&nofb=1&ipt=3a8ace2a1afa4697e90bff25ac5ed90ec1132af6292a26e7b6e15dc555e8b288&ipo=images"),
                              fit: BoxFit.cover,
                            )),
                ),
                Positioned(
                  left: 120,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 6.0, color: Colors.white),
                    ),
                    child: ClipOval(
                        child: widget.loginUsers?.image?.path != ""
                            ? Image(
                                height: 100,
                                width: 100,
                                image: FileImage(widget.loginUsers!.image!),
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
                  widget.loginUsers?.fullName != ""
                      ? Text(' Name: ${widget.loginUsers!.fullName}',
                          style:
                              const TextStyle(fontFamily: bold, fontSize: 16))
                      : const Text('No Name'),
                  const SizedBox(height: 8),
                  widget.loginUsers?.email != ""
                      ? Text(
                          ' Email: ${widget.loginUsers!.email}',
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
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Text('Add to story')
                            ],
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit profile')
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
                      '${widget.loginUsers!.mobileNumber}',
                      style: const TextStyle(fontFamily: semibold),
                    ),
                    subtitle: Text('Mobile'),
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
                      '${widget.loginUsers!.gender}',
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
                      '${widget.loginUsers!.dob}',
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
                      '${widget.loginUsers!.maritialStatus}',
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
