import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/StoreItemWidget.dart';

class StoresList extends StatelessWidget {
  final List<Store> stores;
  final String optionType;
  final String? selectedStoreIndex;
  final Function(String storeIndex) onStoreSelected;
  final VoidCallback onLoadMoreStores;

  const StoresList({
    super.key,
    required this.stores,
    required this.optionType,
    required this.selectedStoreIndex,
    required this.onStoreSelected,
    required this.onLoadMoreStores,
  });

  @override
  Widget build(BuildContext context) {
    final isPickupPoint = optionType == 'pickupDeliveryPoint';
    final itemsToShow = stores.length;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DSText.medium(
              isPickupPoint
                  ? 'Selecteer een servicepunt'
                  : 'Selecteer een winkel',
              fontWeight: FontWeight.w600,
              color: DSColors().primaryColor,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemsToShow,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade300,
            ),
            itemBuilder: (context, index) {
              return StoreItemWidget(
                store: stores[index],
                storeIndex: index.toString(),
                isSelected: selectedStoreIndex == index.toString(),
                onTap: () => onStoreSelected(index.toString()),
              );
            },
          ),
          _buildLoadMoreButton(isPickupPoint),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(bool isPickupPoint) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onLoadMoreStores,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 16,
              color: DSColors().primaryColor,
            ),
            const SizedBox(width: 6),
            DSText.compact(
              isPickupPoint
                  ? 'Toon meer afhaalpunten (3/25)'
                  : 'Toon meer winkels (3/25)',
              color: DSColors().primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
