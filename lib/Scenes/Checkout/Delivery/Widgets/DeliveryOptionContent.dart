import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/RadioButton.dart';

class DeliveryOptionContent extends StatelessWidget {
  final DeliveryOption option;
  final bool isSelected;

  const DeliveryOptionContent({
    super.key,
    required this.option,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioButton(isSelected: isSelected),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              if (option.description != null) ...[
                const SizedBox(height: 4),
                DSText.compact(
                  option.description!,
                  color: DSColors().textGray,
                ),
              ],
              if (option.address != null) ...[
                const SizedBox(height: 8),
                _buildIconText(
                  Icons.location_on_outlined,
                  option.address!,
                ),
              ],
              if (option.recipient != null) ...[
                const SizedBox(height: 4),
                _buildIconText(
                  Icons.person_outline,
                  option.recipient!,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DSText.medium(
            option.name,
            fontWeight: FontWeight.bold,
            color: DSColors().primaryColor,
          ),
        ),
        if (option.value != null)
          DSText.compact(
            option.value!,
            color: Colors.green,
          ),
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: DSColors().textGray,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DSText.compact(
            text,
            color: DSColors().textGray,
          ),
        ),
      ],
    );
  }
}
