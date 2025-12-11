import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/CheckoutPaymentPresenter.dart';

class CheckoutPaymentView extends StatefulWidget {
  final CheckoutPaymentPresenter presenter;

  const CheckoutPaymentView({super.key, required this.presenter});

  @override
  State<CheckoutPaymentView> createState() => _CheckoutPaymentViewState();
}

class _CheckoutPaymentViewState extends State<CheckoutPaymentView> {
  late final presenter = widget.presenter;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
