import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

// ignore: unused_import

var title = "Preferences";

Preferences preferences = Preferences();

class Preferences {
  Preferences._();

  static final Preferences preferences = Preferences._();

  factory Preferences() {
    return preferences;
  }

  late SharedPreferences _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs;

    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  Future<bool> saveString({String? key, String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key!, value ?? "");
  }

  Future<bool> saveInt({String? key, int? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key!, value!);
  }

  Future<int?> getInt({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key!);
  }

  Future<String?> getString({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }

  Future<bool> saveBool({String? key, bool? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key!, value!);
  }

  Future<bool> getBool({String? key, required bool defValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key!) ?? defValue;
  }

  Future clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  clearAllPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    await prefs.remove('imageUrl');
    await prefs.remove('name');
    await prefs.remove('id');
    await prefs.remove('emailid');
    await prefs.remove('userid');
    await prefs.remove('number');
    await prefs.remove('isUserLogin');
    await prefs.remove('profileImg');
    await prefs.remove('phoneNumber');
    await prefs.remove('addresh');

  }
}

class PrefKeys{
  static String test="";
  static String isUaseLogin="isUaseLogin";
  static String userEmailKey="userEmailKey";
  static String userId="userId";

}


bool IS_USER_LOGIN=false;
String USER_ID_pref="";