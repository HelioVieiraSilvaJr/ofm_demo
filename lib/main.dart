import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DSColors.dart';
import 'package:ofm_demo/Scenes/Home/HomeView.dart';

ThemeData getThemeData() {
  return ThemeData(
      primaryColor: DSColors().primaryColor,
      primarySwatch: DSColors().secondaryColor.getMaterialColor(),
      scaffoldBackgroundColor: DSColors().background,
      appBarTheme: const AppBarTheme(elevation: 5),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

void main() {
  runApp(
    MaterialApp(
      title: "OFM App",
      theme: getThemeData(),
      home: const Homeview(),
    ),
  );
}
