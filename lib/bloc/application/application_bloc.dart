import 'package:esdc_emg/bloc/app_bloc.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitialState());

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is ApplicationStartupEvent) {
      yield* _mapApplicationStartupEventToState();
    }
  }

  Stream<ApplicationState> _mapApplicationStartupEventToState() async* {
    /// Start Application Setup
    yield ApplicationLoadingState();

    /// Setup SharedPreferences
    Globals.preferences = await SharedPreferences.getInstance();

    AppBloc.messageBloc.add(MessageLoadEvent());

    /// Application Setup Completed
    yield ApplicationSetupState();
  }



}