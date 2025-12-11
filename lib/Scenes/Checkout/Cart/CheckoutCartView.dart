import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Cart/CheckoutCartPresenter.dart';

class CheckoutCartView extends StatefulWidget {
  final CheckoutCartPresenter presenter;

  const CheckoutCartView({super.key, required this.presenter});

  @override
  State<CheckoutCartView> createState() => _CheckoutCartViewState();
}

class _CheckoutCartViewState extends State<CheckoutCartView> {
  late final presenter = widget.presenter;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
