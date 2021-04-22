import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(title: "Social media"),
    );
  }
}
