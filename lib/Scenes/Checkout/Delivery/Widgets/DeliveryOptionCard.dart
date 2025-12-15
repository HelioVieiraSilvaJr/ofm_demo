import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/DeliveryOptionContent.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/StoresSection.dart';

class DeliveryOptionCard extends StatelessWidget {
  final DeliveryOption option;
  final bool isSelected;
  final String? selectedStoreIndex;
  final bool showStoresList;
  final VoidCallback onTap;
  final Function(String storeIndex) onStoreSelected;
  final VoidCallback onShowStoresList;
  final VoidCallback onLoadMoreStores;

  const DeliveryOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.selectedStoreIndex,
    required this.showStoresList,
    required this.onTap,
    required this.onStoreSelected,
    required this.onShowStoresList,
    required this.onLoadMoreStores,
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
              child: DeliveryOptionContent(
                option: option,
                isSelected: isSelected,
              ),
            ),
          ),
          if (_shouldShowStoresSection)
            StoresSection(
              stores: option.stores!,
              optionType: option.type,
              selectedStoreIndex: selectedStoreIndex,
              showStoresList: showStoresList,
              onStoreSelected: onStoreSelected,
              onShowStoresList: onShowStoresList,
              onLoadMoreStores: onLoadMoreStores,
            ),
        ],
      ),
    );
  }

  bool get _shouldShowStoresSection =>
      (option.type == 'pickupInStore' ||
          option.type == 'pickupDeliveryPoint') &&
      isSelected &&
      option.stores != null &&
      option.stores!.isNotEmpty;
}
