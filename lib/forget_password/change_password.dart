import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project/authentication/login_screen.dart';
import 'package:project/const/import.dart';

class ComparedEmail extends StatefulWidget {
  const ComparedEmail({super.key});

  @override
  State<ComparedEmail> createState() => _ComparedEmailState();
}

class _ComparedEmailState extends State<ComparedEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isVisible = true;
  final _formKey = GlobalKey<FormState>();
  Future<void> updateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserModel users =
          usersDataList.firstWhere((eml) => eml.email == emailController.text);

      int index = usersDataList.indexWhere((user) => user.id == users.id);
      if (index != -1) {
        usersDataList[index].password = passwordController.text;
        String updatedUserListJson = jsonEncode(usersDataList);
        await prefs.setString('dataList', updatedUserListJson);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        final materialBanner = MaterialBanner(
          elevation: 3,
          backgroundColor: Colors.transparent,
          forceActionsBelow: true,
          content: AwesomeSnackbarContent(
            title: 'Wow Wow!!',
            message: 'You have been Successfully changed Password!',
            contentType: ContentType.success,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);
      }
    } catch (e) {
      final materialBanner = MaterialBanner(
        elevation: 3,
        backgroundColor: Colors.transparent,
        forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: 'Sorry!!',
          message: ' Please write correct Email  \n  Email  doesnot match!',
          contentType: ContentType.warning,
          inMaterialBanner: true,
        ),
        actions: const [SizedBox.shrink()],
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(materialBanner);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Go Back')),
      body: SingleChildScrollView(
        child: Padding(
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
                      height: 220,
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Forget Password',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: regular,
                            fontWeight: FontWeight.bold,
                            color: brownColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 45,
                        top: -3,
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
                Text('Enter Your Past Email'),
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
                    controller: emailController,
                    labeltext: 'Email',
                    hint: 'Enter Your Login Email',
                    prefixIcon: Icons.email),
                const SizedBox(height: 12),
                Text('Enter Your New Password'),
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
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          updateUser();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: brownColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Send Email',
                      style: TextStyle(color: whiteColor, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
