import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/screen/main/dashboard/feedback_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/setting_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/category_button.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/vpn_status_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:instant/instant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "KEC","status": "UP","usage": "78","description": "MODERATE"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MTL","status": "DOWN","usage": "100","description": "BAD"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MCT","status": "UP","usage": "24","description": "GOOD"}));
    _controller = YoutubePlayerController(
      initialVideoId: 'KY_01FX06dw',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: false,
      ),
    )..addListener(listener);
  }

  void listener() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ESDCAppbar.renderMainAppbar(
        title: 'app_title_home',
        icon: 'asset/image/nav-icon-home.svg',
          action: AppIconButton(
            icon: SvgPicture.asset(
              'asset/image/settings.svg',
              color: Styles.darkerBlue,
              allowDrawingOutsideViewBox: true,
              height: 24,
            ),
            onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(),)),
            rippleRadius: 40,
            padding: 16,
          ),
        context: context
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildUrgentMessage(),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.white,
                handleColor: Styles.bgGrey,
              ),),
            SizedBox(height: 20,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CategoryButton(
                    title: 'active_screening',
                    icon: 'asset/image/icon-covid.svg',
                    iconSize: 54,
                    backgroundColor: Styles.darkerBlue,
                    onClick: () => launch(AppLocalization.of(context).trans('url_covid_active_screening')),
                  ),
                  SizedBox(width: 20,),
                  CategoryButton(
                    title: 'employ_wellness',
                    icon: 'asset/image/icon-wellness.svg',
                    backgroundColor: Styles.blue,
                    onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessScreen(),)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CategoryButton(
                    title: 'learning',
                    icon: 'asset/image/icon-learning.svg',
                    iconSize: 80,
                    onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearningScreen(),)),
                  ),
                  SizedBox(width: 20,),
                  CategoryButton(
                    title: 'feed_back',
                    icon: 'asset/image/icon-feedback.svg',
                    onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Divider(height: 1,),
            SizedBox(height: 10,),
            buildVPN(),
            SizedBox(height: 20,)
          ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Styles.pink,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.warning_outlined,
                        color: Styles.red,
                        size: 28,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalization.of(context).trans('urgent_message'),
                        style: TextStyle(color: Styles.red, fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        size: 36,
                        color: Styles.red,
                      )
                    ],
                  ),
                ));
          }
        }
      },
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
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalization.of(context).trans('last_updated') + " " + DateFormat('dd MMMM yyyy, hh:mm a', AppLocalization.currentLanguage).format(curDateTimeByZone(zone: "EST")) + " EST", style: TextStyle(color: Styles.primaryColor, fontSize: 14),),
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
