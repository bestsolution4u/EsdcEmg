import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/bloc/message/bloc.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageLoadingState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageLoadEvent) {
      yield* _mapMessageLoadEventToState();
    } else if (event is MessageDeleteEvent) {
      yield* _mapMessageDeleteEventToState(event);
    } else if (event is MessageRefreshEvent) {
      yield* _mapMessageRefreshEventToState();
    }
  }

  Stream<MessageState> _mapMessageLoadEventToState() async* {
    yield MessageLoadingState();
    List<MessageModel> messages = new List<MessageModel>();
    final response = await Api.getMessageList();
    try {
      List<dynamic> list = response;
      List<String> deletedMessages = PreferenceHelper.getStringList(PrefParams.DELETED_MESSAGES) ?? [];
      list.forEach((element) {
        print("--------------- Message Item ------------");
        print(element);
        MessageModel message = MessageModel.fromJson(element);
        if (!deletedMessages.contains(message.id.toString())) {
          messages.add(message);
        }
      });
      messages.sort((a, b) {
        DateTime dateA = DateTime.parse(a.effectiveDate);
        DateTime dateB = DateTime.parse(b.effectiveDate);
        return dateB.compareTo(dateA);
      });
      yield MessageLoadSuccessState(messages: messages);
    } catch (e) {
      yield MessageLoadFailureState();
    }
  }

  Stream<MessageState> _mapMessageDeleteEventToState(MessageDeleteEvent event) async* {
    if (state is MessageLoadSuccessState) {
      yield MessageLoadingState();
      List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
      List<String> deletedIDs = PreferenceHelper.getStringList(PrefParams.DELETED_MESSAGES) ?? [];
      deletedIDs.add(event.deletedID.toString());
      PreferenceHelper.setStringList(PrefParams.DELETED_MESSAGES, deletedIDs);
      FirebaseFirestore.instance.collection("message").doc(event.deletedID.toString()).delete();
      for (int i = 0; i < messages.length; i++) {
        if (messages[i].id == event.deletedID) {
          messages.removeAt(i);
        }
      }
      messages.sort((a, b) {
        DateTime dateA = DateTime.parse(a.effectiveDate);
        DateTime dateB = DateTime.parse(b.effectiveDate);
        return dateB.compareTo(dateA);
      });
      yield MessageLoadSuccessState(messages: messages);
    } else yield state;
  }

  Stream<MessageState> _mapMessageRefreshEventToState() async* {
    List<MessageModel> messages = new List<MessageModel>();
    final response = await Api.getMessageList();
    try {
      List<dynamic> list = response;
      List<String> deletedMessages = PreferenceHelper.getStringList(PrefParams.DELETED_MESSAGES) ?? [];
      list.forEach((element) {
        MessageModel message = MessageModel.fromJson(element);
        if (!deletedMessages.contains(message.id.toString())) {
          messages.add(message);
        }
      });
      messages.sort((a, b) {
        DateTime dateA = DateTime.parse(a.effectiveDate);
        DateTime dateB = DateTime.parse(b.effectiveDate);
        return dateB.compareTo(dateA);
      });
      yield MessageLoadingState();
      yield MessageLoadSuccessState(messages: messages);
    } catch (e) {
      yield MessageLoadingState();
      yield MessageLoadFailureState();
    }
  }
}