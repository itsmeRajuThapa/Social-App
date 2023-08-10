import 'package:project/const/import.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModel> matchQuery = usersData.where((user) {
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
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FriendDetails()));
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
                      : Image(
                          height: 60,
                          width: 60,
                          image: AssetImage('${result.imageUrl}'),
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
    List<UserModel> matchQuery = usersData.where((user) {
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
                MaterialPageRoute(builder: (context) => const FriendDetails()));
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
                      : Image(
                          height: 60,
                          width: 60,
                          image: AssetImage('${result.imageUrl}'),
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
