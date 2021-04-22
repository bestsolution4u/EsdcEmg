import 'package:esdc_emg/bloc/message/bloc.dart';
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

    yield MessageLoadSuccessState(messages: []);
  }
}