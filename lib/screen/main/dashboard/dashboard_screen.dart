import 'package:carousel_slider/carousel_slider.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
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
  int _bannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "KEC","status": "UP","usage": "78","description": "MODERATE"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MTL","status": "DOWN","usage": "100","description": "BAD"}));
    vpnStatusList.add(VPNStatusModel.fromJson({"sitename": "MCT","status": "UP","usage": "24","description": "GOOD"}));
    _controller = YoutubePlayerController(
      initialVideoId: 'rqH3pqi2kf8',
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
            buildToBannerSlider(),
            buildTopBannerIndicator(),
            SizedBox(height: 10,),
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

  Widget buildToBannerSlider() {
    return CarouselSlider(
        items: Globals.TOP_BANNER_IMAGES.asMap().map((index, imageItem) {
          return MapEntry(index, Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(imageItem, fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          child: Text(
                            Globals.TOP_BANNER_TEXTS[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ));
        }).values.toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              _bannerIndex = index;
            });
          },
          scrollDirection: Axis.horizontal,
        )
    );
  }

  Widget buildTopBannerIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Globals.TOP_BANNER_IMAGES.map((url) {
        int index = Globals.TOP_BANNER_IMAGES.indexOf(url);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _bannerIndex == index
                ? Styles.darkerBlue
                : Styles.blue,
          ),
        );
      }).toList(),
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
            return Padding(
                padding: const EdgeInsets.only(bottom: 10),
              child: RippleComponent(
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
                  )),
            );
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
