import 'package:flutter/material.dart';

class DSColors {
  Color primaryColor = const Color(0xFF001F3F);
  Color secundaryColor = const Color(0xFF003366);
  Color accentColor = const Color(0xFFFFD700);
  Color tint = Colors.black;
  Color backgroundLight = const Color.fromARGB(255, 171, 202, 245);

  /// Text
  Color textPrimary = const Color.fromRGBO(0, 0, 0, 1.0);
  Color textSecondary = const Color.fromRGBO(43, 42, 42, 1.0);
  Color textGray = const Color.fromRGBO(76, 80, 77, 1.0);

  /// Background
  Color background = const Color.fromRGBO(241, 240, 240, 1.0);
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
