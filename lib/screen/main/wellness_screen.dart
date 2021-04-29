import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class WellnessScreen extends StatefulWidget {
  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildAppbar(
            title: "Wellness",
          ),
          SizedBox(height: 20,),
          ItemSelectorRow(
            title: 'Employee Assistance Program',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(
                title: "Employee Assistance Program",
                url: "https://www.canada.ca/en/government/publicservice/wellness-inclusion-diversity-public-service/employee-assistance-program.html#E"),
          ),
          ItemSelectorRow(
            title: 'Life Speak',
            assetImage: 'asset/image/chat.svg',
            onClick: () => gotoWebviewScreen(
              title: "Life Speak",
              url: "https://www.canada.ca/en/department-national-defence/maple-leaf/defence/2020/03/lifespeak-your-virtual-library-for-total-well-being.html"
            ),
          ),
        ],
      ),
    ));
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
