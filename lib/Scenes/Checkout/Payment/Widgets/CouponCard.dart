import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  const CouponCard({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DSColors().primaryColor.withOpacity(0.1),
        border: Border.all(
          color: DSColors().primaryColor.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            color: DSColors().primaryColor,
            size: 24,
          ),
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
    );
  }
}
