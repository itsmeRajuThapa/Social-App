import 'add_post.dart';
import 'package:project/const/import.dart';

//import 'package:intl/intl.dart';
UserModel? loginUsers;

class HomeScreen extends StatefulWidget {
  final List<UserModel> usersData;
  const HomeScreen({super.key, required this.usersData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 5));
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> userPostData = [];

  Future<List<String>> getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? profileString = pref.getString('profileData');

    if (profileString != null) {
      try {
        final decodeprofileData = json.decode(profileString) as List<dynamic>;
        setState(() {
          userPostData =
              decodeprofileData.map((e) => PostModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      userPostData = [];
    }
    return [];
  }

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        loginUsers = widget.usersData
            .firstWhere((user) => user.id.toString() == userIdData);
      } catch (e) {
        rethrow;
      }
    } else {
      loginUsers;
    }
    return [];
  }

  void ready() async {
    await getUserId();

    await getProfileData();
  }

  @override
  void initState() {
    ready();
    super.initState();
  }

  Future<void> userLike(String postId) async {
    setState(() {
      final postIndex =
          userPostData.indexWhere((post) => post.postId == postId);
      if (postIndex != -1) {
        if (userPostData[postIndex].postLikedBy.contains(loginUsers!.id)) {
          userPostData[postIndex].postLikedBy.remove(loginUsers!.id);
        } else {
          userPostData[postIndex].postLikedBy.add(loginUsers!.id);
        }
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String updatedPosts = jsonEncode(userPostData);
    prefs.setString('profileData', updatedPosts);

    getProfileData();
  }

  UserModel? postIdDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGolden,
        title: const Text("CAN WE TALK",
            style: TextStyle(
                wordSpacing: 3.0,
                letterSpacing: 4.0,
                fontFamily: bold,
                color: brownColor,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          //  border: Border.all(width: 6.0, color: Colors.white),
                        ),
                        child: ClipOval(
                            child: loginUsers?.image?.path != ""
                                ? Image(
                                    height: 55,
                                    width: 55,
                                    image: FileImage(loginUsers!.image!),
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    height: 55,
                                    width: 55,
                                    image:
                                        AssetImage("${loginUsers?.imageUrl}"),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Positioned(
                          bottom: 6,
                          right: 0,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ))
                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPost(
                                      loginUsers: loginUsers,
                                    )));
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: textfieldGrey),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "What's in your mind",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userPostData.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = userPostData[index];
                  postIdDetails = widget.usersData
                      .firstWhere((user) => user.id == data.userId);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      shadowColor: const Color.fromARGB(255, 242, 28, 28),
                      color: fontGrey,
                      elevation: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'profileId', data.userId.toString());
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FriendDetails()));
                                    },
                                    child: ClipOval(
                                        child: postIdDetails?.image?.path != ""
                                            ? Image(
                                                height: 40,
                                                width: 40,
                                                image: FileImage(
                                                    postIdDetails!.image!),
                                                fit: BoxFit.cover,
                                              )
                                            : Image(
                                                height: 40,
                                                width: 40,
                                                image: AssetImage(
                                                    "${postIdDetails!.imageUrl}"),
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${postIdDetails!.fullName}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(data.createdAt,
                                        style: const TextStyle(fontSize: 14))
                                  ],
                                )
                              ],
                            ),
                          ),
                          data.description != ""
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    data.description,
                                    style: const TextStyle(color: brownColor),
                                  ),
                                )
                              : const Text(''),
                          Container(
                            height: 350,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: data.image?.path != ""
                                  ? DecorationImage(
                                      image: FileImage(data.image!),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: NetworkImage(
                                          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.5QmS07ItAfNPyFSRaYDkrwHaEK%26pid%3DApi&f=1&ipt=6af2a69220292dfa0084a72d56f04f713a07f7a83f38c9cd315fcccdadd4e266&ipo=images'),
                                      fit: BoxFit.cover),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() async {
                                      await userLike(data.postId);
                                    });
                                  },
                                  icon:
                                      data.postLikedBy.contains(loginUsers!.id)
                                          ? const Icon(Icons.favorite,
                                              color: redColor)
                                          : const Icon(
                                              Icons.favorite_border,
                                            )),
                              Text('${data.postLikedBy.length}'),
                              const SizedBox(width: 5),
                              const Text('Like')
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
