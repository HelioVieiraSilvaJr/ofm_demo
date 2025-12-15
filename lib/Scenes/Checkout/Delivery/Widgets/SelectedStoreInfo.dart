import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';

class SelectedStoreInfo extends StatelessWidget {
  final Store store;
  final String optionType;
  final VoidCallback onShowStoresList;

  const SelectedStoreInfo({
    super.key,
    required this.store,
    required this.optionType,
    required this.onShowStoresList,
  });

  @override
  Widget build(BuildContext context) {
    final isPickupPoint = optionType == 'pickupDeliveryPoint';
    final icon = isPickupPoint ? Icons.grid_on_outlined : Icons.store;
    final title =
        isPickupPoint ? 'Geselecteerd servicepunt' : 'Geselecteerde winkel';

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
        color: DSColors().accentColor.withOpacity(0.3),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: DSColors().primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DSText.medium(
                  title,
                  fontWeight: FontWeight.w600,
                  color: DSColors().primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DSText.compact(
            store.name,
            fontWeight: FontWeight.w600,
            color: DSColors().textPrimary,
          ),
          const SizedBox(height: 4),
          DSText.compact(
            store.address,
            color: DSColors().textGray,
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onShowStoresList,
            child: Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  size: 16,
                  color: DSColors().primaryColor,
                ),
                const SizedBox(width: 4),
                DSText.compact(
                  isPickupPoint
                      ? 'Selecteer een ander servicepunt'
                      : 'Selecteer een andere winkel',
                  color: DSColors().primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
