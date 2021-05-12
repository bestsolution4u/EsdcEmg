import 'package:meta/meta.dart';

@immutable
abstract class SettingEvent {}

class SettingLoadEvent extends SettingEvent {}

class SettingUpdateLanguageEvent extends SettingEvent {
  final String language;

  SettingUpdateLanguageEvent({this.language});
}

class SettingUpdateMessageCategoryEvent extends SettingEvent {
  final String messageCategory;

  SettingUpdateMessageCategoryEvent({this.messageCategory});
}

class SettingUpdateMessageLocationEvent extends SettingEvent {
  final String messageLocation;

  SettingUpdateMessageLocationEvent({this.messageLocation});
}