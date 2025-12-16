import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/CouponCard.dart';

class CouponsSection extends StatelessWidget {
  final List<Coupon> coupons;
  final String? selectedCouponUid;
  final Function(Coupon) onCouponTap;

  const CouponsSection({
    super.key,
    required this.coupons,
    required this.selectedCouponUid,
    required this.onCouponTap,
  });

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Coupons inwisselen',
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        ...coupons.map((coupon) => CouponCard(
              coupon: coupon,
              isSelected: selectedCouponUid == coupon.uid,
              onTap: () => onCouponTap(coupon),
            )),
        const SizedBox(height: 24),
      ],
    );
  }
}
