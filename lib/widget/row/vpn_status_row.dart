import 'package:esdc_emg/config/global.dart';
import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:esdc_emg/util/screen_util.dart';
import 'package:flutter/material.dart';

class VpnStatusRow extends StatelessWidget {
  final VPNStatusModel vpnStatus;

  VpnStatusRow({this.vpnStatus});

  @override
  Widget build(BuildContext context) {
    int usage;
    try {
      usage = int.parse(vpnStatus.usage);
    } catch (e) {
      usage = 0;
    }
    String status = "bad";
    Color color = Styles.red;
    if (vpnStatus.status == 'down') {

    } else {
      if (vpnStatus.description == 'GOOD') {
        color = Color(0xFF1FAB10);
        status = "good";
      } else if (vpnStatus.description == 'MODERATE') {
        color = Color(0xFFAC920E);
        status = "moderate";
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: ScreenUtil.calcTextScaleFactor(context) > 1 ? 80 : 60,
          child: Text(
            vpnStatus.sitename,
            style: TextStyle(color: Styles.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: ScreenUtil.calcTextScaleFactor(context) > 1 ? 150 : 110,
          child: Text(
            vpnStatus.status == 'down' ? AppLocalization.of(context).trans('down') : '${vpnStatus.usage}% ' + AppLocalization.of(context).trans('used'),
            style: TextStyle(color: Styles.primaryColor, fontSize: 16),
            textScaleFactor: ScreenUtil.calcTextScaleFactor(context),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        usage > 0 ? Expanded(
            flex: usage,
            child: Container(width: double.infinity, height: 8, color: color,)
        ) : Container(),
        usage < 100 ? Expanded(
            flex: 100 - usage,
            child: Container(width: double.infinity, height: 32, color: Colors.transparent,)
        ) : Container(),
      ],
    );
  }
}
