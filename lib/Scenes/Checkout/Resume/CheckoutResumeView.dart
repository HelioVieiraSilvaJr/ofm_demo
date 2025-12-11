import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Checkout/Resume/CheckoutResumePresenter.dart';

class CheckoutResumeView extends StatefulWidget {
  final CheckoutResumePresenter presenter;

  const CheckoutResumeView({super.key, required this.presenter});

  @override
  State<CheckoutResumeView> createState() => _CheckoutResumeViewState();
}

class _CheckoutResumeViewState extends State<CheckoutResumeView> {
  late final presenter = widget.presenter;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
