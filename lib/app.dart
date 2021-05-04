import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/main_screen.dart';
import 'package:esdc_emg/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';
import 'bloc/bloc.dart';
import 'config/route.dart';

class EsdcEmgApp extends StatefulWidget {
  @override
  _EsdcEmgAppState createState() => _EsdcEmgAppState();
}

class _EsdcEmgAppState extends State<EsdcEmgApp> {

  final routes = Routes();

  @override
  void initState() {
    super.initState();
    AppBloc.applicationBloc.add(ApplicationStartupEvent());
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Styles.lightGray,
      statusBarIconBrightness: Brightness.dark,
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
          theme: ThemeData(
            primaryColor: Colors.white,
            platform: TargetPlatform.iOS,
              appBarTheme: AppBarTheme(color: Colors.white),
            fontFamily: 'PopBlack',
          ),
          home: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              if (state is ApplicationSetupState) return MainScreen();
              return SplashScreen();
            },
          ),
        )
    );
  }
}