import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/employee/covid_screen.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_row.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class PayBenefitScreen extends StatefulWidget {
  @override
  _PayBenefitScreenState createState() => _PayBenefitScreenState();
}

class _PayBenefitScreenState extends State<PayBenefitScreen> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Pay benefit screen loaded",
      value: "Pay benefit screen loaded",
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: 'pay_benefit_leave',
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Styles.lightGray,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel(label: 'collective_agreement_and_pay'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            ItemRow(
                                title: 'collective_agreement',
                                icon: 'asset/image/icon-row-collective.svg',
                                sortKey: 1,
                                isFirst: true,
                                onClick: () => gotoWebviewScreen(
                                    title: 'collective_agreement',
                                    url: "url_collective_agreement")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'public_service_pay_center',
                                icon: 'asset/image/icon-row-pspc.svg',
                                sortKey: 2,
                                onClick: () => gotoWebviewScreen(
                                    title: 'public_service_pay_center',
                                    url: "url_public_service_pay_center")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'how_your_pay',
                                icon: 'asset/image/icon-row-how-pay.svg',
                                sortKey: 3,
                                onClick: () => gotoWebviewScreen(
                                    title: 'how_your_pay',
                                    url: "url_how_your_pay")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'tbs_pay',
                                icon: 'asset/image/icon-row-tbs-pay-rates.svg',
                                sortKey: 4,
                                onClick: () => gotoWebviewScreen(
                                    title: 'tbs_pay', url: "url_tbs_pay")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'occupational_group',
                                icon: 'asset/image/icon-row-occupational.svg',
                                sortKey: 5,
                                isLast: true,
                                onClick: () => gotoWebviewScreen(
                                    title: 'occupational_group',
                                    url: "url_occupational_group")),
                          ],
                        ),
                      ),
                      CategoryLabel(label: 'benefits_and_pension'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            ItemRow(
                                title: 'sun_life_web',
                                icon: 'asset/image/icon-row-sunlife.svg',
                                sortKey: 6,
                                isFirst: true,
                                onClick: () => gotoWebviewScreen(
                                    title: 'sun_life_web',
                                    url: "url_sun_life_web")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'psimp',
                                icon: 'asset/image/icon-row-psimp.svg',
                                sortKey: 7,
                                onClick: () => gotoWebviewScreen(
                                    title: 'psimp', url: "url_psimp")),
                            ItemDivider(paddingLeft: 15),
                            ItemRow(
                                title: 'public_pensions',
                                icon: 'asset/image/icon-row-pensions.svg',
                                isLast: true,
                                sortKey: 8,
                                onClick: () => gotoWebviewScreen(
                                    title: 'public_pensions',
                                    url: "url_public_pensions")),
                          ],
                        ),
                      ),
                      CategoryLabel(label: 'leave_and_vacation'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            ItemRow(
                                title: 'leave_requirement',
                                icon: 'asset/image/icon-row-leave.svg',
                                sortKey: 9,
                                isFirst: true,
                                isLast: true,
                                onClick: () => gotoWebviewScreen(
                                    title: 'leave_requirement',
                                    url: "url_leave_requirement")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
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
