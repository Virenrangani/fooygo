import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const _keyUserId    = 'user_id';
  static const _keyUserEmail = 'user_email';
  static const _keyUserName  = 'user_name';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyWalletBalance = 'wallet_balance';

  static Future<void> saveWalletBalance(int balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyWalletBalance, balance);
  }

  static Future<int> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyWalletBalance) ?? 0;
  }

  static Future<void> saveUser({
    required String id,
    required String email,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, id);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserName, name);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}