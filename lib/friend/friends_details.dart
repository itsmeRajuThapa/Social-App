import 'package:project/const/import.dart';

import '../Model/userFriendListModel.dart';

class FriendDetails extends StatefulWidget {
  const FriendDetails({super.key});

  @override
  State<FriendDetails> createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  List<UserModel> profileList = [];
  UserModel? friendId;
  UserModel? ownId;
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

  Future<List<String>> getOwneId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        ownId =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
      } catch (e) {
        print(e);
      }
    } else {
      ownId;
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

  Map<String, dynamic> requestEmptyList = {};
  List<UserFriendListModel> sentRequest = [];
  void sendRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('request');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          requestAcceptOrCancle = jsonData
              .map((json) => UserFriendListModel.fromJson(json))
              .toList();
        } else if (jsonData is Map<String, dynamic>) {
          requestEmptyList
              .addAll(UserModel.fromJson(jsonData) as Map<String, dynamic>);
        }
      } catch (e) {
        rethrow;
      }
    }
    // Shared preference

    requestAcceptOrCancle.add(UserFriendListModel(
      user_list_id: const Uuid().v4(),
      createdAt: DateTime.now().toString(),
      hasNewRequest: true,
      friendId: friendId!.id,
      userId: ownId!.id,
      hasNewRequestAccepted: false,
      requestedBy: ownId!.id,
      hasRemoved: false,
    ));
    List<Map<String, dynamic>> jsonDataList =
        requestAcceptOrCancle.map((cv) => cv.toJson()).toList();

    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('request', jsonData);
  }

  UserFriendListModel? friendji;
  void compare() {
    friendji =
        requestAcceptOrCancle.firstWhere((e) => e.friendId == friendId!.id);
  }

  @override
  void initState() {
    getAllUserData();
    getUserId();
    sendRequest();
    //compare();
    super.initState();
  }

  bool newRequest = true;

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
                          : Image(
                              image: AssetImage('${friendId!.imageUrl}'),
                              fit: BoxFit.cover,
                            )),
                ),
                Positioned(
                    top: 15,
                    left: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()));
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
                            : Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('${friendId!.imageUrl}'),
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
                          onPressed: () {
                            setState(() {
                              sendRequest();
                            });
                          },
                          child: Row(
                            children: [
                              // Icon(Icons.person_add_alt_1),
                              // SizedBox(width: 8),
                              // friendji?.hasNewRequest == false
                              //     ? Text('Cancle Request')
                              //     : Text('Add friend')
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
