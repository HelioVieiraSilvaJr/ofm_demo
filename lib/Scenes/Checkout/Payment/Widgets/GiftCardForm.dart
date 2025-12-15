import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';

class GiftCardForm extends StatelessWidget {
  final TextEditingController giftCardCodeController;

  const GiftCardForm({
    super.key,
    required this.giftCardCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          DSText.compact(
            'Vul uw giftcard code in',
            color: DSColors().textGray,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          _buildTextField(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.compact(
          'Giftcard code',
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        TextField(
          controller: giftCardCodeController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            hintText: 'Voer uw code in',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: DSColors().primaryColor, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}
