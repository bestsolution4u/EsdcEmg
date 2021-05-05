import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
import 'package:flutter/material.dart';

class VpnStatusRow extends StatelessWidget {
  final VPNStatusModel vpnStatus;

  VpnStatusRow({this.vpnStatus});

  @override
  Widget build(BuildContext context) {
    Color color = Styles.red;
    if (vpnStatus.description == 'GOOD') {
      color = Styles.green;
    } else if (vpnStatus.description == 'MODERATE') {
      color = Styles.yellow;
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
          '${vpnStatus.description}',
          style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
