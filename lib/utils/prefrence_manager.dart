import 'dart:convert';


import 'package:educube1/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/attendance_res_model.dart';
import '../model/profile_res_model.dart';
import '../model/session_details_res_model.dart';


class PreferenceManager {
  static const prefKeyIsLogin = 'pref_key_is_user_login';
  static const prefKeyIsFirstLaunch = 'pref_key_is_first_launch';
  static const prefKeyUserToken = 'pref_key_user_token';
  static const prefKeyFcmToken = 'pref_fcm_token';
  static const prefKeyLatitude = 'pref_latitude';
  static const prefKeyLongitude = 'pref_longitude';
  static const prefKeyUser = 'pref_key_user';
  static const profileKeyUser = 'profile_key_user';
  static const attendanceKeyUser = 'profile_key_user';
  static const prefKeyCurrentLocation = 'pref_key_current_location';
  static const prefKeyAcademicYear = 'profile_academic_year';
  static const preyUserPassword = 'prey_key_user_password';
  static late SharedPreferences _prefs;

  PreferenceManager._();

  static Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  static Future<bool> init() async {
    _prefs = await _getInstance();
    return Future.value(true);
  }

  static void save2Pref(String key, dynamic value) {
    if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is String) {

      _prefs.setString(key, value);
    } else {

    }
  }

  static Object? getPref(String key) {
    return _prefs.get(key);
  }

  static String get userToken => _prefs.getString(prefKeyUserToken) ?? '';
  static set userToken(String? token) {
    _prefs.setString(prefKeyUserToken, token ?? '');
  }
  static String get userPassword => _prefs.getString(preyUserPassword) ?? '';
  static set userPassword(String? password) {
    _prefs.setString(preyUserPassword, password ?? '');
  }
  static Object? academicYear(String key) {
    return _prefs.get(key);
  }

  static UserDetails? get user {
    String? user =  _prefs.getString(prefKeyUser);
    if (user != null) {
      return UserDetails.fromJson(jsonDecode(user));
    } else {
      return null;
    }
  }

  static set user(UserDetails? user) {
    if (user != null) {
      _prefs.setString(prefKeyUser, jsonEncode(user.toJson()));
    } else {
      _prefs.remove(prefKeyUser);
    }
  }
  static ProfileResponse? get profile {
    String? user = _prefs.getString(profileKeyUser);
    if (user != null) {
      return ProfileResponse.fromJson(jsonDecode(user));
    } else {
      return null;
    }
  }
  static set profile(ProfileResponse? profile) {
    if (profile != null) {
      _prefs.setString(profileKeyUser, jsonEncode(profile.toJson()));
    } else {
      _prefs.remove(profileKeyUser);
    }
  }
  static AttendanceSessionResponse? get attendance{
   String? attendanceDetail = _prefs.getString(attendanceKeyUser);
   if(attendanceDetail != null){
     return AttendanceSessionResponse.fromJson(jsonDecode(attendanceDetail));
   }
   return null;
  }
  static set attendance(AttendanceSessionResponse? attendance){

    if(attendance != null){
      _prefs.setString(attendanceKeyUser, jsonEncode(attendance.toJson()));

    }else{
      _prefs.remove(attendanceKeyUser);
    }

  }
  static bool get isFirstLaunch =>
      (getPref(prefKeyIsFirstLaunch) ?? true) as bool;

  static set isFirstLaunch(bool isFirstLaunch) {
    _prefs.setBool(prefKeyIsFirstLaunch, isFirstLaunch);
  }

  static void clean() async {
    await  _prefs.clear();
  }

  static void logoutUser() {
    _prefs.remove(prefKeyUserToken);
    _prefs.remove(prefKeyIsLogin);


  }
  static void removeUserData(){
    _prefs.remove(prefKeyUser);
    _prefs.remove(prefKeyUserToken);
    _prefs.remove(prefKeyIsLogin);
  }

}