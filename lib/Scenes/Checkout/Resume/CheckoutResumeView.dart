import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSButtonWidget.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumePresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Widgets/ResumeBillingSection.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Widgets/ResumeDeliverySection.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Widgets/ResumePaymentSection.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/Widgets/ResumeProductsList.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutResumeView extends StatefulWidget {
  final CheckoutResumePresenter presenter;

  const CheckoutResumeView({super.key, required this.presenter});

  @override
  State<CheckoutResumeView> createState() => _CheckoutResumeViewState();
}

class _CheckoutResumeViewState extends State<CheckoutResumeView> {
  late final presenter = widget.presenter;

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
        final resumeModel = presenter.viewModel.resumeModel;

        if (resumeModel.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final resume = resumeModel.value!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Products List
                ResumeProductsList(products: resume.products),
                const SizedBox(height: 24),

                // Delivery Section
                ResumeDeliverySection(delivery: resume.delivery),
                const SizedBox(height: 24),

                // Payment Section
                ResumePaymentSection(payment: resume.payment),
                const SizedBox(height: 24),

                // Billing Section
                ResumeBillingSection(billing: resume.billing),
                const SizedBox(height: 32),

                // Terms and Conditions
                _buildTermsAndConditions(),
                const SizedBox(height: 24),

                // Finalize Button
                _buildFinalizeButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Door je bestelling te plaatsen, ga je akkoord met onze algemene voorwaarden en privacybeleid.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalizeButton() {
    return DSButtonWidget(
      title: 'Bestelling plaatsen',
      type: DSButtonType.primary,
      state: DSButtonState.enabled,
      onTap: _handleFinalize,
    );
  }

  void _handleFinalize(String? value) {
    debugPrint('=== FINALIZING ORDER ===');
    debugPrint(
        'Products: ${presenter.viewModel.resumeModel.value?.products.length}');
    debugPrint(
        'Delivery: ${presenter.viewModel.resumeModel.value?.delivery.method}');
    debugPrint(
        'Payment: ${presenter.viewModel.resumeModel.value?.payment.method}');
    debugPrint(
        'Total: ${presenter.viewModel.resumeModel.value?.billing.total}');

    presenter.handlerNextStep(null);
  }
}
