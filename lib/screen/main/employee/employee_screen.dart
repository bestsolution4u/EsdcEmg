import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/dashboard/learning_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/screen/main/employee/covid_screen.dart';
import 'package:esdc_emg/screen/main/employee/gc_contact_screen.dart';
import 'package:esdc_emg/screen/main/employee/pay_benefit_screen.dart';
import 'package:esdc_emg/screen/main/pdfviewer_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

import '../webview_screen.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.generateMainAppbar(title: "title_emply", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'heath_and_wellness'),
            ItemSelectorRow(title: 'title_covid', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CovidScreen(),)),),
            ItemSelectorRow(title: 'wellness', assetImage: 'asset/image/employee_wellness.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessScreen(),)),),
            CategoryLabel(label: 'remuneration'),
            ItemSelectorRow(title: 'pay_benefit_leave', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PayBenefitScreen(),)),),
            ItemSelectorRow(title: 'holiday_pay_dates', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(title: 'Holidays and pay dates', pdfPath: 'asset/pdf/calendar.pdf',),)),),
            CategoryLabel(label: 'career'),
            ItemSelectorRow(title: 'learning', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearningScreen(),)),),
            ItemSelectorRow(title: 'gc_jobs', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'gc_jobs', url: 'url_gc_jobs'),),
            ItemSelectorRow(title: 'award_recognition', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'award_recognition', url: 'url_award_recognition'),),
            CategoryLabel(label: 'gc_network'),
            ItemSelectorRow(title: 'esdc_web', assetImage: 'asset/image/chat.svg', onClick: () => gotoWebviewScreen(title: 'esdc_web', url: 'url_esdc_web'),),
            ItemSelectorRow(title: 'gc_contacts', assetImage: 'asset/image/chat.svg', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GCContactScreen(),)),),
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
