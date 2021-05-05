import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {

  final Locale locale;

  const AppLocalizationsDelegate({this.locale});

  @override
  bool isSupported(Locale locale) {
    return Globals.SupportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale newLocale) {
    return AppLocalization.load(locale ?? newLocale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) => true;
}