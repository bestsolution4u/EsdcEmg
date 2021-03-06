import 'package:esdc_emg/bloc/application/application_bloc.dart';
import 'package:esdc_emg/bloc/application/application_event.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/intro_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: Styles.darkBlue,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Center(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'asset/image/onboard-artwork-map.svg',
                    allowDrawingOutsideViewBox: true,
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.fitHeight,
                    semanticsLabel: 'Map of ESDC',
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'asset/image/nav-icon-home.svg',
                            allowDrawingOutsideViewBox: true,
                            width: 45,
                            height: 45,
                            semanticsLabel: 'Logo of ESDC',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalization.of(context).trans('app_title_home'),
                            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                            semanticsLabel: 'MyESDC',
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(AppLocalization.of(context).trans('made_for_esdc'), style: TextStyle(fontSize: 20, color: Styles.darkerBlue, fontWeight: FontWeight.w800, height: 1), semanticsLabel: 'Made for ESDC',),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(AppLocalization.of(context).trans('by_people_in_esdc'), style: TextStyle(fontSize: 20, color: Styles.darkerBlue, fontWeight: FontWeight.w800), semanticsLabel: 'By People in ESDC',),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntroRow(
                        title: 'intro_text_1',
                        icon: 'asset/image/onboard-icon-2.svg',
                        semanticLabel: 'resources',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IntroRow(
                        title: 'intro_text_2',
                        icon: 'asset/image/tab-messages-active.svg',
                        semanticLabel: 'messages',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IntroRow(
                        title: 'intro_text_3',
                        icon: 'asset/image/tab-social-active.svg',
                        semanticLabel: 'preferences',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IntroRow(
                        title: 'intro_text_4',
                        icon: 'asset/image/onboard-icon-1.svg',
                        semanticLabel: 'connection',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RippleComponent(
                        onClick: () {
                          _applicationBloc.add(ApplicationIntroFinishEvent());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: Styles.darkBlue, borderRadius: BorderRadius.circular(8), boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 2, offset: Offset(3, 3)),
                          ]),
                          child: Center(
                            child: Text(
                              AppLocalization.of(context).trans('got_it'),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: RippleComponent(
                          onClick: () {
                            PreferenceHelper.setBool(PrefParams.DONOT_SHOW_INTRO, true);
                            _applicationBloc.add(ApplicationIntroFinishEvent());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Styles.bgGrey,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 2, offset: Offset(3, 3)),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                AppLocalization.of(context).trans('donot_show_intro'),
                                style: TextStyle(color: Styles.darkerBlue, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
