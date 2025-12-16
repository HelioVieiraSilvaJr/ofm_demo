import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartView.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartViewModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/CheckoutDeliveryPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/CheckoutDeliveryView.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/CheckoutDeliveryViewModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentsPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentsView.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentsViewModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumePresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumeView.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumeViewModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessPresenter.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessView.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessViewModel.dart';
import 'package:ofm_demo/Scenes/Home/HomeView.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailView.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailViewModel.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseView.dart';
import 'package:ofm_demo/Scenes/Splash/SplashView.dart';
import 'package:rx_notifier/rx_notifier.dart';

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
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
      actions: [
        RxBuilder(builder: (context) {
          return IconButton(
            icon: Badge(
              label: Text('${CheckoutCartViewModel.cartNumberProducts.value}'),
              isLabelVisible:
                  CheckoutCartViewModel.cartNumberProducts.value > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () {
              goToCart();
            },
          );
        }),
      ],
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
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
      actions: [
        RxBuilder(builder: (context) {
          return IconButton(
            icon: Badge(
              label: Text('${CheckoutCartViewModel.cartNumberProducts.value}'),
              isLabelVisible:
                  CheckoutCartViewModel.cartNumberProducts.value > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () {
              goToCart();
            },
          );
        }),
      ],
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
    final appBar = AppBar(
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
    );
    final viewModel = CheckoutCartViewModel();
    final presenter = CheckoutCartPresenter(viewModel, appBar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutCartView(presenter: presenter),
      ),
    );
  }

  void goToDelivery() {
    final appBar = AppBar(
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
    );
    final viewModel = CheckoutDeliveryViewModel();
    final presenter = CheckoutDeliveryPresenter(viewModel, appBar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutDeliveryView(presenter: presenter),
      ),
    );
  }

  void goToPayments() {
    final appBar = AppBar(
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
    );
    final viewModel = CheckoutPaymentsViewModel();
    final presenter = CheckoutPaymentsPresenter(viewModel, appBar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutPaymentsView(presenter: presenter),
      ),
    );
  }

  void goToResume() {
    final appBar = AppBar(
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
    );
    final viewModel = CheckoutResumeViewModel();
    final presenter = CheckoutResumePresenter(viewModel, appBar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutResumeView(presenter: presenter),
      ),
    );
  }

  void goToSuccess() {
    final appBar = AppBar(
      title: SvgPicture.asset(
        'lib/Resources/Assets/OFM.svg',
        height: 18,
      ),
      backgroundColor: DSColors().secondaryColor,
    );
    final viewModel = CheckoutSuccessViewModel();
    final presenter = CheckoutSuccessPresenter(viewModel, appBar);
    presenter.coordinator = this;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => CheckoutSuccessView(presenter: presenter),
      ),
    );
  }

  void returnToHome() {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => Homeview(coordinator: this)),
      (route) => false,
    );
  }
}
