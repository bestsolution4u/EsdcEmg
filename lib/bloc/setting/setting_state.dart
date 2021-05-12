import 'package:esdc_emg/model/setting_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingState {}

class SettingLoadingState extends SettingState {}

class SettingLoadSuccessState extends SettingState {
  final SettingModel settings;

  SettingLoadSuccessState({this.settings});
}

class SettingLoadFailureState extends SettingState {}