import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // saving data to sharedPreferences
  static Future<bool> saveUserLoggedInSharedPreference(bool isUerLoggedIn) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedPreferenceUserLoggedInKey,  isUerLoggedIn);
  }
  static Future<bool> saveUsernamePreference(String username) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserNameKey,  username);
  }
  static Future<bool> saveUserEmailPreference(String email) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserEmailKey, email);
  }

  // getting data from sharedPreferences
  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(sharedPreferenceUserNameKey);
  }
  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(sharedPreferenceUserEmailKey);
  }

}