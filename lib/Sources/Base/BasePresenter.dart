import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BasePresenter {
  // Properties
  late BuildContext context;
  RxNotifier<bool> isLoadingList = RxNotifier(false);
  final bool isOpaque = false;

  ElegantNotification notificationError = ElegantNotification.error(
      title: const Text(""), description: const Text(""));

  // Methods
  showMessageSuccess({String? title, required String message}) {
    notificationError.closeOverlay();
    notificationError = ElegantNotification.success(
      key: const Key('value'),
      position: Alignment.bottomRight,
      animationDuration: const Duration(milliseconds: 200),
      title: title == null ? null : Text(title),
      description: Text(message),
      progressBarHeight: 5,
      toastDuration: const Duration(milliseconds: 5000),
      progressBarPadding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      progressIndicatorBackground: Colors.green[100]!,
    );

    notificationError.show(context);
  }

  showMessageError({String title = "Ops..", required String message}) async {
    notificationError.closeOverlay();
    notificationError = ElegantNotification.error(
      width: 360,
      toastDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 200),
      stackedOptions: StackedOptions(
        key: 'topRight',
        type: StackedType.below,
        itemOffset: const Offset(0, 5),
      ),
      position: Alignment.topRight,
      animation: AnimationType.fromRight,
      title: Text(title),
      description: Text(message),
      onDismiss: () {},
    );

    notificationError.show(context);
  }

  showLoading(bool isOn) {
    isLoadingList.value = isOn;
  }

  // Setup
  void setup() {}
}
