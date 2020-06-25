import 'package:flutter/material.dart';
import 'package:ownfood/core/style/app_color.dart';
import 'package:ownfood/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OwnFood',
      theme: ThemeData(
        primaryColor: colorPrimary,
        accentColor: colorAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
