import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/learning_screen.dart';
import 'package:esdc_emg/screen/main/pdfviewer_screen.dart';
import 'package:esdc_emg/screen/main/wellness_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import 'webview_screen.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.generateMainAppbar(title: "Employees"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'HEALTH AND WELLNESS'),
            ItemSelectorRow(title: 'COVID-19', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Wellness', assetImage: 'asset/image/employee_wellness.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessScreen(),)),),
            CategoryLabel(label: 'REMUNERATION'),
            ItemSelectorRow(title: 'Pay, benefit, leave', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Holidays and pay dates', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(title: 'Holidays and pay dates', pdfPath: 'asset/pdf/calendar.pdf',),)),),
            CategoryLabel(label: 'CAREER'),
            ItemSelectorRow(title: 'Learning', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearningScreen(),)),),
            ItemSelectorRow(title: 'GC Jobs', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'GC Jobs', url: 'https://www.canada.ca/en/services/jobs/opportunities/government.html'),),
            ItemSelectorRow(title: 'Awards and recognition', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'Awards and recognition', url: 'https://www.canada.ca/en/treasury-board-secretariat/services/innovation/awards-recognition-special-events.html'),),
            CategoryLabel(label: 'GC NETWORK'),
            ItemSelectorRow(title: 'ESDC website', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'ESDC Website', url: 'https://www.canada.ca/en/employment-social-development.html'),),
            ItemSelectorRow(title: 'GC contacts', assetImage: 'asset/image/chat.svg', onClick: () {},),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
