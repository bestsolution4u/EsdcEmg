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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChildAppbar(title: widget.title),
            Expanded(
                child: Stack(
                  children: [
                    WebView(
                      initialUrl: AppLocalization.of(context).trans(widget.url),
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (url) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      navigationDelegate: (NavigationRequest request) {
                        print("-------------- Url Request -----------");
                        print(request.url);
                        /*if(request.url.contains("mailto:")) {
                            launch(request.url);
                            return NavigationDecision.prevent;
                          } else if (request.url.contains("tel:")) {
                            launch(request.url);
                            return NavigationDecision.prevent;
                          }*/
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
    );
  }
}
