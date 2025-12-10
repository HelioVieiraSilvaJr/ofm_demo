import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BaseView extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final BasePresenter presenter;

  const BaseView({
    super.key,
    this.appBar,
    required this.body,
    required this.presenter,
  });

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Future<void> dispose() async {
    super.dispose();
    widget.presenter.notificationError.closeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return Container();
    widget.presenter.context = context;

    return Scaffold(
      appBar: widget.appBar,
      body: Stack(
        children: [
          widget.body,
          RxBuilder(builder: (context) {
            return widget.presenter.isLoadingList.value
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: CustomCircularProgressIndicator(),
                    ),
                  )
                : Container();
          }),
        ],
      ),
    );
  }
}
