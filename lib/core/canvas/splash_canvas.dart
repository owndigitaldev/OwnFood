import 'package:flutter/material.dart';
import 'package:ownfood/core/style/app_color.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ClipPath(
            clipper: SplashTopCanvas(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: colorPrimary,
              ),
            ),
          ),
        ),
        Container(
          child: ClipPath(
            clipper: SplashBottomCanvas(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: colorAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashTopCanvas extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    var path = new Path();

    path.moveTo(0, h * .2);
    path.quadraticBezierTo(w * .075, h * .15, w * .2, h * .15);
    path.lineTo(w * .375, h * .15);
    path.quadraticBezierTo(w * .55, h * .15, w * .75, 0);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SplashBottomCanvas extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    var path = new Path();

    path.moveTo(0, h * .85);
    path.quadraticBezierTo(w * .2, h * .775, w * .4, h * .8);
    path.quadraticBezierTo(w * .625, h * .835, w * .775, h * .725);
    path.lineTo(w * .9, h * .625);
    path.quadraticBezierTo(w * .955, h * .575, w, h * .55);
    path.lineTo(w, h);
    path.lineTo(0, h);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
