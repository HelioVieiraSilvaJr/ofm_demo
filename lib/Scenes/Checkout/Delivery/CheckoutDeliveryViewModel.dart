import 'package:ofm_demo/Scenes/Checkout/Delivery/Models/DeliveryModel.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutDeliveryViewModel {
  // MARK: - Properties
  final String path = '/checkout/delivery';
  final RxNotifier<DeliveryModel?> _deliveryModel = RxNotifier(null);
  RxNotifier<DeliveryModel?> get deliveryModel => _deliveryModel;

  Function()? shouldShowError;
  Function(bool)? shouldShowLoading;

  // MARK: - Methods

  // MARK: - Services
  fetch() async {
    shouldShowLoading?.call(true);
    final network = Network();
    final result =
        await network.get(path, headers: {'Content-Type': 'application/json'});

    final delivery = DeliveryModel.fromJson(result.bodyResponse);

    if (delivery.options.isEmpty) {
      shouldShowError!();
      return;
    }

    _deliveryModel.value = delivery;
    shouldShowLoading?.call(false);
  }
}
