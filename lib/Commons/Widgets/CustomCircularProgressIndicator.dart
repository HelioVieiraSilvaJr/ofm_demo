import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofm_demo/Resources/DSColors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color = DSColors().primaryColor;

  CustomCircularProgressIndicator({
    super.key,
    this.size = 60.0,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Imagem central
          SvgPicture.asset(
            'lib/Resources/Assets/OFM.svg',
            width: size * 0.1,
            height: size * 0.1,
          ),
          // CircularProgressIndicator ao redor
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
