import 'package:esdc_emg/model/message_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageState {}

class MessageLoadingState extends MessageState {}

class MessageLoadSuccessState extends MessageState {
  final List<MessageModel> messages;

  MessageLoadSuccessState({this.messages});
}

class MessageLoadFailureState extends MessageState {}
