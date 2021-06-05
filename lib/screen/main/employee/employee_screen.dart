import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/dashboard/learning_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/screen/main/employee/covid_screen.dart';
import 'package:esdc_emg/screen/main/employee/pay_benefit_screen.dart';
import 'package:esdc_emg/screen/main/pdfviewer_screen.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/contact_item_row.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../webview_screen.dart';
import 'contact_detail_screen.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  int _sliding = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgGrey,
      appBar: ESDCAppbar.renderMainAppbar(
          title: 'title_emply',
          icon: 'asset/image/tab-employees-active.svg',
          context: context
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Text(AppLocalization.of(context).trans('resources'), style: TextStyle(color: Styles.darkerBlue, fontSize: 15),),
                  1: Text(AppLocalization.of(context).trans('contacts'), style: TextStyle(color: Styles.darkerBlue, fontSize: 15),),
                },
                groupValue: _sliding,
                onValueChanged: (newValue) {
                  setState(() {
                    _sliding = newValue;
                  });
                }),
          ),
          _sliding == 0 ? Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryLabel(label: 'heath_and_wellness'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ItemRow(title: 'title_covid', icon: 'asset/image/icon-row-covid.svg', isFirst: true, onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CovidScreen(),))),
                        ItemDivider(paddingLeft: 15),
                        ItemRow(title: 'wellness', icon: 'asset/image/icon-row-wellness.svg', isLast: true, onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessScreen(),))),
                      ],
                    ),
                  ),
                  CategoryLabel(label: 'remuneration'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ItemRow(title: 'pay_benefit_leave', icon: 'asset/image/icon-row-pay.svg', isFirst: true, onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PayBenefitScreen(),))),
                        ItemDivider(paddingLeft: 15),
                        ItemRow(title: 'holiday_pay_dates', icon: 'asset/image/icon-row-holidays.svg', isLast: true, onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerScreen(title: AppLocalization.of(context).trans('holiday_pay_dates'), pdfPath: 'asset/pdf/calendar.pdf',),))),
                      ],
                    ),
                  ),
                  CategoryLabel(label: 'career'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ItemRow(title: 'learning', icon: 'asset/image/icon-row-learning.svg', iconSize: 14, isFirst: true, onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearningScreen(),))),
                        ItemDivider(paddingLeft: 15),
                        ItemRow(title: 'gc_jobs', icon: 'asset/image/icon-row-gcjobs.svg', onClick: () {
                          launch(AppLocalization.of(context).trans('url_gc_jobs'));
                        }),
                        ItemDivider(paddingLeft: 15),
                        ItemRow(title: 'award_recognition', icon: 'asset/image/icon-row-awards.svg', isLast: true, onClick: () => gotoWebviewScreen(title: 'award_recognition', url: 'url_award_recognition')),
                      ],
                    ),
                  ),
                  CategoryLabel(label: 'gc_network'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        ItemRow(title: 'gc_directory', icon: 'asset/image/icon-row-gcdirectory.svg', isFirst: true, onClick: () {
                          launch(AppLocalization.of(context).trans('url_gc_directory'));
                        }),
                        ItemDivider(paddingLeft: 15),
                        ItemRow(title: 'esdc_web', icon: 'asset/image/icon-row-esdcwebsite.svg', isLast: true, onClick: () => gotoWebviewScreen(title: 'esdc_web', url: 'url_esdc_web')),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ) : Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ContactItemRow(
                    title: 'contact_public_service_pay_center',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_public_service_pay_center',
                            phone1: 'phone_contact_service_pay_center',
                            website: 'site_contact_public_service_pay_center',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_employee_assistance_program',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_employee_assistance_program',
                            phone1: 'phone_contact_employee_assistance_program',
                            website: 'site_contact_employee_assistance_program',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_sun_life',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_sun_life',
                            phone1: 'phone_contact_sun_life',
                            website: 'site_contact_sun_life',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_sunlife_health_care_plan',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_sunlife_health_care_plan',
                            phone1: 'phone_contact_sunlife_health_care_plan_toll',
                            phoneDesc1: 'phone_contact_sunlife_health_care_plan_toll_desc',
                            phone2: 'phone_contact_sunlife_health_care_plan_region',
                            phoneDesc2: 'phone_contact_sunlife_health_care_plan_region_desc',
                            website: 'site_contact_sunlife_health_care_plan',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_pdsp',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_pdsp',
                            phone1: 'phone_contact_pdsp',
                            website: 'site_contact_pdsp',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_general_inquiries',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_general_inquiries',
                            phone1: 'phone_contact_general_inquiries',
                            website: 'site_contact_general_inquiries',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_nscc',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_nscc',
                            phone1: 'phone_contact_nscc',
                            website: 'site_contact_nscc',
                          ),
                        )),
                  ),
                  ItemDivider(paddingLeft: 20),
                  ContactItemRow(
                    title: 'contact_psmip',
                    onClick: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(
                            title: 'contact_psmip',
                            phone1: 'phone_contact_psmip',
                            website: 'site_contact_psmip',
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoWebviewScreen({String title, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: title, url: url,),));
  }
}
