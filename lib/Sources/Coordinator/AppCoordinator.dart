import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Home/HomeView.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseView.dart';

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
  void showShowcase(String path) {
    final presenter = ShowcasePresenter(path);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ShowcaseView(presenter: presenter),
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
