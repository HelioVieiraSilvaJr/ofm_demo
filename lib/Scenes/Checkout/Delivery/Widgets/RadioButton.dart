import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';

class RadioButton extends StatelessWidget {
  final bool isSelected;

  const RadioButton({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? DSColors().primaryColor : Colors.grey.shade400,
          width: 2,
        ),
        color: Colors.white,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DSColors().primaryColor,
                ),
              ),
            )
          : null,
    );
  }
}
