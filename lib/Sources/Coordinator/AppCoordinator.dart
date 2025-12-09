import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Home/HomeView.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailView.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailViewModel.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseView.dart';
import 'package:ofm_demo/Scenes/Splash/SplashView.dart';

/// Interface base para todos os coordinators
abstract class Coordinator {
  BuildContext get context;

  void start();
  void pop();
}

/// Coordinator principal da aplicação
class AppCoordinator implements Coordinator {
  @override
  final BuildContext context;

  final GlobalKey<NavigatorState> navigatorKey;

  AppCoordinator({
    required this.context,
    required this.navigatorKey,
  });

  @override
  void start() {
    // Inicia com a SplashView
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => const SplashView()),
    );

    // Após 1 segundo, navega para a HomeView
    Future.delayed(const Duration(seconds: 1), () {
      goToHome();
    });
  }

  void goToHome() {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => Homeview(coordinator: this)),
    );
  }

  @override
  void pop() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  // Métodos de navegação específicos
  void goToShowcase(String path, String? title) {
    final appbar = AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 18),
      ),
    );
    final presenter = ShowcasePresenter(path: path, appBar: appbar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ShowcaseView(presenter: presenter),
      ),
    );
  }

  void goToProductDetail(String path, String? title) {
    final appbar = AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 18),
      ),
    );
    final viewModel = ProductDetailViewModel(path: path);
    final presenter = ProductDetailPresenter(
        viewModel: viewModel, appBar: appbar, coordinator: this);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ProductDetailView(presenter: presenter),
      ),
    );
  }

  void openLink(String? link) async {
    if (link == null || link.isEmpty) return;

    debugPrint('Opening link: $link');
    // TODO: Implementar abertura de link quando necessário
    // Considerar adicionar url_launcher ao pubspec.yaml
  }

  void goToCart() {
    debugPrint('Navigate to cart - to be implemented');
    // Implementar navegação para o carrinho quando a tela estiver pronta
  }
}
