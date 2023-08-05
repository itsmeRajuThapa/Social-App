import 'package:flutter/material.dart';
import 'package:project/friend/friends_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<UserModel> searchList;

  CustomSearchDelegate(this.searchList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModel> matchQuery = searchList.where((user) {
      return user.fullName!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendDetails()));
          },
          child: Card(
            color: const Color.fromARGB(255, 246, 211, 211),
            child: ListTile(
              title: Text('${result.fullName}'),
              leading: ClipOval(
                  child: result.image?.path != ""
                      ? Image(
                          height: 60,
                          width: 60,
                          image: FileImage(result.image!),
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          height: 60,
                          width: 60,
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover,
                        )),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> matchQuery = searchList.where((user) {
      return user.fullName!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendDetails()));
          },
          child: Card(
            color: const Color.fromARGB(255, 246, 211, 211),
            child: ListTile(
              title: Text('${result.fullName}'),
              leading: CircleAvatar(
                  // backgroundColor: textfieldGrey,
                  child: result.image?.path != ""
                      ? Image(
                          height: 80,
                          width: 80,
                          image: FileImage(result.image!),
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          height: 80,
                          width: 80,
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover,
                        )),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }
}
