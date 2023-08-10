import 'package:intl/intl.dart';
import '../common_widget/radio_button.dart';
import 'package:project/const/import.dart';

import 'login_screen.dart';

Map<String, dynamic> signUpEmptyList = {};
Map<String, dynamic> loginEmptyList = {};

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = true;
  final ImagePicker picker = ImagePicker();
  Future takePhoto(ImageSource source) async {
    try {
      final pickedProfile = await picker.pickImage(source: source);
      if (pickedProfile == null) return;
      String imagePath = pickedProfile.path;
      File? img = File(imagePath);
      setState(() {
        image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException {
      //rethrow;
      Navigator.of(context).pop();
    }
  }

  void signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    // print('aa${jsonString}');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString) as List<dynamic>;

        setState(() {
          signupList =
              jsonData.map((json) => UserModel.fromJson(json)).toList();
        });
      } catch (e) {
        rethrow;
      }
    }
    // Shared preference

    signupList.add(UserModel(
      fullName: fullNameController.text,
      email: emailController.text,
      mobileNumber: mobileNumController.text,
      dob: dateController.text,
      password: passwordController.text,
      gender: genderList,
      maritialStatus: selectValue,
      id: const Uuid().v4(),
      image: image!,
    ));
    List<Map<String, dynamic>> jsonDataList =
        signupList.map((cv) => cv.toJson()).toList();
    loginEmptyList[emailController.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text(
        'Data Added Sucessfully',
      )),
      backgroundColor: Colors.green,
    ));
  }

  late String genderList;
  _SignUpScreenState() {
    genderList = '';
  }

  final TextEditingController dateController = TextEditingController();
  String selectValue = 'Single';
  List<String> dropdownItem = [
    'Single',
    'Married',
    'Divorced',
    'Seperated',
    'Widowed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.grey,
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'SignUp Form',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: brownColor,
                ),
              ),
              const SizedBox(height: 5),
              Stack(children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: Center(
                    child: image == null
                        ? const Text('No Image selected')
                        : CircleAvatar(
                            backgroundColor: lightGolden,
                            radius: 60,
                            backgroundImage: FileImage(image!),
                          ),
                  ),
                ),
                Positioned(
                    bottom: -5,
                    right: -2,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            // barrierColor: Colors.black87.withOpacity(0.5),
                            backgroundColor: lightGolden,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (context) => buttonSheet());
                      },
                      icon: const Icon(Icons.camera_alt),
                    ))
              ]),
              const SizedBox(height: 6),
              textform(
                validate: (value) {
                  RegExp regexp = RegExp(r'^[a-z A-Z]{0,20}$');
                  if (value.isEmpty) {
                    return 'Please enter FullName';
                  } else {
                    if (!regexp.hasMatch(value)) {
                      return 'Only text form';
                    }
                    return null;
                  }
                },
                controller: fullNameController,
                prefixIcon: Icons.person,
                labeltext: 'Full Name',
                hint: 'Enter Your FullName',
              ),
              const SizedBox(height: 10),
              textform(
                  validate: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  labeltext: 'Email',
                  hint: 'email@gmail.com',
                  prefixIcon: Icons.email),
              const SizedBox(height: 10),
              textform(
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile num.. is empty";
                    }
                    String pattern = (r'^(98|97)\d{8}$');
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) return "Invalid number";
                    return null;
                  },
                  keyType: TextInputType.phone,
                  controller: mobileNumController,
                  labeltext: 'Mobile Number',
                  hint: '+977**********',
                  prefixIcon: Icons.phone_android),
              // const SizedBox(height: 4),
              RadioBox(
                callback: (String? value) {
                  genderList = value!;
                },
              ),
              Row(children: [
                const Text(
                  'Select Maritial Status',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 50),
                DropdownButton<String>(
                  focusColor: Colors.amberAccent,
                  value: selectValue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.red,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectValue = newValue!;
                    });
                  },
                  items: dropdownItem.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ]),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Choose Date';
                    }
                    return null;
                  },
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: 'Select your correct date of birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                      ),
                      labelText: "Date Of Birth",
                      labelStyle: const TextStyle(color: Colors.purple)),
                  readOnly: true,
                  onTap: () async {
                    //when click we have to show the datepicker
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                  }),
              const SizedBox(height: 6),
              TextFormField(
                validator: (value) {
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else {
                    if (!regex.hasMatch(value)) {
                      return 'Enter valid password';
                    } else {
                      return null;
                    }
                  }
                },
                obscureText: _isVisible,
                controller: passwordController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: brownColor),
                    labelText: 'Password',
                    labelStyle:
                        const TextStyle(color: Colors.purple, fontSize: 16),
                    hintText: '*******',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),

              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        try {
                          // ignore: unused_local_variable
                          UserModel user = usersDataList.firstWhere(
                              (user) => user.email == emailController.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Center(child: Text('Email already use')),
                            backgroundColor: Colors.red,
                          ));

                          return;
                        } catch (e) {
                          signUp();
                          return;
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I already have an account',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_forward),
                          SizedBox(width: 5),
                          Text(
                            'login',
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buttonSheet() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Choose Profile photo'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera),
              const SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: const Text('Camera')),
              const SizedBox(width: 20),
              const Icon(Icons.photo),
              const SizedBox(width: 5),
              ElevatedButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: const Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }
}
