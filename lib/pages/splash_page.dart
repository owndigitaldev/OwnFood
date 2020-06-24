import 'package:flutter/material.dart';
import 'package:ownfood/core/canvas/splash_canvas.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
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
            child: Image.asset(
              images + "ic_own_food.png",
              width: size.width * .75,
            ),
          ),
        ],
      ),
    );
  }
}
