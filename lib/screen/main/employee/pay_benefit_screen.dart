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
                title: translate('pay_benefit_leave'),
              ),
              CategoryLabel(label: translate('collective_agreement_and_pay')),
              ItemSelectorRow(
                title: translate('collective_agreement'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('collective_agreement'), url: "https://www.canada.ca/en/government/publicservice/pay.html"),
              ),
              ItemSelectorRow(
                title: translate('public_service_pay_center'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('public_service_pay_center'), url: "https://www.canada.ca/en/treasury-board-secretariat/topics/pay.html"),
              ),
              ItemSelectorRow(
                title: translate('how_your_pay'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('how_your_pay'), url: "https://www.tpsgc-pwgsc.gc.ca/remuneration-compensation/services-paye-pay-services/paye-information-pay/paye-talon-stub-pay-eng.html"),
              ),
              ItemSelectorRow(
                title: translate('occupational_group'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('occupational_group'), url: "https://www.canada.ca/en/treasury-board-secretariat/services/collective-agreements/occupational-groups.html"),
              ),
              CategoryLabel(label: translate('benefits_and_pension').toUpperCase()),
              ItemSelectorRow(
                title: translate('sun_life_web'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('sun_life_web'), url: "https://www.sunlife.ca/en/"),
              ),
              ItemSelectorRow(
                title: translate('psimp'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('psimp'), url: "https://www.canada.ca/en/treasury-board-secretariat/topics/benefit-plans/plans/management-insurance-plan.html"),
              ),
              ItemSelectorRow(
                title: translate('public_pensions'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('public_pensions'), url: "https://www.tpsgc-pwgsc.gc.ca/comm/index-eng.html"),
              ),
              CategoryLabel(label: translate('leave_and_vacation').toUpperCase()),
              ItemSelectorRow(
                title: translate('occupational_group'),
                assetImage: 'asset/image/chat.svg',
                onClick: () => gotoWebviewScreen(title: translate('leave_requirement'), url: "https://www.tpsgc-pwgsc.gc.ca/remuneration-compensation/services-paye-pay-services/paye-information-pay/vie-life/vie-conge-life-leave/index-eng.html"),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  String translate(String key) {
    return AppLocalization.of(context).trans(key);
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
