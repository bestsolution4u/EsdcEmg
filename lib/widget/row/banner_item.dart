import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/screen/main/webview_screen.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';

class BannerItem extends StatefulWidget {

  final String banner;

  BannerItem({this.banner});

  @override
  _BannerItemState createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  @override
  Widget build(BuildContext context) {
    return RippleComponent(
      onClick: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewScreen(title: widget.banner, url: widget.banner + "_url",),)),
      borderRadius: 12,
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Stack(
              children: <Widget>[
                Image.network(AppLocalization.of(context).trans(widget.banner + "_img"), fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
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
                      AppLocalization.of(context).trans(widget.banner),
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
    );
  }
}
