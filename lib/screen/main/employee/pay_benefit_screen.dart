import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class PayBenefitScreen extends StatefulWidget {
  @override
  _PayBenefitScreenState createState() => _PayBenefitScreenState();
}

class _PayBenefitScreenState extends State<PayBenefitScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: 'pay_benefit_leave',
              ),
              CategoryLabel(label: 'collective_agreement_and_pay'),
              ItemSelectorRow(
                title: 'collective_agreement',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'collective_agreement', url: "url_collective_agreement"),
              ),
              ItemSelectorRow(
                title: 'public_service_pay_center',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'public_service_pay_center', url: "url_public_service_pay_center"),
              ),
              ItemSelectorRow(
                title: 'how_your_pay',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'how_your_pay', url: "url_how_your_pay"),
              ),
              ItemSelectorRow(
                title: 'occupational_group',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'occupational_group', url: "url_occupational_group"),
              ),
              CategoryLabel(label: 'benefits_and_pension'),
              ItemSelectorRow(
                title: 'sun_life_web',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'sun_life_web', url: "url_sun_life_web"),
              ),
              ItemSelectorRow(
                title: 'psimp',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'psimp', url: "url_psimp"),
              ),
              ItemSelectorRow(
                title: 'public_pensions',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'public_pensions', url: "url_public_pensions"),
              ),
              CategoryLabel(label: 'leave_and_vacation'),
              ItemSelectorRow(
                title: 'leave_requirement',
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: 'leave_requirement', url: "url_leave_requirement"),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebviewScreen(
            title: title,
            url: url,
          ),
        ));
  }
}
