import 'dart:async';

import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {

  FeedbackScreen();

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(title: "Send us feedback",),

            ],
          ),
        )
    );
  }
}
