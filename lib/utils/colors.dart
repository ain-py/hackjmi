import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

extension colors on ColorScheme {
  static MaterialColor primary_app = const MaterialColor(
    0xff247cc0,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color primary = Color(0xff247cc0);

  static const Color secondary = Color(0xffF0F0F0);

  Color get btnColor => brightness == Brightness.dark ? whiteTemp : primary;

  Color get lightWhite =>
      brightness == Brightness.dark ? darkColor : const Color(0xffF6F6F6);

  Color get fontColor =>
      brightness == Brightness.dark ? whiteTemp : const Color(0xff212121);

  static Color gray = const Color(0xfff0f0f0);

  Color get simmerBase =>
      brightness == Brightness.dark ? darkColor2 : Colors.grey[300]!;

  Color get simmerHigh =>
      brightness == Brightness.dark ? darkColor : Colors.grey[100]!;

  static Color darkIcon = const Color(0xff9B9B9B);

  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color yellow = Color(0xfffdd901);

  static const Color red = Colors.red;

  Color get lightBlack =>
      brightness == Brightness.dark ? whiteTemp : const Color(0xff52575C);

  Color get lightBlack2 =>
      brightness == Brightness.dark ? Colors.white70 : const Color(0xff999999);

  static const Color darkColor = Color(0xff1E2829);
  static const Color darkColor2 = Color(0xff303E40);
  static const Color darkColor3 = Color(0xff465a5d);

  Color get white =>
      brightness == Brightness.dark ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xffFFFFFF);

  Color get black =>
      brightness == Brightness.dark ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  Color get white70 =>
      brightness == Brightness.dark ? Colors.black87 : Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor = Color(0xffEEF2F9);

  static const Color blackTemp = Color(0xff000000);

  Color get black26 => brightness == Brightness.dark ? white30 : Colors.black26;
  static const Color cardColor = Color(0xffFFFFFF);

  Color get back1 => brightness == Brightness.dark
      ? const Color(0xff1E3039)
      : const Color(0x66a2d8fe);

  Color get back2 => brightness == Brightness.dark
      ? const Color(0xff09202C)
      : const Color(0x66bdb1ff);

  Color get back3 => brightness == Brightness.dark
      ? const Color(0xff10101E)
      : const Color(0x66EFAFBF);

  Color get back4 => brightness == Brightness.dark
      ? const Color(0xff171515)
      : const Color(0x66F9DED7);

  Color get back5 => brightness == Brightness.dark
      ? const Color(0xff0F1412)
      : const Color(0x66C6F8E5);
}
