import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/CheckoutDeliveryViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class CheckoutDeliveryPresenter extends BasePresenter {
  // MARK: - Properties
  CheckoutDeliveryViewModel viewModel;
  AppBar? appBar;
  AppCoordinator? coordinator;

  CheckoutDeliveryPresenter(this.viewModel, this.appBar) {
    _bindEvents();
  }
  // MARK: - BindEvents
  _bindEvents() {
    viewModel.shouldShowError = () {
      // onError!();
    };

    viewModel.shouldShowLoading = (isLoading) {
      setLoading(isLoading);
    };
  }

  // MARK: - Actions
  handlerNextStep(String? value) {
    coordinator?.goToPayments();
  }

  // MARK: - Methods
  fetch() {
    viewModel.fetch();
  }
}
