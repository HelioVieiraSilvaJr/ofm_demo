import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSCustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSButtonWidget.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentsPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/CouponsSection.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Widgets/PaymentOptionsSection.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutPaymentsView extends StatefulWidget {
  final CheckoutPaymentsPresenter presenter;

  const CheckoutPaymentsView({super.key, required this.presenter});

  @override
  State<CheckoutPaymentsView> createState() => _CheckoutPaymentsViewState();
}

class _CheckoutPaymentsViewState extends State<CheckoutPaymentsView> {
  // MARK: - Properties
  late final presenter = widget.presenter;
  String? selectedPaymentUid;
  String? selectedCouponUid;

  // Credit Card fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Gift Card field
  final TextEditingController giftCardCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter.fetch();

    // Add listeners to update button state when fields change
    cardNumberController.addListener(_updateState);
    cardNameController.addListener(_updateState);
    expiryDateController.addListener(_updateState);
    cvvController.addListener(_updateState);
    giftCardCodeController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    // Remove listeners before disposing
    cardNumberController.removeListener(_updateState);
    cardNameController.removeListener(_updateState);
    expiryDateController.removeListener(_updateState);
    cvvController.removeListener(_updateState);
    giftCardCodeController.removeListener(_updateState);

    cardNumberController.dispose();
    cardNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    giftCardCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: presenter.appBar, body: _body, presenter: presenter);
  }

  Widget get _body {
    return RxBuilder(
      builder: (context) {
        final paymentModel = presenter.viewModel.paymentModel;

        if (paymentModel.value == null) {
          return Center(child: DSCustomCircularProgressIndicator());
        }

        return _buildContent(paymentModel.value!);
      },
    );
  }

  Widget _buildContent(PaymentModel paymentModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CouponsSection(
              coupons: paymentModel.coupons,
              selectedCouponUid: selectedCouponUid,
              onCouponTap: _handleCouponTap,
            ),
            PaymentOptionsSection(
              options: paymentModel.options,
              selectedPaymentUid: selectedPaymentUid,
              onOptionTap: _handleOptionTap,
              cardNumberController: cardNumberController,
              cardNameController: cardNameController,
              expiryDateController: expiryDateController,
              cvvController: cvvController,
              giftCardCodeController: giftCardCodeController,
            ),
            const SizedBox(height: 32),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  void _handleCouponTap(Coupon coupon) {
    setState(() {
      // Toggle coupon selection
      if (selectedCouponUid == coupon.uid) {
        selectedCouponUid = null;
      } else {
        selectedCouponUid = coupon.uid;
      }
    });
  }

  void _handleOptionTap(PaymentOption option) {
    setState(() {
      selectedPaymentUid = option.uid;

      // Clear fields when changing payment method
      if (option.type != 'creditcard') {
        cardNumberController.clear();
        cardNameController.clear();
        expiryDateController.clear();
        cvvController.clear();
      }
      if (option.type != 'giftcard') {
        giftCardCodeController.clear();
      }
    });
  }

  Widget _buildContinueButton() {
    final selectedOption =
        presenter.viewModel.paymentModel.value?.options.firstWhere(
      (option) => option.uid == selectedPaymentUid,
      orElse: () => PaymentOption(uid: '', type: '', name: '', bands: []),
    );

    final isValid = _isPaymentValid(selectedOption);

    return DSButtonWidget(
        title: 'Bestelling controleren',
        type: DSButtonType.primary,
        state: isValid ? DSButtonState.enabled : DSButtonState.disabled,
        onTap: isValid ? _handleContinue : null);
  }

  bool _isPaymentValid(PaymentOption? selectedOption) {
    if (selectedPaymentUid == null || selectedOption == null) {
      return false;
    }

    // For credit card, validate all fields are filled
    if (selectedOption.type == 'creditcard') {
      return cardNumberController.text.isNotEmpty &&
          cardNameController.text.isNotEmpty &&
          expiryDateController.text.isNotEmpty &&
          cvvController.text.isNotEmpty;
    }

    // For gift card, validate code is filled
    if (selectedOption.type == 'giftcard') {
      return giftCardCodeController.text.isNotEmpty;
    }

    // For other payment methods (direct), just need to be selected
    return true;
  }

  void _handleContinue(String? value) {
    final selectedOption = presenter.viewModel.paymentModel.value?.options
        .firstWhere((option) => option.uid == selectedPaymentUid);

    if (selectedOption == null) return;

    debugPrint('Selected payment method: $selectedPaymentUid');
    debugPrint('Payment type: ${selectedOption.type}');

    if (selectedCouponUid != null) {
      debugPrint('Selected coupon: $selectedCouponUid');
    }

    if (selectedOption.type == 'creditcard') {
      debugPrint('Card number: ${cardNumberController.text}');
      debugPrint('Card name: ${cardNameController.text}');
      debugPrint('Expiry date: ${expiryDateController.text}');
    } else if (selectedOption.type == 'giftcard') {
      debugPrint('Gift card code: ${giftCardCodeController.text}');
    }

    presenter.handlerNextStep(selectedPaymentUid);
  }
}
