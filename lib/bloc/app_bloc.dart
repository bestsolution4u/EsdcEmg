import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {

  static final applicationBloc = ApplicationBloc();
  static final messageBloc = MessageBloc();
  static final settingBloc = SettingBloc();
  static final vpnBloc = VPNBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(create: (context) => applicationBloc),
    BlocProvider<MessageBloc>(create: (context) => messageBloc),
    BlocProvider<SettingBloc>(create: (context) => settingBloc),
    BlocProvider<VPNBloc>(create: (context) => vpnBloc),
  ];

  static void dispose() {
    applicationBloc.close();
    messageBloc.close();
    settingBloc.close();
    vpnBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();
  factory AppBloc() {
    return _instance;
  }
  AppBloc._internal();
}