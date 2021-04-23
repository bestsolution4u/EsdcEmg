import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

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
            ItemSelectorRow(title: 'Wellness', assetImage: 'asset/image/employee_wellness.svg', onClick: () {},),
            CategoryLabel(label: 'REMUNERATION'),
            ItemSelectorRow(title: 'Pay, benefit, leave', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Holidays and pay dates', assetImage: 'asset/image/chat.svg', onClick: () {},),
            CategoryLabel(label: 'CAREER'),
            ItemSelectorRow(title: 'Learning', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'GC Jobs', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Awards and recognition', assetImage: 'asset/image/chat.svg', onClick: () {},),
            CategoryLabel(label: 'GC NETWORK'),
            ItemSelectorRow(title: 'ESDC website', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'GC contacts', assetImage: 'asset/image/chat.svg', onClick: () {},),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
