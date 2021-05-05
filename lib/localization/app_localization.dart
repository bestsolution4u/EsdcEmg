import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  static Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppLocalization(Locale loc) {
    locale = loc;
    _localisedValues = null;
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static Future<AppLocalization> load(Locale locale) async {
    AppLocalization appTranslations = AppLocalization(locale);
    String jsonContent = await rootBundle.loadString("asset/lang/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  static get currentLanguage => locale.languageCode;

  String trans(String key) {
    if (_localisedValues == null) return "";
    return _localisedValues[key] ?? "$key not found";
  }
}