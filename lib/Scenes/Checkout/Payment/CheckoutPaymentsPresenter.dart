import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentsViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class CheckoutPaymentsPresenter extends BasePresenter {
  // MARK: - Properties
  final CheckoutPaymentsViewModel viewModel;
  final AppBar appBar;
  AppCoordinator? coordinator;

  CheckoutPaymentsPresenter(this.viewModel, this.appBar) {
    _bindEvents();
  }

  // MARK: - BindEvents
  _bindEvents() {
    // Bind events here
  }

  // MARK: - Actions
  handlerNextStep(String? id) {
    coordinator?.goToResume();
  }

  // MARK: - Methods
  fetch() {
    viewModel.fetch();
  }
}
