import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Home/HomePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseView.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';

class Homeview extends StatefulWidget {
  final AppCoordinator? coordinator;

  const Homeview({super.key, this.coordinator});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  // MARK: Properties
  final HomePresenter presenter = HomePresenter();
  late final ShowcasePresenter showcasePresenter;

  @override
  void initState() {
    super.initState();
    showcasePresenter = ShowcasePresenter(path: '/showcase/home', appBar: null);
    showcasePresenter.coordinator = widget.coordinator;
  }

  // MARK: View
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: ShowcaseView(presenter: showcasePresenter),
      presenter: showcasePresenter,
    );
  }
}
