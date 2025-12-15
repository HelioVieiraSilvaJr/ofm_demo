import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/SelectedStoreInfo.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/StoresList.dart';

class StoresSection extends StatelessWidget {
  final List<Store> stores;
  final String optionType;
  final String? selectedStoreIndex;
  final bool showStoresList;
  final Function(String storeIndex) onStoreSelected;
  final VoidCallback onShowStoresList;
  final VoidCallback onLoadMoreStores;

  const StoresSection({
    super.key,
    required this.stores,
    required this.optionType,
    required this.selectedStoreIndex,
    required this.showStoresList,
    required this.onStoreSelected,
    required this.onShowStoresList,
    required this.onLoadMoreStores,
  });

  @override
  Widget build(BuildContext context) {
    // Se uma loja já foi selecionada e a lista não está sendo mostrada
    if (selectedStoreIndex != null && !showStoresList) {
      final selectedStore = stores[int.parse(selectedStoreIndex!)];
      return SelectedStoreInfo(
        store: selectedStore,
        optionType: optionType,
        onShowStoresList: onShowStoresList,
      );
    }

    // Caso contrário, mostra a lista de lojas
    return StoresList(
      stores: stores,
      optionType: optionType,
      selectedStoreIndex: selectedStoreIndex,
      onStoreSelected: onStoreSelected,
      onLoadMoreStores: onLoadMoreStores,
    );
  }
}
