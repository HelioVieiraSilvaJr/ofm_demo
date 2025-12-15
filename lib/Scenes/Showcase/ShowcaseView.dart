import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Showcase/DSShowcaseWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowcaseView extends StatefulWidget {
  final ShowcasePresenter presenter;

  const ShowcaseView({super.key, required this.presenter});

  @override
  State<ShowcaseView> createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<ShowcaseView> {
  late final presenter = widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: widget.presenter.appBar,
        body: RxBuilder(builder: (context) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: DSColors().primaryColor,
            onRefresh: () async {
              presenter.loadData();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (widget.presenter.appBar?.preferredSize.height ?? 0) -
                      MediaQuery.of(context).padding.top,
                ),
                child: DSShowcaseWidget(
                    sections: widget.presenter.sections.value,
                    handlerClickSectionItem: widget.presenter.handlerClickItem,
                    handlerOpenLink: widget.presenter.handlerOpenLink),
              ),
            ),
          );
        }),
        presenter: widget.presenter);
  }
}
