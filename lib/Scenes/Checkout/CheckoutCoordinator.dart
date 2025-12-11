import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartView.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartViewModel.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

/// Coordinator responsável pelo fluxo de checkout
class CheckoutCoordinator implements Coordinator {
  @override
  final BuildContext context;

  final AppCoordinator appCoordinator;

  CheckoutCoordinator({
    required this.context,
    required this.appCoordinator,
  });

  @override
  void start() {
    goToCart();
  }

  @override
  void pop() {
    appCoordinator.pop();
  }

  // MARK: - Navigation Methods

  void goToCart() {
    final viewModel = CheckoutCartViewModel();
    final presenter = CheckoutCartPresenter(viewModel);

    appCoordinator.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutCartView(presenter: presenter),
      ),
    );
  }

  // Métodos futuros para navegação no fluxo de checkout
  void goToAddress() {
    // TODO: Implementar navegação para endereço
  }

  void goToPayment() {
    // TODO: Implementar navegação para pagamento
  }

  void goToResume() {
    // TODO: Implementar navegação para resumo
  }

  void goToSuccess() {
    // TODO: Implementar navegação para sucesso
  }
}
