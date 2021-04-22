import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(title: "Employees"),
    );
  }
}
