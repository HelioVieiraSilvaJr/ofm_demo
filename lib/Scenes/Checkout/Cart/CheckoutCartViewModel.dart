import 'package:ofm_demo/Commons/Models/CartModel.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutCartViewModel {
  // MARK: - Properties
  final String path = '/checkout/cart';
  final RxNotifier<CartModel?> _cartModel = RxNotifier(null);
  RxNotifier<CartModel?> get cartModel => _cartModel;

  static RxNotifier<int> cartNumberProducts = RxNotifier(3);

  Function()? shouldShowError;
  Function(bool)? shouldShowLoading;

  // MARK: - Methods

  // MARK: - Services
  fetch() async {
    shouldShowLoading?.call(true);
    final network = Network();
    final result =
        await network.get(path, headers: {'Content-Type': 'application/json'});

    final cart = CartModel.fromJson(result.bodyResponse);

    if (cart.products.isEmpty) {
      shouldShowError!();
      return;
    }

    _cartModel.value = cart;
    shouldShowLoading?.call(false);
  }
}
