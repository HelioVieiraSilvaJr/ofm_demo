import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/DSShowcaseWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/Widgets/DSButtonWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailDescription.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailListImagesWidget.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailSelectedSKU.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailSelectedSizeWidget.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ProductDetailView extends StatefulWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailView({super.key, required this.presenter});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late final presenter = widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: presenter.appBar,
        body: SingleChildScrollView(
          child: RxBuilder(builder: (context) {
            final sections = presenter.viewModel.productModel.value?.sections;
            final imagens = presenter.viewModel.selectedSKU.value?.images;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductDetailListImagesWidget(
                        images: imagens ?? []),
                ProductDetailDescription(presenter: presenter),
                ProductDetailSelectedSKU(presenter: presenter),
                ProductDetailSelectedSizeWidget(presenter: presenter),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DSButtonWidget(
                    title: 'In winkelwagen',
                    type: DSButtonType.primary,
                    iconType: DSButtonIconType.cart,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DSButtonWidget(
                    title: 'Vind vergelijkbare items',
                    type: DSButtonType.secondary,
                    iconType: DSButtonIconType.ai,
                  ),
                ),
                DSShowcaseWidget(
                    sections: sections ?? [],
                    handlerClickSectionItem: presenter.handlerClickSectionItem,
                    handlerOpenLink: presenter.handlerOpenLink)
              ],
            );
          }),
        ),
        presenter: presenter);
  }
}
