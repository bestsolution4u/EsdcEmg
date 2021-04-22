import 'package:meta/meta.dart';

@immutable
abstract class MessageEvent {}

class MessageLoadEvent extends MessageEvent {}