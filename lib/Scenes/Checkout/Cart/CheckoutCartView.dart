import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/DSShowcaseWidget.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/Widgets/CartProductItemWidget.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/Widgets/BillingSummaryWidget.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutCartView extends StatefulWidget {
  final CheckoutCartPresenter presenter;

  const CheckoutCartView({super.key, required this.presenter});

  @override
  State<CheckoutCartView> createState() => _CheckoutCartViewState();
}

class _CheckoutCartViewState extends State<CheckoutCartView> {
  late final presenter = widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(appBar: presenter.appBar, body: body, presenter: presenter);
  }

  Widget get body {
    return RxBuilder(
      builder: (context) {
        final cartModel = presenter.viewModel.cartModel;
        final sections = cartModel.value?.sections ?? [];

        if (cartModel.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lista de produtos
              if (cartModel.value!.products.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: cartModel.value!.products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final product = cartModel.value!.products[index];
                    return CartProductItemWidget(product: product);
                  },
                )
              else
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'Sua sacola está vazia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              // Resumo de cobrança
              BillingSummaryWidget(
                  billingSummary: cartModel.value!.billingSummary),

              const SizedBox(height: 16),

              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (widget.presenter.appBar?.preferredSize.height ?? 0) -
                      MediaQuery.of(context).padding.top,
                ),
                child: DSShowcaseWidget(
                    sections: sections,
                    handlerClickSectionItem: presenter.handlerClickSectionItem,
                    handlerOpenLink: presenter.handlerOpenLink),
              ),
            ],
          ),
        );
      },
    );
  }
}
