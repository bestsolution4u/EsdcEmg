import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:esdc_emg/util/toasts.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:esdc_emg/widget/input/app_commentbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen();

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String category, from;
  TextEditingController nameController, feedbackController;
  bool isLoading;
  bool isEmpty;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isEmpty = false;
    nameController = TextEditingController();
    feedbackController = TextEditingController()
      ..addListener(() {
        setState(() {
          isEmpty = feedbackController.text.isEmpty;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (category == null)
      category = AppLocalization.of(context).trans(Globals.CATEGORIES[0]);
    if (from == null)
      from = AppLocalization.of(context).trans(Globals.WHICH_FROM[0]);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Feedback screen loaded",
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Styles.darkBlue,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChildImageAppbar(
                      title: "send_us_feedback",
                      icon: 'asset/image/icon-feedback.svg',
                      iconSize: 30,
                      fontSize: 22,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .trans('feed_back_description'),
                                    style: TextStyle(
                                        color: Styles.darkerBlue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    textScaleFactor:
                                        ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .trans('which_are_you_from'),
                                    style: TextStyle(
                                        color: Styles.darkerBlue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor:
                                        ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Styles.darkGray,
                                        width: 1,
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      margin: const EdgeInsets.all(5),
                                      child: DropdownButton<String>(
                                        value: from,
                                        onChanged: (String newValue) async {
                                          setState(() {
                                            from = newValue;
                                          });
                                        },
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        underline: Container(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return Globals.WHICH_FROM
                                              .map<Widget>((String item) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: Text(
                                                  AppLocalization.of(context)
                                                      .trans(item),
                                                  style: TextStyle(
                                                      color: Styles.darkerBlue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textScaleFactor: ScreenUtil
                                                      .calcTextScaleFactor(
                                                          context)),
                                            );
                                          }).toList();
                                        },
                                        items: Globals.WHICH_FROM
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          final String semanticLabel =
                                              AppLocalization.of(context)
                                                  .trans(value);
                                          return DropdownMenuItem<String>(
                                            value: AppLocalization.of(context)
                                                .trans(value),
                                            child: MergeSemantics(
                                              child: Semantics.fromProperties(
                                                properties: SemanticsProperties(
                                                  label: semanticLabel,
                                                  enabled: true,
                                                  selected: from == value
                                                ),
                                                excludeSemantics: true,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .trans(value),
                                                    style: TextStyle(
                                                        color: Styles.textBlack,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textScaleFactor: ScreenUtil
                                                        .calcTextScaleFactor(
                                                            context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .trans('category'),
                                    style: TextStyle(
                                        color: Styles.darkerBlue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor:
                                        ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Styles.darkGray,
                                        width: 1,
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      margin: const EdgeInsets.all(5),
                                      child: DropdownButton<String>(
                                        value: category,
                                        onChanged: (String newValue) async {
                                          setState(() {
                                            category = newValue;
                                          });
                                        },
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        underline: Container(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return Globals.CATEGORIES
                                              .map<Widget>((String item) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: Text(
                                                  AppLocalization.of(context)
                                                      .trans(item),
                                                  style: TextStyle(
                                                      color: Styles.darkerBlue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textScaleFactor: ScreenUtil
                                                      .calcTextScaleFactor(
                                                          context)),
                                            );
                                          }).toList();
                                        },
                                        items: Globals.CATEGORIES
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                                  final String semanticLabel = AppLocalization.of(context).trans(value);
                                          return DropdownMenuItem<String>(
                                            value: AppLocalization.of(context).trans(value),
                                            child: MergeSemantics(
                                              child: Semantics.fromProperties(
                                                  properties: SemanticsProperties(
                                                    label: semanticLabel,
                                                    enabled: true,
                                                    selected: category == AppLocalization.of(context).trans(value),
                                                  ),
                                                excludeSemantics: true,
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                                  child: Text(
                                                    AppLocalization.of(context)
                                                        .trans(value),
                                                    style: TextStyle(
                                                        color: Styles.textBlack,
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    textScaleFactor: ScreenUtil
                                                        .calcTextScaleFactor(
                                                        context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .trans('feed_back'),
                                    style: TextStyle(
                                        color: Styles.darkerBlue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor:
                                        ScreenUtil.calcTextScaleFactor(context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: AppCommentbox(
                                    controller: feedbackController,
                                  ),
                                ),
                                if (isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: Semantics(
                                      label: AppLocalization.of(context)
                                          .trans('error_empty_feedback'),
                                      excludeSemantics: true,
                                      child: Text(
                                        AppLocalization.of(context)
                                            .trans('error_empty_feedback'),
                                        style: TextStyle(
                                            fontSize: 12, color: Styles.red),
                                        textScaleFactor:
                                            ScreenUtil.calcTextScaleFactor(
                                                context),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: RichText(
                                      textScaleFactor:
                                          ScreenUtil.calcTextScaleFactor(
                                              context),
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalization.of(context)
                                                .trans('disclaimer')
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Styles.darkBlue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: AppLocalization.of(context)
                                                .trans('disclaimer_desc'),
                                            style: TextStyle(
                                              color: Styles.darkerBlue,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: FlatButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    color: Styles.darkBlue,
                                    padding: const EdgeInsets.all(16.0),
                                    onPressed: () => submitFeedback(),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .trans('send_feedback'),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      textScaleFactor:
                                          ScreenUtil.calcTextScaleFactor(
                                              context),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                    textColor: Styles.textBlack,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Styles.darkBlue,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                isLoading
                    ? Container(
                        color: Color(0x55242424),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container()
              ],
            ),
          )),
    );
  }

  void submitFeedback() async {
    if (feedbackController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Semantics(
              label: AppLocalization.of(context).trans('alert'),
              excludeSemantics: true,
              child: Text(AppLocalization.of(context).trans('alert'),
                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context)),
            ),
            content: Semantics(
              label: AppLocalization.of(context).trans('error_empty_feedback'),
              excludeSemantics: true,
              child: Text(
                AppLocalization.of(context).trans('error_empty_feedback'),
                textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Semantics(
                  label: AppLocalization.of(context).trans('close'),
                  child: Text(AppLocalization.of(context).trans('close')),
                  button: true,
                  excludeSemantics: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ));
      return;
    }
    setState(() {
      isLoading = true;
      isEmpty = false;
    });
    final response = await Api.submitFeedback(
        name: nameController.text,
        category: category,
        feedback: feedbackController.text,
        source: from);
    setState(() {
      isLoading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Semantics(
                label: AppLocalization.of(context).trans('thank_you'),
                excludeSemantics: true,
                child: Text(AppLocalization.of(context).trans('thank_you'),
                    textScaleFactor: ScreenUtil.calcTextScaleFactor(context)),
              ),
              content: Semantics(
                label: AppLocalization.of(context).trans('we_received_feedback'),
                excludeSemantics: true,
                child: Text(
                  AppLocalization.of(context).trans('we_received_feedback'),
                  textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Semantics(
                    label: AppLocalization.of(context).trans('close'),
                    child: Text(AppLocalization.of(context).trans('close')),
                    button: true,
                    excludeSemantics: true,
                    onTap: () {
                      setState(() {
                        nameController.text = "";
                        category = AppLocalization.of(context)
                            .trans(Globals.CATEGORIES[0]);
                        from = AppLocalization.of(context)
                            .trans(Globals.WHICH_FROM[0]);
                        feedbackController.text = "";
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      nameController.text = "";
                      category = AppLocalization.of(context)
                          .trans(Globals.CATEGORIES[0]);
                      from = AppLocalization.of(context)
                          .trans(Globals.WHICH_FROM[0]);
                      feedbackController.text = "";
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
