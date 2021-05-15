import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization_delegate.dart';
import 'package:esdc_emg/screen/intro_screen.dart';
import 'package:esdc_emg/screen/main/main_screen.dart';
import 'package:esdc_emg/screen/splash_screen.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/app_bloc.dart';
import 'bloc/bloc.dart';
import 'config/route.dart';

class EsdcEmgApp extends StatefulWidget {
  @override
  _EsdcEmgAppState createState() => _EsdcEmgAppState();
}

class _EsdcEmgAppState extends State<EsdcEmgApp> {
  final routes = Routes();
  AppLocalizationsDelegate _localizationsDelegate;

  @override
  void initState() {
    super.initState();
    AppBloc.applicationBloc.add(ApplicationStartupEvent());
    _localizationsDelegate = AppLocalizationsDelegate(locale: null);
    Globals.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _localizationsDelegate = AppLocalizationsDelegate(locale: locale);
    });
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
        providers: AppBloc.blocProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes.generateRoute,
          localizationsDelegates: [
            _localizationsDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: Globals.SupportedLanguageCodes.map<Locale>((language) => Locale(language, "")),
          theme: ThemeData(
            primaryColor: Colors.white,
            platform: TargetPlatform.iOS,
            appBarTheme: AppBarTheme(color: Colors.white),
            fontFamily: 'PopBlack',
          ),
          home: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              if (state is ApplicationSetupState) {
                return BlocListener<SettingBloc, SettingState>(
                  listener: (context, settingState) {
                    if (settingState is SettingLoadSuccessState) {
                      Globals.onLocaleChanged(Locale(settingState.settings.language));
                    }
                  },
                  child: MainScreen(),
                );
              } else if (state is ApplicationIntroState) {
                return IntroScreen();
              } else {
                return SplashScreen();
              }
            },
          ),
        ));
  }
}
