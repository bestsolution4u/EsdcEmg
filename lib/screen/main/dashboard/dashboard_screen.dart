import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/screen/main/dashboard/feedback_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/setting_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/dashboard_button.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/vpn_status_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'learning_screen.dart';

class DashboardScreen extends StatefulWidget {

  final VoidCallback onUrgentClick;

  DashboardScreen({this.onUrgentClick});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<VPNStatusModel> vpnStatusList = [];
  MessageBloc _messageBloc;

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "KEC","status": "UP","usage": "78","description": "MODERATE"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MTL","status": "DOWN","usage": "100","description": "BAD"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MCT","status": "UP","usage": "24","description": "GOOD"}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ESDCAppbar.generateMainAppbar(
        context: context,
          title: 'app_title_home',
          action: AppIconButton(
            icon: SvgPicture.asset(
              'asset/image/settings.svg',
              color: Styles.textBlack,
              allowDrawingOutsideViewBox: true,
              height: 24,
            ),
            onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(),)),
            rippleRadius: 40,
            padding: 16,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //buildSearchbox(),
            buildUrgentMessage(),
            SizedBox(height: 20,),
            buildCovidTraining(),
            SizedBox(height: 20,),
            DashboardButton(
              title: AppLocalization.of(context).trans('employ_wellness'),
              icon: SvgPicture.asset(
                'asset/image/employee_wellness.svg',
                color: Styles.textBlack,
                allowDrawingOutsideViewBox: true,
                height: 28,
              ),
              onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessScreen(),)),
            ),
            DashboardButton(
              title: AppLocalization.of(context).trans('learning'),
              icon: SvgPicture.asset(
                'asset/image/chat.svg',
                color: Styles.textBlack,
                allowDrawingOutsideViewBox: true,
                height: 28,
              ),
              onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearningScreen(),)),
            ),
            SizedBox(height: 10,),
            Divider(height: 1,),
            SizedBox(height: 10,),
            buildVPN(),
            SizedBox(height: 10,),
            Divider(height: 1,),
            SizedBox(height: 10,),
            DashboardButton(
              title: AppLocalization.of(context).trans('send_us_feedback'),
              icon: SvgPicture.asset(
                'asset/image/chat.svg',
                color: Styles.textBlack,
                allowDrawingOutsideViewBox: true,
                height: 28,
              ),
              onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchbox() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Styles.darkGray,
            width: 1,
          ),
        ),
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                'asset/image/search.svg',
                color: Styles.darkGray,
                allowDrawingOutsideViewBox: true,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    suffixIcon: AppIconButton(
                      icon: Icon(
                        Icons.mic,
                        size: 28,
                        color: Styles.darkGray,
                      ),
                      onClick: () {},
                      rippleRadius: 8,
                      padding: 0,
                    ),
                    hintText: 'Search the app',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(color: Styles.textBlack, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUrgentMessage() {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is MessageLoadingState || state is MessageLoadFailureState) {
          return Container();
        } else {
          List<MessageModel> urgents = MessageUtils.filterUrgentMessages((state as MessageLoadSuccessState).messages);
          int lastUrgent = (state as MessageLoadSuccessState).lastUrgent;
          int lastID = MessageUtils.getLastMessageId(urgents);
          if (urgents == null || urgents.isEmpty || lastUrgent >= lastID) {
            return Container();
          } else {
            return RippleComponent(
                onClick: () {
                  widget.onUrgentClick();
                  _messageBloc.add(MessageLastUrgentEvent(messageID: lastID));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Styles.red,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.warning_amber_sharp,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalization.of(context).trans('urgent_message'),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        size: 25,
                        color: Colors.white,
                      )
                    ],
                  ),
                ));
          }
        }
      },
    );
  }

  Widget buildCovidTraining() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: RippleComponent(
        onClick: () => launch(AppLocalization.of(context).trans('url_covid_active_screening')),
        child: Card(
          color: Styles.purple,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalization.of(context).trans('active_screening'),
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, height: 1.5),
                          ),
                          /*TextSpan(
                            text: AppLocalization.of(context).trans('disclaimer_text'),
                            style: TextStyle(color: Colors.white, fontSize: 12, height: 1.5),
                          ),*/
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVPN() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'asset/image/wifi.svg',
                color: Styles.primaryColor,
                allowDrawingOutsideViewBox: true,
                height: 28,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                AppLocalization.of(context).trans('vpn_status'),
                maxLines: 2,
                style: TextStyle(
                    color: Styles.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalization.of(context).trans('last_updated') + " May 8, 2021, 10:36 am EST", style: TextStyle(color: Styles.primaryColor, fontSize: 12),),
                SizedBox(height: 10,),
                ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => VpnStatusRow(vpnStatus: vpnStatusList[index],),
                    separatorBuilder: (context, index) => Divider(height: 16, thickness: 1,),
                    itemCount: vpnStatusList.length)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
