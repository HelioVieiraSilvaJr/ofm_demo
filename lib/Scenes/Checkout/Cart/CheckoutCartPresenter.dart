import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';

class CheckoutCartPresenter extends BasePresenter {
  // MARK: - Properties
  CheckoutCartViewModel viewModel;
  AppBar? appBar;

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
  // Add action handlers here

  // MARK: - Methods
  fetch() {
    viewModel.fetch();
  }
}
