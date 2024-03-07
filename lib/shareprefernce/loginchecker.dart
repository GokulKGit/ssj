import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //init SharedPreferences
  static late SharedPreferences _preferences;

  static const String _keyLoggedIn = 'loggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyUserName = 'userName';
  static const String _keyUserMail = 'userMail';
  static const String _keyUserMobile = 'userMobile';
  static const String _keyUserDateOfBirth = 'userDateOfBirth';
  static const String _keyUserDateOfAnniversary = 'userDateOfAnniversary';
  static const String _keyUserImage = 'userImage';
  static const String _keyUserGender = 'userGender';

  static const String _keyUserFcmToken = 'fcmtoken';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

// check the user loggedIn or not
  static Future setLoggedIn(bool value) async {
    await _preferences.setBool(_keyLoggedIn, value);
  }

  static bool isLoggedIn() {
    return _preferences.getBool(_keyLoggedIn) ?? false;
  }

//  get the user id
  static Future setUserId(String userId) async {
    await _preferences.setString(_keyUserId, userId);
  }

//  get the user name
  static Future setUserName(String userName) async {
    await _preferences.setString(_keyUserName, userName);
  }

  //  get the user mail
  static Future setUserMail(String userMail) async {
    await _preferences.setString(_keyUserMail, userMail);
  }

  //  get the user mail
  static Future setUserMobile(String userMobile) async {
    await _preferences.setString(_keyUserMobile, userMobile);
  }

  //  get the user mail
  static Future setUserDateOfBirth(String userDateOfBirth) async {
    await _preferences.setString(_keyUserDateOfBirth, userDateOfBirth);
  }

  static Future setUserDateOfAnniversary(String userDateOfAnniversary) async {
    await _preferences.setString(
        _keyUserDateOfAnniversary, userDateOfAnniversary);
  }

  static Future setUserGender(String userGender) async {
    await _preferences.setString(_keyUserGender, userGender);
  }

  static Future setUserImage(String userImage) async {
    await _preferences.setString(_keyUserImage, userImage);
  }

  static Future setFcmToken(String fcmToken) async {
    await _preferences.setString(_keyUserFcmToken, fcmToken);
  }

  static String getUserId() {
    return _preferences.getString(_keyUserId) ?? '';
  }

  static String getUserName() {
    return _preferences.getString(_keyUserName) ?? '';
  }

  static String getUserMail() {
    return _preferences.getString(_keyUserMail) ?? '';
  }

  static String getUserMobile() {
    return _preferences.getString(_keyUserMobile) ?? '';
  }

  static String getUserDateOfBith() {
    return _preferences.getString(_keyUserDateOfBirth) ?? '';
  }

  static String getUserDateOfAnniversary() {
    return _preferences.getString(_keyUserDateOfAnniversary) ?? 'yyyy-mm-dd';
  }

  static String getUserImage() {
    return _preferences.getString(_keyUserImage) ?? '';
  }

  static String getUserGender() {
    return _preferences.getString(_keyUserGender) ?? '';
  }

  static String getFcmToken() {
    return _preferences.getString(_keyUserFcmToken) ?? '';
  }
}
