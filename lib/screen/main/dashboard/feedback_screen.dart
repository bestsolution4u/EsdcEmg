import 'dart:async';

import 'package:esdc_emg/api/api.dart';
import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/util/toasts.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/input/app_commentbox.dart';
import 'package:esdc_emg/widget/input/app_inputbox.dart';
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

  @override
  void initState() {
    super.initState();
    category = Globals.CATEGORIES[0];
    from = Globals.WHICH_FROM[0];
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
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(title: "Send us feedback",),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'How are you liking MyESDC?',
                            style: TextStyle(color: Styles.textBlack, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'We are constantly looking for improve the MyESDC app to serve you better. Let us know what you think and what features you\'d like to see in the future.',
                            style: TextStyle(color: Styles.textBlack, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 20,),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Name (Optional)',
                            style: TextStyle(color: Styles.textBlack, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppInputbox(
                            controller: nameController,
                          ),
                        ),*/
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Which are you from?',
                            style: TextStyle(color: Styles.textBlack, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              width: double.infinity,
                              height: 40,
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
                                    return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), child:Text(item, style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),);
                                  }).toList();
                                },
                                items: Globals.WHICH_FROM.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Text(value, style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Category',
                            style: TextStyle(color: Styles.textBlack, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              width: double.infinity,
                              height: 40,
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
                                    return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), child:Text(item, style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),);
                                  }).toList();
                                },
                                items: Globals.CATEGORIES.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Text(value, style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w500),),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Feedback',
                            style: TextStyle(color: Styles.textBlack, fontSize: 15, fontWeight: FontWeight.bold),
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
                                    text: 'DISCLAIMER: ',
                                    style: TextStyle(
                                      color: Styles.textBlack,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    'In your responses, please do not include any personal information about yourself or anyone else; this includes name, mail or email addresses, or any other information by which you can or they could be identified by your comments or views.',
                                    style: TextStyle(
                                      color: Styles.textBlack,
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
                            color: Styles.lightGray,
                            padding: const EdgeInsets.all(16.0),
                            onPressed: () => submitFeedback(),
                            child: Text('Send feedback',
                                style: TextStyle(color: Styles.textBlack)),
                            textColor: Styles.textBlack,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Styles.textBlack,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(height: 40,)
                      ],
                    ),
                  )),
            ],
          ),
        )
    );
  }

  void submitFeedback() async {
    final response = await Api.submitFeedback(name: nameController.text, category: category, feedback: feedbackController.text, source: from);
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Thank you!"),
          content: new Text("We received your feedback."),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Close'),
              onPressed: () {
                setState(() {
                  nameController.text = "";
                  category = Globals.CATEGORIES[0];
                  from = Globals.WHICH_FROM[0];
                  feedbackController.text = "";
                });
                Navigator.pop(context);
              },
            ),
          ],
        )
    );
  }
}