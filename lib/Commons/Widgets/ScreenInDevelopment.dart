import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import '../../Resources/DesignSystem/Colors/DSColors.dart';

class ScreenInDevelopment extends StatelessWidget {
  const ScreenInDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DSColors().primaryColor,
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              DSText.large(
                "Exibição não disponivel.",
              ),
            ],
          ),
        ));
  }
}
