import 'dart:convert';

import 'package:rayahhalekapp/helper/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilSharedPreferences {
  static SharedPreferences _prefs;

  static Future<SharedPreferences> load() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static void setString(String key, String value) {
    _prefs.setString(key, value);
  }

  static void setObj(String key, Object value) {
    _prefs.setString(key, jsonEncode(value));
  }

  static Object getObj(String key) {
    return jsonDecode(_prefs.getString(key));
  }


  static void clear(){
    UtilSharedPreferences.remove("token");
    UtilSharedPreferences.remove("user");
    Helper.user = null;
    Helper.token = null;
  }

  static void setInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  static void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
  }

  static void setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  static String getString(String key) {
    if (_prefs.getString(key) != null) {
      return _prefs.getString(key);
    }
    return null;
  }
  static void remove(String key) {
    if (_prefs.getString(key) != null) {

      _prefs.remove(key);
    }
  }

  static int getInt(String key) {
    if (_prefs.getInt(key) != null) {
      return _prefs.getInt(key);
    }
    return null;
  }

  static double getDouble(String key) {
    if (_prefs.getDouble(key) != null) {
      return _prefs.getDouble(key);
    }
    return null;
  }

  static bool getBool(String key) {
    if (_prefs.getBool(key) != null) {
      return _prefs.getBool(key);
    }
    return false;
  }

}
