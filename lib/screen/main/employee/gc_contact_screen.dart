import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/employee/contact_detail_screen.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class GCContactScreen extends StatefulWidget {
  @override
  _GCContactScreenState createState() => _GCContactScreenState();
}

class _GCContactScreenState extends State<GCContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildAppbar(
            title: 'gc_contacts',
          ),
          SizedBox(
            height: 20,
          ),
          ItemSelectorRow(
            title: 'gc_directory',
            assetImage: 'asset/image/chat.svg',
            onClick: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebviewScreen(
                    title: 'gc_directory',
                    url: 'url_gc_directory',
                  ),
                )),
          ),
          ItemSelectorRow(
            title: 'contact_public_service_pay_center',
            assetImage: 'asset/image/chat.svg',
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
          ItemSelectorRow(
            title: 'contact_employee_assistance_program',
            assetImage: 'asset/image/chat.svg',
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
          ItemSelectorRow(
            title: 'contact_sunlife_health_care_plan',
            assetImage: 'asset/image/chat.svg',
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
          ItemSelectorRow(
            title: 'contact_pdsp',
            assetImage: 'asset/image/chat.svg',
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
          ItemSelectorRow(
            title: 'contact_general_inquiries',
            assetImage: 'asset/image/chat.svg',
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
          ItemSelectorRow(
            title: 'contact_nscc',
            assetImage: 'asset/image/chat.svg',
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
