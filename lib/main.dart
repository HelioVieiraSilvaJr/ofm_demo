import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DSColors.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

ThemeData getThemeData() {
  return ThemeData(
      primaryColor: DSColors().primaryColor,
      primarySwatch: DSColors().secondaryColor.getMaterialColor(),
      scaffoldBackgroundColor: DSColors().background,
      appBarTheme: const AppBarTheme(elevation: 5),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late AppCoordinator coordinator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      coordinator = AppCoordinator(
        context: context,
        navigatorKey: navigatorKey,
      );
      coordinator.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OFM App",
      theme: getThemeData(),
      navigatorKey: navigatorKey,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
