import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Custom_Btn extends StatelessWidget {
  final Function onPressed;
  final Text txt;
  final Icon icon;

  const Custom_Btn({Key key, this.onPressed, this.txt, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: NeumorphicButton(
          style: NeumorphicStyle(color: Colors.transparent),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              txt,
              icon,
            ],
          )),
    );
  }
}
