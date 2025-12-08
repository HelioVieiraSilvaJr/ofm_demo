import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Widgets/ProductDetailListImagesWidget.dart';

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
    presenter.viewModel.selectedSKU.addListener(() {
      // Handle SKU selection changes
      print('SKU changed: ${presenter.viewModel.selectedSKU.value}');
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductDetailListImagesWidget(
              images: presenter.viewModel.selectedSKU.value?.images ?? []),
          // Add more widgets below as needed
        ],
      ),
    );
  }
}
