import 'package:flutter/material.dart';
import 'package:project/const/colors.dart';
import 'package:project/const/styles.dart';
import '../Model/userModel.dart';
import 'search_screen.dart';

class FriendScreen extends StatefulWidget {
  final List<UserModel> searchList;

  const FriendScreen({super.key, required this.searchList});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.people,
          color: brownColor,
        ),
        backgroundColor: lightGolden,
        title: const Text('Friend',
            style: TextStyle(fontFamily: semibold, color: brownColor)),
        actions: [
          TextButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(widget.searchList),
                );
              },
              child: const Row(
                children: [Icon(Icons.search), Text('Search')],
              ))
        ],
      ),
    );
  }
}
