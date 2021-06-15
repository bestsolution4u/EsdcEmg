import 'package:esdc_emg/config/global.dart';

class PreferenceHelper {

  static Future<bool> clear() {
    return Globals.preferences.clear();
  }

  static Future<bool> remove(String key) {
    return Globals.preferences.remove(key);
  }

  static dynamic get(String key) {
    return Globals.preferences.get(key);
  }

  static Set<String> getKeys() {
    return Globals.preferences.getKeys();
  }

  static Future<bool> setBool(String key, bool value) {
    return Globals.preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    bool result = Globals.preferences.getBool(key);
    return result ?? false;
  }

  static Future<bool> setDouble(String key, double value) {
    return Globals.preferences.setDouble(key, value);
  }

  static double getDouble(String key) {
    return Globals.preferences.getDouble(key);
  }

  static Future<bool> setInt(String key, int value) {
    return Globals.preferences.setInt(key, value);
  }

  static int getInt(String key) {
    return Globals.preferences.getInt(key) ?? 0;
  }

  static Future<bool> setDate(String key, DateTime value) {
    if (value == null) return Globals.preferences.remove(key);
    int timestamp = value.millisecondsSinceEpoch;
    return Globals.preferences.setInt(key, timestamp);
  }

  static DateTime getDate(String key) {
    int timestamp = Globals.preferences.getInt(key);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  static Future<bool> setString(String key, String value) {
    return Globals.preferences.setString(key, value);
  }

  static String getString(String key) {
    String result = Globals.preferences.getString(key);
    return result ?? "";
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return Globals.preferences.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return Globals.preferences.getStringList(key) ?? [];
  }
  ///Singleton factory
  static final PreferenceHelper _instance = PreferenceHelper._internal();
  factory PreferenceHelper() {
    return _instance;
  }
  PreferenceHelper._internal();
}