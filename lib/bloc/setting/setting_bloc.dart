import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/model/setting_model.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingLoadingState());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async*{
    if (event is SettingLoadEvent) {
      yield* _mapSettingLoadEventToState();
    } else if (event is SettingUpdateLanguageEvent) {
      yield* _mapSettingUpdateLanguageEventToState(event);
    } else if (event is SettingUpdateMessageCategoryEvent) {
      yield* _mapSettingUpdateMessageCategoryEventToState(event);
    } else if (event is SettingUpdateMessageLocationEvent) {
      yield* _mapSettingUpdateMessageLocationEventToState(event);
    }
  }

  Stream<SettingState> _mapSettingLoadEventToState() async* {
    yield SettingLoadingState();
    try {
      var firestore = FirebaseFirestore.instance;
      Map<String, dynamic> settingsJson = (await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").get()).data() ?? {};
      SettingModel settingModel = SettingModel.fromJson(settingsJson);
      yield SettingLoadSuccessState(settings: settingModel);
    } catch (e) {
      yield SettingLoadSuccessState(settings: SettingModel.fromJson(null));
    }
  }

  Stream<SettingState> _mapSettingUpdateLanguageEventToState(SettingUpdateLanguageEvent event) async* {
    SettingModel settingModel = (state as SettingLoadSuccessState).settings;
    settingModel.language = event.language;
    yield SettingLoadingState();
    yield SettingLoadSuccessState(settings: settingModel);
    var firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(settingModel.toJson());
    } catch (e) {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(settingModel.toJson());
    }
  }

  Stream<SettingState> _mapSettingUpdateMessageCategoryEventToState(SettingUpdateMessageCategoryEvent event) async* {
    SettingModel settingModel = (state as SettingLoadSuccessState).settings;
    String topic = event.messageCategory;
    bool enabled = event.enabled;
    List<String> oldTopics = settingModel.messageCategory.split(",");
    List<String> newTopics = [];
    if (enabled) {
      if (topic == Globals.DEFAULT_MESSAGE_CATEGORY) {
        newTopics.add(Globals.DEFAULT_MESSAGE_CATEGORY);
      } else {
        if (!oldTopics.contains(topic)) oldTopics.add(topic);
        if (oldTopics.length == Globals.MESSAGE_CATEGORIES.length) {
          newTopics.add(Globals.DEFAULT_MESSAGE_CATEGORY);
        } else {
          newTopics.addAll(oldTopics);
        }
      }
    } else {
      if (topic != Globals.DEFAULT_MESSAGE_CATEGORY) {
        if (oldTopics.contains(Globals.DEFAULT_MESSAGE_CATEGORY)) {
          Globals.MESSAGE_CATEGORIES.forEach((element) {
            if (element != topic) {
              newTopics.add(element);
            }
          });
        } else {
          if (oldTopics.contains(topic)) oldTopics.remove(topic);
          if (oldTopics.length != 0) {
            newTopics.addAll(oldTopics);
          }
        }
      }
    }
    String categories = newTopics.join(",");
    if (categories.startsWith(",")) categories = categories.substring(1);
    settingModel.messageCategory = categories;
    yield SettingLoadingState();
    yield SettingLoadSuccessState(settings: settingModel);
    var firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(settingModel.toJson());
    } catch (e) {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(settingModel.toJson());
    }
  }

  Stream<SettingState> _mapSettingUpdateMessageLocationEventToState(SettingUpdateMessageLocationEvent event) async* {
    SettingModel settingModel = (state as SettingLoadSuccessState).settings;
    String location = event.messageLocation;
    bool enabled = event.enabled;





    settingModel.messageLocation = event.messageLocation;
    yield SettingLoadingState();
    yield SettingLoadSuccessState(settings: settingModel);
    var firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(settingModel.toJson());
    } catch (e) {
      await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(settingModel.toJson());
    }
  }
}