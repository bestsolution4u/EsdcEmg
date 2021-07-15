import 'package:esdc_emg/bloc/application/application_bloc.dart';
import 'package:esdc_emg/bloc/application/application_event.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/pref_params.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/preference_helper.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:esdc_emg/widget/row/intro_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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
    return Semantics(
      label: AppLocalization.of(context).trans('app_title_home'),
      explicitChildNodes: true,
      onTap: () => _applicationBloc.add(ApplicationIntroFinishEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
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
                      Semantics(
                        label: 'My E S D C Logo',
                        image: true,
                        excludeSemantics: true,
                        child: SvgPicture.asset(
                          'asset/image/onboard-artwork-map.svg',
                          allowDrawingOutsideViewBox: true,
                          width: double.infinity,
                          height: 280,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                          left: 0,
                          bottom: 0,
                          child: Semantics(
                            label: AppLocalization.of(context).trans('app_title_home'),
                            container: true,
                            button: false,
                            sortKey: OrdinalSortKey(1),
                            excludeSemantics: true,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'asset/image/nav-icon-home.svg',
                                  allowDrawingOutsideViewBox: true,
                                  width: 45,
                                  height: 45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppLocalization.of(context).trans('app_title_home'),
                                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                                )
                              ],
                            ),
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
                child: Semantics(
                  label: AppLocalization.of(context).trans('made_for_esdc') + ' ' + AppLocalization.of(context).trans('by_people_in_esdc'),
                  sortKey: OrdinalSortKey(2),
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          AppLocalization.of(context).trans('made_for_esdc'),
                          style: TextStyle(fontSize: 20, color: Styles.darkerBlue, fontWeight: FontWeight.w800, height: 1),
                        textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                      ),
                      Text(
                          AppLocalization.of(context).trans('by_people_in_esdc'),
                          style: TextStyle(fontSize: 20, color: Styles.darkerBlue, fontWeight: FontWeight.w800),
                        textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: [
                  IntroRow(
                    title: 'intro_text_1',
                    icon: 'asset/image/onboard-icon-2.svg',
                    sortKey: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IntroRow(
                    title: 'intro_text_2',
                    icon: 'asset/image/tab-messages-active.svg',
                    sortKey: 4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IntroRow(
                    title: 'intro_text_3',
                    icon: 'asset/image/tab-social-active.svg',
                    sortKey: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IntroRow(
                    title: 'intro_text_4',
                    icon: 'asset/image/onboard-icon-1.svg',
                    sortKey: 6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Semantics(
                    label: AppLocalization.of(context).trans('got_it'),
                    button: true,
                    excludeSemantics: true,
                    sortKey: OrdinalSortKey(7),
                    onTap: () => _applicationBloc.add(ApplicationIntroFinishEvent()),
                    child: RippleComponent(
                      onClick: () => _applicationBloc.add(ApplicationIntroFinishEvent()),
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
                            textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Semantics(
                      label: AppLocalization.of(context).trans('donot_show_intro'),
                      button: true,
                      excludeSemantics: true,
                      sortKey: OrdinalSortKey(8),
                      onTap: () {
                        PreferenceHelper.setBool(PrefParams.DONOT_SHOW_INTRO, true);
                        _applicationBloc.add(ApplicationIntroFinishEvent());
                      },
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
                              textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
