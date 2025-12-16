import 'package:ofm_demo/Scenes/Checkout/Resume/Models/ResumeModel.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CheckoutResumeViewModel {
  // MARK: - Properties
  String path = '/checkout/resume';
  RxNotifier<ResumeModel?> _resumeModel = RxNotifier(null);
  RxNotifier<ResumeModel?> get resumeModel => _resumeModel;

  Function()? shouldShowError;
  Function(bool)? shouldShowLoading;

  // MARK: - Methods

  // MARK: - Services
  fetch() async {
    shouldShowLoading?.call(true);
    final network = Network();
    final result =
        await network.get(path, headers: {'Content-Type': 'application/json'});

    if (result.statusCode != 200) {
      shouldShowError!();
      return;
    }

    final resume = ResumeModel.fromJson(result.bodyResponse);
    _resumeModel.value = resume;
    shouldShowLoading?.call(false);
  }
}
