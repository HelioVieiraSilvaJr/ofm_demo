import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Sources/Base/BaseScreen.dart';

class ShowcaseView extends StatefulWidget {
  final ShowcasePresenter presenter;

  const ShowcaseView({super.key, required this.presenter});

  @override
  State<ShowcaseView> createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<ShowcaseView> {
  @override
  void initState() {
    super.initState();

    widget.presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        body: Container(
          color: Colors.amber,
        ),
        presenter: widget.presenter);
  }
}
