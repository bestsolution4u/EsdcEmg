import 'package:meta/meta.dart';

@immutable
abstract class MessageEvent {}

class MessageLoadEvent extends MessageEvent {}

class MessageStatusUpdateEvent extends MessageEvent {
  final int messageID;
  final bool read;

  MessageStatusUpdateEvent({this.messageID, this.read});
}

class MessageDeleteEvent extends MessageEvent {
  final messageID;

  MessageDeleteEvent({this.messageID});
}

class MessageLastUrgentEvent extends MessageEvent {
  final int messageID;

  MessageLastUrgentEvent({this.messageID});
}

class MessageRefreshEvent extends MessageEvent {}