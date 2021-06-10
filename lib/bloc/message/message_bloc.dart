import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/bloc/message/bloc.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/message_util.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageLoadingState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageLoadEvent) {
      yield* _mapMessageLoadEventToState();
    } else if (event is MessageStatusUpdateEvent) {
      yield* _mapMessageStatusUpdateEventToState(event);
    } else if (event is MessageDeleteEvent) {
      yield* _mapMessageDeleteEventToState(event);
    } else if (event is MessageLastUrgentEvent) {
      yield* _mapMessageLastUrgentEventToState(event);
    } else if (event is MessageRefreshEvent) {
      yield* _mapMessageRefreshEventToState();
    }
  }

  Stream<MessageState> _mapMessageLoadEventToState() async* {
    yield MessageLoadingState();
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> messageStatus = (await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").get()).data() ?? {};
    List<int> readMessages = messageStatus['read'] == null ? [] : messageStatus['read'].cast<int>();
    List<int> deletedMessages = messageStatus['deleted'] == null ? [] : messageStatus['deleted'].cast<int>();
    int lastUrgent = messageStatus['lastUrgent'] ?? 0;
    List<MessageModel> messages = new List<MessageModel>();
    final response = await Api.getMessageList();
    try {
      List<dynamic> list = response;
      list.forEach((element) {
        MessageModel message = MessageModel.fromJson(element);
        if (!deletedMessages.contains(message.id)) {
          messages.add(message);
        }
      });
      yield MessageLoadSuccessState(messages: MessageUtils.sortMessageFromNewToOld(messages), readMessages: readMessages, deletedMessages: deletedMessages, lastUrgent: lastUrgent);
    } catch (e) {
      yield MessageLoadFailureState();
    }
  }

  Stream<MessageState> _mapMessageStatusUpdateEventToState(MessageStatusUpdateEvent event) async* {
    List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
    List<int> readMessages = (state as MessageLoadSuccessState).readMessages;
    List<int> deletedMessages = (state as MessageLoadSuccessState).deletedMessages;
    int lastUrgent = (state as MessageLoadSuccessState).lastUrgent;
    int messageID = event.messageID;
    bool read = event.read;
    if (read) {
      readMessages.add(messageID);
    } else {
      readMessages.removeWhere((item) => item == messageID);
      print("---------- remove item ---------");
      print(messageID);
      print(readMessages);
    }
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> value = {
      "read": readMessages,
      "deleted": deletedMessages,
      "lastUrgent": lastUrgent
    };
    try {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(value);
    } catch (e) {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(value);
    } finally {
      yield MessageLoadingState();
      yield MessageLoadSuccessState(messages: MessageUtils.sortMessageFromNewToOld(messages), readMessages: readMessages, deletedMessages: deletedMessages, lastUrgent: lastUrgent);
    }
  }

  Stream<MessageState> _mapMessageDeleteEventToState(MessageDeleteEvent event) async* {
    List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
    List<int> readMessages = (state as MessageLoadSuccessState).readMessages;
    List<int> deletedMessages = (state as MessageLoadSuccessState).deletedMessages;
    int lastUrgent = (state as MessageLoadSuccessState).lastUrgent;
    int messageID = event.messageID;
    readMessages.removeWhere((item) => item == messageID);
    deletedMessages.add(messageID);
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> value = {
      "read": readMessages,
      "deleted": deletedMessages,
      "lastUrgent": lastUrgent
    };
    try {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(value);
    } catch (e) {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(value);
    } finally {
      messages.removeWhere((element) => element.id == messageID);
      yield MessageLoadingState();
      yield MessageLoadSuccessState(messages: MessageUtils.sortMessageFromNewToOld(messages), readMessages: readMessages, deletedMessages: deletedMessages, lastUrgent: lastUrgent);
    }
  }

  Stream<MessageState> _mapMessageLastUrgentEventToState(MessageLastUrgentEvent event) async* {
    List<MessageModel> messages = (state as MessageLoadSuccessState).messages;
    List<int> readMessages = (state as MessageLoadSuccessState).readMessages;
    List<int> deletedMessages = (state as MessageLoadSuccessState).deletedMessages;
    int lastUrgent = event.messageID;
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> value = {
      "read": readMessages,
      "deleted": deletedMessages,
      "lastUrgent": lastUrgent
    };
    try {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").update(value);
    } catch (e) {
      await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").set(value);
    } finally {
      yield MessageLoadingState();
      yield MessageLoadSuccessState(messages: MessageUtils.sortMessageFromNewToOld(messages), readMessages: readMessages, deletedMessages: deletedMessages, lastUrgent: lastUrgent);
    }
  }

  Stream<MessageState> _mapMessageRefreshEventToState() async* {
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> messageStatus = (await firestore.collection("message").doc("${PreferenceHelper.getString(PrefParams.DEVICE_ID)}").get()).data() ?? {};
    List<int> readMessages = messageStatus['read'] == null ? [] : messageStatus['read'].cast<int>();
    List<int> deletedMessages = messageStatus['deleted'] == null ? [] : messageStatus['deleted'].cast<int>();
    int lastUrgent = messageStatus['lastUrgent'] ?? 0;
    List<MessageModel> messages = new List<MessageModel>();
    final response = await Api.getMessageList();
    try {
      List<dynamic> list = response;
      list.forEach((element) {
        MessageModel message = MessageModel.fromJson(element);
        if (!deletedMessages.contains(message.id)) {
          messages.add(message);
        }
      });
      yield MessageLoadingState();
      yield MessageLoadSuccessState(messages: MessageUtils.sortMessageFromNewToOld(messages), readMessages: readMessages, deletedMessages: deletedMessages, lastUrgent: lastUrgent);
    } catch (e) {
      yield MessageLoadingState();
      yield MessageLoadFailureState();
    }
  }
}