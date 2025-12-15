import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';

class StoreItemWidget extends StatelessWidget {
  final Store store;
  final String storeIndex;
  final bool isSelected;
  final VoidCallback onTap;

  const StoreItemWidget({
    super.key,
    required this.store,
    required this.storeIndex,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText.compact(
              store.name,
              fontWeight: FontWeight.w600,
              color: DSColors().primaryColor,
            ),
            const SizedBox(height: 4),
            DSText.compact(
              store.address,
              color: DSColors().textGray,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? DSColors().primaryColor : Colors.white,
                  foregroundColor:
                      isSelected ? Colors.white : DSColors().textPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: DSColors().primaryColor,
                      width: 1,
                    ),
                  ),
                ),
                child: DSText.compact(
                  store.buttonLabel,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : DSColors().primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
