import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {

  final String title, url;
  WebviewScreen({this.title = "", this.url = ""});

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;
  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Semantics(
          container: true,
          explicitChildNodes: true,
          label: "Webview screen loaded",
          value: "Webview screen loaded",
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChildAppbar(
                    title: widget.title,
                    showTitle: false,
                    onBack: () async {
                      bool result = await onBack();
                      if (result) Navigator.pop(context);
                    },),
                  Expanded(
                      child: Stack(
                        children: [
                          WebView(
                            initialUrl: AppLocalization.of(context).trans(widget.url),
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                            },
                            javascriptMode: JavascriptMode.unrestricted,
                            onPageFinished: (url) {
                              setState(() {
                                isLoading = false;
                              });
                            },
                            navigationDelegate: (NavigationRequest request) {
                              return NavigationDecision.navigate;
                            },
                          ),
                          isLoading ? Center(child: CircularProgressIndicator(),) : Container()
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: onBack);
  }

  Future<bool> onBack() async {
    if (webViewController != null) {
      bool canBack = await webViewController.canGoBack();
      if (canBack) {
        webViewController.goBack();
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
