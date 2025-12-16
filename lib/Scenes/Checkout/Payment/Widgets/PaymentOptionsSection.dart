import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/PaymentOptionCard.dart';

class PaymentOptionsSection extends StatelessWidget {
  final List<PaymentOption> options;
  final String? selectedPaymentUid;
  final Function(PaymentOption) onOptionTap;
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final TextEditingController giftCardCodeController;

  const PaymentOptionsSection({
    super.key,
    required this.options,
    required this.selectedPaymentUid,
    required this.onOptionTap,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expiryDateController,
    required this.cvvController,
    required this.giftCardCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Kies je betaalwijze',
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16),
        ...options.map((option) => PaymentOptionCard(
              option: option,
              isSelected: selectedPaymentUid == option.uid,
              onTap: () => onOptionTap(option),
              cardNumberController: cardNumberController,
              cardNameController: cardNameController,
              expiryDateController: expiryDateController,
              cvvController: cvvController,
              giftCardCodeController: giftCardCodeController,
            )),
      ],
    );
  }
}
