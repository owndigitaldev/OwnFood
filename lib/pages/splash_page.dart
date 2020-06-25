import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ownfood/core/canvas/splash_canvas.dart';
import 'package:ownfood/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  void _toHomePage() {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _toHomePage();
  }

  @override
  Widget build(BuildContext context) {
    final String images = "asset/images/";
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          SplashBackground(),
          Center(
            child: OrientationBuilder(
              builder: (ctx, orientation) {
                return Image.asset(
                  images + "ic_own_food.png",
                  width: orientation == Orientation.portrait
                      ? size.width * .75
                      : size.height * .75,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
