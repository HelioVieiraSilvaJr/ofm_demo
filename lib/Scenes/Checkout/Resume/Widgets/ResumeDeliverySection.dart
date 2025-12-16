import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Models/ResumeModel.dart';

class ResumeDeliverySection extends StatelessWidget {
  final ResumeDelivery delivery;

  const ResumeDeliverySection({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.large(
          'Bezorgmethode',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getDeliveryIcon(),
                    color: DSColors().primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DSText.medium(
                      _getDeliveryMethodName(),
                      fontWeight: FontWeight.w600,
                      color: DSColors().primaryColor,
                    ),
                  ),
                ],
              ),
              if (delivery.recipient.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.person_outline,
                  delivery.recipient,
                ),
              ],
              if (delivery.address.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.location_on_outlined,
                  delivery.address,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  IconData _getDeliveryIcon() {
    switch (delivery.method.toLowerCase()) {
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'pickupinstore':
        return Icons.store_outlined;
      case 'pickupdeliverypoint':
        return Icons.location_on_outlined;
      default:
        return Icons.local_shipping_outlined;
    }
  }

  String _getDeliveryMethodName() {
    switch (delivery.method.toLowerCase()) {
      case 'delivery':
        return 'Thuisbezorging';
      case 'pickupinstore':
        return 'Afhalen in winkel';
      case 'pickupdeliverypoint':
        return 'Afhalen bij afhaalpunt';
      default:
        return delivery.method;
    }
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DSText.compact(
            text,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
