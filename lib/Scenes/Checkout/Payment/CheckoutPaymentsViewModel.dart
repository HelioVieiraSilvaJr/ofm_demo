import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutPaymentsViewModel {
  // MARK: - Properties
  String path = '/checkout/payments';
  final RxNotifier<PaymentModel?> _paymentModel = RxNotifier(null);
  RxNotifier<PaymentModel?> get paymentModel => _paymentModel;

  Function()? shouldShowError;
  Function(bool)? shouldShowLoading;

  // MARK: - Methods

  // MARK: - Services
  fetch() async {
    shouldShowLoading?.call(true);
    final network = Network();
    final result =
        await network.get(path, headers: {'Content-Type': 'application/json'});

    final payment = PaymentModel.fromJson(result.bodyResponse);

    if (payment.options.isEmpty) {
      shouldShowError!();
      return;
    }

    _paymentModel.value = payment;
    shouldShowLoading?.call(false);
  }
}
