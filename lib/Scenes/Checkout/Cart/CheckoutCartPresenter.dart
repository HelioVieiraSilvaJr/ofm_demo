import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/ActionType.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class CheckoutCartPresenter extends BasePresenter {
  // MARK: - Properties
  CheckoutCartViewModel viewModel;
  AppBar? appBar;
  AppCoordinator? coordinator;

  CheckoutCartPresenter(this.viewModel, this.appBar) {
    _bindEvents();
  }

  // MARK: - BindEvents
  _bindEvents() {
    viewModel.shouldShowLoading = (isLoading) {
      setLoading(isLoading);
    };

    viewModel.shouldShowError = () {};
  }

  // MARK: - Actions
  handlerClickItem(ItemModel item) {
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
        coordinator?.goToCart();
        print('==> No action defined for this item');
    }
  }

  handlerOpenLink(String? url) {
    coordinator?.openLink(url);
  }

  // MARK: - Methods
  fetch() {
    viewModel.fetch();
  }
}
