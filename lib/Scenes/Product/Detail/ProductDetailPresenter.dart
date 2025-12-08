import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Model/ProductModel.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailViewModel.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class ProductDetailPresenter {
  // MARK: - Properties
  final ProductDetailViewModel viewModel;
  final AppBar appBar;
  final AppCoordinator? coordinator;

  ProductDetailPresenter(
      {required this.viewModel, required this.appBar, this.coordinator});

  // MARK: - BindEvents
  bindEvents() {
    viewModel.shouldShowError = () {};
  }

  // MARK: - Actions
  handlerSetSKU(ProductSKU sku) {
    viewModel.setSKU(sku);
  }

  handlerSetSize(SizeModel size) {
    viewModel.setSelectedSize(size);
  }

  // MARK: - Methods
  loadProduct() {
    viewModel.fetch();
  }
}
