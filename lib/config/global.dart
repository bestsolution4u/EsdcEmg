import 'package:esdc_emg/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void LocaleChangeCallback(Locale locale);

class Globals {
  static const bool IS_PRODUCTION = false;
  static const double MAX_TEXT_SCALE_FACTOR = 1.5;
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
  static const String BASE_URL_PROD = "https://emgadmin.azurewebsites.net/api/";
  static const String BASE_URL_DEV = "https://emgapp.azurewebsites.net/api/";

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

  static const String DEFAULT_MESSAGE_CATEGORY = "all_topics";
  /// Message categories
  static const List<String> MESSAGE_CATEGORIES = [
    "hr",
    "it",
    "security",
    "communication",
    "learning",
    "health",
    "wellness",
    "career related",
    "achievements",
    "event",
    "general information"
  ];

  static const List<String> MESSAGE_LOCATIONS = [
    "All",
    "National – Canada wide",
    "Newfoundland and Labrador",
    "Prince Edward Island",
    "Nova Scotia",
    "New Brunswick",
    "Quebec",
    "Ontario",
    "Manitoba",
    "Saskatchewan",
    "Alberta",
    "British Columbia",
    "Nunavut",
    "Northwest Territories",
    "Yukon"
  ];

  static final List<VideoModel> VIDEOS = [
    // https://youtu.be/KY_01FX06dw
    VideoModel(id: 'KY_01FX06dw', title: 'COVID-19 | Update | Measures to support Canadians during the COVID-19 crisis', thumbnail: 'https://img.youtube.com/vi/KY_01FX06dw/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/LXHMwNWMGkM?list=PLSUro1UBralqmBPO4aWZlLhGMib3nBS0j
    VideoModel(id: 'LXHMwNWMGkM', title: 'Future Skills - Priority 1', thumbnail: 'https://img.youtube.com/vi/LXHMwNWMGkM/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/Fdp-eASnlBQ
    VideoModel(id: 'Fdp-eASnlBQ', title: 'Canada Child Benefit young child supplement', thumbnail: 'https://img.youtube.com/vi/Fdp-eASnlBQ/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/03lqp_FKH6g
    VideoModel(id: '03lqp_FKH6g', title: 'Budget 2021 and Reaching Home: Canada\'s Homelessness Strategy', thumbnail: 'https://img.youtube.com/vi/03lqp_FKH6g/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/iwiTTg840KM
    VideoModel(id: 'iwiTTg840KM', title: 'We Asked Seniors About Their COVID Experience | Suzanne\'s Interview', thumbnail: 'https://img.youtube.com/vi/iwiTTg840KM/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/4koAcfA9umQ
    VideoModel(id: '4koAcfA9umQ', title: 'Budget 2021 - Canada-wide early learning and child care system ', thumbnail: 'https://img.youtube.com/vi/4koAcfA9umQ/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/HeWk2v8Rpqw
    VideoModel(id: 'HeWk2v8Rpqw', title: 'Future Skills 2021', thumbnail: 'https://img.youtube.com/vi/HeWk2v8Rpqw/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/OVJ12inEO8E
    VideoModel(id: 'OVJ12inEO8E', title: 'Minister Tassi - National Day of Mourning 2021', thumbnail: 'https://img.youtube.com/vi/OVJ12inEO8E/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/Dh5vKILLWes
    VideoModel(id: 'Dh5vKILLWes', title: 'Support for Canadian families at each stage of their children\'s lives', thumbnail: 'https://img.youtube.com/vi/Dh5vKILLWes/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/hqiEtg19lIc
    VideoModel(id: 'hqiEtg19lIc', title: 'Health and Safety | Workplace inspections', thumbnail: 'https://img.youtube.com/vi/hqiEtg19lIc/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
    // https://youtu.be/PX2Uv0-_Vmg
    VideoModel(id: 'PX2Uv0-_Vmg', title: 'Bell Let\'s Talk 2021- Minister Tassi ', thumbnail: 'https://img.youtube.com/vi/PX2Uv0-_Vmg/hqdefault.jpg', time: '3 days ago', publisher: 'Social Development Canada', pubLogo: 'https://yt3.ggpht.com/ytc/AAUvwnjdlYSyFlpZtZsnBIgl7-YnZPrUzzgJlHne5UVVWw=s900-c-k-c0x00ffffff-no-rj'),
  ];

  static final List<String> TOP_BANNERS = [
    "top_banner_1",
    "top_banner_2",
    "top_banner_3",
    "top_banner_4",
  ];

  static final String YOUTUBE_API_KEY = "AIzaSyDC-nQneSJLqHoF-GaDgL7uBj9yTqg6Pos";
  static final int YOUTUBE_VIDEO_COUNT = 6;
  static final int VPN_STATUS_UPDATE_INTERVAL = 5;
}