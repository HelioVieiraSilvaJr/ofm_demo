import 'package:flutter/material.dart';

class DSColors {
  Color primaryColor = const Color.fromRGBO(1, 65, 107, 1.0);
  Color secondaryColor = const Color.fromRGBO(194, 184, 171, 1.0);
  Color accentColor = const Color.fromRGBO(231, 227, 222, 1.0);
  Color tint = Colors.black;
  Color backgroundLight = const Color.fromARGB(255, 171, 202, 245);
  Color appbarForeground = Colors.black;
  Color appbarBackground = const Color.fromRGBO(194, 184, 171, 1);

  /// Text
  Color textPrimary = const Color.fromRGBO(0, 0, 0, 1.0);
  Color textSecondary = const Color.fromRGBO(43, 42, 42, 1.0);
  Color textGray = const Color.fromRGBO(76, 80, 77, 1.0);

  /// Background
  Color background = const Color.fromRGBO(255, 255, 255, 1.0);
}

extension ColorExtension on Color {
  MaterialColor getMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }
}
