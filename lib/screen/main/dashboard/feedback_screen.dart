import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/util/toasts.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:esdc_emg/widget/input/app_commentbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {

  FeedbackScreen();

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  String category, from;
  TextEditingController nameController, feedbackController;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    nameController = TextEditingController();
    feedbackController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (category == null) category = AppLocalization.of(context).trans(Globals.CATEGORIES[0]);
    if (from == null) from = AppLocalization.of(context).trans(Globals.WHICH_FROM[0]);
    return Scaffold(
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
                  SizedBox(height: 20,),
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
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      AppLocalization.of(context).trans('feed_back_description'),
                                      style: TextStyle(color: Styles.darkerBlue, fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      AppLocalization.of(context).trans('which_are_you_from'),
                                      style: TextStyle(color: Styles.darkerBlue, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                          selectedItemBuilder: (BuildContext context) {
                                            return Globals.WHICH_FROM.map<Widget>((String item) {
                                              return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), child:Text(AppLocalization.of(context).trans(item), style: TextStyle(color: Styles.darkerBlue, fontSize: 14, fontWeight: FontWeight.w500),),);
                                            }).toList();
                                          },
                                          items: Globals.WHICH_FROM.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: AppLocalization.of(context).trans(value),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                child: Text(AppLocalization.of(context).trans(value), style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      AppLocalization.of(context).trans('category'),
                                      style: TextStyle(color: Styles.darkerBlue, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                          selectedItemBuilder: (BuildContext context) {
                                            return Globals.CATEGORIES.map<Widget>((String item) {
                                              return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), child:Text(AppLocalization.of(context).trans(item), style: TextStyle(color: Styles.darkerBlue, fontSize: 14, fontWeight: FontWeight.w500),),);
                                            }).toList();
                                          },
                                          items: Globals.CATEGORIES.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: AppLocalization.of(context).trans(value),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                child: Text(AppLocalization.of(context).trans(value), style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      AppLocalization.of(context).trans('feed_back'),
                                      style: TextStyle(color: Styles.darkerBlue, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: AppCommentbox(
                                      controller: feedbackController,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppLocalization.of(context).trans('disclaimer').toUpperCase(),
                                              style: TextStyle(
                                                  color: Styles.darkBlue,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            TextSpan(
                                              text: AppLocalization.of(context).trans('disclaimer_desc'),
                                              style: TextStyle(
                                                color: Styles.darkerBlue,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: FlatButton(
                                      minWidth: MediaQuery.of(context).size.width,
                                      color: Styles.darkBlue,
                                      padding: const EdgeInsets.all(16.0),
                                      onPressed: () => submitFeedback(),
                                      child: Text(AppLocalization.of(context).trans('send_feedback'),
                                          style: TextStyle(color: Colors.white, fontSize: 16), maxLines: 2, textAlign: TextAlign.center,),
                                      textColor: Styles.textBlack,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Styles.darkBlue,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                  ),
                                  SizedBox(height: 40,)
                                ],
                              ),
                            ),

                          ],
                        ),
                      )),
                ],
              ),
              isLoading ? Container(
                color: Color(0x55242424),
                child: Center(child: CircularProgressIndicator(),),
              ) : Container()
            ],
          ),
        )
    );
  }

  void submitFeedback() async {
    if (feedbackController.text.isEmpty) {
      ToastUtils.showErrorToast(context, AppLocalization.of(context).trans('error_empty_feedback'));
      return;
    }
    setState(() {
      isLoading = true;
    });
    final response = await Api.submitFeedback(name: nameController.text, category: category, feedback: feedbackController.text, source: from);
    setState(() {
      isLoading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text(AppLocalization.of(context).trans('thank_you')),
          content: new Text(AppLocalization.of(context).trans('we_received_feedback')),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(AppLocalization.of(context).trans('close')),
              onPressed: () {
                setState(() {
                  nameController.text = "";
                  category = AppLocalization.of(context).trans(Globals.CATEGORIES[0]);
                  from = AppLocalization.of(context).trans(Globals.WHICH_FROM[0]);
                  feedbackController.text = "";
                });
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        )
    );
  }
}
