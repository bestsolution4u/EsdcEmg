import 'dart:convert';

import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/bloc/message/bloc.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageLoadingState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageLoadEvent) {
      yield* _mapMessageLoadEventToState();
    }
  }

  Stream<MessageState> _mapMessageLoadEventToState() async* {
    yield MessageLoadingState();
    List<MessageModel> messages = new List<MessageModel>();
    final response = await Api.getMessageList();
    try {
      List<dynamic> list = response;
      list.forEach((element) {
        MessageModel message = MessageModel.fromJson(element);
        messages.add(message);
      });
      yield MessageLoadSuccessState(messages: messages);
    } catch (e) {
      yield MessageLoadFailureState();
    }
  }
}