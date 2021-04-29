import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {

  final String title, url;
  WebviewScreen({this.title = "", this.url = "https://google.com"});

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(title: widget.title,),
              Expanded(
                  child: Stack(
                    children: [
                      WebView(
                        initialUrl: widget.url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageFinished: (url) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      isLoading ? Center(child: CircularProgressIndicator(),) : Container()
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
