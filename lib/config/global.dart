import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void LocaleChangeCallback(Locale locale);

class Globals {
  static SharedPreferences preferences;

  /// Supported languages
  static const List<String> SupportedLanguages = [
    "English",
    "French",
  ];

  /// Supported language codes
  static const List<String> SupportedLanguageCodes = [
    "en",
    "fr",
  ];

  static LocaleChangeCallback onLocaleChanged;

  /// API base url
  static const String BASE_URL = "https://emgapp.azurewebsites.net/api/";

  /// Push Notification Topics
  static const String FCM_TOPIC_MESSAGE_CREATED = "messageCreated";
  static const String FCM_TOPIC_MESSAGE_UPDATED = "messageUpdated";
  static const String FCM_TOPIC_MESSAGE_DELETED = "messageDeleted";

  /// Feedback categories
  static const List<String> CATEGORIES = [
    "technical_issue",
    "suggestion",
    "general",
    "other"
  ];

  /// Feedback source
  static const List<String> WHICH_FROM = [
    "esdc_employee",
    "other_federal_department",
    "member_of_the_public"
  ];

  /// Message categories
  static const List<String> MESSAGE_CATEGORIES = [
    "hr",
    "it",
    "security",
    "communication",
    "health",
    "career related",
    "achievements",
    "event",
    "general information"
  ];

  static const List<String> MESSAGE_LOCATIONS = [
    "National – Canada wide",
    "Newfoundland and Labrador",
    "Prince Edward Island",
    "Nova Scotia",
    "New Brunswick",
    "Quebec",
    "Ontario",
    "Winnipeg",
    "Saskatchewan",
    "Alberta",
    "British Columbia",
    "Nunavut",
    "Northwest Territories",
    "Yukon"
  ];
}