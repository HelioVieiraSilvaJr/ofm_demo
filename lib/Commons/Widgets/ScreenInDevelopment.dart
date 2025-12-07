import 'package:flutter/material.dart';
import '../../Resources/DSColors.dart';

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
              Text(
                "Exibição não disponivel.",
                // style: DSTextStyle().custom(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
