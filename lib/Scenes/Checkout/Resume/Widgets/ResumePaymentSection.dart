import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Models/ResumeModel.dart';

class ResumePaymentSection extends StatelessWidget {
  final ResumePayment payment;

  const ResumePaymentSection({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Betaalmethode',
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                _getPaymentIcon(),
                color: DSColors().primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DSText.medium(
                  payment.name,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getPaymentIcon() {
    final method = payment.method.toLowerCase();
    if (method.contains('ideal')) {
      return Icons.account_balance;
    } else if (method.contains('creditcard') || method.contains('card')) {
      return Icons.credit_card;
    } else if (method.contains('paypal')) {
      return Icons.payment;
    } else if (method.contains('klarna') || method.contains('afterpay')) {
      return Icons.schedule;
    } else if (method.contains('giftcard')) {
      return Icons.card_giftcard;
    }
    return Icons.payment;
  }
}
