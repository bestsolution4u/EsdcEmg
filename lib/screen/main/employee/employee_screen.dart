import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/dashboard/learning_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/screen/main/employee/calendar_screen.dart';
import 'package:esdc_emg/screen/main/employee/cell_calendar_screen.dart';
import 'package:esdc_emg/screen/main/employee/covid_screen.dart';
import 'package:esdc_emg/screen/main/employee/pay_benefit_screen.dart';
import 'package:esdc_emg/screen/main/pdfviewer_screen.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/contact_item_row.dart';
import 'package:esdc_emg/widget/row/item_divider.dart';
import 'package:esdc_emg/widget/row/item_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
    return Semantics(
      container: true,
      explicitChildNodes: true,
      focusable: true,
      focused: true,
      label: AppLocalization.of(context).trans("resource_page_loaded"),
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Styles.bgGrey,
            appBar: ESDCAppbar.renderMainAppbar(
                title: 'title_emply',
                icon: 'asset/image/tab-employees-active.svg',
                context: context),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: AppLocalization.of(context).trans('resources'),
                      ),
                      Tab(
                        text: AppLocalization.of(context).trans('contacts'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          CategoryLabel(label: 'heath_and_wellness'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                ItemRow(
                                    title: 'title_covid',
                                    icon: 'asset/image/icon-row-covid.svg',
                                    isFirst: true,
                                    sortKey: 1,
                                    onClick: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CovidScreen(),
                                        ))),
                                ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'wellness',
                                    icon: 'asset/image/icon-row-wellness.svg',
                                    isLast: true,
                                    sortKey: 2,
                                    onClick: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WellnessScreen(),
                                        ))),
                              ],
                            ),
                          ),
                          CategoryLabel(label: 'remuneration'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                ItemRow(
                                    title: 'pay_benefit_leave',
                                    icon: 'asset/image/icon-row-pay.svg',
                                    isFirst: true,
                                    sortKey: 3,
                                    onClick: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PayBenefitScreen(),
                                        ))),
                                ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'holiday_pay_dates_pdf',
                                    icon: 'asset/image/icon-row-holidays.svg',
                                    sortKey: 4,
                                    isLast: true,
                                    onClick: () async {
                                      Directory directory =
                                          await getApplicationDocumentsDirectory();
                                      var tempPath =
                                          join(directory.path, "calendar.pdf");
                                      if (!(await File(tempPath).exists())) {
                                        ByteData data = await rootBundle
                                            .load("asset/pdf/calendar.pdf");
                                        List<int> bytes = data.buffer
                                            .asUint8List(data.offsetInBytes,
                                                data.lengthInBytes);
                                        await File(tempPath)
                                            .writeAsBytes(bytes);
                                      }
                                      OpenFile.open(tempPath);
                                    }),
                                /*ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'holiday_pay_dates',
                                    icon: 'asset/image/icon-row-holidays.svg',
                                    isLast: true,
                                    sortKey: 4,
                                    onClick: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CalendarScreen()))),*/
                              ],
                            ),
                          ),
                          CategoryLabel(label: 'career'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                ItemRow(
                                    title: 'learning',
                                    icon: 'asset/image/icon-row-learning.svg',
                                    iconSize: 14,
                                    isFirst: true,
                                    sortKey: 5,
                                    onClick: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LearningScreen(),
                                        ))),
                                ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'gc_jobs',
                                    icon: 'asset/image/icon-row-gcjobs.svg',
                                    sortKey: 6,
                                    onClick: () {
                                      launch(AppLocalization.of(context)
                                          .trans('url_gc_jobs'));
                                    }),
                                ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'award_recognition',
                                    icon: 'asset/image/icon-row-awards.svg',
                                    isLast: true,
                                    sortKey: 7,
                                    onClick: () => gotoWebviewScreen(
                                        context: context,
                                        title: 'award_recognition',
                                        url: 'url_award_recognition')),
                              ],
                            ),
                          ),
                          CategoryLabel(label: 'gc_network'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                ItemRow(
                                    title: 'gc_directory',
                                    icon:
                                        'asset/image/icon-row-gcdirectory.svg',
                                    isFirst: true,
                                    sortKey: 8,
                                    onClick: () {
                                      launch(AppLocalization.of(context)
                                          .trans('url_gc_directory'));
                                    }),
                                ItemDivider(paddingLeft: 15),
                                ItemRow(
                                    title: 'esdc_web',
                                    sortKey: 9,
                                    icon:
                                        'asset/image/icon-row-esdcwebsite.svg',
                                    isLast: true,
                                    onClick: () => gotoWebviewScreen(
                                        context: context,
                                        title: 'esdc_web',
                                        url: 'url_esdc_web')),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ContactItemRow(
                            title: 'contact_public_service_pay_center',
                            sortKey: 10,
                            onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactDetailScreen(
                                    title: 'contact_public_service_pay_center',
                                    phone1: 'phone_contact_service_pay_center',
                                    website:
                                        'site_contact_public_service_pay_center',
                                  ),
                                )),
                          ),
                          ItemDivider(paddingLeft: 20),
                          ContactItemRow(
                            title: 'contact_employee_assistance_program',
                            sortKey: 11,
                            onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactDetailScreen(
                                    title:
                                        'contact_employee_assistance_program',
                                    phone1:
                                        'phone_contact_employee_assistance_program',
                                    website:
                                        'site_contact_employee_assistance_program',
                                    description: 'eap_desc',
                                  ),
                                )),
                          ),
                          ItemDivider(paddingLeft: 20),
                          ContactItemRow(
                            title: 'contact_sun_life',
                            sortKey: 12,
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
                            sortKey: 13,
                            onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactDetailScreen(
                                    title: 'contact_sunlife_health_care_plan',
                                    phone1:
                                        'phone_contact_sunlife_health_care_plan_toll',
                                    phoneDesc1:
                                        'phone_contact_sunlife_health_care_plan_toll_desc',
                                    phone2:
                                        'phone_contact_sunlife_health_care_plan_region',
                                    phoneDesc2:
                                        'phone_contact_sunlife_health_care_plan_region_desc',
                                    website:
                                        'site_contact_sunlife_health_care_plan',
                                  ),
                                )),
                          ),
                          ItemDivider(paddingLeft: 20),
                          ContactItemRow(
                            title: 'contact_pdsp',
                            sortKey: 14,
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
                            sortKey: 15,
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
                            sortKey: 16,
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
                            sortKey: 17,
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
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }

  void gotoWebviewScreen({BuildContext context, String title, String url}) {
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
