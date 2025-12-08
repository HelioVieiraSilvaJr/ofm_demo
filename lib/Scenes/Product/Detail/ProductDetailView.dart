import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailListImagesWidget.dart';
import 'package:ofm_demo/Sources/Base/BaseScreen.dart';
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
        body: SingleChildScrollView(
          child: RxBuilder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductDetailListImagesWidget(
                    images:
                        presenter.viewModel.selectedSKU.value?.images ?? []),
                // Add more widgets below as needed
              ],
            );
          }
      ),
        ),
        presenter: presenter);
  }
}
