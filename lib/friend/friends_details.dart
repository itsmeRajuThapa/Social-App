import 'package:project/const/import.dart';

import '../Model/userFriendListModel.dart';

class FriendDetails extends StatefulWidget {
  const FriendDetails({super.key});

  @override
  State<FriendDetails> createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  UserModel? friendId;

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('profileId');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        friendId =
            usersData.firstWhere((user) => user.id.toString() == userIdData);
        print('================friend id: ${friendId?.fullName}');
      } catch (e) {
        print(e);
      }
    } else {
      friendId;
    }
    return [];
  }

  // List<UserFriendListModel> sentRequest = [];
  Future<void> sendRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? jsonString = sharedPreferences.getString('request');
    // // print('Json: ${jsonString}');
    // if (jsonString != null) {
    //   try {
    //     final jsonData = jsonDecode(jsonString) as List<dynamic>;

    //     setState(() {
    //       sentRequest = jsonData
    //           .map((json) => UserFriendListModel.fromJson(json))
    //           .toList();
    //       // print('aaaaa${sentRequest}');
    //     });
    //   } catch (e) {
    //     rethrow;
    //   }
    // } else {
    //   usersDataList = [];
    // }

    // Shared preference

    requestAcceptOrCancle.add(UserFriendListModel(
      user_list_id: const Uuid().v4(),
      createdAt: DateTime.now().toString(),
      hasNewRequest: true,
      friendId: friendId!.id,
      userId: loginUsers!.id,
      hasNewRequestAccepted: false,
      requestedBy: loginUsers!.id,
      hasRemoved: false,
    ));
    List<Map<String, dynamic>> jsonDataList =
        requestAcceptOrCancle.map((add) => add.toJson()).toList();

    String jsonData = json.encode(jsonDataList);
    print('===============new data $jsonData');

    sharedPreferences.setString('request', jsonData);
    getUserData();
  }

  var indexOfIt;

  List<UserFriendListModel> request = [];
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('request');
    //  print(jsonData);

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          request =
              decodedData.map((e) => UserFriendListModel.fromJson(e)).toList();
        });
        indexOfIt = request.indexWhere((e) =>
            e.friendId == friendId!.id &&
            e.requestedBy == loginUsers!.id &&
            e.userId == loginUsers!.id);
      } catch (e) {
        rethrow;
      }
    } else {
      request = [];
    }
    return [];
  }

  Future<void> compare() async {
    try {
      indexOfIt = request.indexWhere((e) =>
          e.friendId == friendId!.id &&
          e.requestedBy == loginUsers!.id &&
          e.userId == loginUsers!.id);
      setState(() async {
        if (indexOfIt != -1) {
          requestAcceptOrCancle.removeAt(indexOfIt);
          String update = jsonEncode(requestAcceptOrCancle);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('request', update);

          getUserData();
        } else {
          print('No Data');
          getUserData();
        }
      });
    } catch (e) {
      return;
    }
    setState(() {});
  }

  void all() async {
    await getUserId();
    await getUserData();
    //compare();
  }

  @override
  void initState() {
    all();
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
                        icon: const Icon(
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
                      // ignore: unrelated_type_equality_checks
                      //   indexOfIt != null?

                      ElevatedButton(
                          onPressed: () {
                            indexOfIt != null ? compare() : sendRequest();
                          },
                          child: Row(
                            children: [
                              Icon(indexOfIt != null
                                  ? Icons.cancel
                                  : Icons.person_add_alt_1),
                              const SizedBox(width: 8),

                              // ? Text('Cancle Request')
                              Text(indexOfIt != null
                                  ? 'Cancle Request'
                                  : 'Add friend')
                            ],
                          )),

                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              compare();
                            });
                          },
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
