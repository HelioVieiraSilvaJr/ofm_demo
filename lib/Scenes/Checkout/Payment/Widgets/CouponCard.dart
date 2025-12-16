import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/RadioButton.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final bool isSelected;
  final VoidCallback onTap;

  const CouponCard({
    super.key,
    required this.coupon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? DSColors().primaryColor.withOpacity(0.15)
              : DSColors().primaryColor.withOpacity(0.1),
          border: Border.all(
            color: isSelected
                ? DSColors().primaryColor
                : DSColors().primaryColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            RadioButton(isSelected: isSelected),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSText.medium(
                    coupon.name,
                    fontWeight: FontWeight.bold,
                    color: DSColors().primaryColor,
                  ),
                  const SizedBox(height: 4),
                  DSText.compact(
                    coupon.description,
                    color: DSColors().textGray,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
