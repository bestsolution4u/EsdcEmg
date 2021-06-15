import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/bloc/app_bloc.dart';
import 'package:esdc_emg/bloc/bloc.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/message_model.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/model/youtube_video_model.dart';
import 'package:esdc_emg/screen/main/dashboard/feedback_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/setting_screen.dart';
import 'package:esdc_emg/screen/main/dashboard/wellness_screen.dart';
import 'package:esdc_emg/util/message_util.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/button/category_button.dart';
import 'package:esdc_emg/widget/button/icon_button.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/banner_item.dart';
import 'package:esdc_emg/widget/row/vpn_status_row.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'learning_screen.dart';

class DashboardScreen extends StatefulWidget {

  final VoidCallback onUrgentClick;

  DashboardScreen({this.onUrgentClick});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin{

  List<VPNStatusModel> vpnStatusList = [];
  MessageBloc _messageBloc;
  YoutubePlayerController _controller;
  int _bannerIndex = 0;
  List<YoutubeVideoModel> youtubeVideos;
  Timer timer;
  DateTime vpnUpdatedAt;

  @override
  void initState() {
    super.initState();
    fetchYoutubeVideos(channelID: AppLocalization.currentLanguage != 'fr' ? 'UCCccXdsqVOHjUym8m19FBig' : 'UCRQ4WaflypnRlPzi96WeBWw');
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    timer = Timer.periodic(Duration(minutes: Globals.VPN_STATUS_UPDATE_INTERVAL), (Timer t) => getVPNStatus());
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && notification.title == 'VPN Status Alert') {
        getVPNStatus();
      }
    });
    updateVPNStatus();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getVPNStatus() {
    AppBloc.vpnBloc.add(VPNLoadEvent());
  }

  void updateVPNStatus() {
    if (mounted) {
      DateTime updatedTime = PreferenceHelper.getDate(PrefParams.VPN_UPDATED_AT);
      List<String> values = PreferenceHelper.getStringList(PrefParams.VPN_STATUS);
      if (values != null) {
        setState(() {
          vpnUpdatedAt = updatedTime;
          vpnStatusList = values.map((e) => VPNStatusModel.fromString(e)).toList();
        });
      }
    }
  }

  void fetchYoutubeVideos({channelID}) {
    youtubeVideos = null;
    Api.fetchYoutubeVideos(channelID != null ? channelID : AppLocalization.of(context).trans('youtube_channel_id')).then((videos) {
      if (mounted) {
        setState(() {
          youtubeVideos = videos;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<SettingBloc, SettingState>(
            listener: (context, state) {
              if (state is SettingLoadSuccessState) {
                if (AppLocalization.currentLanguage != state.settings.language) {
                  fetchYoutubeVideos(channelID: state.settings.language != 'fr' ? 'UCCccXdsqVOHjUym8m19FBig' : 'UCRQ4WaflypnRlPzi96WeBWw');
                }
              }
            },
          ),
          BlocListener<VPNBloc, VPNState>(
              listener: (context, state) {
                if (state is VPNLoadedState) {
                  updateVPNStatus();
                }
              },
          )
        ],
        child: Scaffold(
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
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                buildUrgentMessage(),
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
                Divider(height: 40,),
                buildYoutubeVideos(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ));
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
                padding: const EdgeInsets.only(bottom: 20),
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
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vpnUpdatedAt == null ? Container() : Text(AppLocalization.of(context).trans('last_updated') + DateFormat('dd MMMM yyyy, hh:mm a', AppLocalization.currentLanguage).format(dateTimeToZone(zone: "EDT", datetime: vpnUpdatedAt)) + " EST", style: TextStyle(color: Styles.primaryColor, fontSize: 14),),
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

  Widget buildYoutubeVideos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(width: 20,),
            Icon(CupertinoIcons.play_circle, size: 28, color: Styles.primaryColor,),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalization.of(context).trans('esdc_watch'),
              maxLines: 2,
              style: TextStyle(
                  color: Styles.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 40),
          child: Text(AppLocalization.of(context).trans('videos_sourced_from_esdc_channel'), style: TextStyle(color: Styles.primaryColor, fontSize: 14),),
        ),
        SizedBox(height: 8,),
        youtubeVideos == null
            ? SizedBox(height: 200, width: double.infinity, child: Center(child: CircularProgressIndicator(),),)
            : CarouselSlider(
            items: youtubeVideos.map((video) => BannerItem(video: video,)).toList(),
            options: CarouselOptions(
              height: 250,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _bannerIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
            )
        ),
        SizedBox(height: 8,),
        youtubeVideos != null && youtubeVideos.isNotEmpty
        ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: youtubeVideos.map((video) {
            int index = youtubeVideos.indexOf(video);
            return Container(
              width: 20.0,
              height: 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                color: _bannerIndex == index
                    ? Styles.blue
                    : Colors.grey,
              ),
            );
          }).toList(),
        ) : Container(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
