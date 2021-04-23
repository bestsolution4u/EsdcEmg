import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/button/ripple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSelectorRow extends StatelessWidget {

  final VoidCallback onClick;
  final String title, assetImage;

  ItemSelectorRow({this.onClick, this.title, this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: RippleComponent(
            onClick: () {

            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  SvgPicture.asset(
                    assetImage,
                    color: Styles.textBlack,
                    allowDrawingOutsideViewBox: true,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Styles.textBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right, size: 24, color: Styles.textBlack,),
                ],
              ),
            ),
          )),
    );
  }
}
