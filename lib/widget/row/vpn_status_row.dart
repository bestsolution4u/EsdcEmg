import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/localization/app_localization.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:flutter/material.dart';

class VpnStatusRow extends StatelessWidget {
  final VPNStatusModel vpnStatus;

  VpnStatusRow({this.vpnStatus});

  @override
  Widget build(BuildContext context) {
    String status = "bad";
    Color color = Styles.red;
    if (vpnStatus.description == 'GOOD') {
      color = Styles.green;
      status = "good";
    } else if (vpnStatus.description == 'MODERATE') {
      color = Styles.yellow;
      status = "moderate";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color),
        ),
        SizedBox(width: 10,),
        Text(
          vpnStatus.sitename,
          style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '${AppLocalization.of(context).trans(status).toUpperCase()}',
          style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
