import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSButtonWidget.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/CheckoutDeliveryPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/DeliveryOptionCard.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutDeliveryView extends StatefulWidget {
  final CheckoutDeliveryPresenter presenter;

  const CheckoutDeliveryView({super.key, required this.presenter});

  @override
  State<CheckoutDeliveryView> createState() => _CheckoutDeliveryViewState();
}

class _CheckoutDeliveryViewState extends State<CheckoutDeliveryView> {
  // MARK: - Properties
  late final presenter = widget.presenter;
  String? selectedOptionUid;
  String? selectedStoreIndex;
  bool showStoresList = false;

  @override
  void initState() {
    super.initState();
    presenter.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: presenter.appBar, body: _body, presenter: presenter);
  }

  Widget get _body {
    return RxBuilder(
      builder: (context) {
        final deliveryModel = presenter.viewModel.deliveryModel;

        if (deliveryModel.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final options = deliveryModel.value!.options;
        _initializeSelection(options);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...options.map((option) => DeliveryOptionCard(
                      option: option,
                      isSelected: selectedOptionUid == option.uid,
                      selectedStoreIndex: selectedStoreIndex,
                      showStoresList: showStoresList,
                      onTap: () => _handleOptionTap(option),
                      onStoreSelected: _handleStoreSelected,
                      onShowStoresList: _handleShowStoresList,
                      onLoadMoreStores: _handleLoadMoreStores,
                    )),
                const SizedBox(height: 32),
                _buildContinueButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initializeSelection(List<DeliveryOption> options) {
    if (selectedOptionUid == null && options.isNotEmpty) {
      final principalOption = options.firstWhere(
        (option) => option.isPrincipal,
        orElse: () => options.first,
      );
      selectedOptionUid = principalOption.uid;
    }
  }

  void _handleOptionTap(option) {
    setState(() {
      final isChangingOption = selectedOptionUid != option.uid;
      selectedOptionUid = option.uid;

      final hasStores = option.type == 'pickupInStore' ||
          option.type == 'pickupDeliveryPoint';

      if (!hasStores) {
        selectedStoreIndex = null;
        showStoresList = false;
      } else if (isChangingOption) {
        selectedStoreIndex = null;
        showStoresList = false;
      }
    });
  }

  void _handleStoreSelected(String storeIndex) {
    setState(() {
      selectedStoreIndex = storeIndex;
      showStoresList = false;
    });
  }

  void _handleShowStoresList() {
    setState(() {
      showStoresList = true;
    });
  }

  void _handleLoadMoreStores() {}

  Widget _buildContinueButton() {
    final selectedOption = presenter.viewModel.deliveryModel.value?.options
        .firstWhere((option) => option.uid == selectedOptionUid);

    final isDeliveryType = selectedOption?.type == 'delivery';
    final hasStoreSelected = selectedStoreIndex != null;
    final requiresStore = selectedOption?.type == 'pickupInStore' ||
        selectedOption?.type == 'pickupDeliveryPoint';

    final isValid = selectedOptionUid != null &&
        (isDeliveryType || (requiresStore && hasStoreSelected));

    return DSButtonWidget(
        title: 'Ga verder naar betaling',
        type: DSButtonType.primary,
        state: isValid ? DSButtonState.enabled : DSButtonState.disabled,
        onTap: isValid ? _handleContinue : null);
  }

  void _handleContinue(String? value) {
    presenter.handlerNextStep(value);
  }
}
