import 'package:flutter/material.dart';
import 'dart:html' as html;

enum PlatformResponsive { mobile, web }

PlatformResponsive kPlatformResponsive = PlatformResponsive.web;
bool kDeviceMobile = html.window.navigator.userAgent.contains("Mobi");

class ScreenResponsiveBuilder extends StatelessWidget {
  final Widget Function() mobile;
  // final Widget Function()? tablet;
  final Widget Function() web;

  const ScreenResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.web,
    // this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          PlatformResponsive platform;

          if (constraints.maxWidth >= 1200) {
            platform = PlatformResponsive.web;
            // } else if (constraints.maxWidth >= 500) {
            //   platform = tablet != null ? PlatformResponsive.tablet : PlatformResponsive.web;
          } else {
            platform = PlatformResponsive.mobile;
          }

          kPlatformResponsive = platform;
          kDeviceMobile = html.window.navigator.userAgent.contains("Mobi");

          switch (platform) {
            case PlatformResponsive.web:
              // SessionManager.instance.itsShowWeb = true;
              return web();
            // case PlatformResponsive.tablet:
            //   return tablet!();
            case PlatformResponsive.mobile:
              // SessionManager.instance.itsShowWeb = false;
              return mobile();
          }
        },
      ),
    );
  }
}
