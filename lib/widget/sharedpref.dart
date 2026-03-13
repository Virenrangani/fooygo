import 'package:shared_preferences/shared_preferences.dart';
class sharedPrefHelper{

  static String userIdKey='userIdkey';
  static String userNameKey='userNamekey';
  static String userProfileKey='userProfilekey';
  static String userEmailKey='userEmailkey';
  static String userWalletKey='userWalletkey';

  Future<bool> saveUserId(String getUserId)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.setString(userIdKey,getUserId);
  }
  Future<bool> saveWalletId(String getUserWallet)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.setString(userWalletKey,getUserWallet);
  }
  Future<bool> saveUserName(String getUserName)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.setString(userNameKey,getUserName);
  }
  Future<bool> saveUserEmail(String getUserEmail)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userEmailKey, getUserEmail);
  }
  Future<bool> saveUserProfile(String getUserProfile)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userProfileKey, getUserProfile);
  }
  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString(userIdKey);
    print('UserId from SharedPreferences: $userId'); // Debugging line
    return userId;
  }
  Future<String?> getUserName()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }
  Future<String?> getUserEmail()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }
  Future<String?> getUserWallet()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(userWalletKey);
  }
  Future<String?> getUserProfile() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? profile = preferences.getString(userProfileKey);
    print('Profile from SharedPreferences: $profile'); // Debugging line
    return profile;
  }
}