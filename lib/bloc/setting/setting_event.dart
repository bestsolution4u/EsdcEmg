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
  final bool enabled;

  SettingUpdateMessageCategoryEvent({this.messageCategory, this.enabled = true});
}

class SettingUpdateMessageLocationEvent extends SettingEvent {
  final String messageLocation;
  final bool enabled;

  SettingUpdateMessageLocationEvent({this.messageLocation, this.enabled});
}