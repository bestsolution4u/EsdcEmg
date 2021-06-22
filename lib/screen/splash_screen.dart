import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Splash',
      excludeSemantics: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Image.asset('asset/image/bg-splash.png', width: double.infinity, height: double.infinity, fit: BoxFit.fill,),
      ),
    );
  }
}
