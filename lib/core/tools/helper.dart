import 'package:flutter/material.dart';

class Helper {
  BuildContext _context;

  Helper({@required BuildContext context}) {
    _context = context;
  }

  String greetingText() {
    String greeting = "Selamat ";
    var jam = TimeOfDay.now().hour;
    if (jam >= 1 && jam < 11) {
      greeting += "Pagi";
    } else if (jam >= 11 && jam < 15) {
      greeting += "Siang";
    } else if (jam >= 15 && jam < 18) {
      greeting += "Sore";
    } else {
      greeting += "Malam";
    }
    return greeting;
  }
}
