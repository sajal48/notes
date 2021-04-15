import 'package:flutter/material.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;
  final double curvedDistance;
  final double curvedHeight;

  const CurvedWidget({Key key, this.curvedDistance=80, this.curvedHeight=80, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedWidgetBackgroundClippper(
        curvedDistance: this.curvedDistance,
        curvedHeight: this.curvedHeight,
      ),
      child: child,
    );
  }
}

class CurvedWidgetBackgroundClippper extends CustomClipper<Path>{

  final double curvedDistance;
  final double curvedHeight;

  CurvedWidgetBackgroundClippper({this.curvedDistance, this.curvedHeight});
  @override
  getClip(Size size) {
    Path clippath =Path();
    clippath.lineTo(size.width, 0);
    clippath.lineTo(size.width, size.height-curvedDistance-curvedHeight);
    clippath.quadraticBezierTo(size.width, size.height-curvedHeight, size.width-curvedDistance, size.height-curvedHeight);
    clippath.lineTo(curvedDistance, size.height-curvedHeight);
    clippath.quadraticBezierTo(0, size.height-curvedHeight, 0, size.height);
    clippath.lineTo(5, 10);
    return clippath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }

}
