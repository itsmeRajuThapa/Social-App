class UserFriendListModel {
  String user_list_id;
  String userId;
  String friendId;
  String requestedBy;
  String createdAt;
  bool hasNewRequest;
  bool hasNewRequestAccepted;
  bool hasRemoved;

  UserFriendListModel({
    required this.user_list_id,
    required this.userId,
    required this.friendId,
    required this.requestedBy,
    required this.createdAt,
    required this.hasNewRequest,
    required this.hasNewRequestAccepted,
    required this.hasRemoved,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_list_id': user_list_id,
      'user_id': userId,
      'friend_id': friendId,
      'requested_by': requestedBy,
      'created_at': createdAt,
      'has_new_request': hasNewRequest,
      'has_new_request_accepted': hasNewRequestAccepted,
      'has_removed': hasRemoved,
    };
  }

  factory UserFriendListModel.fromJson(Map<String, dynamic> json) {
    return UserFriendListModel(
      user_list_id: json['user_list_id'],
      userId: json['user_id'],
      friendId: json['friend_id'],
      requestedBy: json['requested_by'],
      createdAt: json['created_at'],
      hasNewRequest: json['has_new_request'],
      hasNewRequestAccepted: json['has_new_request_accepted'],
      hasRemoved: json['has_removed'],
    );
  }
}

List<UserFriendListModel> requestAcceptOrCancle = [];

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserModel {
//   final int id;
//   final String name;

//   UserModel({
//     required this.id,
//     required this.name,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<UserModel> userList = [];

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userListJson = prefs.getString('userList');
//     if (userListJson != null) {
//       Iterable decoded = jsonDecode(userListJson);
//       setState(() {
//         userList = decoded.map((e) => UserModel.fromJson(e)).toList();
//       });
//     }
//   }

//   Future<void> updateUser(int userId, String newName) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int index = userList.indexWhere((user) => user.id == userId);
//     if (index != -1) {
//       userList[index] = UserModel(id: userId, name: newName);
//       String updatedUserListJson = jsonEncode(userList);
//       await prefs.setString('userList', updatedUserListJson);
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Shared Preferences Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             for (UserModel user in userList)
//               ListTile(
//                 title: Text(user.name),
//                 trailing: ElevatedButton(
//                   onPressed: () => updateUser(user.id, 'Updated Name'),
//                   child: Text('Update'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class User {
//   final int id;
//   final String name;

//   User({required this.id, required this.name});

//   // Convert the object to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }

//   // Create a User object from a JSON map
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       name: json['name'] as String,
//     );
//   }
// }


// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> {
//   List<User> userList = [];

//   @override
//   void initState() {
//     super.initState();
//     getUserListFromSharedPrefs();
//   }

//   Future<void> getUserListFromSharedPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final userListJson = prefs.getString('userList');
//     if (userListJson != null) {
//       final List<dynamic> decodedData = json.decode(userListJson);
//       setState(() {
//         userList = decodedData.map((e) => User.fromJson(e)).toList();
//       });
//     }
//   }

//   Future<void> updateUserInList(User updatedUser) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final updatedUserList = userList.map((user) {
//       if (user.id == updatedUser.id) {
//         return updatedUser;
//       }
//       return user;
//     }).toList();

//     prefs.setString('userList', json.encode(updatedUserList));
//     setState(() {
//       userList = updatedUserList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: ListView.builder(
//         itemCount: userList.length,
//         itemBuilder: (context, index) {
//           final user = userList[index];
//           return ListTile(
//             title: Text(user.name),
//             subtitle: Text('ID: ${user.id}'),
//             trailing: IconButton(
//               icon: Icon(Icons.edit),
//               onPressed: () {
//                 // Here you can update the user's data and call updateUserInList
//                 final updatedUser = User(id: user.id, name: 'Updated ${user.name}');
//                 updateUserInList(updatedUser);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
