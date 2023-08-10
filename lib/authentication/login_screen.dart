import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../forget_password/change_password.dart';
import 'signup_screen.dart';
import 'package:project/const/import.dart';

List<UserModel> usersDataList = [];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible = true;
  bool value = false;

  Future<void> fetchUserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? jsonString = sharedPreferences.getString('dataList');

      if (jsonString == null) {
        String userString;
        try {
          userString = await rootBundle.loadString('assets/services/user.json');
        } catch (e) {
          print("Error loading 'user.json': $e");
          return;
        }
        final jsonData = json.decode(userString);

        if (jsonData is List<dynamic>) {
          usersDataList =
              jsonData.map((json) => UserModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          usersDataList.add(UserModel.fromJson(jsonData));
        }
        List<Map<String, dynamic>> jsonDataList =
            usersDataList.map((cv) => cv.toJson()).toList();

        String jsonDataString = json.encode(jsonDataList);
        sharedPreferences.setString('dataList', jsonDataString);
      }
    } catch (e) {
      //  print(e);
      rethrow;
    }
  }

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          usersDataList =
              decodedData.map((e) => UserModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      usersDataList = [];
    }
    return [];
  }

  Future<bool> performLogin(String emaill, String passwordd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // ignore: unused_local_variable
      UserModel users = usersDataList.firstWhere(
        (user) => user.email == emaill && user.password == passwordd,
      );
      prefs.setString('userID', users.id.toString());
      prefs.setString('email', emaill);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
      final materialBanner = MaterialBanner(
        elevation: 3,
        backgroundColor: Colors.transparent,
        forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: 'Congratulations!!!',
          message:
              'You have successfully login your account.\n Have a great experience',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
        actions: const [SizedBox.shrink()],
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(materialBanner);

      return true;
    } catch (e) {
      final materialBanner = MaterialBanner(
        elevation: 3,
        backgroundColor: Colors.transparent,
        forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: '  Oh Hey!!',
          message:
              ' Please write correct Email & Password \n  Email or password doesnot match!',
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
        actions: const [SizedBox.shrink()],
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(materialBanner);
      return false;
    }
  }

  TextEditingController emlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
    fetchUserData();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightGolden,
                    ),
                    height: 200,
                    width: double.infinity,
                    child: const Text(
                      'Login Form',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: regular,
                        fontWeight: FontWeight.bold,
                        color: brownColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                      left: 40,
                      top: -10,
                      child: Column(
                        children: [
                          // const SizedBox(height: 12),
                          Image.asset(
                            'assets/logo2.png',
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(height: 12),
              textform(
                  //  keyType:  ,
                  validate: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: emlController,
                  labeltext: 'Email',
                  hint: 'Enter Your Email',
                  prefixIcon: Icons.email),
              const SizedBox(height: 12),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is Empty';
                  }
                  return null;
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
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              Row(
                children: [
                  Checkbox(
                      value: value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      }),
                  const Text('Remember Me'),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComparedEmail()));
                      },
                      child: const Text('Forget Password')),
                ],
              ),
              // const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        // login();
                        performLogin(
                            emlController.text, passwordController.text);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'or, create a new account ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
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
            ],
          ),
        ),
      ),
    );
  }
}
