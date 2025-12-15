import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/PaymentOptionContent.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/CreditCardForm.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/GiftCardForm.dart';

class PaymentOptionCard extends StatelessWidget {
  final PaymentOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final TextEditingController cardNumberController;
  final TextEditingController cardNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final TextEditingController giftCardCodeController;

  const PaymentOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.cardNumberController,
    required this.cardNameController,
    required this.expiryDateController,
    required this.cvvController,
    required this.giftCardCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? DSColors().primaryColor : Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
        color: isSelected
            ? DSColors().primaryColor.withOpacity(0.05)
            : Colors.white,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PaymentOptionContent(
                option: option,
                isSelected: isSelected,
              ),
            ),
          ),
          if (isSelected && option.type == 'creditcard')
            CreditCardForm(
              cardNumberController: cardNumberController,
              cardNameController: cardNameController,
              expiryDateController: expiryDateController,
              cvvController: cvvController,
            ),
          if (isSelected && option.type == 'giftcard')
            GiftCardForm(
              giftCardCodeController: giftCardCodeController,
            ),
        ],
      ),
    );
  }
}
