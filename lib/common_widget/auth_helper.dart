import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const String isLoggedInKey = 'isLoggedIn';

  // Function to set the login status to true when the user logs in
  static Future<void> setUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, true);
  }

  // Function to set the login status to false when the user logs out
  static Future<void> setUserLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, false);
  }

  // Function to check if the user is logged in or not
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
}
