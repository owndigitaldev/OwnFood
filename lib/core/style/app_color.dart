import 'dart:ui';

class AppColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  AppColor(final String hexColor)
      : super(
    _getColorFromHex(hexColor),
  );
}

final darkBlue = AppColor("#375bbe");
final lightGreen = AppColor("#00aea1");