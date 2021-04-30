import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static SharedPreferences preferences;

  static final String BASE_URL = "https://emgapp.azurewebsites.net/api/";

  static final List<String> CATEGORIES = [
    "Technical Issue",
    "Suggestion",
    "General",
    "Other"
  ];

  static final List<String> WHICH_FROM = [
    "ESDC Employee",
    "Other Federal Department",
    "Member of the Public"
  ];
}