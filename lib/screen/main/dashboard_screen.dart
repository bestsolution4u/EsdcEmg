import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(
          title: "MyESDC",
          action: AppIconButton(
            icon: SvgPicture.asset(
              'asset/image/settings.svg',
              color: Styles.textBlack,
              allowDrawingOutsideViewBox: true,
              height: 24,
            ),
            onClick: () {

            },
            rippleRadius: 40,
            padding: 16,
          )),
    );
  }
}
