import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/ActionType.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Model/ProductModel.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class ProductDetailPresenter extends BasePresenter {
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
    viewModel.setSKU(viewModel.selectedSKU.value!);
  }

  handlerClickSectionItem(ItemModel item) {
    switch (item.action) {
      case ActionType.showcase:
        if (item.link != null) {
          coordinator?.goToShowcase(item.link!, item.title);
        }
        break;
      case ActionType.productDetail:
        if (item.link != null) {
          coordinator?.goToProductDetail(item.link!, item.title);
        }
        break;
      case ActionType.openExternalLink:
        coordinator?.openLink(item.link);
        break;
      case ActionType.cart:
        coordinator?.goToCart();
        break;
      default:
        print('==> No action defined for this item');
    }
  }

  handlerOpenLink(String? url) {
    coordinator?.openLink(url);
  }

  // MARK: - Methods
  loadProduct() {
    viewModel.fetch();
  }
}
