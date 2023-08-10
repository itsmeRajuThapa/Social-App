import 'package:project/const/import.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
                      child: loginUsers?.image?.path != ""
                          ? Image(
                              image: FileImage(loginUsers!.image!),
                              fit: BoxFit.cover,
                            )
                          : Image(
                              image: AssetImage("${loginUsers!.imageUrl}"),
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
                        child: loginUsers?.image?.path != ""
                            ? Image(
                                height: 100,
                                width: 100,
                                image: FileImage(loginUsers!.image!),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                height: 100,
                                width: 100,
                                image: AssetImage("${loginUsers!.imageUrl}"),
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
                  loginUsers?.fullName != ""
                      ? Text(' Name: ${loginUsers!.fullName}',
                          style:
                              const TextStyle(fontFamily: bold, fontSize: 16))
                      : const Text('No Name'),
                  const SizedBox(height: 8),
                  loginUsers?.email != ""
                      ? Text(
                          ' Email: ${loginUsers!.email}',
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
                  const Text('Contact info',
                      style: TextStyle(fontFamily: bold)),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: textfieldGrey,
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      '${loginUsers!.mobileNumber}',
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
                      '${loginUsers!.gender}',
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
                      '${loginUsers!.dob}',
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
                      '${loginUsers!.maritialStatus}',
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
                  ),
                  const Divider(
                    height: 10,
                    thickness: 3,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sharedPerference =
                                await SharedPreferences.getInstance();
                            sharedPerference.remove('email');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(fontFamily: semibold),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
