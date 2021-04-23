import 'package:flutter/material.dart';

class RippleComponent extends StatefulWidget {

  final Widget child;
  final VoidCallback onClick;

  RippleComponent({this.child, this.onClick});

  @override
  _RippleComponentState createState() => _RippleComponentState();
}

class _RippleComponentState extends State<RippleComponent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onClick,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ))
      ],
    );
  }
}
