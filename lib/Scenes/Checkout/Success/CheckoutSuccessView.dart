import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessPresenter.dart';

class CheckoutSuccessView extends StatefulWidget {
  final CheckoutSuccessPresenter presenter;

  const CheckoutSuccessView({super.key, required this.presenter});

  @override
  State<CheckoutSuccessView> createState() => _CheckoutSuccessViewState();
}

class _CheckoutSuccessViewState extends State<CheckoutSuccessView> {
  late final presenter = widget.presenter;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
