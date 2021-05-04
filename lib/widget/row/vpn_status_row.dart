import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/model/vpn_status_model.dart';
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
    Color color = Styles.red;
    if (vpnStatus.description == 'GOOD') {
      color = Styles.green;
    } else if (vpnStatus.description == 'MODERATE') {
      color = Styles.yellow;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            vpnStatus.sitename,
            style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${vpnStatus.usage}%',
            style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 80,
          child: Text(
            '${vpnStatus.description}',
            style: TextStyle(color: Styles.textBlack, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        usage > 0 ? Expanded(
          flex: usage,
            child: Container(width: double.infinity, height: 32, color: color,)
        ) : Container(),
        usage < 100 ? Expanded(
            flex: 100 - usage,
            child: Container(width: double.infinity, height: 32, color: Colors.transparent,)
        ) : Container(),
      ],
    );
  }
}