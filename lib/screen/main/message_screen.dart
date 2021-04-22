import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(
          title: "Messages",
          action: AppIconButton(
            icon: SvgPicture.asset(
              'asset/image/setting.svg',
              color: Styles.textBlack,
              allowDrawingOutsideViewBox: true,
              height: 24,
            ),
            onClick: () {},
            rippleRadius: 36,
            padding: 12,
          )),
    );
  }
}
