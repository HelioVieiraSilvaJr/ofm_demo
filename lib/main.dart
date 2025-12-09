import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DSColors.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';
import 'package:ofm_demo/firebase_options.dart';

ThemeData getThemeData() {
  return ThemeData(
      primaryColor: DSColors().primaryColor,
      primarySwatch: DSColors().secondaryColor.getMaterialColor(),
      scaffoldBackgroundColor: DSColors().background,
      appBarTheme: AppBarTheme(
        elevation: 5,
        foregroundColor: DSColors().appbarForeground,
        backgroundColor: DSColors().appbarBackground,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: Scaffold(
        body: Center(
          child: CustomCircularProgressIndicator(),
        ),
      ),
    );
  }
}
