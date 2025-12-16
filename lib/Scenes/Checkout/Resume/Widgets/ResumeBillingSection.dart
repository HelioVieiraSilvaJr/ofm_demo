import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Models/ResumeModel.dart';

class ResumeBillingSection extends StatelessWidget {
  final ResumeBilling billing;

  const ResumeBillingSection({
    super.key,
    required this.billing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Totaaloverzicht',
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
          child: Column(
            children: [
              _buildRow(
                'Verzendkosten',
                billing.shipping,
                isBold: false,
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _buildRow(
                'Totaal',
                billing.total,
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DSText.medium(
          label,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isBold ? Colors.black : Colors.grey.shade700,
        ),
        DSText.medium(
          value,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: isBold ? Colors.black : Colors.grey.shade700,
        ),
      ],
    );
  }
}
