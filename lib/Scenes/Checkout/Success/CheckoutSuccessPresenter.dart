import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class CheckoutSuccessPresenter extends BasePresenter {
  // MARK: - Properties
  CheckoutSuccessViewModel viewModel;
  AppBar appBar;
  AppCoordinator? coordinator;

  CheckoutSuccessPresenter(this.viewModel, this.appBar) {
    _bindEvents();
  }

  // MARK: - BindEvents
  _bindEvents() {
    // Bind events here
  }

  // MARK: - Actions
  handlerGoToHome() {
    coordinator?.returnToHome();
  }

  // MARK: - Methods
  // Add additional methods here
}
