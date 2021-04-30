import 'package:meta/meta.dart';

@immutable
abstract class MessageEvent {}

class MessageLoadEvent extends MessageEvent {}

class MessageDeleteEvent extends MessageEvent {
  final deletedID;

  MessageDeleteEvent({this.deletedID});
}