import 'package:esdc_emg/config/global.dart';

class SettingModel {
  String language, messageCategory, messageLocation;

  SettingModel({this.language, this.messageCategory, this.messageLocation});

  SettingModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      language = Globals.SupportedLanguageCodes[0];
      messageCategory = Globals.DEFAULT_MESSAGE_CATEGORY;
      messageLocation = Globals.MESSAGE_LOCATIONS[0];
    } else {
      language = json['language'] ?? Globals.SupportedLanguageCodes[0];
      messageCategory = json['messageCategory'] ?? Globals.DEFAULT_MESSAGE_CATEGORY;
      messageLocation = json['messageLocation'] ?? Globals.MESSAGE_LOCATIONS[0];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['messageCategory'] = this.messageCategory;
    data['messageLocation'] = this.messageLocation;
    return data;
  }
}