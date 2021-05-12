import 'package:esdc_emg/model/message_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageState {}

class MessageLoadingState extends MessageState {}

class MessageLoadSuccessState extends MessageState {
  final List<MessageModel> messages;
  final List<int> readMessages, deletedMessages;
  final int lastUrgent;

  MessageLoadSuccessState({this.messages, this.readMessages, this.deletedMessages, this.lastUrgent});
}

class MessageLoadFailureState extends MessageState {}
