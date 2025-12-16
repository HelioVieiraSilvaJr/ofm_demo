import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumeViewModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class CheckoutResumePresenter extends BasePresenter {
  // MARK: - Properties
  CheckoutResumeViewModel viewModel;
  AppBar appBar;
  AppCoordinator? coordinator;

  CheckoutResumePresenter(this.viewModel, this.appBar) {
    _bindEvents();
  }

  // MARK: - BindEvents
  _bindEvents() {
    viewModel.shouldShowLoading = (isLoading) {
      setLoading(isLoading);
    };

    viewModel.shouldShowError = () {
      // showError();
    };
  }

  // MARK: - Actions
  handlerNextStep(String? id) {
    coordinator?.goToSuccess();
  }

  // MARK: - Methods
  fetch() {
    viewModel.fetch();
  }
}
