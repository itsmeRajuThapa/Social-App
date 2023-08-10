import 'package:project/const/import.dart';

class AddPost extends StatefulWidget {
  final UserModel? loginUsers;
  const AddPost({super.key, required this.loginUsers});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? postImage;
  final ImagePicker picker = ImagePicker();
  Future takePhoto() async {
    try {
      final pickedProfile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedProfile == null) return;
      String imagePath = pickedProfile.path;
      File? img = File(imagePath);
      setState(() {
        postImage = img;
      });
    } on PlatformException {
      //rethrow;
    }
  }

  Map<String, dynamic> profileEmptyList = {};
  void postDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonString = sharedPreferences.getString('profileData');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          postList = jsonData.map((json) => PostModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          postList.add(PostModel.fromJson(jsonData));
        }
      } catch (e) {
        rethrow;
      }
    }

    postList.add(PostModel(
        postId: const Uuid().v4(),
        userId: widget.loginUsers!.id,
        createdAt: DateTime.now().toString(),
        description: descController.text,
        image: postImage!,
        postLikedBy: []));
    List<Map<String, dynamic>> profileDataList =
        postList.map((e) => e.toJson()).toList();
    String profileData = jsonEncode(profileDataList);
    sharedPreferences.setString('profileData', profileData);
  }

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: lightGolden,
        title: const Text('Create post',
            style: TextStyle(
                fontFamily: bold,
                color: brownColor,
                fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  postDetails();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                });
              },
              child: const Text('POST'))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          takePhoto();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Description',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: bold,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            textform(
                labeltext: 'Description',
                hint: 'Write some description',
                controller: descController),
            const SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: textfieldGrey,
              ),
              child: Center(
                  child: postImage == null
                      ? const Text(
                          'Add Image',
                          style: TextStyle(fontSize: 25),
                        )
                      : Image(
                          height: 300,
                          width: double.infinity,
                          image: FileImage(postImage!),
                          fit: BoxFit.cover,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
