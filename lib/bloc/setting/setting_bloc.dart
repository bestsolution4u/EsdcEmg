import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/bloc/bloc.dart';
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
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> settingsJson = (await firestore.collection("setting").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").get()).data() ?? {};
    SettingModel settingModel = SettingModel.fromJson(settingsJson);
    yield SettingLoadSuccessState(settings: settingModel);
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
    settingModel.messageCategory = event.messageCategory;
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